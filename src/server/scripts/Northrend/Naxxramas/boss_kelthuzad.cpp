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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "naxxramas.h"

enum Yells
{
    SAY_ANSWER_REQUEST                      = 3,
    SAY_TAUNT                               = 6,
    SAY_AGGRO                               = 7,
    SAY_SLAY                                = 8,
    SAY_DEATH                               = 9,
    SAY_CHAIN                               = 10,
    SAY_FROST_BLAST                         = 11,
    SAY_REQUEST_AID                         = 12,
    EMOTE_PHASE_TWO                         = 13,
    SAY_SUMMON_MINIONS                      = 14,
    SAY_SPECIAL                             = 15,

    EMOTE_GUARDIAN_FLEE                     = 0,
    EMOTE_GUARDIAN_APPEAR                   = 1
};

enum Spells
{
    // Kel'Thzuad
    SPELL_FROST_BOLT_SINGLE                 = 28478,
    SPELL_FROST_BOLT_MULTI                  = 28479,
    SPELL_SHADOW_FISURE                     = 27810,
    SPELL_VOID_BLAST                        = 27812,
    SPELL_DETONATE_MANA                     = 27819,
    SPELL_MANA_DETONATION_DAMAGE            = 27820,
    SPELL_FROST_BLAST                       = 27808,
    SPELL_CHAINS_OF_KELTHUZAD               = 28410, // 28408 script effect
    SPELL_BERSERK                           = 28498,
    SPELL_KELTHUZAD_CHANNEL                 = 29423,

    // Minions
    SPELL_FRENZY                            = 28468,
    SPELL_MORTAL_WOUND                      = 28467,
    SPELL_BLOOD_TAP                         = 28470
};

enum Misc
{
    NPC_SOLDIER_OF_THE_FROZEN_WASTES        = 16427,
    NPC_UNSTOPPABLE_ABOMINATION             = 16428,
    NPC_SOUL_WEAVER                         = 16429,
    NPC_GUARDIAN_OF_ICECROWN                = 16441,

    ACTION_CALL_HELP_ON                     = 1,
    ACTION_CALL_HELP_OFF                    = 2,
    ACTION_SECOND_PHASE                     = 3,
    ACTION_GUARDIANS_OFF                    = 4
};

enum Event
{
    // Kel'Thuzad
    EVENT_SUMMON_SOLDIER                    = 1,
    EVENT_SUMMON_UNSTOPPABLE_ABOMINATION    = 2,
    EVENT_SUMMON_SOUL_WEAVER                = 3,
    EVENT_PHASE_2                           = 4,
    EVENT_FROST_BOLT_SINGLE                 = 5,
    EVENT_FROST_BOLT_MULTI                  = 6,
    EVENT_DETONATE_MANA                     = 7,
    EVENT_PHASE_3                           = 8,
    EVENT_P3_LICH_KING_SAY                  = 9,
    EVENT_SHADOW_FISSURE                    = 10,
    EVENT_FROST_BLAST                       = 11,
    EVENT_CHAINS                            = 12,
    EVENT_SUMMON_GUARDIAN_OF_ICECROWN       = 13,
    EVENT_FLOOR_CHANGE                      = 14,
    EVENT_ENRAGE                            = 15,
    EVENT_SPAWN_POOL                        = 16,

    // Minions
    EVENT_MINION_FRENZY                     = 17,
    EVENT_MINION_MORTAL_WOUND               = 18,
    EVENT_MINION_BLOOD_TAP                  = 19
};

const Position SummonGroups[12] =
{
    // Portals
    {3783.272705f, -5062.697266f, 143.711203f, 3.617599f}, // LEFT_FAR
    {3730.291260f, -5027.239258f, 143.956909f, 4.461900f}, // LEFT_MIDDLE
    {3683.868652f, -5057.281250f, 143.183884f, 5.237086f}, // LEFT_NEAR
    {3759.355225f, -5174.128418f, 143.802383f, 2.170104f}, // RIGHT_FAR
    {3700.724365f, -5185.123047f, 143.928024f, 1.309310f}, // RIGHT_MIDDLE
    {3665.121094f, -5138.679199f, 143.183212f, 0.604023f}, // RIGHT_NEAR

    // Middle
    {3769.34f, -5071.80f, 143.2082f, 3.658f},
    {3729.78f, -5043.56f, 143.3867f, 4.475f},
    {3682.75f, -5055.26f, 143.1848f, 5.295f},
    {3752.58f, -5161.82f, 143.2944f, 2.126f},
    {3702.83f, -5171.70f, 143.4356f, 1.305f},
    {3665.30f, -5141.55f, 143.1846f, 0.566f}
};

