/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "TotemAI.h"
#include "CellImpl.h"
#include "Creature.h"
#include "DBCStores.h"
#include "GridNotifiers.h"
#include "ObjectAccessor.h"
#include "SpellMgr.h"
#include "Totem.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

int32 TotemAI::Permissible(Creature const* creature)
{
    if (creature->IsTotem())
        return PERMIT_BASE_PROACTIVE;

    return PERMIT_BASE_NO;
}

TotemAI::TotemAI(Creature* c) : CreatureAI(c)
{
    ASSERT(c->IsTotem());
}

void TotemAI::SpellHit(Unit* /*caster*/, SpellInfo const* /*spellInfo*/)
{
}

void TotemAI::DoAction(int32 /*param*/)
{
}

void TotemAI::MoveInLineOfSight(Unit* /*who*/)
{
}

void TotemAI::EnterEvadeMode(EvadeReason /*why*/)
{
    me->CombatStop(true);
}

void TotemAI::UpdateAI(uint32 /*diff*/)
{
    if (me->ToTotem()->GetTotemType() != TOTEM_ACTIVE)
        return;

    if (!me->IsAlive())
    {
        return;
    }

    if (me->IsNonMeleeSpellCast(false))
    {
        if (Unit* victim = ObjectAccessor::GetUnit(*me, i_victimGuid))
        {
            if (!victim || !victim->IsAlive())
            {
                me->InterruptNonMeleeSpells(false);
            }
        }

        return;
    }

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
        victim = me->GetCharmerOrOwnerOrSelf()->getAttackerForHelper();
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
    if (me->GetEntry() == SENTRY_TOTEM_ENTRY && me->GetOwner()->IsPlayer())
    {
        WorldPacket data(MSG_MINIMAP_PING, (8 + 4 + 4));
        data << me->GetGUID();
        data << me->GetPositionX();
        data << me->GetPositionY();
        me->GetOwner()->ToPlayer()->GetSession()->SendPacket(&data);
    }
}
