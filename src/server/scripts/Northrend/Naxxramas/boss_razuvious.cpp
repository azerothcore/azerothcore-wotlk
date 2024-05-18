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
#include "naxxramas.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_TAUNTED                     = 2,
    SAY_DEATH                       = 3
};

enum Spells
{
    SPELL_UNBALANCING_STRIKE        = 26613,
    SPELL_DISRUPTING_SHOUT_10       = 55543,
    SPELL_DISRUPTING_SHOUT_25       = 29107,
    SPELL_JAGGED_KNIFE              = 55550,
    SPELL_HOPELESS                  = 29125,

    SPELL_TAUNT                     = 29060
};

enum Events
{
    EVENT_UNBALANCING_STRIKE        = 1,
    EVENT_DISRUPTING_SHOUT          = 2,
    EVENT_JAGGED_KNIFE              = 3,
    // OOC RP
    EVENT_GO_TRAINEE                = 4,
    EVENT_TURN_TO_TRAINEE           = 5,
    EVENT_EMOTE_SHOUT               = 6,
    EVENT_ADD_TURN_RAZUV            = 7,
    EVENT_ADD_TALK                  = 8,
    EVENT_ADD_SALUTE                = 9,
    EVENT_ADD_ATTACK                = 10,
    EVENT_ADD_TURN_BACK             = 11
};

enum Actions
{
    ACTION_SALUTE_RAZUVIOUS = 0
};

enum Groups
{
    GROUP_OOC_RP        = 0
};

enum Misc
{
    NPC_DEATH_KNIGHT_UNDERSTUDY     = 16803,
    NPC_RAZUVIOUS                   = 16061
};

class boss_razuvious : public CreatureScript
{
public:
    boss_razuvious() : CreatureScript("boss_razuvious") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_razuviousAI>(pCreature);
    }

    struct boss_razuviousAI : public BossAI
    {
        explicit boss_razuviousAI(Creature* c) : BossAI(c, BOSS_RAZUVIOUS), summons(me)
        {
            pInstance = me->GetInstanceScript();
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;

        void SpawnHelpers()
        {
            me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2762.23f, -3085.07f, 267.685f, 1.95f);
            me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2758.24f, -3110.97f, 267.685f, 3.94f);
            if (Is25ManRaid())
            {
                me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2782.45f, -3088.03f, 267.685f, 0.75f);
                me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2778.56f, -3113.74f, 267.685f, 5.28f);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
        }

        void Reset() override
        {
            BossAI::Reset();
            summons.DespawnAll();
            events.Reset();
            SpawnHelpers();
            ScheduleRP();
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != WAYPOINT_MOTION_TYPE)
                return;

            if (!_roleplayReady)
                return;

            if ( id == _roleplayWaypointCount || (id == 5 && _roleplayWaypointCount == 4))
            {
                _roleplayReady = false;
                if (Creature* understudy = GetClosestCreatureWithEntry(me, NPC_DEATH_KNIGHT_UNDERSTUDY, 15.0f))
                {
                    me->PauseMovement();
                    me->SetFacingToObject(understudy);
                    understudy->AI()->DoAction(ACTION_SALUTE_RAZUVIOUS);
                    scheduler.Schedule(4s, GROUP_OOC_RP, [this](TaskContext context)
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    }).Schedule(8s, GROUP_OOC_RP, [this](TaskContext context)
                    {
                        me->ResumeMovement();
                    });
                }
            }
        }

        void ScheduleRP()
        {
            _roleplayWaypointCount = 1;
            _roleplayReady = false;
            // scheduler.Schedule(60s, 80s, GROUP_OOC_RP, [this](TaskContext context)
            scheduler.Schedule(20s, 25s, GROUP_OOC_RP, [this](TaskContext context)
            {
                // waypoints 10M: 1,2 25M: 1,2,3,5
                _roleplayWaypointCount = (_roleplayWaypointCount % RAID_MODE(2,4)) + 1;
                _roleplayReady = true;
                // context.Repeat(60s, 80s);
                context.Repeat(30s, 40s);
            });
        }

        void KilledUnit(Unit* who) override
        {
            if (roll_chance_i(30))
            {
                Talk(SAY_SLAY);
            }
            if (who->GetTypeId() == TYPEID_PLAYER && pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            // Damage done by the controlled Death Knight understudies should also count toward damage done by players
            if(who && who->GetTypeId() == TYPEID_UNIT && who->GetEntry() == NPC_DEATH_KNIGHT_UNDERSTUDY)
            {
                me->LowerPlayerDamageReq(damage);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
            me->CastSpell(me, SPELL_HOPELESS, true);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_TAUNT)
            {
                Talk(SAY_TAUNTED, caster);
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            scheduler.CancelGroup(GROUP_OOC_RP);
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_UNBALANCING_STRIKE, 20s);
            events.ScheduleEvent(EVENT_DISRUPTING_SHOUT, 15s);
            events.ScheduleEvent(EVENT_JAGGED_KNIFE, 10s);
            summons.DoZoneInCombat();
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
                case EVENT_UNBALANCING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_UNBALANCING_STRIKE, false);
                    events.Repeat(20s);
                    break;
                case EVENT_DISRUPTING_SHOUT:
                    me->CastSpell(me, RAID_MODE(SPELL_DISRUPTING_SHOUT_10, SPELL_DISRUPTING_SHOUT_25), false);
                    events.Repeat(15s);
                    break;
                case EVENT_JAGGED_KNIFE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 45.0f))
                    {
                        me->CastSpell(target, SPELL_JAGGED_KNIFE, false);
                    }
                    events.Repeat(10s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    private:
        bool _roleplayReady;
        uint8 _roleplayWaypointCount;
    };
};

