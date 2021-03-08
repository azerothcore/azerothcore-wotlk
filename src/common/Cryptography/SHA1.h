/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _AUTH_SHA1_H
#define _AUTH_SHA1_H

#include "Define.h"
#include <string>
#include <openssl/sha.h>

class BigNumber;

class SHA1Hash
{
public:
    SHA1Hash();
    ~SHA1Hash();

    void UpdateBigNumbers(BigNumber* bn0, ...);

    void UpdateData(const uint8* dta, int len);
    void UpdateData(const std::string& str);

    void Initialize();
    void Finalize();

    uint8* GetDigest() { return mDigest; };
    [[nodiscard]] int GetLength() const { return SHA_DIGEST_LENGTH; };

private:
    SHA_CTX mC;
    uint8 mDigest[SHA_DIGEST_LENGTH];
};
#endif
