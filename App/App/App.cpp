#include <openenclave/host.h>

#include <iomanip>
#include <iostream>

#include "Enclave_u.h"
#include "seal/seal.h"

using namespace std;
using namespace seal;

// Benchmarking
size_t NUM_REPEATS = 5;
size_t NUM_CTXTS = 1;
std::chrono::time_point<std::chrono::high_resolution_clock> time_start;
std::chrono::time_point<std::chrono::high_resolution_clock> time_end;

// FHE params
size_t N = 8192;
string bench_name = "medium"; // "tiny";  "small"; "medium"; 

// Host-side SEAL
vector<Ciphertext> ciphertexts;
Evaluator* evaluator;
SEALContext* context;

oe_result_t create_Enclave_enclave(const char* enclave_name,
	oe_enclave_t** out_enclave) {
	oe_enclave_t* enclave = NULL;
	uint32_t enclave_flags = 0;
	oe_result_t result;

	*out_enclave = NULL;

	// Create the enclave
#ifdef _DEBUG
	enclave_flags |= OE_ENCLAVE_FLAG_DEBUG;
#endif
	result = oe_create_Enclave_enclave(enclave_name, OE_ENCLAVE_TYPE_AUTO,
		enclave_flags, NULL, 0, &enclave);
	if (result != OE_OK) {
		printf("Error %d creating enclave\n", result);
		/*printf("Error %d creating enclave, trying simulation mode...\n", result);
		enclave_flags |= OE_ENCLAVE_FLAG_SIMULATE;
		result = oe_create_Enclave_enclave(
				enclave_name,
				OE_ENCLAVE_TYPE_AUTO,
				enclave_flags,
				NULL,
				0,
				&enclave);*/
	}
	if (result != OE_OK) {
		return result;
	}

	*out_enclave = enclave;
	return OE_OK;
}

oe_enclave_t* setup_enclave(void) {
	oe_enclave_t* enclave = NULL;
	oe_result_t result = create_Enclave_enclave(
#ifdef OE_USE_OPTEE
		"FILL THIS IN",
#else
		"Enclave.elf.signed",
#endif
		& enclave);
	if (result != OE_OK) {
		fprintf(stderr, "oe_create_enclave(): result=%u (%s)\n", result,
			oe_result_str(result));
		/* Clean up the enclave if we created one. */
		if (enclave != NULL) {
			oe_terminate_enclave(enclave);
		}
		return NULL;
	}

	return enclave;
}

void teardown_enclave(oe_enclave_t* enclave) {
	/* Clean up the enclave if we created one. */
	if (enclave != NULL) {
		oe_terminate_enclave(enclave);
	}
}

void ocall_StoreInput(int index, unsigned char* buffer, size_t len) {
	// cout << "[APP] StoreInput(" << index << ", " << static_cast<void*>(buffer)
	// << ", " << len << ")" << endl << flush;

	Ciphertext* ciphertext = new Ciphertext();
	seal_byte* seal_buffer = reinterpret_cast<seal_byte*>(buffer);
	try {
		ciphertext->load(*context, seal_buffer, len);
	}
	catch (exception& e) {
		cerr << "[APP] Ciphertext::load() threw exception: " << e.what() << endl
			<< flush;
		throw e;
	}
	if (index >= ciphertexts.size()) {
		ciphertexts.resize(index + 1);
	}
	ciphertexts[index] = *ciphertext;
}

void* ocall_Multiply(int input1, int input2) {
	Ciphertext* res = new Ciphertext();
	evaluator->multiply(ciphertexts[input1], ciphertexts[input2], *res);
	return static_cast<void*>(res);
}

void* ocall_Multiply_BenchHost(int input1, int input2) {
	time_start = chrono::high_resolution_clock::now();

	Ciphertext* res = new Ciphertext();
	evaluator->multiply(ciphertexts[input1], ciphertexts[input2], *res);

	time_end = chrono::high_resolution_clock::now();
	return static_cast<void*>(res);
}

void* Multiply_BenchHost(int input1, int input2) {
	time_start = chrono::high_resolution_clock::now();

	Ciphertext* res = new Ciphertext();
	evaluator->multiply(ciphertexts[input1], ciphertexts[input2], *res);

	time_end = chrono::high_resolution_clock::now();
	return static_cast<void*>(res);
}

void print_SEAL_options() {
	cout << "[APP] C++ version: \t" << __cplusplus << endl;
	cout << "[APP] SEAL_USE_INTRIN"
		<< "\t"
		<<
#ifdef SEAL_USE_INTRIN
		"ON"
#else
		"OFF"
#endif
		<< endl;
	cout << "[APP] SEAL_USE_INTEL_HEXL"
		<< "\t"
		<<
#ifdef SEAL_USE_INTEL_HEXL
		"ON"
#else
		"OFF"
#endif
		<< endl;
	cout << "[APP] SEAL_USE_MSGSL"
		<< "\t"
		<<
#ifdef SEAL_USE_MSGSL
		"ON"
#else
		"OFF"
#endif
		<< endl;
}

