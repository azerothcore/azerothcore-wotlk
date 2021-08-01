/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "CellImpl.h"
#include "Creature.h"
#include "DBCStores.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ObjectAccessor.h"
#include "SpellMgr.h"
#include "Totem.h"
#include "TotemAI.h"

int TotemAI::Permissible(Creature const* creature)
{
    if (creature->IsTotem())
        return PERMIT_BASE_PROACTIVE;

    return PERMIT_BASE_NO;
}

TotemAI::TotemAI(Creature* c) : CreatureAI(c)
{
    ASSERT(c->IsTotem());
}

void TotemAI::SpellHit(Unit* /*caster*/, const SpellInfo* /*spellInfo*/)
{
}

void TotemAI::DoAction(int32 /*param*/)
{
}

void TotemAI::MoveInLineOfSight(Unit* /*who*/)
{
}

void TotemAI::EnterEvadeMode()
{
    me->CombatStop(true);
}

void TotemAI::UpdateAI(uint32 /*diff*/)
{
    if (me->ToTotem()->GetTotemType() != TOTEM_ACTIVE)
        return;

    if (!me->IsAlive() || me->IsNonMeleeSpellCast(false))
        return;

    // Search spell
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(me->ToTotem()->GetSpell());
    if (!spellInfo)
        return;

    // Get spell range
    float max_range = spellInfo->GetMaxRange(false);

    // SPELLMOD_RANGE not applied in this place just because not existence range mods for attacking totems

    // pointer to appropriate target if found any
    Unit* victim = i_victimGuid ? ObjectAccessor::GetUnit(*me, i_victimGuid) : nullptr;

    // Search victim if no, not attackable, or out of range, or friendly (possible in case duel end)
    if (!victim ||
            !victim->isTargetableForAttack(true, me) || !me->IsWithinDistInMap(victim, max_range) ||
            me->IsFriendlyTo(victim) || !me->CanSeeOrDetect(victim))
    {
        victim = nullptr;
        Acore::NearestAttackableUnitInObjectRangeCheck u_check(me, me, max_range);
        Acore::UnitLastSearcher<Acore::NearestAttackableUnitInObjectRangeCheck> checker(me, victim, u_check);
        Cell::VisitAllObjects(me, checker, max_range);
    }

    if (!victim && me->GetCharmerOrOwnerOrSelf()->IsInCombat())
    {
        victim = me->GetCharmerOrOwnerOrSelf()->GetVictim();
    }

    // If have target
    if (victim)
    {
        // remember
        i_victimGuid = victim->GetGUID();

        // attack
        me->SetInFront(victim);                         // client change orientation by self
        me->CastSpell(victim, me->ToTotem()->GetSpell(), false);
    }
    else
        i_victimGuid.Clear();
}

void TotemAI::AttackStart(Unit* /*victim*/)
{
    // Sentry totem sends ping on attack
    if (me->GetEntry() == SENTRY_TOTEM_ENTRY && me->GetOwner()->GetTypeId() == TYPEID_PLAYER)
    {
        WorldPacket data(MSG_MINIMAP_PING, (8 + 4 + 4));
        data << me->GetGUID();
        data << me->GetPositionX();
        data << me->GetPositionY();
        me->GetOwner()->ToPlayer()->GetSession()->SendPacket(&data);
    }
}
