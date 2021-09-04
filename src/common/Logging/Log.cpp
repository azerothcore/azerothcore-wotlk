/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "Log.h"
#include "AppenderConsole.h"
#include "AppenderFile.h"
#include "Config.h"
#include "Errors.h"
#include "LogMessage.h"
#include "LogOperation.h"
#include "Logger.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "Util.h"
#include <chrono>
#include <sstream>

Log::Log() : AppenderId(0), highestLogLevel(LOG_LEVEL_FATAL)
{
    m_logsTimestamp = "_" + GetTimestampStr();
    RegisterAppender<AppenderConsole>();
    RegisterAppender<AppenderFile>();
}

Log::~Log()
{
    Close();
}

uint8 Log::NextAppenderId()
{
    return AppenderId++;
}

Appender* Log::GetAppenderByName(std::string_view name)
{
    auto it = appenders.begin();
    while (it != appenders.end() && it->second && it->second->getName() != name)
    {
        ++it;
    }

    return it == appenders.end() ? nullptr : it->second.get();
}

void Log::CreateAppenderFromConfig(std::string const& appenderName)
{
    if (appenderName.empty())
    {
        return;
    }

    // Format = type, level, flags, optional1, optional2
    // if type = File. optional1 = file and option2 = mode
    // if type = Console. optional1 = Color
    std::string options = sConfigMgr->GetStringDefault(appenderName, "");

    std::vector<std::string_view> tokens = Acore::Tokenize(options, ',', true);

    size_t const size = tokens.size();
    std::string name = appenderName.substr(9);

    if (size < 2)
    {
        fprintf(stderr, "Log::CreateAppenderFromConfig: Wrong configuration for appender %s. Config line: %s\n", name.c_str(), options.c_str());
        return;
    }

    AppenderFlags flags = APPENDER_FLAGS_NONE;
    AppenderType type = AppenderType(Acore::StringTo<uint8>(tokens[0]).value_or(APPENDER_INVALID));
    LogLevel level = LogLevel(Acore::StringTo<uint8>(tokens[1]).value_or(LOG_LEVEL_INVALID));

    auto factoryFunction = appenderFactory.find(type);
    if (factoryFunction == appenderFactory.end())
    {
        fprintf(stderr, "Log::CreateAppenderFromConfig: Unknown type '%s' for appender %s\n", std::string(tokens[0]).c_str(), name.c_str());
        return;
    }

    if (level > NUM_ENABLED_LOG_LEVELS)
    {
        fprintf(stderr, "Log::CreateAppenderFromConfig: Wrong Log Level '%s' for appender %s\n", std::string(tokens[1]).c_str(), name.c_str());
        return;
    }

    if (size > 2)
    {
        if (Optional<uint8> flagsVal = Acore::StringTo<uint8>(tokens[2]))
        {
            flags = AppenderFlags(*flagsVal);
        }
        else
        {
            fprintf(stderr, "Log::CreateAppenderFromConfig: Unknown flags '%s' for appender %s\n", std::string(tokens[2]).c_str(), name.c_str());
            return;
        }
    }

    try
    {
        Appender* appender = factoryFunction->second(NextAppenderId(), name, level, flags, tokens);
        appenders[appender->getId()].reset(appender);
    }
    catch (InvalidAppenderArgsException const& iaae)
    {
        fprintf(stderr, "%s\n", iaae.what());
    }
}

