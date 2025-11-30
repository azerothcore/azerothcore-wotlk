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
#include "naxxramas.h"
#include "SpellInfo.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_TAUNTED                     = 2,
    SAY_DEATH                       = 3,
    SAY_PATHETIC                    = 4,
    SAY_TARGET_DUMMY                = 5,
    SAY_DEATH_KNIGHT_UNDERSTUDY     = 0,
};

enum Spells
{
    SPELL_UNBALANCING_STRIKE        = 26613,
    SPELL_DISRUPTING_SHOUT          = 55543,
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

enum NPCs
{
    NPC_DEATH_KNIGHT_UNDERSTUDY     = 16803,
    NPC_TARGET_DUMMY                = 16211,
};

enum Actions
{
    ACTION_FACE_ME                 = 0,
    ACTION_TALK                    = 1,
    ACTION_EMOTE                   = 2,
    ACTION_SALUTE                  = 3,
    ACTION_BACK_TO_TRAINING        = 4,
};

enum Misc
{
    GROUP_OOC_RP                    = 0,
    POINT_DEATH_KNIGHT              = 0,
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
        {}

        EventMap events;
        SummonList summons;

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

        void ScheduleInteractWithDeathKnight()
        {
            if (_rpBuddyGUID)
                if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                    me->SetFacingToObject(understudy);

            scheduler.Schedule(2s, GROUP_OOC_RP, [this](TaskContext /*context*/)
            {
                if (roll_chance_i(75))
                {
                    bool longText = roll_chance_i(50);
                    Talk(longText ? SAY_TARGET_DUMMY : SAY_PATHETIC);
                    scheduler.Schedule(4s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        if (_rpBuddyGUID)
                            if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                                understudy->AI()->DoAction(ACTION_TALK);
                    });
                    if (longText)
                        scheduler.DelayGroup(GROUP_OOC_RP, 5s);
                }
                else
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    scheduler.Schedule(4s, GROUP_OOC_RP, [this](TaskContext /*context*/)
                    {
                        if (_rpBuddyGUID)
                            if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                            {
                                if (roll_chance_i(25))
                                    understudy->AI()->DoAction(ACTION_EMOTE);
                                else
                                    understudy->AI()->DoAction(ACTION_TALK);
                            }
                    });
                }
            }).Schedule(4s, GROUP_OOC_RP, [this](TaskContext /*context*/)
            {
                if (_rpBuddyGUID)
                    if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                        understudy->AI()->DoAction(ACTION_FACE_ME);
            }).Schedule(10s, GROUP_OOC_RP, [this](TaskContext /*context*/)
            {
                if (_rpBuddyGUID)
                    if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                        understudy->AI()->DoAction(ACTION_SALUTE);
            }).Schedule(13s, GROUP_OOC_RP, [this](TaskContext /*context*/)
            {
                me->ResumeMovement();
            }).Schedule(16s, GROUP_OOC_RP, [this](TaskContext /*context*/)
            {
                if (_rpBuddyGUID)
                    if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                        understudy->AI()->DoAction(ACTION_BACK_TO_TRAINING);
                ScheduleRP();
            });
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type == POINT_MOTION_TYPE && id == POINT_DEATH_KNIGHT)
            {
                ScheduleInteractWithDeathKnight();
            }
        }

        void ScheduleRP()
        {
            _rpBuddyGUID = Acore::Containers::SelectRandomContainerElement(summons);
            scheduler.Schedule(60s, 80s, GROUP_OOC_RP, [this](TaskContext context)
            {
                if (_rpBuddyGUID)
                {
                    if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                    {
                        if (me->GetDistance2d(understudy) <= 6.0f)
                        {
                            me->PauseMovement();
                            scheduler.Schedule(500ms, GROUP_OOC_RP, [this](TaskContext /*context*/)
                            {
                                if (_rpBuddyGUID)
                                    if (Creature* understudy = ObjectAccessor::GetCreature(*me, _rpBuddyGUID))
                                        me->GetMotionMaster()->MovePoint(POINT_DEATH_KNIGHT, understudy->GetNearPosition(3.2f, understudy->GetRelativeAngle(me)));
                            });
                            return;
                        }
                    }
                }
                context.Repeat(2s);
            });
        }

        void KilledUnit(Unit* who) override
        {
            if (roll_chance_i(30))
                Talk(SAY_SLAY);

            if (who->IsPlayer())
                instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            // Damage done by the controlled Death Knight understudies should also count toward damage done by players
            if (who && who->IsCreature() && who->GetEntry() == NPC_DEATH_KNIGHT_UNDERSTUDY)
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
                    me->CastSpell(me, SPELL_DISRUPTING_SHOUT, false);
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
        ObjectGuid _rpBuddyGUID;
    };
};

class boss_razuvious_minion : public CreatureScript
{
public:
    boss_razuvious_minion() : CreatureScript("boss_razuvious_minion") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetNaxxramasAI<boss_razuvious_minionAI>(creature);
    }

    struct boss_razuvious_minionAI : public ScriptedAI
    {
        explicit boss_razuvious_minionAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            scheduler.CancelAll();
            ScheduleAttackDummy();
        }

        void ScheduleAttackDummy()
        {
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
            if (Creature* targetDummy = me->FindNearestCreature(NPC_TARGET_DUMMY, 10.0f))
            {
                me->SetFacingToObject(targetDummy);
            }
            scheduler.Schedule(6s, 9s, GROUP_OOC_RP, [this](TaskContext context)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
                context.Repeat(6s, 9s);
            });
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_FACE_ME:
                {
                    scheduler.CancelGroup(GROUP_OOC_RP);
                    me->SetSheath(SHEATH_STATE_UNARMED);
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_NONE);

                    if (Creature* creature = me->GetInstanceScript()->GetCreature(DATA_RAZUVIOUS_BOSS))
                        me->SetFacingToObject(creature);

                    break;
                }
                case ACTION_TALK:
                    Talk(SAY_DEATH_KNIGHT_UNDERSTUDY);
                    break;
                case ACTION_EMOTE:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    break;
                case ACTION_SALUTE:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    break;
                case ACTION_BACK_TO_TRAINING:
                    me->SetSheath(SHEATH_STATE_MELEE);
                    ScheduleAttackDummy();
                    break;
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                me->GetInstanceScript()->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void JustEngagedWith(Unit* who) override
        {
            scheduler.CancelGroup(GROUP_OOC_RP);

            if (Creature* creature = me->GetInstanceScript()->GetCreature(DATA_RAZUVIOUS_BOSS))
            {
                creature->SetInCombatWithZone();
                creature->AI()->AttackStart(who);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            scheduler.Update(diff);

            if (UpdateVictim())
            {
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
