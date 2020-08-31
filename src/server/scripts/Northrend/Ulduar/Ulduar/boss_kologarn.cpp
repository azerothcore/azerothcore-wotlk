/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "Vehicle.h"
#include "SpellAuraEffects.h"
#include "PassiveAI.h"
#include "Player.h"

enum KologarnSays
{
    SAY_AGGRO           = 0,
    SAY_SLAY            = 1,
    SAY_LEFT_ARM_GONE   = 2,
    SAY_RIGHT_ARM_GONE  = 3,
    SAY_SHOCKWAVE       = 4,
    SAY_GRAB_PLAYER     = 5,
    SAY_DEATH           = 6,
    SAY_BERSERK         = 7,
    EMOTE_STONE_GRIP    = 8,
    EMOTE_EYES          = 9
};

enum KologarnSpells
{
    SPELL_KOLOGARN_REDUCE_PARRY         = 64651,

    // BASIC
    SPELL_OVERHEAD_SMASH_10             = 63356,
    SPELL_OVERHEAD_SMASH_25             = 64003,
    SPELL_ONEARMED_OVERHEAD_SMASH_10    = 63573,
    SPELL_ONEARMED_OVERHEAD_SMASH_25    = 64006,
    SPELL_PETRIFYING_BREATH_10          = 62030,
    SPELL_PETRIFYING_BREATH_25          = 63980,
    SPELL_STONE_SHOUT_10                = 63716,
    SPELL_STONE_SHOUT_25                = 64005,

    // EYEBEAM
    SPELL_FOCUSED_EYEBEAM_10            = 63347,
    SPELL_FOCUSED_EYEBEAM_25            = 63977,
    SPELL_FOCUSED_EYEBEAM_RIGHT         = 63676, // NPC -> KOLOGARN
    SPELL_FOCUSED_EYEBEAM_LEFT          = 63352, // KOLOGARN -> NPC

    // ARMS
    SPELL_ARM_DEAD_10                   = 63629,
    SPELL_ARM_DEAD_25                   = 63979,
    SPELL_RUBBLE_FALL_10                = 63821,
    SPELL_RUBBLE_FALL_25                = 64001,
    SPELL_ARM_RESPAWN_VISUAL            = 64753,

    // LEFT ARM
    SPELL_ARM_SWEEP_10                  = 63766,
    SPELL_ARM_SWEEP_25                  = 63983,

    // RIGHT ARM
    SPELL_STONE_GRIP_10                 = 62166,
    SPELL_STONE_GRIP_25                 = 63981,
    SPELL_RIDE_RIGHT_ARM_10             = 62056,
    SPELL_RIDE_RIGHT_ARM_25             = 63985,

    // RUBBLE TRASH
    SPELL_RUBBLE_ATTACK_10              = 63818,
    SPELL_RUBBLE_ATTACK_25              = 63978,
};

#define SPELL_PETRIFYING_BREATH         RAID_MODE(SPELL_PETRIFYING_BREATH_10, SPELL_PETRIFYING_BREATH_25)
#define SPELL_OVERHEAD_SMASH            RAID_MODE(SPELL_OVERHEAD_SMASH_10, SPELL_OVERHEAD_SMASH_25)
#define SPELL_ONEARMED_OVERHEAD_SMASH   RAID_MODE(SPELL_ONEARMED_OVERHEAD_SMASH_10, SPELL_ONEARMED_OVERHEAD_SMASH_25)
#define SPELL_ARM_DEAD                  RAID_MODE(SPELL_ARM_DEAD_10, SPELL_ARM_DEAD_25)
#define SPELL_ARM_SWEEP                 RAID_MODE(SPELL_ARM_SWEEP_10, SPELL_ARM_SWEEP_25)
#define SPELL_STONE_GRIP                RAID_MODE(SPELL_STONE_GRIP_10, SPELL_STONE_GRIP_25)
#define SPELL_FOCUSED_EYEBEAM           RAID_MODE(SPELL_FOCUSED_EYEBEAM_10, SPELL_FOCUSED_EYEBEAM_25)
#define SPELL_RUBBLE_FALL               RAID_MODE(SPELL_RUBBLE_FALL_10, SPELL_RUBBLE_FALL_25)
#define SPELL_RUBBLE_ATTACK             RAID_MODE(SPELL_RUBBLE_ATTACK_10, SPELL_RUBBLE_ATTACK_25)
#define SPELL_RIDE_RIGHT_ARM            RAID_MODE(SPELL_RIDE_RIGHT_ARM_10, SPELL_RIDE_RIGHT_ARM_25)
#define SPELL_STONE_SHOUT               RAID_MODE(SPELL_STONE_SHOUT_10, SPELL_STONE_SHOUT_25)

