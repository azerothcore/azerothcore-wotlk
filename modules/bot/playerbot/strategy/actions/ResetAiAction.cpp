#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "ResetAiAction.h"
#include "../../PlayerbotDbStore.h"

using namespace BotAI;

bool ResetAiAction::Execute(Event event)
{
	//sPlayerbotDbStore.Reset(ai);
    ai->ResetStrategies();
    ai->TellMaster("AI was reset to defaults");
    return true;
}
