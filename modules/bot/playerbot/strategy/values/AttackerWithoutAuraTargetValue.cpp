#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "AttackerWithoutAuraTargetValue.h"
#include "../../PlayerbotAIConfig.h"

using namespace BotAI;

Unit* AttackerWithoutAuraTargetValue::Calculate()
{
    list<uint64> attackers = ai->GetAiObjectContext()->GetValue<list<uint64> >("attackers")->Get();
    Unit* target = ai->GetAiObjectContext()->GetValue<Unit*>("current target")->Get();
    for (list<uint64>::iterator i = attackers.begin(); i != attackers.end(); ++i)
    {
        Unit* unit = ai->GetUnit(*i);
        if (!unit || unit == target)
            continue;

        if (bot->GetDistance(unit) > sPlayerbotAIConfig.spellDistance)
            continue;

        if (!ai->HasAura(qualifier, unit))
            return unit;
    }

    return NULL;
}
