#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "TargetValue.h"

using namespace BotAI;

Unit* TargetValue::FindTarget(FindTargetStrategy* strategy)
{
    list<uint64> attackers = ai->GetAiObjectContext()->GetValue<list<uint64> >("attackers")->Get();
    for (list<uint64>::iterator i = attackers.begin(); i != attackers.end(); ++i)
    {
        Unit* unit = ai->GetUnit(*i);
        if (!unit)
            continue;

        ThreatManager &threatManager = unit->getThreatManager();
        strategy->CheckAttacker(unit, &threatManager);
    }

    return strategy->GetResult();
}

void FindTargetStrategy::GetPlayerCount(Unit* creature, int* tankCount, int* dpsCount)
{
    Player* bot = ai->GetBot();
    if (tankCountCache.find(creature) != tankCountCache.end())
    {
        *tankCount = tankCountCache[creature];
        *dpsCount = dpsCountCache[creature];
        return;
    }

    *tankCount = 0;
    *dpsCount = 0;

    for (HostileReference *ref = creature->getHostileRefManager().getFirst(); ref; ref = ref->next())
    {
        ThreatManager *threatManager = ref->GetSource();
        Unit *attacker = threatManager->GetOwner();
        Unit *victim = attacker->GetVictim();
        Player *player = dynamic_cast<Player*>(victim);

        if (!player)
            continue;

        if (ai->IsTank(player))
            (*tankCount)++;
        else
            (*dpsCount)++;
    }

    tankCountCache[creature] = *tankCount;
    dpsCountCache[creature] = *dpsCount;
}
