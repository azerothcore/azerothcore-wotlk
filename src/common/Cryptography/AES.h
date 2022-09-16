/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#ifndef Warhead_AES_h__
#define Warhead_AES_h__

#include "Define.h"
#include <array>
#include <openssl/evp.h>

namespace Acore::Crypto
{
    class AC_COMMON_API AES
    {
    public:
        static constexpr size_t IV_SIZE_BYTES = 12;
        static constexpr size_t KEY_SIZE_BYTES = 16;
        static constexpr size_t TAG_SIZE_BYTES = 12;

        using IV = std::array<uint8, IV_SIZE_BYTES>;
        using Key = std::array<uint8, KEY_SIZE_BYTES>;
        using Tag = uint8[TAG_SIZE_BYTES];

        explicit AES(bool encrypting);
        ~AES();

        void Init(Key const& key);

        bool Process(IV const& iv, uint8* data, size_t length, Tag& tag);

    private:
        EVP_CIPHER_CTX* _ctx;
        bool _encrypting;
    };
}

#endif // Warhead_AES_h__
