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

#include "AchievementCriteriaScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "nexus.h"

enum Spells
{
    SPELL_SPARK                         = 47751,
    SPELL_RIFT_SHIELD                   = 47748,
    SPELL_CHARGE_RIFTS                  = 47747,
    SPELL_CREATE_RIFT                   = 47743,
    SPELL_ARCANE_ATTRACTION             = 57063,
    SPELL_CLOSE_RIFTS                   = 47745
};

enum Yells
{
    SAY_AGGRO                           = 0,
    SAY_DEATH                           = 1,
    SAY_RIFT                            = 2,
    EMOTE_RIFT                          = 3,
    EMOTE_SHIELD                        = 4
};

enum Events
{
    EVENT_ANOMALUS_SPARK                = 1,
    EVENT_ANOMALUS_HEALTH               = 2,
    EVENT_ANOMALUS_ARCANE_ATTRACTION    = 3,
    EVENT_ANOMALUS_SPAWN_RIFT           = 4,
    EVENT_ANOMALUS_SPAWN_RIFT_EMPOWERED = 5
};

class ChargeRifts : public BasicEvent
{
public:
    ChargeRifts(Creature* caster) : _caster(caster)
    {
    }

    bool Execute(uint64 /*execTime*/, uint32 /*diff*/) override
    {
        _caster->AI()->Talk(EMOTE_SHIELD);
        _caster->CastSpell(_caster, SPELL_CHARGE_RIFTS, true);
        return true;
    }

private:
    Creature* _caster;
};

class boss_anomalus : public CreatureScript
{
public:
    boss_anomalus() : CreatureScript("boss_anomalus") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetNexusAI<boss_anomalusAI>(creature);
    }

    struct boss_anomalusAI : public BossAI
    {
        boss_anomalusAI(Creature* creature) : BossAI(creature, DATA_ANOMALUS_EVENT)
        {
        }

        bool achievement;
        uint16 activeRifts;

        void Reset() override
        {
            BossAI::Reset();
            achievement = true;
            me->CastSpell(me, SPELL_CLOSE_RIFTS, true);
        }

        uint32 GetData(uint32 data) const override
        {
            if (data == me->GetEntry())
                return achievement;
            return 0;
        }

        void SetData(uint32 type, uint32) override
        {
            if (type == me->GetEntry())
            {
                if (activeRifts > 0 && --activeRifts == 0 && me->HasAura(SPELL_RIFT_SHIELD))
                {
                    events.DelayEvents(me->GetAura(SPELL_RIFT_SHIELD)->GetDuration() - 46000);
                    me->RemoveAura(SPELL_RIFT_SHIELD);
                    me->InterruptNonMeleeSpells(false);
                }
                achievement = false;
            }
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            activeRifts++;
        }

        void JustEngagedWith(Unit* who) override
        {
            Talk(SAY_AGGRO);
            BossAI::JustEngagedWith(who);

            activeRifts = 0;
            events.SetTimer(45000);
            events.ScheduleEvent(EVENT_ANOMALUS_SPARK, 5s);
            events.ScheduleEvent(EVENT_ANOMALUS_HEALTH, 1s);
            events.ScheduleEvent(EVENT_ANOMALUS_SPAWN_RIFT, IsHeroic() ? 15s : 25s);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_ANOMALUS_ARCANE_ATTRACTION, 8s);
        }

        void JustDied(Unit* killer) override
        {
            Talk(SAY_DEATH);
            BossAI::JustDied(killer);
            me->CastSpell(me, SPELL_CLOSE_RIFTS, true);
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
                case EVENT_ANOMALUS_SPARK:
                    me->CastSpell(me->GetVictim(), SPELL_SPARK, false);
                    events.ScheduleEvent(EVENT_ANOMALUS_SPARK, 5s);
                    break;
                case EVENT_ANOMALUS_HEALTH:
                    if (me->HealthBelowPct(51))
                    {
                        //First time we reach 51%, the next rift going to be empowered following timings.
                        events.CancelEvent(EVENT_ANOMALUS_SPAWN_RIFT);
                        events.ScheduleEvent(EVENT_ANOMALUS_SPAWN_RIFT_EMPOWERED, 1s);
                        break;
                    }
                    events.ScheduleEvent(EVENT_ANOMALUS_HEALTH, 1s);
                    break;
                case EVENT_ANOMALUS_ARCANE_ATTRACTION:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 50.0f, true))
                        me->CastSpell(target, SPELL_ARCANE_ATTRACTION, false);
                    events.ScheduleEvent(EVENT_ANOMALUS_ARCANE_ATTRACTION, 15s);
                    break;
                case EVENT_ANOMALUS_SPAWN_RIFT:
                    Talk(SAY_RIFT);
                    Talk(EMOTE_RIFT);
                    me->CastSpell(me, SPELL_CREATE_RIFT, false);
                    //Once we hit 51% hp mark, after each rift we spawn an empowered
                    events.ScheduleEvent(me->HealthBelowPct(51) ? EVENT_ANOMALUS_SPAWN_RIFT_EMPOWERED : EVENT_ANOMALUS_SPAWN_RIFT, IsHeroic() ? 15000 : 25000);
                    break;
                case EVENT_ANOMALUS_SPAWN_RIFT_EMPOWERED:
                    Talk(SAY_RIFT);
                    Talk(EMOTE_RIFT);

                    me->CastSpell(me, SPELL_CREATE_RIFT, false);
                    me->CastSpell(me, SPELL_RIFT_SHIELD, true);
                    me->m_Events.AddEvent(new ChargeRifts(me), me->m_Events.CalculateTime(1000));
                    events.DelayEvents(46s);
                    //As we just spawned an empowered spawn a normal one
                    events.ScheduleEvent(EVENT_ANOMALUS_SPAWN_RIFT, IsHeroic() ? 15s : 25s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        bool CheckEvadeIfOutOfCombatArea() const override
        {
            return me->GetHomePosition().GetExactDist2d(me) > 60.0f;
        }
    };
};

class achievement_chaos_theory : public AchievementCriteriaScript
{
public:
    achievement_chaos_theory() : AchievementCriteriaScript("achievement_chaos_theory")
    {
    }

    bool OnCheck(Player* /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(target->GetEntry());
    }
};

void AddSC_boss_anomalus()
{
    new boss_anomalus();
    new achievement_chaos_theory();
}
