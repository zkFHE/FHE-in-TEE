#include <cmath>
#include <iomanip>
#include <iostream>
#include <stdexcept>
#include <vector>

#include "Enclave_t.h"
#include "polytools/poly_arith.h"
#include "seal_sgx/seal.h"
#include "seal_sgx/util/polyarithsmallmod.h"

using namespace std;
using namespace seal_sgx;
using namespace seal_sgx::util;
using namespace polytools;

// Enclave has access to 128 MB of memory, Enclave Page Cache (EPC) is 96 MB
#define HEAP_SIZE_BYTES (80 * 1024 * 1024) /* 256 MB */
#define STACK_SIZE_BYTES (24 * 1024)       /* 24 KB */

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

vector<Ciphertext> ciphertexts;
vector<Plaintext> plaintexts; 
vector<Ciphertext> noise;

Evaluator* evaluator;
SEALContext* context;
EncryptionParameters* params;

void print_SEAL_options() {
	cout << "[SGX] C++ version: \t" << __cplusplus << endl;
	cout << "[SGX] SEAL_USE_INTRIN"
		<< "\t"
		<<
#ifdef SEAL_USE_INTRIN
		"ON"
#else
		"OFF"
#endif
		<< endl;
	cout << "[SGX] SEAL_USE_INTEL_HEXL"
		<< "\t"
		<<
#ifdef SEAL_USE_INTEL_HEXL
		"ON"
#else
		"OFF"
#endif
		<< endl;
	cout << "[SGX] SEAL_USE_MSGSL"
		<< "\t"
		<<
#ifdef SEAL_USE_MSGSL
		"ON"
#else
		"OFF"
#endif
		<< endl;
}

// For an unsigned int v, return 2^(n+1)-1, where 2^n is the next power of 2
// after v. For example, for v = 0xffffee001,
//               return 0xfffffffff
inline uint64_t get_pow2_mask(uint64_t v) {
	v |= v >> 1;
	v |= v >> 2;
	v |= v >> 4;
	v |= v >> 8;
	v |= v >> 16;
	v |= v >> 32;
	return v;
}

// Generate random non-negative int < p by rejection-sampling the enclave's
// randomness
inline uint64_t get_random(uint64_t p) {
	uint64_t mask = get_pow2_mask(p);
	uint64_t res;
	do {
		oe_random(static_cast<void*>(&res), 8);
		res &= mask;  // Mask out higher order bits for efficiency
	} while (res >= p);
	return res;
}

void ecall_InitEnclave(void) {
	ciphertexts = vector<Ciphertext>();

	// Set up SEAL parameters
	params = new EncryptionParameters(scheme_type::bgv);
	auto poly_modulus_degree = (size_t)pow(2, 13);
	params->set_poly_modulus_degree(poly_modulus_degree);
	
	string bench_name = "medium";
	if (bench_name == "tiny") {
		params->set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, { 43, 43, 60 }));
	}
	else if (bench_name == "small") {
		params->set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, { 59, 60, 60 }));
	}
	else if (bench_name == "medium") {
		params->set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, { 45, 46, 46, 46 }));
	}
	else {
		throw invalid_argument(bench_name);
	}
	params->set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 30));


	context = new SEALContext(*params);

	evaluator = new Evaluator(*context);
	BatchEncoder encoder(*context);
	KeyGenerator keygen(*context);
	const SecretKey& secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);
	Encryptor encryptor(*context, public_key);

	vector<uint64_t> ins(poly_modulus_degree);
	for (int i = 0; i < poly_modulus_degree; i++) {
		ins[i] = i;
	}
	Plaintext plain;
	encoder.encode(ins, plain);
	size_t num_ctxts;
	if (bench_name == "tiny") {
		num_ctxts = 2;


	}
	else if (bench_name == "small") {
		num_ctxts = 1;

		plaintexts = vector<Plaintext>(2);

		//plaintexts[0] = new Plaintext();
		//plaintexts[1] = new Plaintext();
		encoder.encode(ins, plaintexts[0]);
		encoder.encode(ins, plaintexts[1]);

		noise = vector<Ciphertext>(128);
		for (int i = 0; i < noise.size(); i++) {
			encryptor.encrypt(plain, noise[i]);
			cout << ".";
		}
		cout << endl;
	}
	else if (bench_name == "medium") {
		num_ctxts = 1;

		plaintexts = vector<Plaintext>(1);

		//plaintexts[0] = new Plaintext();
		//plaintexts[1] = new Plaintext();
		encoder.encode(ins, plaintexts[0]);

		noise = vector<Ciphertext>(128);
		for (int i = 0; i < noise.size(); i++) {
			encryptor.encrypt(plain, noise[i]);
			evaluator->mod_switch_to_next_inplace(noise[i]);
			cout << ".";
		}
		cout << endl;
	} 
	cout << "[SGX] Allocated plaintexts / noise" << endl;

	ciphertexts = vector<Ciphertext>(num_ctxts);
	for (int i = 0; i < num_ctxts; i++) {
		encryptor.encrypt(plain, ciphertexts[i]);
	}
	cout << "[SGX] Allocated ciphertexts" << endl;


	print_SEAL_options();
}

