#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "EnemyHealerTargetValue.h"
#include "../../PlayerbotAIConfig.h"

using namespace BotAI;

Unit* EnemyHealerTargetValue::Calculate()
{
    string spell = qualifier;

    list<uint64> attackers = ai->GetAiObjectContext()->GetValue<list<uint64> >("attackers")->Get();
    Unit* target = ai->GetAiObjectContext()->GetValue<Unit*>("current target")->Get();
    for (list<uint64>::iterator i = attackers.begin(); i != attackers.end(); ++i)
    {
        Unit* unit = ai->GetUnit(*i);
        if (!unit || unit == target)
            continue;

        if (bot->GetDistance(unit) > sPlayerbotAIConfig.spellDistance)
            continue;

        if (!ai->IsInterruptableSpellCasting(unit, spell))
            continue;

        Spell* spell = unit->GetCurrentSpell(CURRENT_GENERIC_SPELL);
        if (spell && spell->m_spellInfo->IsPositive())
            return unit;

        spell = unit->GetCurrentSpell(CURRENT_CHANNELED_SPELL);
        if (spell && spell->m_spellInfo->IsPositive())
            return unit;
    }

    return NULL;
}
