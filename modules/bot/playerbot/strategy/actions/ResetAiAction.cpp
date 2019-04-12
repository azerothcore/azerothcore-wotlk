#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "ResetAiAction.h"

using namespace BotAI;

bool ResetAiAction::Execute(Event event)
{
    ai->ResetStrategies();
    ai->TellMaster("AI was reset to defaults");
    return true;
}
