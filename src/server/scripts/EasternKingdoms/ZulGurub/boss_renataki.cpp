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

/* ScriptData
SDName: Boss_Renataki
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_VANISH            = 24699,
    SPELL_AMBUSH            = 24337,
    SPELL_GOUGE             = 24698,
    SPELL_THOUSAND_BLADES   = 24649,
    SPELL_THRASH            = 3417,
    SPELL_ENRAGE            = 8269
};

enum Events
{
    EVENT_VANISH            = 1,
    EVENT_AMBUSH            = 2,
    EVENT_GOUGE             = 3,
    EVENT_THOUSAND_BLADES   = 4
};

class boss_renataki : public CreatureScript
{
public:
    boss_renataki() : CreatureScript("boss_renataki") { }

    struct boss_renatakiAI : public BossAI
    {
        boss_renatakiAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

        void Reset() override
        {
            _Reset();
            me->SetReactState(REACT_AGGRESSIVE);
            _enraged = false;
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();
            events.ScheduleEvent(EVENT_VANISH, 23s, 25s);
            events.ScheduleEvent(EVENT_GOUGE, 5s, 10s);
            events.ScheduleEvent(EVENT_THOUSAND_BLADES, 15s, 20s);

            DoCastSelf(SPELL_THRASH, true);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (!_enraged && HealthBelowPct(30))
            {
                me->TextEmote("%s becomes enraged", me, false);
                DoCast(me, SPELL_ENRAGE);
                _enraged = true;
            }
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return !target->HasAura(SPELL_GOUGE);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_VANISH:
                        me->SetReactState(REACT_PASSIVE);
                        DoCastSelf(SPELL_VANISH);
                        events.DelayEvents(5s);
                        events.ScheduleEvent(EVENT_AMBUSH, 5s);
                        events.ScheduleEvent(EVENT_VANISH, 38s, 45s);
                        break;
                    case EVENT_AMBUSH:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                        {
                            me->NearTeleportTo(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), me->GetOrientation());
                            DoCast(target, SPELL_AMBUSH, true);
                        }
                        me->RemoveAurasDueToSpell(SPELL_VANISH);
                        me->SetReactState(REACT_AGGRESSIVE);
                        break;
                    case EVENT_GOUGE:
                        DoCastAOE(SPELL_GOUGE);
                        events.ScheduleEvent(EVENT_GOUGE, 10s, 15s);
                        break;
                    case EVENT_THOUSAND_BLADES:
                        DoCastVictim(SPELL_THOUSAND_BLADES);
                        events.ScheduleEvent(EVENT_THOUSAND_BLADES, 15s, 22s);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        bool _enraged;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetZulGurubAI<boss_renatakiAI>(creature);
    }
};

void AddSC_boss_renataki()
{
    new boss_renataki();
}
