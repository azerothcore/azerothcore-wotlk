#pragma once
#include "../Value.h"
#include "TargetValue.h"
#include "NearestUnitsValue.h"

namespace BotAI
{
    class AttackersValue : public ObjectGuidListCalculatedValue
	{
	public:
        AttackersValue(PlayerbotAI* ai) : ObjectGuidListCalculatedValue(ai, "attackers", 5) {}
        list<uint64> Calculate();

	private:
        void AddAttackersOf(Group* group, set<Unit*>& targets);
        void AddAttackersOf(Unit* unit, set<Unit*>& targets);
		void RemoveNonThreating(set<Unit*>& targets);
		bool hasRealThreat(Unit* attacker);
    };
}
