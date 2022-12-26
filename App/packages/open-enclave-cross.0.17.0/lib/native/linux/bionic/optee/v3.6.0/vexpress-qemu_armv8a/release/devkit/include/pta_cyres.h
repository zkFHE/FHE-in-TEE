/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (C) Microsoft. All rights reserved
 */

#ifndef __PTA_CYRES_H
#define __PTA_CYRES_H

/*
 * Interface to the cyres pseudo-TA.
 */

// {5818F318-1887-468F-883A-A8BF7B289B74}
#define PTA_CYRES_UUID { 0x5818f318, 0x1887, 0x468f, { \
		   0x88, 0x3a, 0xa8, 0xbf, 0x7b, 0x28, 0x9b, 0x74 } }

enum PTA_CYRES_CMDS {
	//
	// Get the size of the buffer required by PTA_CYRES_GET_PRIVATE_KEY.
	//
	// params[0]: VALUE_OUTPUT
	//   Receives the size in bytes of the buffer required by
	//   PTA_CYRES_GET_PRIVATE_KEY
	//
	PTA_CYRES_GET_PRIVATE_KEY_SIZE,

	//
	// Get the calling TA's private key.
	//
	// You should first call PTA_CYRES_GET_PRIVATE_KEY_SIZE to
	// get the required buffer size.
	//
	// params[0]: MEMREF_OUTPUT
	//   A buffer that will receive a null-terminated string containing
	//   the private key encoded as PEM.
	//
	PTA_CYRES_GET_PRIVATE_KEY,

	//
	// Get the size of the buffer required by PTA_CYRES_GET_PUBLIC_KEY.
	//
	// params[0]: VALUE_OUTPUT
	//   Receives the size in bytes of the buffer required by
	//   PTA_CYRES_GET_PUBLIC_KEY
	//
	PTA_CYRES_GET_PUBLIC_KEY_SIZE,

	//
	// Get the calling TA's public key.
	//
	// You should first call PTA_CYRES_GET_PUBLIC_KEY_SIZE to get the
	// required buffer size.
	//
	// params[0]: MEMREF_OUTPUT
	//   A buffer that will receive a null-terminated string containing
	//   the public key encoded as PEM.
	//
	PTA_CYRES_GET_PUBLIC_KEY,

	//
	// Get the size of the buffer required by PTA_CYRES_GET_CERT_CHAIN.
	//
	// params[0]: VALUE_OUTPUT
	//   Receives the size in bytes of the buffer required by
	//   PTA_CYRES_GET_CERT_CHAIN.
	//
	PTA_CYRES_GET_CERT_CHAIN_SIZE,

	//
	// Get the calling TA's Cyres certificate chain.
	//
	// You should first call PTA_CYRES_GET_CERT_CHAIN_SIZE to get
	// the required buffer size.
	//
	// params[0]: MEMREF_OUTPUT
	//   A buffer that will receive a null-terminated string containing
	//   the certificate chain encoded as PEM.
	//
	PTA_CYRES_GET_CERT_CHAIN,

	//
	// Returns a secret derived from the TA platform, that can be used
	// for symmetric encryption key.
	//
	// params[0]: MEMREF_OUTPUT
	//   Buffer to hold the seal key. Size must be a multiple of 32 bytes.
	//
	// params[1]: MEMREF_INPUT
	//   Optional selector buffer. Can be NULL.
	//
	PTA_CYRES_GET_SEAL_KEY,
};


#endif /* __PTA_CYRES_H */
