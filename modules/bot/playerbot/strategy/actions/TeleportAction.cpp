#include "../../../pchdef.h"
#include "../../playerbot.h"
#include "TeleportAction.h"
#include "../values/LastMovementValue.h"
#include "../../PlayerbotAI.h"

using namespace BotAI;

bool TeleportAction::Execute(Event event)
{
    list<uint64> gos = *context->GetValue<list<uint64> >("nearest game objects");
    for (list<uint64>::iterator i = gos.begin(); i != gos.end(); i++)
    {
        GameObject* go = ai->GetGameObject(*i);
        if (!go)
            continue;

        GameObjectTemplate const *goInfo = go->GetGOInfo();
        if (goInfo->type != GAMEOBJECT_TYPE_SPELLCASTER)
            continue;

        uint32 spellId = goInfo->spellcaster.spellId;
        const SpellInfo* const pSpellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (pSpellInfo->Effects[0].Effect != SPELL_EFFECT_TELEPORT_UNITS && pSpellInfo->Effects[1].Effect != SPELL_EFFECT_TELEPORT_UNITS && pSpellInfo->Effects[2].Effect != SPELL_EFFECT_TELEPORT_UNITS)
            continue;

        ostringstream out; out << "Teleporting using " << goInfo->name;
        ai->TellMasterNoFacing(out.str());

        ai->ChangeStrategy("-follow,+stay", BOT_STATE_NON_COMBAT);

        Spell *spell = new Spell(bot, pSpellInfo, TRIGGERED_NONE);
        SpellCastTargets targets;
        targets.SetUnitTarget(bot);
        spell->prepare(&targets);
        spell->cast(true);
        return true;
    }


    LastMovement& movement = context->GetValue<LastMovement&>("last movement")->Get();
    if (movement.lastAreaTrigger)
    {
        WorldPacket p(CMSG_AREATRIGGER);
        p << movement.lastAreaTrigger;
        p.rpos(0);

        bot->GetSession()->HandleAreaTriggerOpcode(p);
        movement.lastAreaTrigger = 0;
        return true;
    }

    ai->TellMaster("Cannot find any portal to teleport");
    return false;
}
