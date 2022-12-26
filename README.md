# FHE-in-TEE
A framework to run Fully Homomorphic Encryption (FHE) computations (especially using the SEAL library) on Trusted Execution Environments (TEEs). 
This framework also includes a scheme to verifiably offload some computations to untrusted hardware for faster evaluation. 

## Introduction

This framework leverages FHE and TEEs to enable a user to _verifiably_ outsource computations on _private_ data to a potentially actively malicious server. 

### Why not use FEE/TEEs alone?

TEEs enable a user to run a program on a secure co-processor (an enclave) designed to be free from interference from the operating system. 
TEEs promise _integrity_ (the program being run is exactly the one specified by the user) and _confidentiality_ (the data processed by the program is not leaked outside of the enclave) against an actively malicious adversary with control over the operating system. 
In practice however, the confidentiality guarantees of TEEs have been reguarly broken [[1]](#1), notably due to side-channel attacks. 
On the contrary, the integrity properties of TEEs have withstood the attacks of researchers much better (some attacks were still found, e.g., by lowering the power supply of the enclave until faults start appearing [[2]](#2)). 

On the other hand, FHE is a cryptographic primitive that enables arbitrary computations to be performed on encrypted data, thus guaranteeing the confidentiality of the user's data. 
However, the inherent malleability of FHE allows a malicious adversary to tamper with an FHE computation, and voids any integrity guarantees for the user. 

By running an FHE computation inside a TEE, this framework guarantees confidentiality and integrity for outsourced computations.
This approach was first introduced by Natarajan, Loveless, Dai, and Dreslinski in CHEX-MIX [[3]](#3). 

Unfortunately, the code used in CHEX-MIX is not open-source, and combining FHE and TEE requires some non-trivial expertise in both FHE and TEE stacks. 
This prompted the development of this framework to abstract away some of the gory engineering details, and provide a clean template to port existing FHE applications to the TEE setting. 

### Accelerating FHE-in-TEE using untrusted hardware

Computing inside an enclave imposes an additional computational cost, especially for FHE computations; this is due to a reduced standard library available on the enclave, together with a restricted enclave memory size. 
We address this slowdown by using a custom, lightweight cryptographic protocol to verifiably offload sub-computations to the faster untrusted hardware (i.e., the regular CPU). 
This offloading protocol uses the Schwartz-Zippel lemma over rings to probabilistically test polynomial equality. 
The confidentiality of the data is always guaranteed, as all computations are done over FHE ciphertexts. 

### Requirements

This framework uses the [SEAL](https://github.com/microsoft/SEAL) library for FHE (which implements the B/FV, BGV, and CKKS schemes). 
We rely on the [Open Enclave SDK](https://github.com/openenclave/openenclave) to interface with TEEs; Open Enclave can target Intel SGX and ARM TrustZone, and can run in simulation mode if no trusted hardware backend is available. 
For our verifiable offloading protocol, this framework uses the the `polytools` set of utilities. `polytools` was developed by Alexander Viand at Intel Labs, and is still closed-sourced (stay tuned for its open-sourcing!). 

### Security

This code is a research-quality proof-of-concept, has not undergone a thorough security review, and is still being actively developed. 
You are welcome to use it for proof-of-concept and research projects, but this code is not suitable for critical and production systems. 

## Installation

Build SEAL from source, by following the detailed installation instructions on the [SEAL README](https://github.com/microsoft/SEAL/#building-microsoft-seal-manually).

For Open Enclave, follow the [Open Enclave "Getting Started" docs](https://github.com/openenclave/openenclave/tree/master/docs/GettingStartedDocs) for your chosen platform and hardware backend. 

After these components are set up, you should be able to open the [App.sln](/blob/main/App/App.sln) Visual Studio solution file, and run the sample application right away. 

This framework was developed and tested on Windows 10 with Visual Studio 2019 and an Intel SGX backend. 

## Usage
You should be able to port existing FHE applications written in SEAL directly by copying your code to the enclave-side files. 
To use verifiable offloading, you can use the functions `ecall_VerifyMult` in [Enclave_ecalls.cpp](/blob/main/App/Enclave/Enclave_ecalls.cpp).

## References

<a id="1">[1]</a> A. Nilsson, P. N. Bideh, and J. Brorsson, “A Survey of Published Attacks on Intel SGX,” arXiv [cs.CR], Jun. 24, 2020 [Online]. Available: http://arxiv.org/abs/2006.13598

<a id="2">[2]</a> K. Murdock, D. Oswald, F. D. Garcia, J. Van Bulck, D. Gruss, and F. Piessens, “Plundervolt: Software-based Fault Injection Attacks against Intel SGX,” in 2020 IEEE Symposium on Security and Privacy (SP), San Francisco, CA, USA, May 2020, pp. 1466–1482, doi: 10.1109/SP40000.2020.00057 [Online]. Available: http://dx.doi.org/10.1109/SP40000.2020.00057

<a id="3">[3]</a> D. Natarajan, A. Loveless, W. Dai, and R. Dreslinski, “CHEX-MIX: Combining Homomorphic Encryption with Trusted Execution Environments for Two-party Oblivious Inference in the Cloud,” Cryptology ePrint Archive, 2021 [Online]. Available: https://eprint.iacr.org/2021/1603. [Accessed: Nov. 02, 2022]
