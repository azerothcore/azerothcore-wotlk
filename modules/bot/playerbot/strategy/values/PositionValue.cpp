#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "PositionValue.h"

using namespace BotAI;

PositionValue::PositionValue(PlayerbotAI* ai)
    : ManualSetValue<BotAI::Position&>(ai, position), Qualified()
{
}
