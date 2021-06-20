/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef APPENDERFILE_H
#define APPENDERFILE_H

#include "Appender.h"
#include <atomic>

class AppenderFile : public Appender
{
public:
    static constexpr AppenderType type = APPENDER_FILE;

    AppenderFile(uint8 id, std::string const& name, LogLevel level, AppenderFlags flags, std::vector<std::string_view> const& args);
    ~AppenderFile();
    FILE* OpenFile(std::string const& name, std::string const& mode, bool backup);
    AppenderType getType() const override { return type; }

private:
    void CloseFile();
    void _write(LogMessage const* message) override;
    FILE* logfile;
    std::string _fileName;
    std::string _logDir;
    bool _dynamicName;
    bool _backup;
    uint64 _maxFileSize;
    std::atomic<uint64> _fileSize;
};

#endif
