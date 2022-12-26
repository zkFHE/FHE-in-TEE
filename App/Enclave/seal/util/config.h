// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

#pragma once

#define SEAL_VERSION "4.0.0"
#define SEAL_VERSION_MAJOR 4
#define SEAL_VERSION_MINOR 0
#define SEAL_VERSION_PATCH 0

// Are we in debug mode?
/* #undef SEAL_DEBUG */

// C++17 features
/* #undef SEAL_USE_STD_BYTE */
/* #undef SEAL_USE_ALIGNED_ALLOC */
/* #undef SEAL_USE_SHARED_MUTEX */
/* #undef SEAL_USE_IF_CONSTEXPR */
/* #undef SEAL_USE_MAYBE_UNUSED */
/* #undef SEAL_USE_NODISCARD */
/* #undef SEAL_USE_STD_FOR_EACH_N */

// Security
#define SEAL_THROW_ON_TRANSPARENT_CIPHERTEXT
/* #undef SEAL_USE_GAUSSIAN_NOISE */
#define SEAL_DEFAULT_PRNG Blake2xb
/* #undef SEAL_AVOID_BRANCHING */

// Intrinsics
/* #undef SEAL_USE_INTRIN */
/* #undef SEAL_USE__UMUL128 */
/* #undef SEAL_USE__BITSCANREVERSE64 */
/* #undef SEAL_USE___BUILTIN_CLZLL */
/* #undef SEAL_USE___INT128 */
/* #undef SEAL_USE__ADDCARRY_U64 */
/* #undef SEAL_USE__SUBBORROW_U64 */

// Zero memory functions
/* #undef SEAL_USE_EXPLICIT_BZERO */
/* #undef SEAL_USE_EXPLICIT_MEMSET */
/* #undef SEAL_USE_MEMSET_S */

// Third-party dependencies
/* #undef SEAL_USE_MSGSL */
/* #undef SEAL_USE_ZLIB */
/* #undef SEAL_USE_ZSTD */
/* #undef SEAL_USE_INTEL_HEXL */