void Log::CreateLoggerFromConfig(std::string const& appenderName)
{
    if (appenderName.empty())
    {
        return;
    }

    LogLevel level = LOG_LEVEL_DISABLED;

    std::string options = sConfigMgr->GetStringDefault(appenderName, "");
    std::string name = appenderName.substr(7);

    if (options.empty())
    {
        fprintf(stderr, "Log::CreateLoggerFromConfig: Missing config option Logger.%s\n", name.c_str());
        return;
    }

    std::vector<std::string_view> tokens = Acore::Tokenize(options, ',', true);

    if (tokens.size() != 2)
    {
        fprintf(stderr, "Log::CreateLoggerFromConfig: Wrong config option Logger.%s=%s\n", name.c_str(), options.c_str());
        return;
    }

    std::unique_ptr<Logger>& logger = loggers[name];
    if (logger)
    {
        fprintf(stderr, "Error while configuring Logger %s. Already defined\n", name.c_str());
        return;
    }

    level = LogLevel(Acore::StringTo<uint8>(tokens[0]).value_or(LOG_LEVEL_INVALID));
    if (level > NUM_ENABLED_LOG_LEVELS)
    {
        fprintf(stderr, "Log::CreateLoggerFromConfig: Wrong Log Level '%s' for logger %s\n", std::string(tokens[0]).c_str(), name.c_str());
        return;
    }

    if (level > highestLogLevel)
    {
        highestLogLevel = level;
    }

    logger = std::make_unique<Logger>(name, level);
    //fprintf(stdout, "Log::CreateLoggerFromConfig: Created Logger %s, Level %u\n", name.c_str(), level);

    for (std::string_view appendName : Acore::Tokenize(tokens[1], ' ', false))
    {
        if (Appender* appender = GetAppenderByName(appendName))
        {
            logger->addAppender(appender->getId(), appender);
            //fprintf(stdout, "Log::CreateLoggerFromConfig: Added Appender %s to Logger %s\n", appender->getName().c_str(), name.c_str());
        }
        else
        {
            fprintf(stderr, "Error while configuring Appender %s in Logger %s. Appender does not exist\n", std::string(appendName).c_str(), name.c_str());
        }
    }
}

void Log::ReadAppendersFromConfig()
{
    std::vector<std::string> keys = sConfigMgr->GetKeysByString("Appender.");
    for (std::string const& appenderName : keys)
    {
        CreateAppenderFromConfig(appenderName);
    }
}

void Log::ReadLoggersFromConfig()
{
    std::vector<std::string> keys = sConfigMgr->GetKeysByString("Logger.");
    for (std::string const& loggerName : keys)
    {
        CreateLoggerFromConfig(loggerName);
    }

    // Bad config configuration, creating default config
    if (loggers.find(LOGGER_ROOT) == loggers.end())
    {
        fprintf(stderr, "Wrong Loggers configuration. Review your Logger config section.\n"
                        "Creating default loggers [root (Error), server (Info)] to console\n");

        Close(); // Clean any Logger or Appender created

        AppenderConsole* appender = new AppenderConsole(NextAppenderId(), "Console", LOG_LEVEL_DEBUG, APPENDER_FLAGS_NONE, {});
        appenders[appender->getId()].reset(appender);

        Logger* rootLogger = new Logger(LOGGER_ROOT, LOG_LEVEL_ERROR);
        rootLogger->addAppender(appender->getId(), appender);
        loggers[LOGGER_ROOT].reset(rootLogger);

        Logger* serverLogger = new Logger("server", LOG_LEVEL_INFO);
        serverLogger->addAppender(appender->getId(), appender);
        loggers["server"].reset(serverLogger);
    }
}

void Log::RegisterAppender(uint8 index, AppenderCreatorFn appenderCreateFn)
{
    auto itr = appenderFactory.find(index);
    ASSERT(itr == appenderFactory.end());
    appenderFactory[index] = appenderCreateFn;
}

void Log::outMessage(std::string const& filter, LogLevel level, std::string&& message)
{
    write(std::make_unique<LogMessage>(level, filter, std::move(message)));
}

void Log::_outMessageFmt(std::string const& filter, LogLevel level, std::string&& message)
{
    write(std::make_unique<LogMessage>(level, filter, std::move(message)));
}

void Log::outCommand(std::string&& message, std::string&& param1)
{
    write(std::make_unique<LogMessage>(LOG_LEVEL_INFO, "commands.gm", std::move(message), std::move(param1)));
}

void Log::write(std::unique_ptr<LogMessage>&& msg) const
{
    Logger const* logger = GetLoggerByType(msg->type);

    logger->write(msg.get());
}

