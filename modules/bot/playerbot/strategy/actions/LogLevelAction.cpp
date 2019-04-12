#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "LogLevelAction.h"


using namespace BotAI;

bool LogLevelAction::Execute(Event event)
{
    string param = event.getParam();
    Value<LogLevel> *value = ai->GetAiObjectContext()->GetValue<LogLevel>("log level");

    ostringstream out;
    if (param != "?")
    {
        value->Set(string2logLevel(param));
        out << "My log level set to " << logLevel2string(value->Get());
    }
    else
    {
        out << "My log level is " << logLevel2string(value->Get());
    }
    ai->TellMaster(out);
    return true;
}

string LogLevelAction::logLevel2string(LogLevel level)
{
    switch (level)
    {
    case LOGL_BASIC:
        return "info";
    default:
        return "debug";
    }
}
LogLevel LogLevelAction::string2logLevel(string level)
{
    if (level == "debug")
        return LOGL_DEBUG;
    else
        return LOGL_BASIC;
}
