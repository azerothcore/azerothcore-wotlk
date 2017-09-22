#pragma once
#include "../Value.h"
#include "PartyMemberValue.h"

namespace BotAI
{
    class PartyMemberToDispel : public PartyMemberValue, Qualified
	{
	public:
        PartyMemberToDispel(PlayerbotAI* ai) : 
          PartyMemberValue(ai) {}
    
    protected:
        virtual Unit* Calculate();
	};
}
