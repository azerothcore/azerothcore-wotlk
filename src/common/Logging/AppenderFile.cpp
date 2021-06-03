/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "AppenderFile.h"
#include "Log.h"
#include "LogMessage.h"
#include "StringConvert.h"
#include "Util.h"
#include <algorithm>

AppenderFile::AppenderFile(uint8 id, std::string const& name, LogLevel level, AppenderFlags flags, std::vector<std::string_view> const& args) :
    Appender(id, name, level, flags),
    logfile(nullptr),
    _logDir(sLog->GetLogsDir()),
    _maxFileSize(0),
    _fileSize(0)
{
    if (args.size() < 4)
        throw InvalidAppenderArgsException(Acore::StringFormat("Log::CreateAppenderFromConfig: Missing file name for appender %s", name.c_str()));

    _fileName.assign(args[3]);

    std::string mode = "a";
    if (4 < args.size())
        mode.assign(args[4]);

    if (flags & APPENDER_FLAGS_USE_TIMESTAMP)
    {
        size_t dot_pos = _fileName.find_last_of('.');
        if (dot_pos != std::string::npos)
            _fileName.insert(dot_pos, sLog->GetLogsTimestamp());
        else
            _fileName += sLog->GetLogsTimestamp();
    }

    if (5 < args.size())
    {
        if (Optional<uint32> size = Acore::StringTo<uint32>(args[5]))
            _maxFileSize = *size;
        else
            throw InvalidAppenderArgsException(Acore::StringFormat("Log::CreateAppenderFromConfig: Invalid size '%s' for appender %s", std::string(args[5]).c_str(), name.c_str()));
    }

    _dynamicName = std::string::npos != _fileName.find("%s");
    _backup = (flags & APPENDER_FLAGS_MAKE_FILE_BACKUP) != 0;

    if (!_dynamicName)
        logfile = OpenFile(_fileName, mode, (mode == "w") && _backup);
}

AppenderFile::~AppenderFile()
{
    CloseFile();
}

void AppenderFile::_write(LogMessage const* message)
{
    bool exceedMaxSize = _maxFileSize > 0 && (_fileSize.load() + message->Size()) > _maxFileSize;

    if (_dynamicName)
    {
        char namebuf[ACORE_PATH_MAX];
        snprintf(namebuf, ACORE_PATH_MAX, _fileName.c_str(), message->param1.c_str());

        // always use "a" with dynamic name otherwise it could delete the log we wrote in last _write() call
        FILE* file = OpenFile(namebuf, "a", _backup || exceedMaxSize);
        if (!file)
            return;

        fprintf(file, "%s%s\n", message->prefix.c_str(), message->text.c_str());
        fflush(file);
        _fileSize += uint64(message->Size());
        fclose(file);

        return;
    }
    else if (exceedMaxSize)
        logfile = OpenFile(_fileName, "w", true);

    if (!logfile)
        return;

    fprintf(logfile, "%s%s\n", message->prefix.c_str(), message->text.c_str());
    fflush(logfile);
    _fileSize += uint64(message->Size());
}

FILE* AppenderFile::OpenFile(std::string const& filename, std::string const& mode, bool backup)
{
    std::string fullName(_logDir + filename);
    if (backup)
    {
        CloseFile();
        std::string newName(fullName);
        newName.push_back('.');
        newName.append(LogMessage::getTimeStr(time(nullptr)));
        std::replace(newName.begin(), newName.end(), ':', '-');
        rename(fullName.c_str(), newName.c_str()); // no error handling... if we couldn't make a backup, just ignore
    }

    if (FILE* ret = fopen(fullName.c_str(), mode.c_str()))
    {
        _fileSize = ftell(ret);
        return ret;
    }

    return nullptr;
}

void AppenderFile::CloseFile()
{
    if (logfile)
    {
        fclose(logfile);
        logfile = nullptr;
    }
}
