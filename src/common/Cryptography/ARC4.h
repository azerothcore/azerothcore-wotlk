/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _AUTH_SARC4_H
#define _AUTH_SARC4_H

#include "Define.h"

#include <array>
#include <openssl/evp.h>

namespace acore::Crypto
{
    class ARC4
    {
        public:
            ARC4();
            ~ARC4();

            void Init(uint8 const* seed, size_t len);
            template <typename Container>
            void Init(Container const& c) { Init(std::data(c), std::size(c)); }

            void UpdateData(uint8* data, size_t len);
            template <typename Container>
            void UpdateData(Container& c) { UpdateData(std::data(c), std::size(c)); }
        private:
            EVP_CIPHER_CTX* _ctx;
    };
}

#endif