enum KologarnEvents
{
    EVENT_SMASH                         = 1,
    EVENT_GRIP                          = 2,
    EVENT_SWEEP                         = 3,
    EVENT_RESTORE_ARM_LEFT              = 4,
    EVENT_RESTORE_ARM_RIGHT             = 5,
    EVENT_FOCUSED_EYEBEAM               = 6,
    EVENT_STONE_SHOUT                   = 7,
    EVENT_PREPARE_BREATH                = 8, // Kologarn can't cast breath on pull
};

enum KologarnNPCs
{
    NPC_LEFT_ARM                        = 32933,
    NPC_RIGHT_ARM                       = 32934,
    NPC_SWEEP_TRIGGER                   = 33661,
    NPC_EYE_LEFT                        = 33632,
    NPC_EYE_RIGHT                       = 33802,
    NPC_RUBBLE_TRIGGER                  = 33809,
    NPC_RUBBLE_SUMMON                   = 33768,
};

enum KologarnSounds
{
    SOUND_AGGRO                         = 15586,
    SOUND_SLAY1                         = 15587,
    SOUND_SLAY2                         = 15588,
    SOUND_LARM_GONE                     = 15589,
    SOUND_RARM_GONE                     = 15590,
    SOUND_SHOCKWAVE                     = 15591,
    SOUND_GRIP                          = 15592,
    SOUND_DEATH                         = 15593,
    SOUND_BERSERK                       = 15594,
};

enum Misc
{
    ACHIEVEMENT_DISARMED_CRITERIA       = 21687,

    DATA_KOLOGARN_LOOKS_ACHIEV          = 55,
    DATA_KOLOGARN_RUBBLE_ACHIEV         = 56,
    DATA_KOLOGARN_ARMS_ACHIEV           = 57,
};

