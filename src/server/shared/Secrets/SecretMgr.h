/*
 * Copyright (C) 2016+  AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+  WarheadCore <https://github.com/WarheadCore>
 */

#ifndef __WARHEAD_SECRETMGR_H__
#define __WARHEAD_SECRETMGR_H__

#include "BigNumber.h"
#include "Common.h"
#include "Optional.h"
#include "Log.h"
#include <array>
#include <mutex>
#include <string>

enum Secrets : uint32
{
    SECRET_TOTP_MASTER_KEY = 0,

    // only add new indices right above this line
    NUM_SECRETS
};

class AC_SHARED_API SecretMgr
{
private:
    SecretMgr() {}
    ~SecretMgr() {}

public:
    SecretMgr(SecretMgr const&) = delete;
    static SecretMgr* instance();

    struct Secret
    {
        public:
            explicit operator bool() const { return (state == PRESENT); }
            BigNumber const& operator*() const { return value; }
            BigNumber const* operator->() const { return &value; }
            bool IsAvailable() const { return (state != NOT_LOADED_YET) && (state != LOAD_FAILED); }

        private:
            std::mutex lock;
            enum { NOT_LOADED_YET, LOAD_FAILED, NOT_PRESENT, PRESENT } state = NOT_LOADED_YET;
            BigNumber value;

        friend class SecretMgr;
    };

    void Initialize();
    Secret const& GetSecret(Secrets i);

private:
    void AttemptLoad(Secrets i, LogLevel errorLevel, std::unique_lock<std::mutex> const&);
    Optional<std::string> AttemptTransition(Secrets i, Optional<BigNumber> const& newSecret, Optional<BigNumber> const& oldSecret, bool hadOldSecret) const;

    std::array<Secret, NUM_SECRETS> _secrets;
};

#define sSecretMgr SecretMgr::instance()

#endif