void ecall_SendInputs(void) {
	// cout << "[SGX] SendInputs" << endl << flush;
	oe_result_t result;

	vector<seal_byte> buffer;
	for (size_t i = 0; i < ciphertexts.size(); i++) {
		size_t curr_size = ciphertexts[i].save_size();
		if (curr_size > buffer.size()) {
			buffer.resize(curr_size);
		}
		try {
			ciphertexts[i].save(buffer.data(), curr_size);
		}
		catch (const exception& e) {
			cerr << "[SGX] Ciphertext::save() threw exception: " << e.what() << endl
				<< flush;
			throw e;
		}
		unsigned char* c_buffer = reinterpret_cast<unsigned char*>(buffer.data());

		/*
		cout << "[SGX] attempting re-load from buffer" << endl;
		Ciphertext ciphertext;
		seal_byte* p = reinterpret_cast<seal_byte*>(c_buffer);
		try {
				ciphertext.load(*context, p, curr_size);
		}
		catch (const exception& e) {
				cerr << "[SGX] Ciphertext::load() threw exception: " << e.what() <<
		endl << flush; throw e;
		}
		cout << "[SGX] reload done" << endl;
		*/

		result = ocall_StoreInput(i, c_buffer, curr_size);
		if (result != OE_OK) {
			throw result;
		}
	}
}

void ecall_StoreInput(int index, unsigned char* buffer, size_t len) {
	cout << "[SGX] StoreInput(" << index << ", " << static_cast<void*>(buffer)
		<< ", " << len << ")" << endl
		<< flush;

	// TODO: add check on len (e.g., not allowed to be larger than save_size() of
	// a size-3 ctxt under current params
	Ciphertext* ciphertext = new Ciphertext();
	seal_byte* seal_buffer = reinterpret_cast<seal_byte*>(buffer);
	try {
		ciphertext->load(*context, seal_buffer, len);
	}
	catch (const exception& e) {
		cerr << "[SGX] Ciphertext::load() threw exception: " << e.what() << endl
			<< flush;
		throw e;
	}
	// TODO: add check on index
	if (index >= ciphertexts.size()) {
		ciphertexts.resize(index + 1);
	}
	ciphertexts[index] = *ciphertext;
}

void ecall_Multiply(int input1, int input2, int output) {
	Ciphertext* res = new Ciphertext();
	try {
		evaluator->multiply(ciphertexts[input1], ciphertexts[input2], *res);
	}
	catch (exception& e) {
		cerr << "[SGX] multiply threw exception: " << e.what() << endl << flush;
		throw e;
	}

	if (output >= ciphertexts.size()) {
		ciphertexts.resize(output + 1);
	}
	ciphertexts[output] = *res;
}

void ecall_MultiplyOutsource(int input1, int input2, int output) {
	Ciphertext* res_p = nullptr;
	void* res_void_p = static_cast<void*>(res_p);
	oe_result_t result = ocall_Multiply(&res_void_p, input1, input2);
	if (result != OE_OK) {
		cerr << "[SGX] ocall_Multiply had error " << result << " "
			<< oe_result_str(result) << endl;
	}
	if (output >= ciphertexts.size()) {
		ciphertexts.resize(output + 1);
	}
	ciphertexts[output] = *static_cast<Ciphertext*>(res_void_p);

	uint64_t Y = get_random(params->coeff_modulus()[0].value());

	Ciphertext x_enc = ciphertexts[input1];
	Ciphertext y_enc = ciphertexts[input2];
	Ciphertext res = ciphertexts[output];

	SealPoly r2(*context, res, 2);
	SealPoly x1(*context, x_enc, 1);
	SealPoly y1(*context, y_enc, 1);

	auto tables =
		context->get_context_data(x1.get_parms_id())->small_ntt_tables();

	// res(Y) = res_0 + Y * (res_1 + Y * (res_2))
	r2.multiply_scalar_inplace(Y);
	r2.add_inplace(res, 1);
	r2.multiply_scalar_inplace(Y);
	r2.add_inplace(res, 0);

	// x(Y) = x_0 + x_1 * Y
	x1.multiply_scalar_inplace(Y);
	x1.add_inplace(x_enc, 0);

	// y(Y) = y_0 + y_1 * Y
	y1.multiply_scalar_inplace(Y);
	y1.add_inplace(y_enc, 0);

	// out = res(Y) - x(Y) * y(Y)
	x1.ntt_inplace(tables);
	y1.ntt_inplace(tables);
	x1.multiply_inplace(y1);
	x1.intt_inplace(tables);

	// CHECK
	bool check = r2.is_equal(x1);

	if (!check) {
		throw runtime_error("verification failed");
	}
}

