#pragma once
#include "../Value.h"

namespace BotAI
{
    class PetTargetValue : public UnitCalculatedValue
	{
	public:
        PetTargetValue(PlayerbotAI* ai) : UnitCalculatedValue(ai) {}

        virtual Unit* Calculate() { return (Unit*)(ai->GetBot()->GetPet()); }
    };
}
