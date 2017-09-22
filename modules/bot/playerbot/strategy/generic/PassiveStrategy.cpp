#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "PassiveStrategy.h"
#include "../PassiveMultiplier.h"

using namespace BotAI;


void PassiveStrategy::InitMultipliers(std::list<Multiplier*> &multipliers)
{
    multipliers.push_back(new PassiveMultiplier(ai));
}

