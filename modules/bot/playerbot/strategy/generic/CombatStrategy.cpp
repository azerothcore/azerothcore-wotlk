#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "CombatStrategy.h"

using namespace BotAI;

void CombatStrategy::InitTriggers(list<TriggerNode*> &triggers)
{
    triggers.push_back(new TriggerNode(
        "invalid target",
        NextAction::array(0, new NextAction("drop target", 59), NULL)));
}
