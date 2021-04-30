/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef APPENDERDB_H
#define APPENDERDB_H

#include "Appender.h"

class AppenderDB : public Appender
{
public:
    static constexpr AppenderType type = APPENDER_DB;

    AppenderDB(uint8 id, std::string const& name, LogLevel level, AppenderFlags flags, std::vector<std::string_view> const& args);
    ~AppenderDB();

    void setRealmId(uint32 realmId) override;
    AppenderType getType() const override { return type; }

private:
    uint32 realmId;
    bool enabled;
    void _write(LogMessage const* message) override;
};

#endif
