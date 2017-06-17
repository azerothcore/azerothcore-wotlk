#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "ReviveFromCorpseAction.h"
#include "../../PlayerbotFactory.h"
#include "../../PlayerbotAIConfig.h"

using namespace BotAI;

bool ReviveFromCorpseAction::Execute(Event event)
{
    Corpse* corpse = bot->GetCorpse();
    if (!corpse)
        return false;

    time_t reclaimTime = corpse->GetGhostTime() + bot->GetCorpseReclaimDelay( corpse->GetType()==CORPSE_RESURRECTABLE_PVP );
    if (reclaimTime > time(0) || corpse->GetDistance(bot) > sPlayerbotAIConfig.spellDistance)
        return false;

    bot->ResurrectPlayer(0.5f);
    bot->SpawnCorpseBones();
	bot->SaveToDB(false, true);
    context->GetValue<Unit*>("current target")->Set(NULL);
    bot->SetSelection(0);
    return true;
}

bool SpiritHealerAction::Execute(Event event)
{
    Corpse* corpse = bot->GetCorpse();
    if (!corpse)
        return false;

    list<uint64> npcs = AI_VALUE(list<uint64>, "nearest npcs");
    for (list<uint64>::iterator i = npcs.begin(); i != npcs.end(); i++)
    {
        Unit* unit = ai->GetUnit(*i);
        if (unit && unit->IsSpiritHealer())
        {
            PlayerbotChatHandler ch(bot);
            bot->ResurrectPlayer(0.5f);
            bot->SpawnCorpseBones();
			bot->SaveToDB(false, true);
            context->GetValue<Unit*>("current target")->Set(NULL);
            bot->SetSelection(0);
            return true;
        }
    }

    ai->TellMaster("Cannot find any spirit healer nearby");
    return false;
}