const Position SpawnPool[7] =
{
    // Portals
    {3783.272705f, -5062.697266f, 143.711203f, 3.617599f}, // LEFT_FAR
    {3730.291260f, -5027.239258f, 143.956909f, 4.461900f}, // LEFT_MIDDLE
    {3683.868652f, -5057.281250f, 143.183884f, 5.237086f}, // LEFT_NEAR
    {3759.355225f, -5174.128418f, 143.802383f, 2.170104f}, // RIGHT_FAR
    {3700.724365f, -5185.123047f, 143.928024f, 1.309310f}, // RIGHT_MIDDLE
    {3665.121094f, -5138.679199f, 143.183212f, 0.604023f}, // RIGHT_NEAR
    {3651.729980f, -5092.620117f, 143.380005f, 6.050000f} // GATE
};

class boss_kelthuzad : public CreatureScript
{
public:
    boss_kelthuzad() : CreatureScript("boss_kelthuzad") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_kelthuzadAI>(pCreature);
    }

    struct boss_kelthuzadAI : public BossAI
    {
        explicit boss_kelthuzadAI(Creature* c) : BossAI(c, BOSS_KELTHUZAD), summons(me)
        {}

        EventMap events;
        SummonList summons;

        float NormalizeOrientation(float o)
        {
            return std::fmod(o, 2.0f * static_cast<float>(M_PI)); // Only positive values will be passed
        }

        void SpawnHelpers()
        {
            // spawn at gate
            me->SummonCreature(NPC_UNSTOPPABLE_ABOMINATION, 3656.19f, -5093.78f, 143.33f, 6.08, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000);// abo center
            me->SummonCreature(NPC_UNSTOPPABLE_ABOMINATION, 3657.94f, -5087.68f, 143.60f, 6.08, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000);// abo left
            me->SummonCreature(NPC_UNSTOPPABLE_ABOMINATION, 3655.48f, -5100.05f, 143.53f, 6.08, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000);// abo right
            me->SummonCreature(NPC_SOUL_WEAVER, 3651.73f, -5092.62f, 143.38f, 6.05, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000); // soul behind
            me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 3660.17f, -5092.45f, 143.37f, 6.07, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000); // ske front left
            me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 3659.39f, -5096.21f, 143.29f, 6.07, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000); // ske front right
            me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 3659.29f, -5090.19f, 143.48f, 6.07, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000); // ske left left
            me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 3657.43f, -5098.03f, 143.41f, 6.07, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000); // ske right right
            me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 3654.36f, -5090.51f, 143.48f, 6.09, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000); // ske behind left
            me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 3653.35f, -5095.91f, 143.41f, 6.09, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 2000); // ske right right

            // 6 rooms, 8 soldiers, 3 abominations and 1 weaver in each room | middle positions in table starts from 6
            for (uint8 i = 6; i < 12; ++i)
            {
                for (uint8 j = 0; j < 8; ++j)
                {
                    float angle = M_PI * 2 / 8 * j;
                    me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, SummonGroups[i].GetPositionX() + 6 * cos(angle), SummonGroups[i].GetPositionY() + 6 * std::sin(angle), SummonGroups[i].GetPositionZ(), SummonGroups[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
            }
            for (uint8 i = 6; i < 12; ++i)
            {
                for (uint8 j = 1; j < 4; ++j)
                {
                    float dist = j == 2 ? 0.0f : 8.0f; // second in middle
                    float angle = SummonGroups[i].GetOrientation() + M_PI * 2 / 4 * j;
                    me->SummonCreature(NPC_UNSTOPPABLE_ABOMINATION, SummonGroups[i].GetPositionX() + dist * cos(angle), SummonGroups[i].GetPositionY() + dist * std::sin(angle), SummonGroups[i].GetPositionZ(), SummonGroups[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
            }
            for (uint8 i = 6; i < 12; ++i)
            {
                for (uint8 j = 0; j < 1; ++j)
                {
                    float angle = SummonGroups[i].GetOrientation() + M_PI;
                    me->SummonCreature(NPC_SOUL_WEAVER, SummonGroups[i].GetPositionX() + 6 * cos(angle), SummonGroups[i].GetPositionY() + 6 * std::sin(angle), SummonGroups[i].GetPositionZ() + 0.5f, SummonGroups[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
            }
        }

        void SummonHelper(uint32 entry, uint32 count)
        {
            for (uint8 i = 0; i < count; ++i)
            {
                if (Creature* cr = me->SummonCreature(entry, SpawnPool[urand(0, 6)], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                {
                    if (Unit* target = SelectTargetFromPlayerList(100.0f))
                    {
                        cr->AI()->DoAction(ACTION_CALL_HELP_OFF);
                        cr->AI()->AttackStart(target);
                    }
                }
            }
        }

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_AGGRESSIVE);
            if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_FLOOR))
            {
                go->SetPhaseMask(1, true);
                go->SetGoState(GO_STATE_READY);
            }

            if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_1))
                go->SetGoState(GO_STATE_READY);

            if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_2))
                go->SetGoState(GO_STATE_READY);

            if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_3))
                go->SetGoState(GO_STATE_READY);

            if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_4))
                go->SetGoState(GO_STATE_READY);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode(why);
        }

        void KilledUnit(Unit* who) override
        {
            if (!who->IsPlayer())
                return;

            Talk(SAY_SLAY);
            instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            summons.DoAction(ACTION_GUARDIANS_OFF);
            if (Creature* guardian = summons.GetCreatureWithEntry(NPC_GUARDIAN_OF_ICECROWN))
            {
                guardian->AI()->Talk(EMOTE_GUARDIAN_FLEE);
            }
            Talk(SAY_DEATH);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!me->IsInCombat() && who->IsPlayer() && who->IsAlive() && me->GetDistance(who) <= 50.0f)
                AttackStart(who);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            Talk(SAY_SUMMON_MINIONS);
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            me->RemoveAllAttackers();
            me->SetTarget();
            me->SetReactState(REACT_PASSIVE);
            me->CastSpell(me, SPELL_KELTHUZAD_CHANNEL, false);
            events.ScheduleEvent(EVENT_SPAWN_POOL, 5s);
            events.ScheduleEvent(EVENT_SUMMON_SOLDIER, 6400ms);
            events.ScheduleEvent(EVENT_SUMMON_UNSTOPPABLE_ABOMINATION, 10s);
            events.ScheduleEvent(EVENT_SUMMON_SOUL_WEAVER, 12s);
            events.ScheduleEvent(EVENT_PHASE_2, 228s);
            events.ScheduleEvent(EVENT_ENRAGE, 15min);

            if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_FLOOR))
            {
                events.ScheduleEvent(EVENT_FLOOR_CHANGE, 15s);
                go->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
            if (!cr->IsInCombat())
            {
                cr->GetMotionMaster()->MoveRandom(5);
            }
            if (cr->GetEntry() == NPC_GUARDIAN_OF_ICECROWN)
            {
                cr->SetHomePosition(cr->GetPositionX(), cr->GetPositionY(), cr->GetPositionZ(), cr->GetOrientation());
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (!me->HasAura(SPELL_KELTHUZAD_CHANNEL))
            {
                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
            }

            switch (events.ExecuteEvent())
            {
                case EVENT_FLOOR_CHANGE:
                    if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_FLOOR))
                    {
                        events.ScheduleEvent(EVENT_FLOOR_CHANGE, 15s);
                        go->SetGoState(GO_STATE_READY);
                        go->SetPhaseMask(2, true);
                    }
                    break;
                case EVENT_SPAWN_POOL:
                    SpawnHelpers();
                    break;
                case EVENT_SUMMON_SOLDIER:
                    SummonHelper(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 1);
                    events.Repeat(3100ms);
                    break;
                case EVENT_SUMMON_UNSTOPPABLE_ABOMINATION:
                    SummonHelper(NPC_UNSTOPPABLE_ABOMINATION, 1);
                    events.Repeat(18s + 500ms);
                    break;
                case EVENT_SUMMON_SOUL_WEAVER:
                    SummonHelper(NPC_SOUL_WEAVER, 1);
                    events.Repeat(30s);
                    break;
                case EVENT_PHASE_2:
                    Talk(EMOTE_PHASE_TWO);
                    Talk(SAY_AGGRO);
                    events.Reset();
                    summons.DoAction(ACTION_SECOND_PHASE);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    me->RemoveAura(SPELL_KELTHUZAD_CHANNEL);
                    me->SetReactState(REACT_AGGRESSIVE);
                    events.ScheduleEvent(EVENT_FROST_BOLT_SINGLE, 2s, 10s);
                    events.ScheduleEvent(EVENT_FROST_BOLT_MULTI, 15s, 30s);
                    events.ScheduleEvent(EVENT_DETONATE_MANA, 30s);
                    events.ScheduleEvent(EVENT_PHASE_3, 1s);
                    events.ScheduleEvent(EVENT_SHADOW_FISSURE, 25s);
                    events.ScheduleEvent(EVENT_FROST_BLAST, 45s);
                    if (Is25ManRaid())
                    {
                        events.ScheduleEvent(EVENT_CHAINS, 90s);
                    }
                    break;
                case EVENT_ENRAGE:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_FROST_BOLT_SINGLE:
                    me->CastSpell(me->GetVictim(), SPELL_FROST_BOLT_SINGLE, false);
                    events.Repeat(2s, 10s);
                    break;
                case EVENT_FROST_BOLT_MULTI:
                    me->CastSpell(me, SPELL_FROST_BOLT_MULTI, false);
                    events.Repeat(15s, 30s);
                    break;
                case EVENT_SHADOW_FISSURE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                    {
                        me->CastSpell(target, SPELL_SHADOW_FISURE, false);
                    }
                    events.Repeat(25s);
                    break;
                case EVENT_FROST_BLAST:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0, true, RAID_MODE(false, true)))
                    {
                        me->CastSpell(target, SPELL_FROST_BLAST, false);
                    }
                    Talk(SAY_FROST_BLAST);
                    events.Repeat(45s);
                    break;
                case EVENT_CHAINS:
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 200, true, false, -SPELL_CHAINS_OF_KELTHUZAD))
                        {
                            me->CastSpell(target, SPELL_CHAINS_OF_KELTHUZAD, true);
                        }
                    }
                    Talk(SAY_CHAIN);
                    events.Repeat(90s);
                    break;
                case EVENT_DETONATE_MANA:
                    {
                        std::vector<Unit*> unitList;
                        ThreatContainer::StorageType const& threatList = me->GetThreatMgr().GetThreatList();
                        for (auto itr : threatList)
                        {
                            if (itr->getTarget()->IsPlayer()
                                    && itr->getTarget()->getPowerType() == POWER_MANA
                                    && itr->getTarget()->GetPower(POWER_MANA))
                                    {
                                        unitList.push_back(itr->getTarget());
                                    }
                        }
                        if (!unitList.empty())
                        {
                            auto itr = unitList.begin();
                            advance(itr, urand(0, unitList.size() - 1));
                            me->CastSpell(*itr, SPELL_DETONATE_MANA, false);
                            Talk(SAY_SPECIAL);
                        }
                        events.Repeat(30s);
                        break;
                    }
                case EVENT_PHASE_3:
                    if (me->HealthBelowPct(45))
                    {
                        Talk(SAY_REQUEST_AID);
                        events.DelayEvents(5500ms);
                        events.ScheduleEvent(EVENT_P3_LICH_KING_SAY, 5s);
                        if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_1))
                            go->SetGoState(GO_STATE_ACTIVE);

                        if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_2))
                            go->SetGoState(GO_STATE_ACTIVE);

                        if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_3))
                            go->SetGoState(GO_STATE_ACTIVE);

                        if (GameObject* go = instance->GetGameObject(DATA_KELTHUZAD_PORTAL_4))
                            go->SetGoState(GO_STATE_ACTIVE);

                        break;
                    }
                    events.Repeat(1s);
                    break;
                case EVENT_P3_LICH_KING_SAY:
                {
                    if (Creature* cr = instance->GetCreature(DATA_LICH_KING_BOSS))
                        cr->AI()->Talk(SAY_ANSWER_REQUEST);

                    for (uint8 i = 0 ; i < RAID_MODE(2, 4); ++i)
                        events.ScheduleEvent(EVENT_SUMMON_GUARDIAN_OF_ICECROWN, Milliseconds(10000 + (i * 5000)));

                    break;
                }
                case EVENT_SUMMON_GUARDIAN_OF_ICECROWN:
                    if (Creature* cr = me->SummonCreature(NPC_GUARDIAN_OF_ICECROWN, SpawnPool[RAND(0, 1, 3, 4)]))
                    {
                        cr->AI()->Talk(EMOTE_GUARDIAN_APPEAR);
                        cr->AI()->AttackStart(me->GetVictim());
                    }
                    break;
            }
            if (!me->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
                DoMeleeAttackIfReady();
        }
    };
};

