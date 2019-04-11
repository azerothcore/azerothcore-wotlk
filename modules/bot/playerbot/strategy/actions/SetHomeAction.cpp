#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "SetHomeAction.h"
#include "../../PlayerbotAIConfig.h"


using namespace BotAI;

bool SetHomeAction::Execute(Event event)
{
    Player* master = ai->GetMaster();
    if (!master)
        return false;

    Unit* unit = master->GetSelectedUnit();
    if (unit && unit->IsInnkeeper())
    {
        float angle = GetFollowAngle();
        float x = unit->GetPositionX() + sPlayerbotAIConfig.followDistance * cos(angle);
        float y = unit->GetPositionY() + sPlayerbotAIConfig.followDistance * sin(angle);
        float z = unit->GetPositionZ();
        WorldLocation loc(unit->GetMapId(), x, y, z);
        bot->SetHomebind(loc, unit->GetAreaId());
        ai->TellMaster("This inn is my new home");
        return true;
    }

    list<uint64> npcs = AI_VALUE(list<uint64>, "nearest npcs");
    for (list<uint64>::iterator i = npcs.begin(); i != npcs.end(); i++)
    {
        Creature *unit = bot->GetNPCIfCanInteractWith(*i, UNIT_NPC_FLAG_INNKEEPER);
        if (!unit)
            continue;

        bot->GetSession()->SendBindPoint(unit);
        ai->TellMaster("This inn is my new home");
        return true;
    }

    ai->TellMaster("Can't find any innkeeper around");
    return false;
}
