#pragma once

namespace BotAI
{
	class TaxiAction : public Action {
	public:
		TaxiAction(PlayerbotAI* ai) : Action(ai, "taxi") {}

    public:
        virtual bool Execute(Event event);
    };

}