class boss_kologarn : public CreatureScript
{
public:
    boss_kologarn() : CreatureScript("boss_kologarn") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_kologarnAI (pCreature);
    }

    struct boss_kologarnAI : public ScriptedAI
    {
        boss_kologarnAI(Creature* pCreature) : ScriptedAI(pCreature), vehicle(me->GetVehicleKit()),
            _left(0), _right(0), summons(me), breathReady(false)
        {
            m_pInstance = me->GetInstanceScript();
            assert(vehicle);
            me->SetStandState(UNIT_STAND_STATE_SUBMERGED);
        }

        InstanceScript* m_pInstance;

        Vehicle* vehicle;
        uint64 _left, _right;
        EventMap events;
        SummonList summons;

        bool _looksAchievement, breathReady;
        uint8 _rubbleAchievement;

        void MoveInLineOfSight(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER && me->GetExactDist2d(who) < 45.0f && me->getStandState() == UNIT_STAND_STATE_SUBMERGED)
            {
                me->SetStandState(UNIT_STAND_STATE_STAND);
                if (Unit* arm = ObjectAccessor::GetCreature(*me, _left))
                    arm->CastSpell(arm, SPELL_ARM_RESPAWN_VISUAL, true);
                if (Unit* arm = ObjectAccessor::GetCreature(*me, _right))
                    arm->CastSpell(arm, SPELL_ARM_RESPAWN_VISUAL, true);
            }

            if (me->GetExactDist2d(who) < 30.0f)
                ScriptedAI::MoveInLineOfSight(who);
        }

        void EnterEvadeMode() override
        {
            if (!_EnterEvadeMode())
                return;
            Reset();
            me->setActive(false);
        }

        void AttachLeftArm()
        {
            if (Unit* arm = ObjectAccessor::GetCreature(*me, _left))
                arm->SetHealth(arm->GetMaxHealth());
            else if (Creature* accessory = me->SummonCreature(NPC_LEFT_ARM, *me, TEMPSUMMON_MANUAL_DESPAWN))
            {
                accessory->AddUnitTypeMask(UNIT_MASK_ACCESSORY);
                if (!me->HandleSpellClick(accessory, 0))
                    accessory->DespawnOrUnsummon();
                else
                {
                    _left = accessory->GetGUID();
                    accessory->SetOrientation(M_PI);
                    accessory->CastSpell(accessory, SPELL_ARM_RESPAWN_VISUAL, true);
                }
            }
        }

        void AttachRightArm()
        {
            if (Unit* arm = ObjectAccessor::GetCreature(*me, _right))
                arm->SetHealth(arm->GetMaxHealth());
            else if (Creature* accessory = me->SummonCreature(NPC_RIGHT_ARM, *me, TEMPSUMMON_MANUAL_DESPAWN))
            {
                accessory->AddUnitTypeMask(UNIT_MASK_ACCESSORY);
                if (!me->HandleSpellClick(accessory, 1))
                    accessory->DespawnOrUnsummon();
                else
                {
                    _right = accessory->GetGUID();
                    accessory->SetOrientation(M_PI);
                    accessory->CastSpell(accessory, SPELL_ARM_RESPAWN_VISUAL, true);
                }
            }
        }

        void Reset() override
        {
            _rubbleAchievement = 0;
            _looksAchievement = true;

            me->SetDisableGravity(true);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->DisableRotate(true);

            events.Reset();
            summons.DespawnAll();

            if (m_pInstance)
                m_pInstance->SetData(TYPE_KOLOGARN, NOT_STARTED);

            AttachLeftArm();
            AttachRightArm();

            // Reset breath on pull
            breathReady = false;

            // Open the door inside Kologarn chamber
            if (GameObject* door = me->FindNearestGameObject(GO_KOLOGARN_DOORS, 100.0f))
                door->SetGoState(GO_STATE_ACTIVE);
        }

        void DoAction(int32 param) override
        {
            if (param == DATA_KOLOGARN_LOOKS_ACHIEV)
                _looksAchievement = false;
            if (param == DATA_KOLOGARN_RUBBLE_ACHIEV)
            {
                // Means arm died
                if (m_pInstance && (!_left || !_right))
                    m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_DISARMED_CRITERIA);

                ++_rubbleAchievement;
            }
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_KOLOGARN_LOOKS_ACHIEV)
                return _looksAchievement;
            else if (param == DATA_KOLOGARN_RUBBLE_ACHIEV)
                return (_rubbleAchievement >= 5);
            else if (param == DATA_KOLOGARN_ARMS_ACHIEV)
                return !_rubbleAchievement;

            return 0;
        }

        void AttackStart(Unit* who) override
        {
            me->Attack(who, true);
        }

        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() != NPC_LEFT_ARM && cr->GetEntry() != NPC_RIGHT_ARM)
                summons.Summon(cr);
        }

        void JustDied(Unit*) override
        {
            summons.DespawnAll();
            me->StopMoving();
            if (m_pInstance)
                m_pInstance->SetData(TYPE_KOLOGARN, DONE);

            Talk(SAY_DEATH);

            if (GameObject* bridge = me->FindNearestGameObject(GO_KOLOGARN_BRIDGE, 100))
                bridge->SetGoState(GO_STATE_READY);

            // Summon Chest
            if (GameObject* go = me->SummonGameObject(RAID_MODE(GO_KOLOGARN_CHEST, GO_KOLOGARN_CHEST_HERO), 1839.62f, -35.98f, 448.81f, 3.6f, 0, 0, 0, 0, 7*86400))
            {
                me->RemoveGameObject(go, false);
                go->SetSpellId(1); // hack to make it despawn
                go->SetUInt32Value(GAMEOBJECT_FLAGS, 0);
            }
            if (Creature* arm = ObjectAccessor::GetCreature(*me, _left))
                arm->DespawnOrUnsummon(3000); // visual
            if (Creature* arm = ObjectAccessor::GetCreature(*me, _right))
                arm->DespawnOrUnsummon(3000); // visual
        }

        void KilledUnit(Unit*) override
        {
            if (!urand(0,2))
                return;

            Talk(SAY_SLAY);
        }

        void PassengerBoarded(Unit* who, int8  /*seatId*/, bool apply) override
        {
            if (!me->IsAlive())
                return;

            if (!apply)
            {
                // left arm
                if (who->GetGUID() == _left)
                {
                    _left = 0;
                    if (me->IsInCombat())
                    {
                        Talk(SAY_LEFT_ARM_GONE);
                        events.ScheduleEvent(EVENT_RESTORE_ARM_LEFT, 50000);
                    }
                }
                else
                {
                    _right = 0;
                    if (me->IsInCombat())
                    {
                        Talk(SAY_RIGHT_ARM_GONE);
                        events.ScheduleEvent(EVENT_RESTORE_ARM_RIGHT, 50000);
                    }
                }

                me->CastSpell(me, SPELL_ARM_DEAD, true);
                if (!_right && !_left)
                    events.ScheduleEvent(EVENT_STONE_SHOUT, 5000);
            }
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (who && who->GetEntry() == me->GetEntry() && me->GetHealth())
            {
                damage = std::min(damage, me->GetHealth()-1);
                me->LowerPlayerDamageReq(damage);
            }
        }

        void EnterCombat(Unit*  /*who*/) override
        {
            if (m_pInstance)
                m_pInstance->SetData(TYPE_KOLOGARN, IN_PROGRESS);

            events.ScheduleEvent(EVENT_SMASH, 8000);
            events.ScheduleEvent(EVENT_SWEEP, 17000);
            events.ScheduleEvent(EVENT_GRIP, 15000);
            events.ScheduleEvent(EVENT_FOCUSED_EYEBEAM, 25000);
            events.ScheduleEvent(EVENT_PREPARE_BREATH, 3000);
            //events.ScheduleEvent(EVENT_ENRAGE, x); no info
            
            Talk(SAY_AGGRO);
            me->setActive(true);

            // Close the door inside Kologarn chamber
            if (GameObject* door = me->FindNearestGameObject(GO_KOLOGARN_DOORS, 100.0f))
                door->SetGoState(GO_STATE_READY);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                EnterEvadeMode();
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_PREPARE_BREATH:
                    breathReady = true;
                    break;
                case EVENT_STONE_SHOUT:
                    if (_left || _right)
                    {
                        events.PopEvent();
                        return;
                    }

                    me->CastSpell(me->GetVictim(), SPELL_STONE_SHOUT, false);
                    events.ScheduleEvent(EVENT_STONE_SHOUT, 2000);
                    break;
                case EVENT_SMASH:
                    if (_left && _right)
                        me->CastSpell(me->GetVictim(), SPELL_OVERHEAD_SMASH, false);
                    else if (_left || _right)
                        me->CastSpell(me->GetVictim(), SPELL_ONEARMED_OVERHEAD_SMASH, false);
                    
                    events.DelayEvents(1000);
                    events.ScheduleEvent(EVENT_SMASH, 14000);
                    return;
                case EVENT_SWEEP:
                    if (_left)
                    {
                        if (Creature* cr = me->FindNearestCreature(NPC_SWEEP_TRIGGER, 300))
                            cr->CastSpell(cr, SPELL_ARM_SWEEP, false);

                        if (urand(0,1))
                            Talk(SAY_SHOCKWAVE);
                    }

                    events.DelayEvents(1000);
                    events.ScheduleEvent(EVENT_SWEEP, 17000);
                    return;
                case EVENT_GRIP:
                    events.ScheduleEvent(EVENT_GRIP, 25000);
                    if (!_right)
                        break;

                    me->CastSpell(me, SPELL_STONE_GRIP, false);
                    Talk(SAY_GRAB_PLAYER);
                    Talk(EMOTE_STONE_GRIP);
                    return;
                case EVENT_FOCUSED_EYEBEAM:
                {
                    events.ScheduleEvent(EVENT_FOCUSED_EYEBEAM, 13000+rand()%5000);
                    Unit* target = nullptr;
                    Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                    for(auto itr = pList.begin(); itr != pList.end(); ++itr)
                    {
                        if (itr->GetSource()->GetPositionZ() < 420)
                            continue;

                        target = itr->GetSource();
                        if (urand(0,3) == 3)
                            break;
                    }
                    if (!target)
                        break;

                    if (Creature* eye = me->SummonCreature(NPC_EYE_LEFT, target->GetPositionX(), target->GetPositionY()-6, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 12000))
                    {
                        eye->GetMotionMaster()->MoveFollow(target, 0.01f, M_PI*3/2, MOTION_SLOT_CONTROLLED);
                        me->CastSpell(eye, SPELL_FOCUSED_EYEBEAM_LEFT, true);
                    }
                    if (Creature* eye2 = me->SummonCreature(NPC_EYE_RIGHT, target->GetPositionX(), target->GetPositionY()+6, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 12000))
                    {
                        eye2->GetMotionMaster()->MoveFollow(target, 0.01f, M_PI/2, MOTION_SLOT_CONTROLLED);
                        eye2->CastSpell(me, SPELL_FOCUSED_EYEBEAM_RIGHT, true);
                    }

                    Talk(EMOTE_EYES);
                    events.DelayEvents(12000, 0);
                    return;
                }
                case EVENT_RESTORE_ARM_LEFT:
                    // shouldn't happen
                    events.PopEvent();
                    AttachLeftArm();
                    return;
                case EVENT_RESTORE_ARM_RIGHT:
                    // shouldn't happen
                    events.PopEvent();
                    AttachRightArm();
                    return;
            }

            //Make sure our attack is ready and we aren't currently casting before checking distance
            if (me->isAttackReady() && me->GetVictim()) // victim could die by a spell (IMPORTANT!!!) and kologarn entered evade mode
            {
                //If we are within range melee the target
                if (me->IsWithinMeleeRange(me->GetVictim()))
                {
                    me->AttackerStateUpdate(me->GetVictim());
                    me->resetAttackTimer();
                    return;
                }
                else if (Unit* tgt = me->SelectNearbyTarget())
                {
                    me->AttackerStateUpdate(tgt);
                    me->resetAttackTimer();
                    return;
                }

                if (breathReady)
                    me->CastSpell(me->GetVictim(), SPELL_PETRIFYING_BREATH, false);
                me->resetAttackTimer();
            }
        }
    };
};