void print_time(string func_name, unsigned long long elapsed_time) {
	cout << "[TIME] " << func_name << "\t" << fixed << setprecision(0) << right
		<< setw(10) << elapsed_time / float(NUM_REPEATS) << " us" << endl;
}

void print_header(string header, int width = 50) {
	cout << endl;
	cout << setfill('=') << setw(width) << "=" << endl;
	int wl = width - header.size() - 2;
	cout << setw(wl) << " " << header << " " << setw(width - wl - 1) << '='
		<< endl;
	;
	cout << endl;
	cout << setfill(' ');
}

void initHost() {
	ciphertexts = vector<Ciphertext>();

	// Set up SEAL parameters
	EncryptionParameters params(scheme_type::bgv);
	auto poly_modulus_degree = N;
	params.set_poly_modulus_degree(poly_modulus_degree);

	if (bench_name == "tiny") {
		params.set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, { 43, 43, 60 }));
	}
	else if (bench_name == "small") {
		params.set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, { 59, 60, 60 }));
	}
	else if (bench_name == "medium") {
		params.set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, { 45, 46, 46, 46 }));
	}
	else {
		throw invalid_argument(bench_name);
	}
	params.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 30));

	context = new SEALContext(params);

	evaluator = new Evaluator(*context);

	// Generate ciphertexts (TODO: receive these from client)
	KeyGenerator keygen(*context);
	const SecretKey& secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);
	BatchEncoder batch_encoder(*context);

	Encryptor encryptor(*context, public_key);

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

	for (size_t i = 0; i < NUM_CTXTS; i++) {
		ciphertexts.push_back(x_enc);
	}
	for (size_t i = 0; i < NUM_CTXTS; i++) {
		ciphertexts.push_back(y_enc);
	}

	print_SEAL_options();
}

