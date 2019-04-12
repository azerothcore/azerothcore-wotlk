#pragma once
#include "../Value.h"
#include "../../PlayerbotAIConfig.h"

namespace BotAI
{
    class NearestGameObjects : public ObjectGuidListCalculatedValue
	{
	public:
        NearestGameObjects(PlayerbotAI* ai, float range = sPlayerbotAIConfig.sightDistance) :
            ObjectGuidListCalculatedValue(ai), range(range) {}

    protected:
        virtual list<uint64> Calculate();

    private:
        float range;
	};
}