// also used for left arm, all functions except JustDied wont be used by left arm
class boss_kologarn_arms : public CreatureScript
{
public:
    boss_kologarn_arms() : CreatureScript("boss_kologarn_arms") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_kologarn_armsAI (pCreature);
    }

    struct boss_kologarn_armsAI : public ScriptedAI
    {
        boss_kologarn_armsAI(Creature* c) : ScriptedAI(c) { }

        int32 _damageDone;
        bool _combatStarted;

        void EnterEvadeMode() {}
        void MoveInLineOfSight(Unit*) {}
        void AttackStart(Unit*) {}
        void UpdateAI(uint32  /*diff*/) {}

        void Reset()
        {
            _combatStarted = false;
            _damageDone = 0;
        }

        void PassengerBoarded(Unit*  /*who*/, int8  /*seatId*/, bool apply)
        {
            if (!apply)
                _damageDone = 0;
            else
            {
                //who->ClearUnitState(UNIT_STATE_ONVEHICLE);
                if (!_damageDone)
                    _damageDone = RAID_MODE(80000, 380000);
            }
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (!_combatStarted)
                if (InstanceScript* instance = me->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, instance->GetData64(TYPE_KOLOGARN)))
                    {
                        _combatStarted = true;
                        if (!cr->IsInCombat() && who)
                            cr->AI()->AttackStart(who);
                    }

            if (_damageDone > 0)
            {
                _damageDone -= damage;
                if (_damageDone <= 0 || damage >= me->GetHealth())
                    me->RemoveAurasByType(SPELL_AURA_CONTROL_VEHICLE);
            }
        }

        void JustDied(Unit*)
        {
            float x, y, z;
            // left arm
            if( me->GetEntry() == NPC_LEFT_ARM )
            {
                x = 1776.97f; y = -44.8396f; z = 448.888f;
            }
            else
            {
                x = 1777.82f; y = -3.50803f; z = 448.888f;
            }

            if (Creature *cr = me->SummonTrigger(x, y, z, 0, 5000))
            {
                cr->CastSpell(cr, SPELL_RUBBLE_FALL, true);

                if (me->GetInstanceScript())
                    if (Creature* kologarn = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_KOLOGARN)))
                        for (uint8 i = 0; i < 5; ++i)
                            if (Creature* cr2 = kologarn->SummonCreature(NPC_RUBBLE_SUMMON, cr->GetPositionX()+irand(-5,5), cr->GetPositionY()+irand(-5,5), cr->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000))
                            {
                                cr2->SetInCombatWithZone();
                                if (Unit *target = SelectTargetFromPlayerList(100))
                                    cr2->AI()->AttackStart(target);
                            }
            }

            if (me->GetInstanceScript())
                if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_KOLOGARN)))
                    cr->AI()->DoAction(DATA_KOLOGARN_RUBBLE_ACHIEV);
            
            me->ExitVehicle();
        }
    };
};