int main() {
	long long elapsed_time;

	cout << "[APP] Starting on host" << endl;
	initHost();
	cout << "[APP] initHost done" << endl;

	// Load enclave
	auto enclave = setup_enclave();
	oe_result_t result;
	cout << "[APP] setup_enclave done" << endl;

	// Init enclave
	result = ecall_InitEnclave(enclave);
	if (result != OE_OK) {
		cerr << "[APP] calling into ecall_InitEnclave failed: result=" << result
			<< "(" << oe_result_str(result) << ")" << endl;
		return result;
	}
	cout << "[APP] ecall_InitEnclave done" << endl;

	// Send ctxts to enclave (TODO: send by client instead)
	/*
	vector<seal_byte>* buffer = new vector<seal_byte>();
	for (size_t i = 0; i < ciphertexts.size(); i++) {
		size_t curr_size = ciphertexts[i].save_size();
		if (curr_size > buffer->size()) {
			buffer->resize(curr_size);
		}
		ciphertexts[i].save(buffer->data(), curr_size);
		unsigned char* c_buffer = reinterpret_cast<unsigned char*>(buffer->data());
		result = ecall_StoreInput(enclave, i, c_buffer, curr_size);
		if (result != OE_OK) {
			cerr << "[APP] calling into ecall_StoreInput failed: result=" << result
				<< "(" << oe_result_str(result) << ")" << endl;
			return result;
		}
		cout << "[APP] \tecall_StoreInput " << i << "/" << ciphertexts.size() - 1
			<< " done" << endl;
	}
	cout << "[APP] ecall_StoreInput done" << endl;
	*/


	// Ask enclave to compute workload
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		time_start = chrono::high_resolution_clock::now();
		if (bench_name == "tiny") {
			result = ecall_Tiny(enclave);
		}
		else if (bench_name == "small") {
			result = ecall_Small(enclave);
		}
		else if (bench_name == "medium") {
			result = ecall_Medium(enclave);
		}
		else {
			throw invalid_argument(bench_name);
		}

		time_end = chrono::high_resolution_clock::now();
		elapsed_time +=
			chrono::duration_cast<chrono::microseconds>(time_end - time_start)
			.count();

		if (result != OE_OK) {
			cerr << "[APP] calling into ecall_" << bench_name << "failed: result = " << result
				<< "(" << oe_result_str(result) << ")" << endl;
			return result;
		}

	}
	print_time(bench_name, elapsed_time);


	// Tell enclave to send inputs to host
	/*
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		time_start = chrono::high_resolution_clock::now();
		result = ecall_SendInputs(enclave);
		time_end = chrono::high_resolution_clock::now();
		elapsed_time +=
			chrono::duration_cast<chrono::microseconds>(time_end - time_start)
			.count();

		if (result != OE_OK) {
			cerr << "[APP] calling into ecall_SendInputs failed: result=" << result
				<< "(" << oe_result_str(result) << ")" << endl;
			return result;
		}
	}
	print_time("Sending inputs host<-enclave", elapsed_time);
	*/


	/*
	// Ask enclave to multiply two ciphertexts
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		for (size_t idx = 0; idx < NUM_CTXTS; idx++) {
			time_start = chrono::high_resolution_clock::now();
			result = ecall_Multiply(enclave, idx, NUM_CTXTS + idx, 2 * NUM_CTXTS + idx);
			time_end = chrono::high_resolution_clock::now();
			elapsed_time +=
				chrono::duration_cast<chrono::microseconds>(time_end - time_start)
				.count();

			if (result != OE_OK) {
				cerr << "[APP] calling into ecall_Multiply failed: result=" << result
					<< "(" << oe_result_str(result) << ")" << endl;
				return result;
			}
		}
	}
	print_time("Multiplication in enclave (" + to_string(NUM_CTXTS) + ")", elapsed_time);

	// Ask enclave to multiply two ciphertexts with outsourcing to host
	// It will call back to the host to carry out the multiplications, and then
	// verify it itself
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		for (size_t idx = 0; idx < NUM_CTXTS; idx++) {
			time_start = chrono::high_resolution_clock::now();
			result = ecall_MultiplyOutsource(enclave, idx, NUM_CTXTS + idx, 2 * NUM_CTXTS + idx);
			time_end = chrono::high_resolution_clock::now();
			elapsed_time +=
				chrono::duration_cast<chrono::microseconds>(time_end - time_start)
				.count();

			if (result != OE_OK) {
				cerr << "[APP] calling into ecall_MultiplyOutsource failed: result="
					<< result << "(" << oe_result_str(result) << ")" << endl;
				return result;
			}
		}
	}
	print_time("MultiplicationOutsource (E/O)", elapsed_time);


	print_header("MICRO_BENCHMARKS");

	// Multiplication done on host during ocall
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		for (size_t idx = 0; idx < NUM_CTXTS; idx++) {
			result = ecall_MultiplyOutsource_BenchHost(enclave, idx, NUM_CTXTS + idx, 2 * NUM_CTXTS + idx);
			elapsed_time +=
				chrono::duration_cast<chrono::microseconds>(time_end - time_start)
				.count();

			if (result != OE_OK) {
				cerr << "[APP] calling into ecall_MultiplyOutsource_BenchHost failed: "
					"result="
					<< result << "(" << oe_result_str(result) << ")" << endl;
				return result;
			}
		}
	}
	print_time("Multiply in host only (ocall)", elapsed_time);

	// Multiplication done on host during ocall
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		for (size_t idx = 0; idx < NUM_CTXTS; idx++) {
			Multiply_BenchHost(idx, NUM_CTXTS + idx);
			elapsed_time +=
				chrono::duration_cast<chrono::microseconds>(time_end - time_start)
				.count();
		}
	}
	print_time("Multiply in host only (no OCALL)", elapsed_time);

	// Verification on enclave
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		for (size_t idx = 0; idx < NUM_CTXTS; idx++) {
			time_start = chrono::high_resolution_clock::now();
			result = ecall_VerifyMult(enclave, idx, NUM_CTXTS + idx, 2 * NUM_CTXTS + idx);
			time_end = chrono::high_resolution_clock::now();
			elapsed_time +=
				chrono::duration_cast<chrono::microseconds>(time_end - time_start)
				.count();

			if (result != OE_OK) {
				cerr << "[APP] calling into ecall_VerifyMult failed: result=" << result
					<< "(" << oe_result_str(result) << ")" << endl;
				return result;
			}
		}
	}
	print_time("Verification on enclave (ECALL)", elapsed_time);

	//// Test Verification-1 on enclave
	//elapsed_time = 0;
	//for (size_t i = 0; i < NUM_REPEATS; i++) {
	//	for (size_t idx = 0; idx < NUM_CTXTS; idx++) {
	//		time_start = chrono::high_resolution_clock::now();
	//		result = ecall_VerifyMultBatch_1(enclave);
	//		time_end = chrono::high_resolution_clock::now();
	//		elapsed_time +=
	//			chrono::duration_cast<chrono::microseconds>(time_end - time_start)
	//			.count();

	//		if (result != OE_OK) {
	//			cerr << "[APP] calling into ecall_VerifyMult failed: result=" << result
	//				<< "(" << oe_result_str(result) << ")" << endl;
	//			return result;
	//		}
	//	}
	//}
	//print_time("Verification batch=1", elapsed_time);

	// Batch-Verification on enclave
	elapsed_time = 0;
	for (size_t i = 0; i < NUM_REPEATS; i++) {
		time_start = chrono::high_resolution_clock::now();
		result = ecall_VerifyMultBatch(enclave, NUM_CTXTS);
		time_end = chrono::high_resolution_clock::now();
		elapsed_time +=
			chrono::duration_cast<chrono::microseconds>(time_end - time_start)
			.count();

		if (result != OE_OK) {
			cerr << "[APP] calling into ecall_VerifyMultBatch failed: result=" << result
				<< "(" << oe_result_str(result) << ")" << endl;
			return result;
		}
	}
	print_time("Verification on enclave (Batch)", elapsed_time);

	*/

	teardown_enclave(enclave);
}