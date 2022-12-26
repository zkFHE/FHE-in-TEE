// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

#pragma once

#include "seal_sgx/context.h"
#include "seal_sgx/memorymanager.h"
#include "seal_sgx/plaintext.h"
#include "seal_sgx/util/iterator.h"
#include <cstdint>

namespace seal_sgx
{
    namespace util
    {
        void add_plain_without_scaling_variant(
            const Plaintext &plain, const SEALContext::ContextData &context_data, RNSIter destination);

        void sub_plain_without_scaling_variant(
            const Plaintext &plain, const SEALContext::ContextData &context_data, RNSIter destination);

        void multiply_add_plain_with_scaling_variant(
            const Plaintext &plain, const SEALContext::ContextData &context_data, RNSIter destination);

        void multiply_sub_plain_with_scaling_variant(
            const Plaintext &plain, const SEALContext::ContextData &context_data, RNSIter destination);
    } // namespace util
} // namespace seal_sgx