class boss_kologarn_eyebeam : public CreatureScript
{
public:
    boss_kologarn_eyebeam() : CreatureScript("boss_kologarn_eyebeam") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_kologarn_eyebeamAI (pCreature);
    }

    struct boss_kologarn_eyebeamAI : public NullCreatureAI
    {
        boss_kologarn_eyebeamAI(Creature *c) : NullCreatureAI(c), _timer(1), _damaged(false) {}

        uint32 _timer;
        bool _damaged;

        void DamageDealt(Unit* /*victim*/, uint32& damage, DamageEffectType /*damageType*/)
        {
            if (damage > 0 && !_damaged && me->GetInstanceScript())
            {
                _damaged = true;
                if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_KOLOGARN)))
                    cr->AI()->DoAction(DATA_KOLOGARN_LOOKS_ACHIEV);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (_timer)
            {
                _timer += diff;
                if (_timer >= 2000)
                {
                    me->CastSpell(me, (me->GetMap()->Is25ManRaid() ? SPELL_FOCUSED_EYEBEAM_25 : SPELL_FOCUSED_EYEBEAM_10), true);
                    _timer = 0;
                }
            }
        }
    };
};


// predicate function to select non main tank target
class StoneGripTargetSelector : public acore::unary_function<Unit*, bool>
{
    public:
        StoneGripTargetSelector(Creature* me, Unit const* victim) : _me(me), _victim(victim) {}

