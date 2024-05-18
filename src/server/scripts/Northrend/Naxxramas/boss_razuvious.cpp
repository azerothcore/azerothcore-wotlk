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
    SAY_DEATH                       = 3,
    SAY_PATHETIC                    = 4,
    SAY_TARGET_DUMMY                = 5,
    SAY_DK_BEAT_ME                  = 0,
    SAY_DK_UNWORTHY                 = 1,
    SAY_DK_WORTHLESS                = 2
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
    EVENT_JAGGED_KNIFE              = 3
};

enum Misc
{
    NPC_DEATH_KNIGHT_UNDERSTUDY     = 16803,
    NPC_RAZUVIOUS                   = 16061,
    NPC_TARGET_DUMMY                = 16211,
    WP_TOP_LEFT                     = 1,
    WP_TOP_RIGHT                    = 2,
    WP_MIDDLE_RIGHT                 = 3,
    WP_MIDDLE_BOTTOM                = 4,
    // WP_MIDDLE_LEFT = 5
    ACTION_INTERACT_WITH_RAZUVIOUS  = 0,
    GROUP_OOC_RP                    = 0,
    DATA_CAN_SPEAK                  = 0,
};

const uint32 TABLE_WAYPOINT_RP_10[4] = {WP_TOP_LEFT, WP_TOP_RIGHT, WP_TOP_LEFT, WP_TOP_RIGHT};
const uint32 TABLE_WAYPOINT_RP_25[4] = {WP_MIDDLE_BOTTOM, WP_TOP_LEFT, WP_MIDDLE_RIGHT, WP_TOP_RIGHT};

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
                if (TempSummon* temp = me->SummonCreature(NPC_DEATH_KNIGHT_UNDERSTUDY, 2778.56f, -3113.74f, 267.685f, 5.28f))
                    temp->AI()->SetData(DATA_CAN_SPEAK, 1);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
        }

        void Reset() override
        {
            BossAI::Reset();
            me->SetControlled(false, UNIT_STATE_ROOT);
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

            if (id == RAID_MODE(TABLE_WAYPOINT_RP_10, TABLE_WAYPOINT_RP_25)[_roleplayWaypointCount])
            {
                _roleplayReady = false;
                if (Creature* understudy = GetClosestCreatureWithEntry(me, NPC_DEATH_KNIGHT_UNDERSTUDY, 15.0f))
                {
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->SetFacingToObject(understudy);
                    scheduler.Schedule(1s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        if (Creature* understudy = GetClosestCreatureWithEntry(me, NPC_DEATH_KNIGHT_UNDERSTUDY, 20.0f))
                        {
                            if (_roleplayWaypointCount == 0 && Is25ManRaid() && roll_chance_i(75))
                            {
                                Talk(urand(SAY_PATHETIC,SAY_TARGET_DUMMY));
                            }
                            else
                            {
                                me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                            }
                        }
                    }).Schedule(4s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        if (Creature* understudy = GetClosestCreatureWithEntry(me, NPC_DEATH_KNIGHT_UNDERSTUDY, 20.0f))
                        {
                            understudy->AI()->DoAction(ACTION_INTERACT_WITH_RAZUVIOUS);
                        }
                    }).Schedule(10s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        me->SetControlled(false, UNIT_STATE_ROOT);
                    });
                }
            }
        }

        void ScheduleRP()
        {
            _roleplayWaypointCount = 1;
            _roleplayReady = false;
            // scheduler.Schedule(1s, 2s, GROUP_OOC_RP, [this](TaskContext context)
            scheduler.Schedule(60s, 80s, GROUP_OOC_RP, [this](TaskContext context)
            {
                _roleplayWaypointCount = (_roleplayWaypointCount + 1) % 4;
                _roleplayReady = true;
                context.Repeat(60s, 80s);
                // context.Repeat(30s, 40s);
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
            me->SetControlled(false, UNIT_STATE_ROOT);
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_UNBALANCING_STRIKE, 20s);
            events.ScheduleEvent(EVENT_DISRUPTING_SHOUT, 15s);
            events.ScheduleEvent(EVENT_JAGGED_KNIFE, 10s);
            summons.DoZoneInCombat();
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat())
                scheduler.Update(diff);

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

        void Reset() override
        {
            scheduler.CancelAll();
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
            scheduler.Schedule(6s, 9s, GROUP_OOC_RP, [this](TaskContext /*context*/)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
            });
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_INTERACT_WITH_RAZUVIOUS)
            {
                if (Creature* cr = me->FindNearestCreature(NPC_RAZUVIOUS, 36.0f))
                {
                    me->SetFacingToObject(cr);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);
                    scheduler.DelayGroup(GROUP_OOC_RP, 12s);
                    scheduler.Schedule(2s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        if(_canSpeak)
                        {
                            Talk(urand(SAY_DK_BEAT_ME, SAY_DK_WORTHLESS));
                        }
                        else
                        {
                            me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        }
                    }).Schedule(6s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    }).Schedule(11s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        if (Creature* targetDummy = me->FindNearestCreature(16211, 10.0f))
                        {
                            me->SetFacingToObject(targetDummy);
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
                        }
                    });
                }
            }
        }

        void SetData(uint32 /*type*/, uint32 /*data*/) override
        {
            _canSpeak = true;
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
            if (!me->IsInCombat())
                scheduler.Update(diff);

            if (UpdateVictim())
            {
                if (!me->HasUnitState(UNIT_STATE_CASTING) || !me->IsCharmed())
                {
                    DoMeleeAttackIfReady();
                }
            }
        }
    private:
        bool _canSpeak;
    };
};

void AddSC_boss_razuvious()
{
    new boss_razuvious();
    new boss_razuvious_minion();
}
