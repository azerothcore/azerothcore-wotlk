/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef AZEROTHCORE_HMAC_H
#define AZEROTHCORE_HMAC_H

#include "CryptoConstants.h"
#include "Define.h"
#include "Errors.h"
#include <array>
#include <string>
#include <string_view>
#include <openssl/hmac.h>

class BigNumber;

namespace acore::Impl
{
    struct HMACImpl
    {
        typedef EVP_MD const* (*HashCreator)();

#if defined(OPENSSL_VERSION_NUMBER) && OPENSSL_VERSION_NUMBER < 0x10100000L
        static HMAC_CTX* MakeCTX()
        {
            HMAC_CTX* ctx = new HMAC_CTX();
            HMAC_CTX_init(ctx);
            return ctx;
        }

        static void DestroyCTX(HMAC_CTX* ctx)
        {
            HMAC_CTX_cleanup(ctx);
            delete ctx;
        }
#else
        static HMAC_CTX* MakeCTX() { return HMAC_CTX_new(); }
        static void DestroyCTX(HMAC_CTX* ctx) { HMAC_CTX_free(ctx); }
#endif
    };

    template <HMACImpl::HashCreator HashCreator, size_t DigestLength>
    class GenericHMAC
    {
        public:
            static constexpr size_t DIGEST_LENGTH = DigestLength;
            using Digest = std::array<uint8, DIGEST_LENGTH>;

            template <typename Container>
            static Digest GetDigestOf(Container const& seed, uint8 const* data, size_t len)
            {
                GenericHMAC hash(seed);
                hash.UpdateData(data, len);
                hash.Finalize();
                return hash.GetDigest();
            }

            template <typename Container, typename... Ts>
            static auto GetDigestOf(Container const& seed, Ts&&... pack) -> std::enable_if_t<!(std::is_integral_v<std::decay_t<Ts>> || ...), Digest>
            {
                GenericHMAC hash(seed);
                (hash.UpdateData(std::forward<Ts>(pack)), ...);
                hash.Finalize();
                return hash.GetDigest();
            }

            GenericHMAC(uint8 const* seed, size_t len) : _ctx(HMACImpl::MakeCTX())
            {
                int result = HMAC_Init_ex(_ctx, seed, len, HashCreator(), nullptr);
                ASSERT(result == 1);
            }
            template <typename Container>
            GenericHMAC(Container const& container) : GenericHMAC(std::data(container), std::size(container)) {}

            ~GenericHMAC()
            {
                if (!_ctx)
                    return;
                HMACImpl::DestroyCTX(_ctx);
                _ctx = nullptr;
            }

            void UpdateData(uint8 const* data, size_t len)
            {
                int result = HMAC_Update(_ctx, data, len);
                ASSERT(result == 1);
            }
            void UpdateData(std::string_view str) { UpdateData(reinterpret_cast<uint8 const*>(str.data()), str.size()); }
            void UpdateData(std::string const& str) { UpdateData(std::string_view(str)); } /* explicit overload to avoid using the container template */
            void UpdateData(char const* str) { UpdateData(std::string_view(str)); } /* explicit overload to avoid using the container template */
            template <typename Container>
            void UpdateData(Container const& c) { UpdateData(std::data(c), std::size(c)); }

            void Finalize()
            {
                uint32 length = 0;
                int result = HMAC_Final(_ctx, _digest.data(), &length);
                ASSERT(result == 1);
                ASSERT(length == DIGEST_LENGTH);
                HMACImpl::DestroyCTX(_ctx);
                _ctx = nullptr;
            }

            Digest const& GetDigest() const { return _digest; }
        private:
            HMAC_CTX* _ctx;
            Digest _digest = { };
    };
}

namespace acore::Crypto
{
    using HMAC_SHA1 = acore::Impl::GenericHMAC<EVP_sha1, Constants::SHA1_DIGEST_LENGTH_BYTES>;
    using HMAC_SHA256 = acore::Impl::GenericHMAC<EVP_sha256, Constants::SHA256_DIGEST_LENGTH_BYTES>;
}
#endif