class boss_razuvious_minion : public CreatureScript
{
public:
    boss_razuvious_minion() : CreatureScript("boss_razuvious_minion") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_razuvious_minionAI>(pCreature);
    }

    struct boss_razuvious_minionAI : public ScriptedAI
    {
        explicit boss_razuvious_minionAI(Creature* c) : ScriptedAI(c) { }

        EventMap events;

        void Reset() override
        {
            events.Reset();
            ScheduleRP();
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_SALUTE_RAZUVIOUS)
            {
                if (Creature* cr = me->FindNearestCreature(NPC_RAZUVIOUS, 100.0f))
                {
                    me->SetFacingToObject(cr);
                    scheduler.DelayGroup(GROUP_OOC_RP, 10s);
                    scheduler.Schedule(1s, GROUP_OOC_RP, [this](TaskContext context)
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    }).Schedule(4s, GROUP_OOC_RP, [this](TaskContext context)
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    }).Schedule(2s, GROUP_OOC_RP, [this](TaskContext context)
                    {
                        if (Creature* targetDummy = me->FindNearestCreature(16211, 10.0f))
                        {
                            me->SetFacingToObject(targetDummy);
                            me->HandleEmoteCommand(EMOTE_STATE_READY1H);
                        }
                    });
                }
            }
        }

        void ScheduleRP()
        {
            scheduler.Schedule(6s, 8s, GROUP_OOC_RP, [this](TaskContext context)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
            });
        }


        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && me->GetInstanceScript())
            {
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            scheduler.CancelGroup(GROUP_OOC_RP);
            if (Creature* cr = me->FindNearestCreature(NPC_RAZUVIOUS, 100.0f))
            {
                cr->SetInCombatWithZone();
                cr->AI()->AttackStart(who);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (UpdateVictim())
            {
                events.Update(diff);
                if (!me->HasUnitState(UNIT_STATE_CASTING) || !me->IsCharmed())
                {
                    DoMeleeAttackIfReady();
                }
            }
        }
    };
};

void AddSC_boss_razuvious()
{
    new boss_razuvious();
    new boss_razuvious_minion();
}