Logger const* Log::GetLoggerByType(std::string const& type) const
{
    auto it = loggers.find(type);
    if (it != loggers.end())
    {
        return it->second.get();
    }

    if (type == LOGGER_ROOT)
    {
        return nullptr;
    }

    std::string parentLogger = LOGGER_ROOT;
    size_t found = type.find_last_of('.');
    if (found != std::string::npos)
    {
        parentLogger = type.substr(0, found);
    }

    return GetLoggerByType(parentLogger);
}

std::string Log::GetTimestampStr()
{
    time_t tt = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

    std::tm aTm;
    localtime_r(&tt, &aTm);

    //       YYYY   year
    //       MM     month (2 digits 01-12)
    //       DD     day (2 digits 01-31)
    //       HH     hour (2 digits 00-23)
    //       MM     minutes (2 digits 00-59)
    //       SS     seconds (2 digits 00-59)
    return Acore::StringFormat("%04d-%02d-%02d_%02d-%02d-%02d",
        aTm.tm_year + 1900, aTm.tm_mon + 1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec);
}

bool Log::SetLogLevel(std::string const& name, int32 newLeveli, bool isLogger /* = true */)
{
    if (newLeveli < 0)
    {
        return false;
    }

    LogLevel newLevel = LogLevel(newLeveli);

    if (isLogger)
    {
        auto it = loggers.begin();
        while (it != loggers.end() && it->second->getName() != name)
        {
            ++it;
        }

        if (it == loggers.end())
        {
            return false;
        }

        it->second->setLogLevel(newLevel);

        if (newLevel != LOG_LEVEL_DISABLED && newLevel > highestLogLevel)
        {
            highestLogLevel = newLevel;
        }
    }
    else
    {
        Appender* appender = GetAppenderByName(name);
        if (!appender)
        {
            return false;
        }

        appender->setLogLevel(newLevel);
    }

    return true;
}

void Log::outCharDump(char const* str, uint32 accountId, uint64 guid, char const* name)
{
    if (!str || !ShouldLog("entities.player.dump", LOG_LEVEL_INFO))
    {
        return;
    }

    std::ostringstream ss;
    ss << "== START DUMP == (account: " << accountId << " guid: " << guid << " name: " << name
       << ")\n" << str << "\n== END DUMP ==\n";

    std::unique_ptr<LogMessage> msg(new LogMessage(LOG_LEVEL_INFO, "entities.player.dump", ss.str()));
    std::ostringstream param;
    param << guid << '_' << name;

    msg->param1 = param.str();

    write(std::move(msg));
}

void Log::SetRealmId(uint32 id)
{
    for (std::pair<uint8 const, std::unique_ptr<Appender>>& appender : appenders)
    {
        appender.second->setRealmId(id);
    }
}

void Log::Close()
{
    loggers.clear();
    appenders.clear();
}

bool Log::ShouldLog(std::string const& type, LogLevel level) const
{
    // TODO: Use cache to store "Type.sub1.sub2": "Type" equivalence, should
    // Speed up in cases where requesting "Type.sub1.sub2" but only configured
    // Logger "Type"

    // Don't even look for a logger if the LogLevel is higher than the highest log levels across all loggers
    if (level > highestLogLevel)
    {
        return false;
    }

    Logger const* logger = GetLoggerByType(type);
    if (!logger)
    {
        return false;
    }

    LogLevel logLevel = logger->getLogLevel();
    return logLevel != LOG_LEVEL_DISABLED && logLevel >= level;
}

Log* Log::instance()
{
    static Log instance;
    return &instance;
}

void Log::Initialize()
{
    LoadFromConfig();
}

void Log::LoadFromConfig()
{
    Close();

    highestLogLevel = LOG_LEVEL_FATAL;
    AppenderId = 0;
    m_logsDir = sConfigMgr->GetOption<std::string>("LogsDir", "", false);

    if (!m_logsDir.empty())
        if ((m_logsDir.at(m_logsDir.length() - 1) != '/') && (m_logsDir.at(m_logsDir.length() - 1) != '\\'))
        {
            m_logsDir.push_back('/');
        }

    ReadAppendersFromConfig();
    ReadLoggersFromConfig();

    _debugLogMask = DebugLogFilters(sConfigMgr->GetOption<uint32>("DebugLogMask", LOG_FILTER_NONE, false));
}
