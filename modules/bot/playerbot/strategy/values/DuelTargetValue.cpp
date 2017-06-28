#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "DuelTargetValue.h"

using namespace BotAI;

Unit* DuelTargetValue::Calculate()
{
    return bot->duel ? bot->duel->opponent : NULL;
}
