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

#include "CreatureAIImpl.h"
#include "GuardAI.h"
#include "Player.h"

int GuardAI::Permissible(Creature const* creature)
{
    if (creature->IsGuard())
        return PERMIT_BASE_SPECIAL;

    return PERMIT_BASE_NO;
}

GuardAI::GuardAI(Creature* creature) : ScriptedAI(creature)
{
}

void GuardAI::Reset()
{
    ScriptedAI::Reset();
    me->CastSpell(me, 18950 /*SPELL_INVISIBILITY_AND_STEALTH_DETECTION*/, true);
}

void GuardAI::EnterEvadeMode()
{
    if (!me->IsAlive())
    {
        me->GetMotionMaster()->MoveIdle();
        me->CombatStop(true);
        me->DeleteThreatList();
        return;
    }

    LOG_DEBUG("entities.unit", "Guard entry: %u enters evade mode.", me->GetEntry());

    me->RemoveAllAuras();
    me->DeleteThreatList();
    me->CombatStop(true);

    // Remove ChaseMovementGenerator from MotionMaster stack list, and add HomeMovementGenerator instead
    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
        me->GetMotionMaster()->MoveTargetedHome();
}

void GuardAI::JustDied(Unit* killer)
{
    if (Player* player = killer->GetCharmerOrOwnerPlayerOrPlayerItself())
        me->SendZoneUnderAttackMessage(player);
}
