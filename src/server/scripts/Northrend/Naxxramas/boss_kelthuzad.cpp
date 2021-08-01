/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "naxxramas.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "SpellScript.h"

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
    SPELL_FROST_BOLT_SINGLE_10              = 28478,
    SPELL_FROST_BOLT_SINGLE_25              = 55802,
    SPELL_FROST_BOLT_MULTI_10               = 28479,
    SPELL_FROST_BOLT_MULTI_25               = 55807,
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
        {
            pInstance = me->GetInstanceScript();
            _justSpawned = true;
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;
        bool _justSpawned;

        float NormalizeOrientation(float o)
        {
            return fmod(o, 2.0f * static_cast<float>(M_PI)); // Only positive values will be passed
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
                    me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, SummonGroups[i].GetPositionX() + 6 * cos(angle), SummonGroups[i].GetPositionY() + 6 * sin(angle), SummonGroups[i].GetPositionZ(), SummonGroups[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
            }
            for (uint8 i = 6; i < 12; ++i)
            {
                for (uint8 j = 1; j < 4; ++j)
                {
                    float dist = j == 2 ? 0.0f : 8.0f; // second in middle
                    float angle = SummonGroups[i].GetOrientation() + M_PI * 2 / 4 * j;
                    me->SummonCreature(NPC_UNSTOPPABLE_ABOMINATION, SummonGroups[i].GetPositionX() + dist * cos(angle), SummonGroups[i].GetPositionY() + dist * sin(angle), SummonGroups[i].GetPositionZ(), SummonGroups[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
            }
            for (uint8 i = 6; i < 12; ++i)
            {
                for (uint8 j = 0; j < 1; ++j)
                {
                    float angle = SummonGroups[i].GetOrientation() + M_PI;
                    me->SummonCreature(NPC_SOUL_WEAVER, SummonGroups[i].GetPositionX() + 6 * cos(angle), SummonGroups[i].GetPositionY() + 6 * sin(angle), SummonGroups[i].GetPositionZ() + 0.5f, SummonGroups[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
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
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_AGGRESSIVE);
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_FLOOR)))
            {
                go->SetPhaseMask(1, true);
                go->SetGoState(GO_STATE_READY);
            }
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_GATE)))
            {
                if(!_justSpawned) // Don't open the door if we just spawned and are still doing the conversation
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
            _justSpawned = false;
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_1)))
            {
                go->SetGoState(GO_STATE_READY);
            }
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_2)))
            {
                go->SetGoState(GO_STATE_READY);
            }
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_3)))
            {
                go->SetGoState(GO_STATE_READY);
            }
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_4)))
            {
                go->SetGoState(GO_STATE_READY);
            }
        }

        void EnterEvadeMode() override
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode();
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
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
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!me->IsInCombat() && who->GetTypeId() == TYPEID_PLAYER && who->IsAlive() && me->GetDistance(who) <= 50.0f)
                AttackStart(who);
        }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            Talk(SAY_SUMMON_MINIONS);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            me->RemoveAllAttackers();
            me->SetTarget();
            me->SetReactState(REACT_PASSIVE);
            me->CastSpell(me, SPELL_KELTHUZAD_CHANNEL, false);
            events.ScheduleEvent(EVENT_SPAWN_POOL, 5000);
            events.ScheduleEvent(EVENT_SUMMON_SOLDIER, 6400);
            events.ScheduleEvent(EVENT_SUMMON_UNSTOPPABLE_ABOMINATION, 10000);
            events.ScheduleEvent(EVENT_SUMMON_SOUL_WEAVER, 12000);
            events.ScheduleEvent(EVENT_PHASE_2, 228000);
            events.ScheduleEvent(EVENT_ENRAGE, 900000);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_FLOOR)))
                {
                    events.ScheduleEvent(EVENT_FLOOR_CHANGE, 15000);
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_GATE)))
            {
                go->SetGoState(GO_STATE_READY);
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
                    if (pInstance)
                    {
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_FLOOR)))
                        {
                            events.ScheduleEvent(EVENT_FLOOR_CHANGE, 15000);
                            go->SetGoState(GO_STATE_READY);
                            go->SetPhaseMask(2, true);
                        }
                    }
                    break;
                case EVENT_SPAWN_POOL:
                    SpawnHelpers();
                    break;
                case EVENT_SUMMON_SOLDIER:
                    SummonHelper(NPC_SOLDIER_OF_THE_FROZEN_WASTES, 1);
                    events.RepeatEvent(3100);
                    break;
                case EVENT_SUMMON_UNSTOPPABLE_ABOMINATION:
                    SummonHelper(NPC_UNSTOPPABLE_ABOMINATION, 1);
                    events.RepeatEvent(18500);
                    break;
                case EVENT_SUMMON_SOUL_WEAVER:
                    SummonHelper(NPC_SOUL_WEAVER, 1);
                    events.RepeatEvent(30000);
                    break;
                case EVENT_PHASE_2:
                    Talk(EMOTE_PHASE_TWO);
                    Talk(SAY_AGGRO);
                    events.Reset();
                    summons.DoAction(ACTION_SECOND_PHASE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    me->RemoveAura(SPELL_KELTHUZAD_CHANNEL);
                    me->SetReactState(REACT_AGGRESSIVE);
                    events.ScheduleEvent(EVENT_FROST_BOLT_SINGLE, urand(2000, 10000));
                    events.ScheduleEvent(EVENT_FROST_BOLT_MULTI, urand(15000, 30000));
                    events.ScheduleEvent(EVENT_DETONATE_MANA, 30000);
                    events.ScheduleEvent(EVENT_PHASE_3, 1000);
                    events.ScheduleEvent(EVENT_SHADOW_FISSURE, 25000);
                    events.ScheduleEvent(EVENT_FROST_BLAST, 45000);
                    if (Is25ManRaid())
                    {
                        events.ScheduleEvent(EVENT_CHAINS, 90000);
                    }
                    break;
                case EVENT_ENRAGE:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_FROST_BOLT_SINGLE:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_FROST_BOLT_SINGLE_10, SPELL_FROST_BOLT_SINGLE_25), false);
                    events.RepeatEvent(urand(2000, 10000));
                    break;
                case EVENT_FROST_BOLT_MULTI:
                    me->CastSpell(me, RAID_MODE(SPELL_FROST_BOLT_MULTI_10, SPELL_FROST_BOLT_MULTI_25), false);
                    events.RepeatEvent(urand(15000, 30000));
                    break;
                case EVENT_SHADOW_FISSURE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                    {
                        me->CastSpell(target, SPELL_SHADOW_FISURE, false);
                    }
                    events.RepeatEvent(25000);
                    break;
                case EVENT_FROST_BLAST:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, RAID_MODE(1, 0), 0, true))
                    {
                        me->CastSpell(target, SPELL_FROST_BLAST, false);
                    }
                    Talk(SAY_FROST_BLAST);
                    events.RepeatEvent(45000);
                    break;
                case EVENT_CHAINS:
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 200, true, -SPELL_CHAINS_OF_KELTHUZAD))
                        {
                            me->CastSpell(target, SPELL_CHAINS_OF_KELTHUZAD, true);
                        }
                    }
                    Talk(SAY_CHAIN);
                    events.RepeatEvent(90000);
                    break;
                case EVENT_DETONATE_MANA:
                    {
                        std::vector<Unit*> unitList;
                        ThreatContainer::StorageType const& threatList = me->getThreatManager().getThreatList();
                        for (auto itr : threatList)
                        {
                            if (itr->getTarget()->GetTypeId() == TYPEID_PLAYER
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
                        events.RepeatEvent(30000);
                        break;
                    }
                case EVENT_PHASE_3:
                    if (me->HealthBelowPct(45))
                    {
                        Talk(SAY_REQUEST_AID);
                        events.DelayEvents(5500);
                        events.ScheduleEvent(EVENT_P3_LICH_KING_SAY, 5000);
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_1)))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                        }
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_2)))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                        }
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_3)))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                        }
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_KELTHUZAD_PORTAL_4)))
                        {
                            go->SetGoState(GO_STATE_ACTIVE);
                        }
                        break;
                    }
                    events.RepeatEvent(1000);
                    break;
                case EVENT_P3_LICH_KING_SAY:
                    if (pInstance)
                    {
                        if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(DATA_LICH_KING_BOSS)))
                        {
                            cr->AI()->Talk(SAY_ANSWER_REQUEST);
                        }
                    }
                    for (uint8 i = 0 ; i < RAID_MODE(2, 4); ++i)
                    {
                        events.ScheduleEvent(EVENT_SUMMON_GUARDIAN_OF_ICECROWN, 10000 + (i * 5000));
                    }
                    break;
                case EVENT_SUMMON_GUARDIAN_OF_ICECROWN:
                    if (Creature* cr = me->SummonCreature(NPC_GUARDIAN_OF_ICECROWN, SpawnPool[RAND(0, 1, 3, 4)]))
                    {
                        cr->AI()->Talk(EMOTE_GUARDIAN_APPEAR);
                        cr->AI()->AttackStart(me->GetVictim());
                    }
                    break;
            }
            if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
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
                    me->DespawnOrUnsummon(500);
                }
            }
            if (param == ACTION_GUARDIANS_OFF)
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                me->RemoveAllAuras();
                EnterEvadeMode();
                me->SetPosition(me->GetHomePosition());
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER && !who->IsPet())
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustDied(Unit* ) override
        {
            if (me->GetEntry() == NPC_UNSTOPPABLE_ABOMINATION && me->GetInstanceScript())
            {
                me->GetInstanceScript()->SetData(DATA_ABOMINATION_KILLED, 0);
            }
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

        void EnterCombat(Unit*  /*who*/) override
        {
            me->SetInCombatWithZone();
            if (me->GetEntry() == NPC_UNSTOPPABLE_ABOMINATION)
            {
                events.ScheduleEvent(EVENT_MINION_FRENZY, 1000);
                events.ScheduleEvent(EVENT_MINION_MORTAL_WOUND, 5000);
            }
            else if (me->GetEntry() == NPC_GUARDIAN_OF_ICECROWN)
            {
                events.ScheduleEvent(EVENT_MINION_BLOOD_TAP, 15000);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && me->GetInstanceScript())
            {
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
            }
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
                    events.RepeatEvent(15000);
                    break;
                case EVENT_MINION_FRENZY:
                    if (me->HealthBelowPct(35))
                    {
                        me->CastSpell(me, SPELL_FRENZY, true);
                        break;
                    }
                    events.RepeatEvent(1000);
                    break;
                case EVENT_MINION_BLOOD_TAP:
                    me->CastSpell(me->GetVictim(), SPELL_BLOOD_TAP, false);
                    events.RepeatEvent(15000);
                    break;
            }
            DoMeleeAttackIfReady();
        }
    };
};

class spell_kelthuzad_frost_blast : public SpellScriptLoader
{
public:
    spell_kelthuzad_frost_blast() : SpellScriptLoader("spell_kelthuzad_frost_blast") { }

    class spell_kelthuzad_frost_blast_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_kelthuzad_frost_blast_SpellScript);

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
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kelthuzad_frost_blast_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_kelthuzad_frost_blast_SpellScript();
    }
};

class spell_kelthuzad_detonate_mana : public SpellScriptLoader
{
public:
    spell_kelthuzad_detonate_mana() : SpellScriptLoader("spell_kelthuzad_detonate_mana") { }

    class spell_kelthuzad_detonate_mana_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_kelthuzad_detonate_mana_AuraScript);

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
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_kelthuzad_detonate_mana_AuraScript::HandleScript, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_kelthuzad_detonate_mana_AuraScript();
    }
};

void AddSC_boss_kelthuzad()
{
    new boss_kelthuzad();
    new boss_kelthuzad_minion();
    new spell_kelthuzad_frost_blast();
    new spell_kelthuzad_detonate_mana();
}
