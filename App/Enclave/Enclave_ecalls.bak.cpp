#include <stdio.h>

#include "Enclave_t.h"
#include "polytools/poly_arith.h"
#include "seal/seal.h"
#include "seal/util/polyarithsmallmod.h"

using namespace std;
using namespace seal;
using namespace polytools;

#define HEAP_SIZE_BYTES (2 * 1024 * 1024) /* 2 MB */
#define STACK_SIZE_BYTES (24 * 1024)      /* 24 KB */

#define SGX_PAGE_SIZE (4 * 1024) /* 4 KB */

#define TA_UUID /* 30ee47ad-6169-4db9-bac8-a00c13515f92 */ \
  {                                                        \
    0x30ee47ad, 0x6169, 0x4db9, {                          \
      0xba, 0xc8, 0xa0, 0x0c, 0x13, 0x51, 0x5f, 0x92       \
    }                                                      \
  }

OE_SET_ENCLAVE_OPTEE(TA_UUID,               /* UUID */
                     HEAP_SIZE_BYTES,       /* HEAP_SIZE */
                     STACK_SIZE_BYTES,      /* STACK_SIZE */
                     TA_FLAG_MULTI_SESSION, /* FLAGS */
                     "1.0.0",               /* VERSION */
                     "Enclave TA");         /* DESCRIPTION */

OE_SET_ENCLAVE_SGX(1, /* ProductID */
                   1, /* SecurityVersion */
#ifdef _DEBUG
                   1, /* Debug */
#else
                   0, /* Debug */
#endif
                   HEAP_SIZE_BYTES / SGX_PAGE_SIZE,  /* NumHeapPages */
                   STACK_SIZE_BYTES / SGX_PAGE_SIZE, /* NumStackPages */
                   1);                               /* NumTCS */

size_t REPEATS = 10000;

void prove_mult() {
  EncryptionParameters params(scheme_type::bgv);
  auto poly_modulus_degree = (size_t)pow(2, 12);
  params.set_poly_modulus_degree(poly_modulus_degree);
  params.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
  params.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 20));
  SEALContext context(params);
  auto coeff_modulus = params.coeff_modulus();

  KeyGenerator keygen(context);
  const SecretKey& secret_key = keygen.secret_key();
  PublicKey public_key;
  keygen.create_public_key(public_key);
  RelinKeys relin_keys;
  keygen.create_relin_keys(relin_keys);
  BatchEncoder batch_encoder(context);

  Encryptor encryptor(context, public_key);
  Evaluator evaluator(context);
  Decryptor decryptor(context, secret_key);

  size_t slot_count = batch_encoder.slot_count();
  size_t row_size = slot_count / 2;

  vector<uint64_t> pod_matrix(slot_count, 0ULL);
  for (size_t i = 0; i < row_size; i++) {
    pod_matrix[i] = (uint64_t)i;
    pod_matrix[row_size + i] = (uint64_t)3 * i;
  }

  Plaintext x_plain;
  batch_encoder.encode(pod_matrix, x_plain);

  for (size_t i = 0; i < row_size; i++) {
    pod_matrix[i] = (uint64_t)i + 1;
    pod_matrix[row_size + i] = (uint64_t)2 * i;
  }

  Plaintext y_plain;
  batch_encoder.encode(pod_matrix, y_plain);

  Ciphertext x_enc, y_enc;
  encryptor.encrypt(x_plain, x_enc);
  encryptor.encrypt(y_plain, y_enc);

  Ciphertext res;
  // Operation without proof
  unsigned long long op_time = 0;
  for (size_t i = 0; i < REPEATS; i++) {
    // auto start = chrono::high_resolution_clock::now();
    evaluator.multiply(x_enc, y_enc, res);
    /*auto end = chrono::high_resolution_clock::now();
    op_time += chrono::duration_cast<chrono::microseconds>(end -
    start).count();*/
  }

  cout << "=======================================" << endl;
  cout << "Performed multiplication " << REPEATS << " times" << endl;
  // cout << "res = c * c': \t" << op_time / float(REPEATS) << "ms" << endl;

  // Proof of operation using Schwartz-Zippel
  unsigned long long proof_time = 0;
  for (size_t i = 0; i < REPEATS; i++) {
    uint64_t Y = (i + 1) % params.coeff_modulus()[0].value();  // TODO: insecure

    SealPoly r0(context, res, 0);
    SealPoly r1(context, res, 1);
    SealPoly r2(context, res, 2);

    SealPoly x0(context, x_enc, 0);
    SealPoly x1(context, x_enc, 1);

    SealPoly y0(context, y_enc, 0);
    SealPoly y1(context, y_enc, 1);

    auto tables =
        context.get_context_data(x0.get_parms_id())->small_ntt_tables();
    // auto start = chrono::high_resolution_clock::now();

    // res(Y) = res_0 + Y * (res_1 + Y * (res_2))
    r2.multiply_scalar_inplace(Y);
    r2.add_inplace(r1);
    r2.multiply_scalar_inplace(Y);
    r2.add_inplace(r0);

    // x(Y) = x_0 + x_1 * Y
    x1.multiply_scalar_inplace(Y);
    x1.add_inplace(x0);

    // y(Y) = y_0 + y_1 * Y
    y1.multiply_scalar_inplace(Y);
    y1.add_inplace(y0);

    // out = res(Y) - x(Y) * y(Y)
    x1.ntt_inplace(tables);
    y1.ntt_inplace(tables);
    x1.multiply_inplace(y1);
    x1.intt_inplace(tables);
    r2.subtract_inplace(x1);

    // CHECK out = 0
    bool is_zero = r2.is_zero();

    /*auto end = chrono::high_resolution_clock::now();
    proof_time += chrono::duration_cast<chrono::microseconds>(end -
    start).count();*/

    assert(is_zero);
    //        if (!is_zero) {
    //            cout << "Verification failed!" << endl;
    //        } else {
    //            cout << "Verification succeeded!" << endl;
    //        }
  }
  cout << "Verified multiplication " << REPEATS << " times" << endl;
}