void ecall_MultiplyOutsource_BenchHost(int input1, int input2, int output) {
	Ciphertext* res_p = nullptr;
	void* res_void_p = static_cast<void*>(res_p);
	oe_result_t result = ocall_Multiply_BenchHost(&res_void_p, input1, input2);
	if (result != OE_OK) {
		cerr << "[SGX] ocall_Multiply had error " << result << " "
			<< oe_result_str(result) << endl;
	}
	if (output >= ciphertexts.size()) {
		ciphertexts.resize(output + 1);
	}
	ciphertexts[output] = *static_cast<Ciphertext*>(res_void_p);

	uint64_t Y = get_random(params->coeff_modulus()[0].value());

	Ciphertext x_enc = ciphertexts[input1];
	Ciphertext y_enc = ciphertexts[input2];
	Ciphertext res = ciphertexts[output];

	SealPoly r2(*context, res, 2);
	SealPoly x1(*context, x_enc, 1);
	SealPoly y1(*context, y_enc, 1);

	auto tables =
		context->get_context_data(x1.get_parms_id())->small_ntt_tables();

	// res(Y) = res_0 + Y * (res_1 + Y * (res_2))
	r2.multiply_scalar_inplace(Y);
	r2.add_inplace(res, 1);
	r2.multiply_scalar_inplace(Y);
	r2.add_inplace(res, 0);

	// x(Y) = x_0 + x_1 * Y
	x1.multiply_scalar_inplace(Y);
	x1.add_inplace(x_enc, 0);

	// y(Y) = y_0 + y_1 * Y
	y1.multiply_scalar_inplace(Y);
	y1.add_inplace(y_enc, 0);

	// out = res(Y) - x(Y) * y(Y)
	x1.ntt_inplace(tables);
	y1.ntt_inplace(tables);
	x1.multiply_inplace(y1);
	x1.intt_inplace(tables);

	// CHECK
	bool check = r2.is_equal(x1);

	if (!check) {
		throw runtime_error("verification failed");
	}
}

void ecall_VerifyMult(int input1, int input2, int output) {
	uint64_t Y = get_random(params->coeff_modulus()[0].value());

	Ciphertext x_enc = ciphertexts[input1];
	Ciphertext y_enc = ciphertexts[input2];
	Ciphertext res = ciphertexts[output];

	SealPoly r2(*context, res, 2);
	SealPoly x1(*context, x_enc, 1);
	SealPoly y1(*context, y_enc, 1);

	auto tables = context->get_context_data(x1.get_parms_id())->small_ntt_tables();

	// res(Y) = res_0 + Y * (res_1 + Y * (res_2))
	r2.multiply_scalar_inplace(Y);
	r2.add_inplace(res, 1);
	r2.multiply_scalar_inplace(Y);
	r2.add_inplace(res, 0);

	// x(Y) = x_0 + x_1 * Y
	x1.multiply_scalar_inplace(Y);
	x1.add_inplace(x_enc, 0);

	// y(Y) = y_0 + y_1 * Y
	y1.multiply_scalar_inplace(Y);
	y1.add_inplace(y_enc, 0);

	// out = res(Y) - x(Y) * y(Y)
	x1.ntt_inplace(tables);
	y1.ntt_inplace(tables);
	x1.multiply_inplace(y1);
	x1.intt_inplace(tables);

	// CHECK
	bool check = r2.is_equal(x1);

	if (!check) {
		throw runtime_error("verification failed");
	}
}

