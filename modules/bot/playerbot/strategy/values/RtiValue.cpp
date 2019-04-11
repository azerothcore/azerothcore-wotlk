#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "RtiValue.h"

using namespace BotAI;

RtiValue::RtiValue(PlayerbotAI* ai)
    : ManualSetValue<string>(ai, "skull")
{
}
