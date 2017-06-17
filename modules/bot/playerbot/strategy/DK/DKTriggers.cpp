#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "DKTriggers.h"
#include "DKActions.h"

using namespace BotAI;

bool DKPresenceTrigger::IsActive()
{
    Unit* target = GetTarget();
    return !ai->HasAura("blood presence", target) &&
        !ai->HasAura("unholy presence", target) &&
        !ai->HasAura("frost presence", target);
}