class boss_kelthuzad_minion : public CreatureScript
{
public:
    boss_kelthuzad_minion() : CreatureScript("boss_kelthuzad_minion") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_kelthuzad_minionAI>(pCreature);
    }

    struct boss_kelthuzad_minionAI : public ScriptedAI
    {
        explicit boss_kelthuzad_minionAI(Creature* c) : ScriptedAI(c) { }

        EventMap events;
        bool callHelp{};

        void Reset() override
        {
            me->SetNoCallAssistance(true);
            callHelp = true;
            events.Reset();
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_CALL_HELP_ON)
            {
                callHelp = true;
            }
            else if (param == ACTION_CALL_HELP_OFF)
            {
                callHelp = false;
            }
            else if (param == ACTION_SECOND_PHASE)
            {
                if (!me->IsInCombat())
                {
                    me->DespawnOrUnsummon(500ms);
                }
            }
            if (param == ACTION_GUARDIANS_OFF)
            {
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAllAuras();
                EnterEvadeMode();
                me->SetPosition(me->GetHomePosition());
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!who->IsPlayer() && !who->IsPet())
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (me->GetEntry() == NPC_UNSTOPPABLE_ABOMINATION)
                me->GetInstanceScript()->SetData(DATA_ABOMINATION_KILLED, 0);
        }

        void AttackStart(Unit* who) override
        {
            ScriptedAI::AttackStart(who);
            if (callHelp)
            {
                std::list<Creature*> targets;
                me->GetCreaturesWithEntryInRange(targets, 15.0f, me->GetEntry());
                for (std::list<Creature*>::const_iterator itr = targets.begin(); itr != targets.end(); ++itr)
                {
                    if ((*itr)->GetGUID() != me->GetGUID())
                    {
                        (*itr)->ToCreature()->AI()->DoAction(ACTION_CALL_HELP_OFF);
                        (*itr)->ToCreature()->AI()->AttackStart(who);
                    }
                }
            }

            if (me->GetEntry() != NPC_UNSTOPPABLE_ABOMINATION && me->GetEntry() != NPC_GUARDIAN_OF_ICECROWN)
            {
                me->AddThreat(who, 1000000.0f);
            }
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            me->SetInCombatWithZone();
            if (me->GetEntry() == NPC_UNSTOPPABLE_ABOMINATION)
            {
                events.ScheduleEvent(EVENT_MINION_FRENZY, 1s);
                events.ScheduleEvent(EVENT_MINION_MORTAL_WOUND, 5s);
            }
            else if (me->GetEntry() == NPC_GUARDIAN_OF_ICECROWN)
            {
                events.ScheduleEvent(EVENT_MINION_BLOOD_TAP, 15s);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
                me->GetInstanceScript()->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void JustReachedHome() override
        {
            if (me->GetEntry() == NPC_GUARDIAN_OF_ICECROWN)
            {
                me->DespawnOrUnsummon();
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
                case EVENT_MINION_MORTAL_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                    events.Repeat(15s);
                    break;
                case EVENT_MINION_FRENZY:
                    if (me->HealthBelowPct(35))
                    {
                        me->CastSpell(me, SPELL_FRENZY, true);
                        break;
                    }
                    events.Repeat(1s);
                    break;
                case EVENT_MINION_BLOOD_TAP:
                    me->CastSpell(me->GetVictim(), SPELL_BLOOD_TAP, false);
                    events.Repeat(15s);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class spell_kelthuzad_frost_blast : public SpellScript
{
    PrepareSpellScript(spell_kelthuzad_frost_blast);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_FROST_BLAST });
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();
        if (!caster || !caster->ToCreature())
            return;

        std::list<WorldObject*> tmplist;
        for (auto& target : targets)
        {
            if (!target->ToUnit()->HasAura(SPELL_FROST_BLAST))
            {
                tmplist.push_back(target);
            }
        }
        targets.clear();
        for (auto& itr : tmplist)
        {
            targets.push_back(itr);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kelthuzad_frost_blast::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

class spell_kelthuzad_detonate_mana_aura : public AuraScript
{
    PrepareAuraScript(spell_kelthuzad_detonate_mana_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_MANA_DETONATION_DAMAGE });
    }

    void HandleScript(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        Unit* target = GetTarget();
        if (auto mana = int32(target->GetMaxPower(POWER_MANA) / 10))
        {
            mana = target->ModifyPower(POWER_MANA, -mana);
            target->CastCustomSpell(SPELL_MANA_DETONATION_DAMAGE, SPELLVALUE_BASE_POINT0, -mana * 10, target, true, nullptr, aurEff);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_kelthuzad_detonate_mana_aura::HandleScript, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

void AddSC_boss_kelthuzad()
{
    new boss_kelthuzad();
    new boss_kelthuzad_minion();
    RegisterSpellScript(spell_kelthuzad_frost_blast);
    RegisterSpellScript(spell_kelthuzad_detonate_mana_aura);
}
