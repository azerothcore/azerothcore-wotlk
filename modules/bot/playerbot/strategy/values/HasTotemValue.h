#pragma once
#include "../Value.h"
#include "TargetValue.h"
#include "../../LootObjectStack.h"

namespace BotAI
{
    class HasTotemValue : public BoolCalculatedValue, public Qualified
	{
	public:
        HasTotemValue(PlayerbotAI* ai) : BoolCalculatedValue(ai) {}

    public:
        bool Calculate()
        {
            list<uint64> units = *context->GetValue<list<uint64> >("nearest npcs");
            for (list<uint64>::iterator i = units.begin(); i != units.end(); i++)
            {
                Unit* unit = ai->GetUnit(*i);
                if (!unit)
                    continue;

                Creature* creature = dynamic_cast<Creature*>(unit);
                if (!creature || !creature->IsTotem())
                    continue;

                if (strstri(creature->GetName().c_str(), qualifier.c_str()) && bot->GetDistance(creature) <= sPlayerbotAIConfig.spellDistance)
                    return true;
            }

            return false;
        }
    };
}
