/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"
#include "SpellScript.h"
#include "Player.h"

enum Yells
{
    SAY_TAUNT                                              = 6,
    SAY_AGGRO                                              = 7,
    SAY_SLAY                                               = 8,
    SAY_DEATH                                              = 9,
    SAY_CHAIN                                              = 10,
    SAY_FROST_BLAST                                        = 11,
    SAY_REQUEST_AID                                        = 12, //start of phase 3
    SAY_ANSWER_REQUEST                                     = 13, //lich king answer
    SAY_SUMMON_MINIONS                                     = 14, //start of phase 1
    SAY_SPECIAL                                            = 15
};

enum Spells
{
    SPELL_FROST_BOLT_SINGLE_10              = 28478,
    SPELL_FROST_BOLT_SINGLE_25              = 55802,
    SPELL_FROST_BOLT_MULTI_10               = 28479,
    SPELL_FROST_BOLT_MULTI_25               = 55807,
    SPELL_SHADOW_FISURE                     = 27810,
    SPELL_VOID_BLAST                        = 27812,
    SPELL_DETONATE_MANA                     = 27819,
    SPELL_MANA_DETONATION_DAMAGE            = 27820,
    SPELL_FROST_BLAST                       = 27808,
    SPELL_CHAINS_OF_KELTHUZAD               = 28410, //28408 script effect
    SPELL_BERSERK                           = 28498,

    // Minions
    SPELL_FRENZY                            = 28468,
    SPELL_MORTAL_WOUND                      = 28467,
    SPELL_BLOOD_TAP                         = 28470,
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
};

enum Event
{
    // Kel'Thuzad
    EVENT_SUMMON_SOLDIER                    = 1,
    EVENT_SUMMON_UNSTOPPABLE_ABOMINATION    = 2,
    EVENT_SUMMON_SOUL_WEAVER                = 3,
    EVENT_START_SECOND_PHASE                = 4,
    EVENT_SPELL_FROST_BOLT_SINGLE           = 5,
    EVENT_SPELL_FROST_BOLT_MULTI            = 6,
    EVENT_SPELL_DETONATE_MANA               = 7,
    EVENT_SECOND_PHASE_HEALTH_CHECK         = 8,
    EVENT_THIRD_PHASE_LICH_KING_SAY         = 9,
    EVENT_SPELL_SHADOW_FISSURE              = 10,
    EVENT_SPELL_FROST_BLAST                 = 11,
    EVENT_SPELL_CHAINS                      = 12,
    EVENT_SUMMON_GUARDIAN_OF_ICECROWN       = 13,
    EVENT_FLOOR_CHANGE                      = 14,

    // Minions
    EVENT_MINION_SPELL_FRENZY               = 100,
    EVENT_MINION_SPELL_MORTAL_WOUND         = 101,
    EVENT_MINION_SPELL_BLOOD_TAP            = 102,
};

const Position SummonPositions[12] =
{
    // Portals
    {3783.272705f, -5062.697266f, 143.711203f, 3.617599f},     //LEFT_FAR
    {3730.291260f, -5027.239258f, 143.956909f, 4.461900f},     //LEFT_MIDDLE
    {3683.868652f, -5057.281250f, 143.183884f, 5.237086f},     //LEFT_NEAR
    {3759.355225f, -5174.128418f, 143.802383f, 2.170104f},     //RIGHT_FAR
    {3700.724365f, -5185.123047f, 143.928024f, 1.309310f},     //RIGHT_MIDDLE
    {3665.121094f, -5138.679199f, 143.183212f, 0.604023f},     //RIGHT_NEAR

    // Edges
    //{3754.431396f, -5080.727734f, 142.036316f, 3.736189f},     //LEFT_FAR
   // {3724.396484f, -5061.330566f, 142.032700f, 4.564785f},     //LEFT_MIDDLE
    //{3687.158424f, -5076.834473f, 142.017319f, 5.237086f},     //LEFT_NEAR
    //{3687.571777f, -5126.831055f, 142.017807f, 0.604023f},     //RIGHT_FAR
    //{3707.990733f, -5151.450195f, 142.032562f, 1.376855f},     //RIGHT_MIDDLE
   // {3739.500000f, -5141.883989f, 142.014113f, 2.121412f}      //RIGHT_NEAR

    // Middle
    {3769.34f, -5071.80f, 143.2082f, 3.658f},
    {3729.78f, -5043.56f, 143.3867f, 4.475f},
    {3682.75f, -5055.26f, 143.1848f, 5.295f},
    {3752.58f, -5161.82f, 143.2944f, 2.126f},
    {3702.83f, -5171.70f, 143.4356f, 1.305f},
    {3665.30f, -5141.55f, 143.1846f, 0.566f}
};