void ecall_VerifyMultBatch_1() {
	int NUM_CTXTS = 1;
	vector<uint64_t> Y(NUM_CTXTS);
	SealPoly* x = nullptr;
	SealPoly* y = nullptr;
	SealPoly* r = nullptr;

	int i = 0;
	for (size_t j = 0; j < 1; j++) {
		Y[i] = get_random(params->coeff_modulus()[0].value());

		SealPoly curr_x(*context, ciphertexts[i], 1);
		SealPoly curr_y(*context, ciphertexts[NUM_CTXTS + i], 1);
		SealPoly curr_r(*context, ciphertexts[2 * NUM_CTXTS + i], 2);

		curr_x.multiply_scalar_inplace(Y[i]);
		curr_x.add_inplace(ciphertexts[i], 0);

		curr_y.multiply_scalar_inplace(Y[i]);
		curr_y.add_inplace(ciphertexts[NUM_CTXTS + i], 0);

		curr_r.multiply_scalar_inplace(Y[i]);
		curr_r.add_inplace(ciphertexts[2 * NUM_CTXTS + i], 1);
		curr_r.multiply_scalar_inplace(Y[i]);
		curr_r.add_inplace(ciphertexts[2 * NUM_CTXTS + i], 0);

		if (i == 0) {
			x = &curr_x;
			y = &curr_y;
			r = &curr_r;
		}
		else {
			x->add_inplace(curr_x);
			y->add_inplace(curr_y);
			r->add_inplace(curr_r);
		}
	}

	auto tables = context->get_context_data(x->get_parms_id())->small_ntt_tables();

	x->ntt_inplace(tables);
	y->ntt_inplace(tables);
	x->multiply_inplace(*y);
	x->intt_inplace(tables);

	// CHECK
	bool check = r->is_equal(*x);

	if (!check) {
		throw runtime_error("verification failed");
	}
}

void ecall_VerifyMultBatch(int NUM_CTXTS) {
	vector<uint64_t> Y(NUM_CTXTS);
	SealPoly* x = nullptr;
	SealPoly* y = nullptr;
	SealPoly* r = nullptr;

	for (size_t i = 0; i < NUM_CTXTS; i++) {
		Y[i] = get_random(params->coeff_modulus()[0].value());

		SealPoly curr_x(*context, ciphertexts[i], 1);
		SealPoly curr_y(*context, ciphertexts[NUM_CTXTS + i], 1);
		SealPoly curr_r(*context, ciphertexts[2 * NUM_CTXTS + i], 2);

		curr_x.multiply_scalar_inplace(Y[i]);
		curr_x.add_inplace(ciphertexts[i], 0);

		curr_y.multiply_scalar_inplace(Y[i]);
		curr_y.add_inplace(ciphertexts[NUM_CTXTS + i], 0);

		curr_r.multiply_scalar_inplace(Y[i]);
		curr_r.add_inplace(ciphertexts[2 * NUM_CTXTS + i], 1);
		curr_r.multiply_scalar_inplace(Y[i]);
		curr_r.add_inplace(ciphertexts[2 * NUM_CTXTS + i], 0);

		if (i == 0) {
			x = &curr_x;
			y = &curr_y;
			r = &curr_r;
		}
		else {
			x->add_inplace(curr_x);
			y->add_inplace(curr_y);
			r->add_inplace(curr_r);
		}
	}

	auto tables = context->get_context_data(x->get_parms_id())->small_ntt_tables();

	x->ntt_inplace(tables);
	y->ntt_inplace(tables);
	x->multiply_inplace(*y);
	x->intt_inplace(tables);

	// CHECK
	bool check = r->is_equal(*x);

	if (!check) {
		throw runtime_error("verification failed");
	}
}

void ecall_Tiny() {
	Ciphertext* res = new Ciphertext();
	try {
		evaluator->multiply(ciphertexts[0], ciphertexts[1], *res);
	}
	catch (exception& e) {
		cerr << "[SGX] multiply threw exception: " << e.what() << endl << flush;
		throw e;
	}
	int output = 2;

	if (output >= ciphertexts.size()) {
		ciphertexts.resize(output + 1);
	}
	ciphertexts[output] = *res;
}

void ecall_Small() {
	Ciphertext* res = new Ciphertext();
	try {
		evaluator->multiply_plain(ciphertexts[0], plaintexts[0], *res);
		evaluator->add_plain_inplace(*res, plaintexts[1]);
		for (int i = 0; i < 128 / 2; i++) {
			evaluator->add_inplace(*res, noise[2 * i]);
		}
	}
	catch (exception& e) {
		cerr << "[SGX] small threw exception: " << e.what() << endl << flush;
		throw e;
	}
	/*
	int output = 1;

	if (output >= ciphertexts.size()) {
		ciphertexts.resize(output + 1);
	}
	ciphertexts[output] = *res;
	*/
}

void ecall_Medium() {
	Ciphertext* res = new Ciphertext();
	try {
		evaluator->sub_plain(ciphertexts[0], plaintexts[0], *res);
		evaluator->square_inplace(*res);
		evaluator->mod_switch_to_next_inplace(*res);

		for (int i = 0; i < 128 / 2; i++) {
			evaluator->add_inplace(*res, noise[2 * i]);
		}
	}
	catch (exception& e) {
		cerr << "[SGX] small threw exception: " << e.what() << endl << flush;
		throw e;
	}
}