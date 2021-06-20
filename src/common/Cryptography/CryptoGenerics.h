/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef AZEROTHCORE_CRYPTO_GENERICS_HPP
#define AZEROTHCORE_CRYPTO_GENERICS_HPP

#include "BigNumber.h"
#include "CryptoRandom.h"
#include "Define.h"
#include "Errors.h"
#include <iterator>
#include <vector>

namespace Acore::Impl
{
    struct CryptoGenericsImpl
    {
        template <typename Cipher>
        static typename Cipher::IV GenerateRandomIV()
        {
            typename Cipher::IV iv;
            Acore::Crypto::GetRandomBytes(iv);
            return iv;
        }

        template <typename Container>
        static void AppendToBack(std::vector<uint8>& data, Container const& tail)
        {
            data.insert(data.end(), std::begin(tail), std::end(tail));
        }

        template <typename Container>
        static void SplitFromBack(std::vector<uint8>& data, Container& tail)
        {
            ASSERT(data.size() >= std::size(tail));
            for (size_t i = 1, N = std::size(tail); i <= N; ++i)
            {
                tail[N - i] = data.back();
                data.pop_back();
            }
        }
    };
}

namespace Acore::Crypto
{
    template <typename Cipher>
    void AEEncryptWithRandomIV(std::vector<uint8>& data, typename Cipher::Key const& key)
    {
        using IV = typename Cipher::IV;
        using Tag = typename Cipher::Tag;
        // select random IV
        IV iv = Acore::Impl::CryptoGenericsImpl::GenerateRandomIV<Cipher>();
        Tag tag;

        // encrypt data
        Cipher cipher(true);
        cipher.Init(key);
        bool success = cipher.Process(iv, data.data(), data.size(), tag);
        ASSERT(success);

        // append trailing IV and tag
        Acore::Impl::CryptoGenericsImpl::AppendToBack(data, iv);
        Acore::Impl::CryptoGenericsImpl::AppendToBack(data, tag);
    }

    template <typename Cipher>
    void AEEncryptWithRandomIV(std::vector<uint8>& data, BigNumber const& key)
    {
        AEEncryptWithRandomIV<Cipher>(data, key.ToByteArray<Cipher::KEY_SIZE_BYTES>());
    }

    template <typename Cipher>
    bool AEDecrypt(std::vector<uint8>& data, typename Cipher::Key const& key)
    {
        using IV = typename Cipher::IV;
        using Tag = typename Cipher::Tag;
        // extract trailing IV and tag
        IV iv;
        Tag tag;
        Acore::Impl::CryptoGenericsImpl::SplitFromBack(data, tag);
        Acore::Impl::CryptoGenericsImpl::SplitFromBack(data, iv);

        // decrypt data
        Cipher cipher(false);
        cipher.Init(key);
        return cipher.Process(iv, data.data(), data.size(), tag);
    }

    template <typename Cipher>
    bool AEDecrypt(std::vector<uint8>& data, BigNumber const& key)
    {
        return AEDecrypt<Cipher>(data, key.ToByteArray<Cipher::KEY_SIZE_BYTES>());
    }
}

#endif