        bool operator() (WorldObject* target) const
        {
            if (target == _victim && _me->getThreatManager().getThreatList().size() > 1)
                return true;

            if (target->GetTypeId() != TYPEID_PLAYER)
                return true;

            return false;
        }

        Creature* _me;
        Unit const* _victim;
};

class spell_ulduar_stone_grip_cast_target : public SpellScriptLoader
{
    public:
        spell_ulduar_stone_grip_cast_target() : SpellScriptLoader("spell_ulduar_stone_grip_cast_target") { }

        class spell_ulduar_stone_grip_cast_target_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ulduar_stone_grip_cast_target_SpellScript);

            bool Load()
            {
                if (GetCaster()->GetTypeId() != TYPEID_UNIT)
                    return false;
                return true;
            }

            void FilterTargetsInitial(std::list<WorldObject*>& targets)
            {
                // Remove "main tank" and non-player targets
                targets.remove_if (StoneGripTargetSelector(GetCaster()->ToCreature(), GetCaster()->GetVictim()));
                // Maximum affected targets per difficulty mode
                uint32 maxTargets = 1;
                if (GetSpellInfo()->Id == 63981)
                    maxTargets = 3;

                // Return a random amount of targets based on maxTargets
                while (maxTargets < targets.size())
                {
                    std::list<WorldObject*>::iterator itr = targets.begin();
                    advance(itr, urand(0, targets.size()-1));
                    targets.erase(itr);
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_ulduar_stone_grip_cast_target_SpellScript::FilterTargetsInitial, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ulduar_stone_grip_cast_target_SpellScript();
        }
};

class spell_ulduar_stone_grip : public SpellScriptLoader
{
    public:
        spell_ulduar_stone_grip() : SpellScriptLoader("spell_ulduar_stone_grip") { }

        class spell_ulduar_stone_grip_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_ulduar_stone_grip_AuraScript);

            void OnRemoveStun(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (Player* owner = GetOwner()->ToPlayer())
                    owner->RemoveAurasDueToSpell(aurEff->GetAmount());
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_ulduar_stone_grip_AuraScript::OnRemoveStun, EFFECT_2, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_ulduar_stone_grip_AuraScript();
        }
};

