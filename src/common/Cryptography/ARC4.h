/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
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
