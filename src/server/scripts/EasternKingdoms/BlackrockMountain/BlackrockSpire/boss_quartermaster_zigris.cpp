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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_SHOOT                     = 16496,
    SPELL_STUNBOMB                  = 16497,
    SPELL_HEALING_POTION            = 15504,
    SPELL_HOOKEDNET                 = 15609
};

enum Events
{
    EVENT_STUN_BOMB                 = 1,
    EVENT_HOOKED_NET,
    EVENT_SHOOT
};

struct boss_quartermaster_zigris : public BossAI
{
    boss_quartermaster_zigris(Creature* creature) : BossAI(creature, DATA_QUARTERMASTER_ZIGRIS)
    {
        _hasDrunkPotion = false;
    }

    void Reset() override
    {
        _Reset();
        me->SetCombatMovement(false);
        _hasDrunkPotion = false;
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        events.ScheduleEvent(EVENT_STUN_BOMB, 16s);
        events.ScheduleEvent(EVENT_HOOKED_NET, 14s);
        events.ScheduleEvent(EVENT_SHOOT, 1s);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*effType*/, SpellSchoolMask /*schoolMask*/) override
    {
        if (!_hasDrunkPotion && me->HealthBelowPctDamaged(50, damage))
        {
            _hasDrunkPotion = true;
            DoCastSelf(SPELL_HEALING_POTION, true);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
    }

    void SpellHitTarget(Unit* /*target*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_STUNBOMB || spellInfo->Id == SPELL_HOOKEDNET)
        {
            if (me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->GetMotionMaster()->MoveBackwards(me->GetVictim(), 10.0f);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_STUN_BOMB:
                    DoCastVictim(SPELL_STUNBOMB);
                    events.ScheduleEvent(EVENT_STUN_BOMB, 14s);
                    break;
                case EVENT_HOOKED_NET:
                    if (me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        DoCastVictim(SPELL_HOOKEDNET);
                        events.RepeatEvent(16000);
                    }
                    else
                    {
                        events.RepeatEvent(3000);
                    }
                    break;
                case EVENT_SHOOT:
                    if (!me->IsWithinMeleeRange(me->GetVictim()) && me->IsWithinLOSInMap(me->GetVictim()))
                    {
                        DoCastVictim(SPELL_SHOOT);
                        me->GetMotionMaster()->Clear();
                        me->SetCombatMovement(false);
                    }
                    else if (!me->IsWithinLOSInMap(me->GetVictim()))
                    {
                        me->SetCombatMovement(true);
                        me->GetMotionMaster()->Clear();
                        me->GetMotionMaster()->MoveChase(me->GetVictim());
                    }
                    events.RepeatEvent(2000);
                    break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }
        }

        DoMeleeAttackIfReady();
    }

    private:
        bool _hasDrunkPotion;
};

void AddSC_boss_quartermasterzigris()
{
    RegisterBlackrockSpireCreatureAI(boss_quartermaster_zigris);
}