class spell_ulduar_squeezed_lifeless : public SpellScriptLoader
{
    public:
        spell_ulduar_squeezed_lifeless() : SpellScriptLoader("spell_ulduar_squeezed_lifeless") { }

        class spell_ulduar_squeezed_lifeless_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_ulduar_squeezed_lifeless_SpellScript);

            void HandleInstaKill(SpellEffIndex  /*effIndex*/)
            {
                if (!GetHitPlayer() || !GetHitPlayer()->GetVehicle())
                    return;

                // Hack to set correct position is in _ExitVehicle()
                GetHitPlayer()->ExitVehicle();
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_ulduar_squeezed_lifeless_SpellScript::HandleInstaKill, EFFECT_1, SPELL_EFFECT_INSTAKILL);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_ulduar_squeezed_lifeless_SpellScript();
        }
};

class spell_kologarn_stone_shout : public SpellScriptLoader
{
    public:
        spell_kologarn_stone_shout() :  SpellScriptLoader("spell_kologarn_stone_shout") { }

        class spell_kologarn_stone_shout_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_kologarn_stone_shout_AuraScript);

            void OnPeriodic(AuraEffect const* /*aurEff*/)
            {
                uint32 triggerSpellId = GetSpellInfo()->Effects[EFFECT_0].TriggerSpell;
                if (Unit* caster = GetCaster())
                    caster->CastSpell(caster, triggerSpellId, false);
            }

            void Register()
            {
                if (m_scriptSpellId == SPELL_STONE_SHOUT_10 || m_scriptSpellId == SPELL_STONE_SHOUT_25)
                    OnEffectPeriodic += AuraEffectPeriodicFn(spell_kologarn_stone_shout_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_kologarn_stone_shout_AuraScript();
        }

        class spell_kologarn_stone_shout_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kologarn_stone_shout_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if (PlayerOrPetCheck());
            }

            void Register()
            {
                if (m_scriptSpellId != SPELL_STONE_SHOUT_10 && m_scriptSpellId != SPELL_STONE_SHOUT_25)
                    OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_kologarn_stone_shout_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kologarn_stone_shout_SpellScript();
        }
};

class achievement_kologarn_looks_could_kill : public AchievementCriteriaScript
{
    public:
        achievement_kologarn_looks_could_kill() : AchievementCriteriaScript("achievement_kologarn_looks_could_kill") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (target)
                if (InstanceScript* instance = target->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(TYPE_KOLOGARN)))
                        return cr->AI()->GetData(DATA_KOLOGARN_LOOKS_ACHIEV);
                        
            return false;
        }
};

class achievement_kologarn_rubble_and_roll : public AchievementCriteriaScript
{
    public:
        achievement_kologarn_rubble_and_roll() : AchievementCriteriaScript("achievement_kologarn_rubble_and_roll") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (target)
                if (InstanceScript* instance = target->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(TYPE_KOLOGARN)))
                        return cr->AI()->GetData(DATA_KOLOGARN_RUBBLE_ACHIEV);
                        
            return false;
        }
};

class achievement_kologarn_with_open_arms : public AchievementCriteriaScript
{
    public:
        achievement_kologarn_with_open_arms() : AchievementCriteriaScript("achievement_kologarn_with_open_arms") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (target)
                if (InstanceScript* instance = target->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(TYPE_KOLOGARN)))
                        return cr->AI()->GetData(DATA_KOLOGARN_ARMS_ACHIEV);
                        
            return false;
        }
};

void AddSC_boss_kologarn()
{
    // Npcs
    new boss_kologarn();
    new boss_kologarn_arms();
    new boss_kologarn_eyebeam();

    // Spells
    new spell_ulduar_stone_grip_cast_target();
    new spell_ulduar_stone_grip();
    new spell_ulduar_squeezed_lifeless();
    new spell_kologarn_stone_shout();

    // Achievements
    new achievement_kologarn_looks_could_kill();
    new achievement_kologarn_rubble_and_roll();
    new achievement_kologarn_with_open_arms();
}
