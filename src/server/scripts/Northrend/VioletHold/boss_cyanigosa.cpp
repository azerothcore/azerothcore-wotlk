/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "violet_hold.h"

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SPAWN                                   = 3,
    SAY_DISRUPTION                              = 4,
    SAY_BREATH_ATTACK                           = 5,
    SAY_SPECIAL_ATTACK                          = 6
};

enum eSpells
{
    SPELL_ARCANE_VACUUM                             = 58694,
    SPELL_BLIZZARD                                  = 58693,
    SPELL_MANA_DESTRUCTION                          = 59374,
    SPELL_TAIL_SWEEP                                = 58690,
    SPELL_UNCONTROLLABLE_ENERGY                     = 58688
};

enum eEvents
{
    EVENT_SPELL_ARCANE_VACUUM = 1,
    EVENT_SPELL_BLIZZARD,
    EVENT_SPELL_MANA_DESTRUCTION,
    EVENT_SPELL_TAIL_SWEEP,
    EVENT_SPELL_UNCONTROLLABLE_ENERGY,
    EVENT_UNROOT,
};

class boss_cyanigosa : public CreatureScript
{
public:
    boss_cyanigosa() : CreatureScript("boss_cyanigosa") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<boss_cyanigosaAI>(pCreature);
    }

    struct boss_cyanigosaAI : public ScriptedAI
    {
        boss_cyanigosaAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            DoZoneInCombat();
            Talk(SAY_AGGRO);
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_ARCANE_VACUUM, 30s);
            events.RescheduleEvent(EVENT_SPELL_BLIZZARD, 5s, 10s);
            events.RescheduleEvent(EVENT_SPELL_TAIL_SWEEP, 15s, 20s);
            events.RescheduleEvent(EVENT_SPELL_UNCONTROLLABLE_ENERGY, 5s, 8s);
            if (IsHeroic())
                events.RescheduleEvent(EVENT_SPELL_MANA_DESTRUCTION, 20s);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spell) override
        {
            if (!target || !spell)
                return;
            switch (spell->Id)
            {
                case SPELL_ARCANE_VACUUM:
                    target->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 10.0f, target->GetOrientation());
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_ARCANE_VACUUM:
                    me->CastSpell((Unit*)nullptr, SPELL_ARCANE_VACUUM, false);
                    DoResetThreatList();
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->setAttackTimer(BASE_ATTACK, 3000);
                    events.Repeat(30s);
                    events.ScheduleEvent(EVENT_UNROOT, 3s);
                    break;
                case EVENT_UNROOT:
                    me->SetControlled(false, UNIT_STATE_ROOT);

                    break;
                case EVENT_SPELL_BLIZZARD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 45.0f, true))
                        me->CastSpell(target, SPELL_BLIZZARD, false);
                    events.Repeat(15s);
                    break;
                case EVENT_SPELL_MANA_DESTRUCTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_MANA_DESTRUCTION, false);
                    events.Repeat(20s);
                    break;
                case EVENT_SPELL_TAIL_SWEEP:
                    me->CastSpell(me->GetVictim(), SPELL_TAIL_SWEEP, false);
                    events.Repeat(15s, 20s);
                    break;
                case EVENT_SPELL_UNCONTROLLABLE_ENERGY:
                    me->CastSpell(me->GetVictim(), SPELL_UNCONTROLLABLE_ENERGY, false);
                    events.Repeat(20s, 25s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
            float h = me->GetMapHeight(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
            if (h != INVALID_HEIGHT && me->GetPositionZ() - h > 3.0f)
            {
                me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), h, me->GetOrientation(), true); // move to ground
                me->StopMovingOnCurrentPos();
                me->DestroyForVisiblePlayers();
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;
            Talk(SAY_SLAY);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void EnterEvadeMode(EvadeReason why) override
        {
            me->SetControlled(false, UNIT_STATE_ROOT);
            ScriptedAI::EnterEvadeMode(why);
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

void AddSC_boss_cyanigosa()
{
    new boss_cyanigosa();
}
