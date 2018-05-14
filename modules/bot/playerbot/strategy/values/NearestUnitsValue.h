#pragma once
#include "../Value.h"
#include "../../PlayerbotAIConfig.h"

namespace BotAI
{
    class NearestUnitsValue : public ObjectGuidListCalculatedValue
	{
	public:
        NearestUnitsValue(PlayerbotAI* ai, float range = sPlayerbotAIConfig.sightDistance) :
            ObjectGuidListCalculatedValue(ai, "nearest units", 5), range(range) {}

	public:
        list<uint64> Calculate()
        {
            list<Unit*> targets;
            FindUnits(targets);

            list<uint64> results;
            for(list<Unit *>::iterator i = targets.begin(); i!= targets.end(); ++i)
            {
                Unit* unit = *i;
                if(bot->IsWithinLOSInMap(unit) && AcceptUnit(unit))
                    results.push_back(unit->GetGUID());
            }
            return results;
        }

    protected:
        virtual void FindUnits(list<Unit*> &targets) = 0;
        virtual bool AcceptUnit(Unit* unit) = 0;

    protected:
        float range;
	};
}