class boss_kelthuzad : public CreatureScript
{
public:
    boss_kelthuzad() : CreatureScript("boss_kelthuzad") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_kelthuzadAI (pCreature);
    }

    struct boss_kelthuzadAI : public BossAI
    {
        boss_kelthuzadAI(Creature* c) : BossAI(c, BOSS_KELTHUZAD), summons(me)
        {
            pInstance = me->GetInstanceScript();
            _justSpawned=true;
        }

        EventMap events;
        SummonList summons;
        InstanceScript* pInstance;
        bool _justSpawned;

        float NormalizeOrientation(float o)
        {
            // Only positive values will be passed
            return fmod(o, 2.0f * static_cast<float>(M_PI));
        }

        void SpawnHelpers()
        {
            // Ehhh...
            // in short: 6 rooms, 8 soldiers, 3 abominations and 1 weaver in each room
            // middle positions in table starts from 6
            for (uint8 i = 6; i < 12; ++i)
                for (uint8 j = 0; j < 8; ++j)
                {
                    float angle = M_PI*2/8*j;
                    me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, SummonPositions[i].GetPositionX()+6*cos(angle), SummonPositions[i].GetPositionY()+6*sin(angle), SummonPositions[i].GetPositionZ()+0.5f, SummonPositions[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
            for (uint8 i = 6; i < 12; ++i)
                for (uint8 j = 1; j < 4; ++j)
                {
                    float dist = j == 2 ? 0.0f : 8.0f; // second in middle
                    float angle = SummonPositions[i].GetOrientation() + M_PI*2/4*j;
                    NormalizeOrientation(angle);
                    me->SummonCreature(NPC_UNSTOPPABLE_ABOMINATION, SummonPositions[i].GetPositionX()+dist*cos(angle), SummonPositions[i].GetPositionY()+dist*sin(angle), SummonPositions[i].GetPositionZ()+0.5f, SummonPositions[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
            for (uint8 i = 6; i < 12; ++i)
                for (uint8 j = 0; j < 1; ++j)
                {
                    float angle = SummonPositions[i].GetOrientation() + M_PI;
                    NormalizeOrientation(angle);
                    me->SummonCreature(NPC_SOUL_WEAVER, SummonPositions[i].GetPositionX()+6*cos(angle), SummonPositions[i].GetPositionY()+6*sin(angle), SummonPositions[i].GetPositionZ()+0.5f, SummonPositions[i].GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000);
                }
        }

        void Reset()
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            me->SetReactState(REACT_AGGRESSIVE);

            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KELTHUZAD_FLOOR)))
            {
                go->SetPhaseMask(1, true);
                go->SetGoState(GO_STATE_READY);
            }

            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KELTHUZAD_GATE)))
            {
                if(!_justSpawned) /* Don't open the door if we just spawned and are still doing the RP */
                    go->SetGoState(GO_STATE_ACTIVE);
            }
            _justSpawned=false;

        }

        void EnterEvadeMode()
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE|UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode();
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (!urand(0,3))
                Talk(SAY_SLAY);

            if (pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void JustDied(Unit*  killer)
        {
            BossAI::JustDied(killer);
            summons.DespawnAll();
            Talk(SAY_DEATH);

            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KELTHUZAD_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (!me->IsInCombat() && who->GetTypeId() == TYPEID_PLAYER && who->IsAlive() && me->GetDistance(who) <= 50.0f)
                AttackStart(who);
        }

        void EnterCombat(Unit * who)
        {
            BossAI::EnterCombat(who);
            Talk(SAY_SUMMON_MINIONS);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
            me->RemoveAllAttackers();
            me->SetTarget(0);
            me->SetReactState(REACT_PASSIVE);

            // Spawn helpers
            SpawnHelpers();

            events.ScheduleEvent(EVENT_SUMMON_SOLDIER, 3200);
            events.ScheduleEvent(EVENT_SUMMON_UNSTOPPABLE_ABOMINATION, 10000);
            events.ScheduleEvent(EVENT_SUMMON_SOUL_WEAVER, 24000);
            events.ScheduleEvent(EVENT_START_SECOND_PHASE, 228000);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KELTHUZAD_FLOOR)))
                {
                    events.ScheduleEvent(EVENT_FLOOR_CHANGE, 15000);
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
            if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KELTHUZAD_GATE)))
                go->SetGoState(GO_STATE_READY);
        }

        void JustSummoned(Creature* cr) { summons.Summon(cr); }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_FLOOR_CHANGE:
                    if (pInstance)
                    {
                        if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_KELTHUZAD_FLOOR)))
                        {
                            events.ScheduleEvent(EVENT_FLOOR_CHANGE, 15000);
                            go->SetGoState(GO_STATE_READY);
                            go->SetPhaseMask(2, true);
                        }
                    }
                    events.PopEvent();
                    break;
                case EVENT_SUMMON_SOLDIER:
                    if (Creature* cr = me->SummonCreature(NPC_SOLDIER_OF_THE_FROZEN_WASTES, SummonPositions[urand(0,5)], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                    {
                        if (Unit* target = SelectTargetFromPlayerList(100.0f))
                        {
                            cr->AI()->DoAction(ACTION_CALL_HELP_OFF);
                            cr->AI()->AttackStart(target);
                        }
                    }

                    events.RepeatEvent(3200);
                    break;
                case EVENT_SUMMON_UNSTOPPABLE_ABOMINATION:
                    if (Creature* cr = me->SummonCreature(NPC_UNSTOPPABLE_ABOMINATION, SummonPositions[urand(0,5)], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                    {
                        if (Unit* target = SelectTargetFromPlayerList(100.0f))
                        {
                            cr->AI()->DoAction(ACTION_CALL_HELP_OFF);
                            cr->AI()->AttackStart(target);
                        }
                    }

                    events.RepeatEvent(30000);
                    break;
                case EVENT_SUMMON_SOUL_WEAVER:
                    if (Creature* cr = me->SummonCreature(NPC_SOUL_WEAVER, SummonPositions[urand(0,5)], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 20000))
                    {
                        if (Unit* target = SelectTargetFromPlayerList(100.0f))
                        {
                            cr->AI()->DoAction(ACTION_CALL_HELP_OFF);
                            cr->AI()->AttackStart(target);
                        }
                    }

                    events.RepeatEvent(30000);
                    break;
                case EVENT_START_SECOND_PHASE:
                    // same as pop
                    Talk(SAY_AGGRO);
                    events.Reset();
                    summons.DoAction(ACTION_SECOND_PHASE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_DISABLE_MOVE);
                    me->GetMotionMaster()->MoveChase(me->GetVictim());
                    me->SetReactState(REACT_AGGRESSIVE);
                    events.ScheduleEvent(EVENT_SPELL_FROST_BOLT_SINGLE, 2000);
                    events.ScheduleEvent(EVENT_SPELL_FROST_BOLT_MULTI, 15000);
                    events.ScheduleEvent(EVENT_SPELL_DETONATE_MANA, 20000);
                    events.ScheduleEvent(EVENT_SECOND_PHASE_HEALTH_CHECK, 1000);
                    events.ScheduleEvent(EVENT_SPELL_SHADOW_FISSURE, 25000);
                    events.ScheduleEvent(EVENT_SPELL_FROST_BLAST, 45000);
                    if (Is25ManRaid())
                        events.ScheduleEvent(EVENT_SPELL_CHAINS, 50000);
                    break;
                case EVENT_SPELL_FROST_BOLT_SINGLE:
                    me->CastSpell(me->GetVictim(), RAID_MODE(SPELL_FROST_BOLT_SINGLE_10, SPELL_FROST_BOLT_SINGLE_25), false);
                    events.RepeatEvent(urand(2000, 15000));
                    break;
                case EVENT_SPELL_FROST_BOLT_MULTI:
                    me->CastSpell(me, RAID_MODE(SPELL_FROST_BOLT_MULTI_10, SPELL_FROST_BOLT_MULTI_25), false);
                    events.RepeatEvent(24000);
                    break;
                case EVENT_SPELL_SHADOW_FISSURE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                        me->CastSpell(target, SPELL_SHADOW_FISURE, false);
                    events.RepeatEvent(25000);
                    break;
                case EVENT_SPELL_FROST_BLAST:
                    if (Unit *target = SelectTarget(SELECT_TARGET_RANDOM, RAID_MODE(1,0), 0, true))
                        me->CastSpell(target, SPELL_FROST_BLAST, false);
                    
                    if (!urand(0,2))
                        Talk(SAY_FROST_BLAST);
                    events.RepeatEvent(45000);
                    break;
                case EVENT_SPELL_CHAINS:
                    for (uint8 i = 0; i < 3; ++i)
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1, 200, true, -SPELL_CHAINS_OF_KELTHUZAD))
                            me->CastSpell(target, SPELL_CHAINS_OF_KELTHUZAD, true);

                    if (!urand(0,2))
                        Talk(SAY_CHAIN);
                    events.RepeatEvent(50000);
                    break;
                case EVENT_SPELL_DETONATE_MANA:
                {
                    std::vector<Unit*> unitList;
                    ThreatContainer::StorageType const& threatList = me->getThreatManager().getThreatList();
                    for (ThreatContainer::StorageType::const_iterator itr = threatList.begin(); itr != threatList.end(); ++itr)
                    {
                        if ((*itr)->getTarget()->GetTypeId() == TYPEID_PLAYER
                            && (*itr)->getTarget()->getPowerType() == POWER_MANA
                            && (*itr)->getTarget()->GetPower(POWER_MANA))
                            unitList.push_back((*itr)->getTarget());
                    }

                    if (!unitList.empty())
                    {
                        std::vector<Unit*>::iterator itr = unitList.begin();
                        advance(itr, urand(0, unitList.size()-1));
                        me->CastSpell(*itr, SPELL_DETONATE_MANA, false);
                        if (!urand(0,2))
                            Talk(SAY_SPECIAL);
                    }

                    events.RepeatEvent(30000);
                    break;
                }
                case EVENT_SECOND_PHASE_HEALTH_CHECK:
                    if (me->HealthBelowPct(45))
                    {
                        events.PopEvent();
                        Talk(SAY_REQUEST_AID);
                        events.DelayEvents(5500);
                        events.ScheduleEvent(EVENT_THIRD_PHASE_LICH_KING_SAY, 5000);
                        break;
                    }
                    events.RepeatEvent(1000);
                    break;
                case EVENT_THIRD_PHASE_LICH_KING_SAY:
                    if (pInstance)
                        if (Creature* cr = ObjectAccessor::GetCreature(*me, pInstance->GetData64(DATA_LICH_KING_BOSS)))
                            cr->AI()->Talk(SAY_ANSWER_REQUEST);

                    for (uint8 i = 0 ; i < RAID_MODE(2,4); ++i)
                        events.ScheduleEvent(EVENT_SUMMON_GUARDIAN_OF_ICECROWN, 10000+(i*5000));
                    events.PopEvent();
                    break;
                case EVENT_SUMMON_GUARDIAN_OF_ICECROWN:
                    me->MonsterTextEmote("A Guardian of Icecrown enter the fight!", 0, true);
                    if (Creature* cr = me->SummonCreature(NPC_GUARDIAN_OF_ICECROWN, SummonPositions[RAND(0, 1, 3, 4)]))
                        cr->AI()->AttackStart(me->GetVictim());

                    events.PopEvent();
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

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_kelthuzad_minionAI (pCreature);
    }

    struct boss_kelthuzad_minionAI : public ScriptedAI
    {
        boss_kelthuzad_minionAI(Creature* c) : ScriptedAI(c)
        {
        }

        EventMap events;
        bool callHelp;

        void Reset()
        {
            me->SetNoCallAssistance(true);
            callHelp = true;
            events.Reset();
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_CALL_HELP_ON)
                callHelp = true;
            else if (param == ACTION_CALL_HELP_OFF)
                callHelp = false;
            else if (param == ACTION_SECOND_PHASE)
            {
                if (!me->IsInCombat())
                    me->DespawnOrUnsummon(500);
            }
        }

        void MoveInLineOfSight(Unit* who)
        {
            if (who->GetTypeId() != TYPEID_PLAYER && !who->IsPet())
                return;

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustDied(Unit* )
        {
            if (me->GetEntry() == NPC_UNSTOPPABLE_ABOMINATION && me->GetInstanceScript())
                me->GetInstanceScript()->SetData(DATA_ABOMINATION_KILLED, 0);
        }

        void AttackStart(Unit* who)
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
                me->AddThreat(who, 1000000.0f);
        }

        void EnterCombat(Unit*  /*who*/)
        {
            me->SetInCombatWithZone();
            if (me->GetEntry() == NPC_UNSTOPPABLE_ABOMINATION)
            {
                events.ScheduleEvent(EVENT_MINION_SPELL_FRENZY, 1000);
                events.ScheduleEvent(EVENT_MINION_SPELL_MORTAL_WOUND, 5000);
            }
            else if (me->GetEntry() == NPC_GUARDIAN_OF_ICECROWN)
                events.ScheduleEvent(EVENT_MINION_SPELL_BLOOD_TAP, 15000);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER && me->GetInstanceScript())
                me->GetInstanceScript()->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_MINION_SPELL_MORTAL_WOUND:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_WOUND, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_MINION_SPELL_FRENZY:
                    if (me->HealthBelowPct(35))
                    {
                        me->CastSpell(me, SPELL_FRENZY, true);
                        events.PopEvent();
                        break;
                    }
                    events.RepeatEvent(1000);
                    break;
                case EVENT_MINION_SPELL_BLOOD_TAP:
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
                for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    if (!(*itr)->ToUnit()->HasAura(SPELL_FROST_BLAST))
                        tmplist.push_back(*itr);

                 targets.clear();
                 for (std::list<WorldObject*>::iterator itr = tmplist.begin(); itr != tmplist.end(); ++itr)
                     targets.push_back(*itr);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kelthuzad_frost_blast_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
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

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_MANA_DETONATION_DAMAGE))
                    return false;
                return true;
            }

            void HandleScript(AuraEffect const* aurEff)
            {
                PreventDefaultAction();

                Unit* target = GetTarget();
                if (int32 mana = int32(target->GetMaxPower(POWER_MANA) / 10))
                {
                    mana = target->ModifyPower(POWER_MANA, -mana);
                    target->CastCustomSpell(SPELL_MANA_DETONATION_DAMAGE, SPELLVALUE_BASE_POINT0, -mana * 10, target, true, NULL, aurEff);
                }
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_kelthuzad_detonate_mana_AuraScript::HandleScript, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
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