int ecall_DoWorkInEnclave(void) {
  cout << "[SGX] Starting work in enclave" << endl;

  EncryptionParameters params(scheme_type::bgv);
  auto poly_modulus_degree = (size_t)pow(2, 12);
  cout << "[SGX] 2" << endl;
  params.set_poly_modulus_degree(poly_modulus_degree);
  params.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
  params.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 20));
  cout << "[SGX] pre:context" << endl;

  SEALContext context(params);

  cout << "[SGX] Parameter validation (success): "
       << context.parameter_error_message() << endl;
  auto qualifiers = context.first_context_data()->qualifiers();
  cout << "[SGX] Batching enabled: " << boolalpha << qualifiers.using_batching
       << endl;

  KeyGenerator keygen(context);
  const SecretKey& secret_key = keygen.secret_key();
  PublicKey public_key;
  keygen.create_public_key(public_key);
  RelinKeys relin_keys;
  keygen.create_relin_keys(relin_keys);
  BatchEncoder batch_encoder(context);

  Encryptor encryptor(context, public_key);
  Evaluator evaluator(context);
  Decryptor decryptor(context, secret_key);

  size_t slot_count = batch_encoder.slot_count();
  size_t row_size = slot_count / 2;

  vector<uint64_t> pod_matrix(slot_count, 0ULL);
  for (size_t i = 0; i < row_size; i++) {
    pod_matrix[i] = (uint64_t)i;
    pod_matrix[row_size + i] = (uint64_t)3 * i;
  }

  Plaintext x_plain;
  batch_encoder.encode(pod_matrix, x_plain);

  for (size_t i = 0; i < row_size; i++) {
    pod_matrix[i] = (uint64_t)i + 1;
    pod_matrix[row_size + i] = (uint64_t)2 * i;
  }

  Plaintext y_plain;
  batch_encoder.encode(pod_matrix, y_plain);
  cout << "[SGX] Batch encoding works" << endl;

  Ciphertext x_enc, y_enc;
  encryptor.encrypt(x_plain, x_enc);
  encryptor.encrypt(y_plain, y_enc);
  cout << "[SGX] Encryption works" << endl;

  uint64_t random_mod_q1 = 2;
  Plaintext p;
  pod_matrix = vector<uint64_t>(slot_count, 0ULL);
  pod_matrix[0] = random_mod_q1;

  batch_encoder.encode(pod_matrix, p);

  // prove_mult();

  oe_result_t result = ocall_DoWorkInHost();
  return (result != OE_OK);
}
