/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#ifndef AZEROTHCORE_LOGMOCK_H
#define AZEROTHCORE_LOGMOCK_H

#include "gmock/gmock.h"
#include "ILog.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

LoginDatabaseWorkerPool LoginDatabase;

class LogMock: public ILog {
public:
    ~LogMock() override {}
    MOCK_METHOD(void, Initialize, ());
    MOCK_METHOD(void, ReloadConfig, ());
    MOCK_METHOD(void, InitColors, (const std::string& init_str));
    void SetColor(bool stdout_stream, ColorTypes color) override {}
    MOCK_METHOD(void, ResetColor, (bool stdout_stream));
    MOCK_METHOD(void, outDB, (LogTypes type, const char* str));
    void outString(const char* str, ...) override {}
    MOCK_METHOD(void, outString, ());
    void outStringInLine(const char* str, ...) override {}
    MOCK_METHOD(void, outErrorMock, ()); // because outError has variadic type and cannot be directly mocked
    void outError(const char* err, ...) override { outErrorMock(); }
    void outCrash(const char* err, ...) override {}
    void outBasic(const char* str, ...) override {}
    void outDetail(const char* str, ...) override {}
    void outSQLDev(const char* str, ...) override {}
    void outDebug(DebugLogFilters f, const char* str, ...) override {}
    void outStaticDebug(const char* str, ...) override {}
    void outErrorDb(const char* str, ...) override {}
    void outChar(const char* str, ...) override {}
    void outCommand(uint32 account, const char* str, ...) override {}
    void outChat(const char* str, ...) override {}
    void outRemote(const char* str, ...) override {}
    void outSQLDriver(const char* str, ...) override {}
    void outMisc(const char* str, ...) override {}
    void outCharDump(const char* str, uint32 account_id, uint32 guid, const char* name) override {}
    MOCK_METHOD(void, SetLogLevel, (char* Level));
    MOCK_METHOD(void, SetLogFileLevel, (char* Level));
    MOCK_METHOD(void, SetSQLDriverQueryLogging, (bool newStatus));
    MOCK_METHOD(void, SetRealmID, (uint32 id));
    MOCK_METHOD(bool, IsOutDebug, (), (const));
    MOCK_METHOD(bool, IsOutCharDump, (), (const));
    MOCK_METHOD(bool, GetLogDB, (), (const));
    MOCK_METHOD(void, SetLogDB, (bool enable));
    MOCK_METHOD(bool, GetSQLDriverQueryLogging, (), (const));
};
#pragma GCC diagnostic pop

#endif //AZEROTHCORE_LOGMOCK_H
