/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "Vehicle.h"
#include "PassiveAI.h"
#include "SpellAuraEffects.h"
#include "Player.h"
#include "Opcodes.h"

enum XT002Spells
{
    // BASIC
    SPELL_GRAVITY_BOMB_10       = 63024,
    SPELL_GRAVITY_BOMB_25       = 64234,
    SPELL_SEARING_LIGHT_10      = 63018,
    SPELL_SEARING_LIGHT_25      = 65121,
    SPELL_TYMPANIC_TANTARUM     = 62776,
    SPELL_XT002_ENRAGE          = 26662,

    // HELPERS
    SPELL_ARCING_SMASH          = 8374,
    SPELL_TRAMPLE               = 5568,
    SPELL_UPPERCUT              = 10966,
    SPELL_BOOM                  = 62834,

    // HEARTBREAK
    SPELL_HEART_OVERLOAD        = 62789,
    SPELL_EXPOSED_HEART         = 63849,
    SPELL_ENERGY_ORB            = 62790,
    SPELL_ENERGY_ORB_TRIGGER    = 62826,
    SPELL_HEARTBREAK_10         = 65737,
    SPELL_HEARTBREAK_25         = 64193,

    // VOID ZONE
    SPELL_VOID_ZONE_SUMMON_10   = 64203,
    SPELL_VOID_ZONE_SUMMON_25   = 64235,
    //SPELL_VOID_ZONE_SUMMON        = RAID_MODE(SPELL_VOID_ZONE_SUMMON_10, SPELL_VOID_ZONE_SUMMON_25, SPELL_VOID_ZONE_SUMMON_10, SPELL_VOID_ZONE_SUMMON_25),
    SPELL_VOID_ZONE_DAMAGE      = 46262,
    
    // SPARK
    SPELL_SPARK_SUMMON          = 64210,
    SPELL_SPARK_DAMAGE_10       = 64227,
    SPELL_SPARK_DAMAGE_25       = 64236,
    SPELL_SPARK_MELEE           = 64230,
};

#define SPELL_GRAVITY_BOMB      RAID_MODE(SPELL_GRAVITY_BOMB_10, SPELL_GRAVITY_BOMB_25)
#define SPELL_SEARING_LIGHT     RAID_MODE(SPELL_SEARING_LIGHT_10, SPELL_SEARING_LIGHT_25)
#define SPELL_HEARTBREAK        RAID_MODE(SPELL_HEARTBREAK_10, SPELL_HEARTBREAK_25)
#define SPELL_SPARK_DAMAGE      RAID_MODE(SPELL_SPARK_DAMAGE_10, SPELL_SPARK_DAMAGE_25)

enum XT002Events
{
    EVENT_HEALTH_CHECK          = 1,
    EVENT_GRAVITY_BOMB          = 2,
    EVENT_SEARING_LIGHT         = 3,
    EVENT_ENRAGE                = 4,
    EVENT_TYMPANIC_TANTARUM     = 5,
    EVENT_RESTORE               = 6,
    EVENT_START_SECOND_PHASE    = 7,
    EVENT_REMOVE_EMOTE          = 8,
    EVENT_CHECK_ROOM            = 9,
};

enum NPCs
{
    NPC_VOID_ZONE               = 34001,
    NPC_LIFE_SPARK              = 34004,
    NPC_XT002_HEART             = 33329,
    NPC_XS013_SCRAPBOT          = 33343,
    NPC_XM024_PUMMELLER         = 33344,
    NPC_XE321_BOOMBOT           = 33346,
    NPC_PILE_TRIGGER            = 33337,
};

enum Sounds
{
    XT_SOUND_AGGRO              = 15724,
    XT_SOUND_HEART_OPEN         = 15725,
    XT_SOUND_HEART_CLOSED       = 15726,
    XT_SOUND_TANTARUM           = 15727,
    XT_SOUND_SLAY1              = 15728,
    XT_SOUND_SLAY2              = 15729,
    XT_SOUND_ENRAGE             = 15730,
    XT_SOUND_DEATH              = 15731,
    XT_SOUND_SUMMON             = 15732,
};

enum Misc
{
    HEART_VEHICLE_SEAT          = 0,


    ACTION_AWAKEN_HEART         = -5,
    ACTION_HIDE_HEART           = -4,
    ACTION_HEART_BROKEN         = -3,

    ACHIEVEMENT_MUST_DECONSTRUCT_FASTER = 21027,

    DATA_XT002_NERF_ENGINEERING = 50,
    DATA_XT002_GRAVITY_ACHIEV   = 51,
};


class boss_xt002 : public CreatureScript
{
public:
    boss_xt002() : CreatureScript("boss_xt002") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new boss_xt002AI (pCreature);
    }

    struct boss_xt002AI : public ScriptedAI
    {
        boss_xt002AI(Creature *pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        uint8 _healthCheck;
        bool _hardMode;
        bool _nerfAchievement;
        bool _gravityAchievement;
        EventMap events;
        SummonList summons;

        void RescheduleEvents()
        {
            events.RescheduleEvent(EVENT_GRAVITY_BOMB, 1000, 1);
            events.RescheduleEvent(EVENT_TYMPANIC_TANTARUM, 60000, 1);
            if (!_hardMode)
                events.RescheduleEvent(EVENT_HEALTH_CHECK, 2000, 1);
        }

        void Reset()
        {
            summons.DespawnAll();
            events.Reset();

            me->ResetLootMode();
            me->RemoveAllAuras();

            // first heart expose
            _healthCheck = 75;
            _hardMode = false;
            _nerfAchievement = true;
            _gravityAchievement = true;

            me->SetByteValue(UNIT_FIELD_BYTES_1, 0, UNIT_STAND_STATE_STAND); // emerge
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->SetControlled(false, UNIT_STATE_STUNNED);

            if (m_pInstance)
            {
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_MUST_DECONSTRUCT_FASTER);
                m_pInstance->SetData(TYPE_XT002, NOT_STARTED);
                if (GameObject *pGo = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(GO_XT002_DOORS)))
                    pGo->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void JustSummoned(Creature* cr) { summons.Summon(cr); }
        void SummonedCreatureDespawn(Creature* cr) { summons.Despawn(cr); }

        void AttachHeart()
        {
            if (Unit* heart = me->GetVehicleKit() ? me->GetVehicleKit()->GetPassenger(HEART_VEHICLE_SEAT) : nullptr)
                heart->SetHealth(heart->GetMaxHealth());
            else if (Creature* accessory = me->SummonCreature(NPC_XT002_HEART, *me, TEMPSUMMON_MANUAL_DESPAWN))
            {
                accessory->AddUnitTypeMask(UNIT_MASK_ACCESSORY);
                if (!me->HandleSpellClick(accessory, 0))
                    accessory->DespawnOrUnsummon();
            }
        }

        void JustReachedHome() { me->setActive(false); }

        void EnterCombat(Unit*)
        {
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            events.ScheduleEvent(EVENT_ENRAGE, 600000, 0, 0);
            events.ScheduleEvent(EVENT_CHECK_ROOM, 5000, 0, 0);
            RescheduleEvents(); // Other events are scheduled here

            me->setActive(true);
            me->MonsterYell("New toys? For me? I promise I won't break them this time!", LANG_UNIVERSAL, 0);
            me->PlayDirectSound(XT_SOUND_AGGRO);

            if (m_pInstance)
            {
                m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_MUST_DECONSTRUCT_FASTER);
                m_pInstance->SetData(TYPE_XT002, IN_PROGRESS);
                if (GameObject *pGo = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(GO_XT002_DOORS)))
                    pGo->SetGoState(GO_STATE_READY);
            }

            me->CallForHelp(175);
            me->SetInCombatWithZone();
            AttachHeart();
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER && !urand(0,2))
            {
                if (urand(0,1))
                {
                    me->MonsterYell("I... I think I broke it.", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(XT_SOUND_SLAY1);
                }
                else
                {
                    me->MonsterYell("I guess it doesn't bend that way.", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(XT_SOUND_SLAY2);
                }
            }
        }

        void JustDied(Unit * /*victim*/)
        {
            me->MonsterYell("You are bad... Toys... Very... Baaaaad!", LANG_UNIVERSAL, 0);
            me->PlayDirectSound(XT_SOUND_DEATH);

            if (m_pInstance)
            {
                m_pInstance->SetData(TYPE_XT002, DONE);
                if (GameObject *pGo = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(GO_XT002_DOORS)))
                    pGo->SetGoState(GO_STATE_ACTIVE);
            }

            // Despawn summons
            summons.DespawnAll();
        }

        void DoAction(int32 param)
        {
            if (param == DATA_XT002_NERF_ENGINEERING)
            {
                _nerfAchievement = false;
                return;
            }
            if (param == DATA_XT002_GRAVITY_ACHIEV)
            {
                _gravityAchievement = false;
                return;
            }
            
            if (!me->IsAlive() || _hardMode)
                return;

            // heart destory
            if (param == ACTION_HEART_BROKEN)
            {
                _hardMode = true;
                me->SetLootMode(3); // hard mode + normal loot
                me->SetMaxHealth(me->GetMaxHealth());
                me->SetHealth(me->GetMaxHealth());
                me->SetByteValue(UNIT_FIELD_BYTES_1, 0, UNIT_STAND_STATE_STAND); // emerge

                me->CastSpell(me, SPELL_HEARTBREAK, true);
                
                me->MonsterTextEmote("XT-002 Deconstructor's heart is severed from his body.", 0, true);
                events.ScheduleEvent(EVENT_REMOVE_EMOTE, 4000);
                return;
            }

            // damage from heart
            if (param > 0)
            {
                // avoid reducing health under 1
                int32 _final = std::min(param, int32(me->GetHealth()-1));

                me->ModifyHealth(-_final);
                me->LowerPlayerDamageReq(_final);
            }
        }

        uint32 GetData(uint32 param) const
        {
            if (param == DATA_XT002_NERF_ENGINEERING)
                return _nerfAchievement;
            else if (param == DATA_XT002_GRAVITY_ACHIEV)
                return _gravityAchievement;

            return 0;
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.GetEvent())
            {
                // Control events
                case EVENT_HEALTH_CHECK:
                    if (_hardMode)
                    {
                        events.PopEvent();
                        return;
                    }

                    if (me->HealthBelowPct(_healthCheck))
                    {
                        _healthCheck -= 25;                 
                        me->SetControlled(true, UNIT_STATE_STUNNED);
                        me->SetByteValue(UNIT_FIELD_BYTES_1, 0, UNIT_STAND_STATE_SUBMERGED); // submerge with animation

                        me->MonsterYell("So tired. I will rest for just a moment!", LANG_UNIVERSAL, 0);
                        me->PlayDirectSound(XT_SOUND_HEART_OPEN);

                        events.CancelEventGroup(1);
                        events.ScheduleEvent(EVENT_START_SECOND_PHASE, 5000);
                        return;
                    }
                    events.RepeatEvent(1000);
                    break;
                case EVENT_CHECK_ROOM:
                    events.RepeatEvent(5000);
                    if (me->GetPositionX() < 722 || me->GetPositionX() > 987 || me->GetPositionY() < -139 || me->GetPositionY() > 124)
                        EnterEvadeMode();

                    return;

                // Abilities events
                case EVENT_GRAVITY_BOMB:
                    me->CastCustomSpell(SPELL_GRAVITY_BOMB, SPELLVALUE_MAX_TARGETS, 1, me, true);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_SEARING_LIGHT, 10000, 1);
                    break;
                case EVENT_SEARING_LIGHT:
                    me->CastCustomSpell(SPELL_SEARING_LIGHT, SPELLVALUE_MAX_TARGETS, 1, me, true);
                    events.PopEvent();
                    events.ScheduleEvent(EVENT_GRAVITY_BOMB, 10000, 1);
                    break;
                case EVENT_TYMPANIC_TANTARUM:
                    me->MonsterTextEmote("XT-002 Deconstructor begins to cause the earth to quake.", 0, true);
                    me->MonsterYell("NO! NO! NO! NO! NO!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(XT_SOUND_TANTARUM);
                    me->CastSpell(me, SPELL_TYMPANIC_TANTARUM, true);
                    events.RepeatEvent(60000);
                    return;
                case EVENT_ENRAGE:
                    me->MonsterYell("I'm tired of these toys. I don't want to play anymore!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(XT_SOUND_SUMMON);
                    me->CastSpell(me, SPELL_XT002_ENRAGE, true);
                    events.PopEvent();
                    break;

                // Animation events
                case EVENT_START_SECOND_PHASE:
                    me->MonsterTextEmote("XT-002 Deconstructor's heart is exposed and leaking energy.", 0, true);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    if (Unit* heart = me->GetVehicleKit() ? me->GetVehicleKit()->GetPassenger(HEART_VEHICLE_SEAT) : nullptr)
                        heart->GetAI()->DoAction(ACTION_AWAKEN_HEART);
                    
                    events.ScheduleEvent(EVENT_RESTORE, 30000);
                    events.PopEvent();
                    return;
                // Restore from heartbreak
                case EVENT_RESTORE:
                    if (_hardMode)
                    {
                        events.PopEvent();
                        return;
                    }

                    me->MonsterYell("I'm ready to play!", LANG_UNIVERSAL, 0);
                    me->PlayDirectSound(XT_SOUND_HEART_CLOSED);
                    
                    me->SetByteValue(UNIT_FIELD_BYTES_1, 0, UNIT_STAND_STATE_STAND); // emerge
                    // Hide heart
                    if (Unit* heart = me->GetVehicleKit() ? me->GetVehicleKit()->GetPassenger(HEART_VEHICLE_SEAT) : nullptr)
                        heart->GetAI()->DoAction(ACTION_HIDE_HEART);

                    events.ScheduleEvent(EVENT_REMOVE_EMOTE, 4000);
                    events.PopEvent();
                    return;
                case EVENT_REMOVE_EMOTE:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                    me->SetControlled(false, UNIT_STATE_STUNNED);

                    RescheduleEvents();
                    events.PopEvent();
                    return;
            }
            
            // Disabled by stunned state
            DoMeleeAttackIfReady();
        }

    };
};

class npc_xt002_heart : public CreatureScript
{
public:
    npc_xt002_heart() : CreatureScript("npc_xt002_heart") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_xt002_heartAI (pCreature);
    }

    struct npc_xt002_heartAI : public PassiveAI
    {
        npc_xt002_heartAI(Creature* pCreature) : PassiveAI(pCreature), summons(me)
        {
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
        }

        SummonList summons;
        uint32 _damageDone;
        uint32 _timerSpawn;
        
        uint8 _spawnSelection;
        uint8 _pummelerCount;

        void MoveInLineOfSight(Unit*) { }
        void AttackStart(Unit*) { }
        void JustSummoned(Creature* cr)
        {
            summons.Summon(cr);
            if (Unit* owner = me->GetVehicleBase())
                if (owner->GetTypeId() == TYPEID_UNIT)
                    owner->ToCreature()->AI()->JustSummoned(cr);
        }
        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            _damageDone += damage;
        }

        void SummonPiles()
        {
            me->SummonCreature(NPC_PILE_TRIGGER, 893.290f, 66.820f, 409.81f, 4.2f);
            me->SummonCreature(NPC_PILE_TRIGGER, 898.099f, -88.9115f, 409.887f, 2.23402f);
            me->SummonCreature(NPC_PILE_TRIGGER, 793.096f, -95.158f,  409.887f, 0.855211f);
            me->SummonCreature(NPC_PILE_TRIGGER, 794.600f, 59.660f, 409.82f, 5.34f);
        }

        void DoAction(int32 param)
        {
            if (param == ACTION_AWAKEN_HEART)
            {
                _pummelerCount = 0;
                _spawnSelection = 0;
                _damageDone = 0;
                _timerSpawn = 0;
                me->SetHealth(me->GetMaxHealth());
                me->CastSpell(me, SPELL_HEART_OVERLOAD, true);
                me->CastSpell(me, SPELL_EXPOSED_HEART, false);    // Channeled
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);

                if (!summons.HasEntry(NPC_PILE_TRIGGER))
                    SummonPiles();
            }
            else if (param == ACTION_HIDE_HEART)
            {
                if (Creature* pXT002 = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_XT002)))
                    if (pXT002->AI())
                    {
                        pXT002->AI()->DoAction(_damageDone);
                        _damageDone = 0;
                    }
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            }
        }

        void SendEnergyToCorner()
        {
            Unit* pile = nullptr;
            uint8 num = urand(1,4);
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                    if (summon->GetEntry() == NPC_PILE_TRIGGER)
                    {
                        pile = summon;
                        if ((--num) == 0)
                            break;
                    }

            if (pile)
                me->CastSpell(pile, SPELL_ENERGY_ORB, true);
        }

        void SpellHitTarget(Unit *target, const SpellInfo *spellInfo)
        {
            // spawn not-so-random robots
            if (spellInfo->Id == SPELL_ENERGY_ORB_TRIGGER && target->GetEntry() == NPC_PILE_TRIGGER)
                switch (_spawnSelection)
                {
                    case 0:
                        for (uint8 i = 0; i < 5; ++i)
                            me->SummonCreature(NPC_XS013_SCRAPBOT, target->GetPositionX()+irand(-3, 3), target->GetPositionY()+irand(-3, 3), target->GetPositionZ()+2, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1000);
                        _spawnSelection++;
                        break;
                    case 1:
                        me->SummonCreature(NPC_XE321_BOOMBOT, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()+2, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
                        _spawnSelection++;
                        break;
                    case 2:
                        for (uint8 i = 0; i < 5; ++i)
                            me->SummonCreature(NPC_XS013_SCRAPBOT, target->GetPositionX()+irand(-3, 3), target->GetPositionY()+irand(-3, 3), target->GetPositionZ()+2, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1000);
                        _spawnSelection++;
                        break;
                    case 3:
                        if(_pummelerCount < 2)
                            me->SummonCreature(NPC_XM024_PUMMELLER, target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()+2, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
                        
                        _pummelerCount++;
                        _spawnSelection++;
                        break;
                    case 4:
                        for (uint8 i = 0; i < 5; ++i)
                            me->SummonCreature(NPC_XS013_SCRAPBOT, target->GetPositionX()+irand(-3, 3), target->GetPositionY()+irand(-3, 3), target->GetPositionZ()+2, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1000);
                        _spawnSelection = 0;
                        break;
                }
        }

        void JustDied(Unit * /*victim*/)
        {
            me->SetVisible(false);
            if (me->GetInstanceScript())
                if (Creature* XT002 = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_XT002)))
                    if (XT002->AI())
                        XT002->AI()->DoAction(ACTION_HEART_BROKEN);
        }

        void UpdateAI(uint32 diff)
        {
            if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE))
            {
                _timerSpawn += diff;
                if (_timerSpawn >= 1900)
                {
                    SendEnergyToCorner();
                    _timerSpawn -= 1900;
                }
            }
        }
    };
};

class npc_xt002_scrapbot : public CreatureScript
{
public:
    npc_xt002_scrapbot() : CreatureScript("npc_xt002_scrapbot") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_xt002_scrapbotAI (pCreature);
    }

    struct npc_xt002_scrapbotAI : public PassiveAI
    {
        npc_xt002_scrapbotAI(Creature* pCreature) : PassiveAI(pCreature) { }

        bool _locked;
        void Reset()
        {
            me->StopMoving();
            _locked = true;
            me->SetWalk(true);

            if (me->GetInstanceScript())
                if (Creature* pXT002 = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_XT002)))
                {
                    if (pXT002->GetPositionZ() > 411.0f) // he is on stairs... idiot cryness protection
                        me->GetMotionMaster()->MovePoint(0, 884.028931f, -14.593809f, 409.786987f);
                    else
                        _locked = false;
                }
        }

        void JustDied(Unit* killer)
        {
            // Nerf Scrapbots achievement
            if (killer->GetEntry() == NPC_XE321_BOOMBOT)
                if (me->GetInstanceScript())
                {
                    me->GetInstanceScript()->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_SPELL_TARGET, 65037);
                    me->GetInstanceScript()->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 65037);
                }
        }

        // tc idiots, they use updateAI, while we have movementinform :)
        void MovementInform(uint32 type, uint32  /*param*/)
        {
            if (type == POINT_MOTION_TYPE)
            {
                _locked = false;
                return;
            }

            // we reached the target :)
            if (type == FOLLOW_MOTION_TYPE && me->GetInstanceScript())
                if (Creature* pXT002 = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_XT002)))
                {
                    if (pXT002->IsAlive())
                    {
                        pXT002->AI()->DoAction(DATA_XT002_NERF_ENGINEERING);
                        pXT002->ModifyHealth(pXT002->GetMaxHealth() * 0.01f);
                    }

                    if (!urand(0,2))
                        me->MonsterTextEmote("XT-002 Deconstructor consumes scrap bot to repair himself.", 0, true);
                    
                    me->DespawnOrUnsummon(1);
                }
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (!_locked)
            {
                if (me->GetInstanceScript())
                    if (Creature* pXT002 = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_XT002)))
                    {
                        me->GetMotionMaster()->MoveFollow(pXT002, 0.0f, 0.0f);
                        _locked = true;
                    }
            }
        }
    };
};

class npc_xt002_pummeller : public CreatureScript
{
public:
    npc_xt002_pummeller() : CreatureScript("npc_xt002_pummeller") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_xt002_pummellerAI (pCreature);
    }

    struct npc_xt002_pummellerAI : public ScriptedAI
    {
        npc_xt002_pummellerAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        int32 _arcingSmashTimer;
        int32 _trampleTimer;
        int32 _uppercutTimer;

        void Reset()
        {
            _arcingSmashTimer = 0;
            _trampleTimer = 0;
            _uppercutTimer = 0;

            if (Unit *target = SelectTargetFromPlayerList(200))
                AttackStart(target);
            else
                me->DespawnOrUnsummon(500);
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            _arcingSmashTimer += diff;
            _trampleTimer += diff;
            _uppercutTimer += diff;

            if (_arcingSmashTimer >= 8000)
            {
                me->CastSpell(me->GetVictim(), SPELL_ARCING_SMASH, false);
                _arcingSmashTimer = 0;
                return;
            }
            if (_trampleTimer >= 11000)
            {
                me->CastSpell(me->GetVictim(), SPELL_TRAMPLE, false);
                _trampleTimer = 0;
                return;
            }
            if (_uppercutTimer >= 14000)
            {
                me->CastSpell(me->GetVictim(), SPELL_UPPERCUT, false);
                _uppercutTimer = 0;
                return;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class BoomEvent : public BasicEvent
{
    public:
        BoomEvent(Creature* me) : _me(me)
        {
        }

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            // This hack is here because we suspect our implementation of spell effect execution on targets
            // is done in the wrong order. We suspect that EFFECT_0 needs to be applied on all targets,
            // then EFFECT_1, etc - instead of applying each effect on target1, then target2, etc.
            // The above situation causes the visual for this spell to be bugged, so we remove the instakill
            // effect and implement a script hack for that.

            _me->CastSpell(_me, SPELL_BOOM, false);
            return true;
        }

    private:
        Creature* _me;
};

class npc_xt002_boombot : public CreatureScript
{
public:
    npc_xt002_boombot() : CreatureScript("npc_xt002_boombot") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_xt002_boombotAI (pCreature);
    }

    struct npc_xt002_boombotAI : public PassiveAI
    {
        npc_xt002_boombotAI(Creature* pCreature) : PassiveAI(pCreature) { }

        bool _locked;
        bool _boomed;
        void Reset()
        {
            me->StopMoving();
            _locked = true;
            _boomed = false;
            me->SetUnitMovementFlags(MOVEMENTFLAG_WALKING);

            if (me->GetInstanceScript())
                if (Creature* pXT002 = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_XT002)))
                {
                    if (pXT002->GetPositionZ() > 411.0f) // he is on stairs... idiot cryness protection
                        me->GetMotionMaster()->MovePoint(0, 884.028931f, -14.593809f, 409.786987f);
                    else
                        _locked = false;
                }
        }

        void Explode()
        {
            if (_boomed)
                return;

             _boomed = true; // Prevent recursive calls

            WorldPacket data(SMSG_SPELLINSTAKILLLOG, 8+8+4);
            data << uint64(me->GetGUID());
            data << uint64(me->GetGUID());
            data << uint32(SPELL_BOOM);
            me->SendMessageToSet(&data, false);

            Unit::Kill(me, me);

            // Visual only seems to work if the instant kill event is delayed or the spell itself is delayed
            // Casting done from player and caster source has the same targetinfo flags,
            // so that can't be the issue
            // See BoomEvent class
            // Schedule 1s delayed
            me->m_Events.AddEvent(new BoomEvent(me), me->m_Events.CalculateTime(1*IN_MILLISECONDS));
        }

        void JustDied(Unit*)
        {
            me->m_Events.AddEvent(new BoomEvent(me), me->m_Events.CalculateTime(1*IN_MILLISECONDS));
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask)
        {
            if (_boomed)
                damage = 0;

            if (me->HealthBelowPctDamaged(50, damage) && !_boomed)
            {
                damage = 0;
                Explode();
            }
        }

        // tc idiots, they use updateAI, while we have movementinform :)
        void MovementInform(uint32 type, uint32  /*param*/)
        {
            if (type == POINT_MOTION_TYPE)
            {
                _locked = false;
                return;
            }
            // we reached the target :)
            //if (type == FOLLOW_MOTION_TYPE)
            //  _kill = true;
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (!_locked)
            {
                if (me->GetInstanceScript())
                    if (Creature* pXT002 = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(TYPE_XT002)))
                    {
                        me->GetMotionMaster()->MoveFollow(pXT002, 0.0f, 0.0f);
                        _locked = true;
                    }
            }
        }
    };
};

class npc_xt002_life_spark : public CreatureScript
{
public:
    npc_xt002_life_spark() : CreatureScript("npc_xt002_life_spark") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_xt002_life_sparkAI (pCreature);
    }

    struct npc_xt002_life_sparkAI : public ScriptedAI
    {
        npc_xt002_life_sparkAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetMaxHealth(RAID_MODE(54000, 172000));
            me->SetHealth(me->GetMaxHealth());
            me->CastSpell(me, SPELL_SPARK_DAMAGE, true);
        }

        uint32 _attackTimer;
        void Reset()
        {
            if (Unit *target = SelectTargetFromPlayerList(200))
                AttackStart(target);
            else
                me->DespawnOrUnsummon();
        }

        void UpdateAI(uint32  /*diff*/)
        {
            if (!UpdateVictim())
                return;

            me->CastSpell(me->GetVictim(), SPELL_SPARK_MELEE, false);
            DoMeleeAttackIfReady();
        }
    };
};

class spell_xt002_tympanic_tantrum : public SpellScriptLoader
{
    public:
        spell_xt002_tympanic_tantrum() : SpellScriptLoader("spell_xt002_tympanic_tantrum") { }

        class spell_xt002_tympanic_tantrum_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_xt002_tympanic_tantrum_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(PlayerOrPetCheck());
            }

            void RecalculateDamage()
            {
                if (GetHitUnit())
                    SetHitDamage(GetHitUnit()->CountPctFromMaxHealth(GetHitDamage()));
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_xt002_tympanic_tantrum_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
                OnHit += SpellHitFn(spell_xt002_tympanic_tantrum_SpellScript::RecalculateDamage);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_xt002_tympanic_tantrum_SpellScript();
        }
};

class spell_xt002_gravity_bomb_aura : public SpellScriptLoader
{
    public:
        spell_xt002_gravity_bomb_aura() : SpellScriptLoader("spell_xt002_gravity_bomb_aura") { }

        class spell_xt002_gravity_bomb_aura_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_xt002_gravity_bomb_aura_AuraScript);

            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (Player* player = GetOwner()->ToPlayer())
                    if (Unit* xt002 = GetCaster())
                        if (xt002->HasAura(aurEff->GetAmount()))   // Heartbreak aura indicating hard mode
                            if (Creature* cr = xt002->SummonCreature(NPC_VOID_ZONE, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 180000))
                            {
                                int32 damage = GetSpellInfo()->Id == 63025 ? 5000 : 7500;
                                cr->CastCustomSpell(cr, SPELL_VOID_ZONE_DAMAGE, &damage, 0, 0, true);
                            }
            }

            void OnPeriodic(AuraEffect const* aurEff)
            {
                Unit* xt002 = GetCaster();
                if (!xt002)
                    return;

                Unit* owner = GetOwner()->ToUnit();
                if (!owner)
                    return;

               if (aurEff->GetAmount() >= int32(owner->GetHealth()))
                    if (xt002->GetAI())
                        xt002->GetAI()->DoAction(DATA_XT002_GRAVITY_ACHIEV);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_xt002_gravity_bomb_aura_AuraScript::OnPeriodic, EFFECT_2, SPELL_AURA_PERIODIC_DAMAGE);
                AfterEffectRemove += AuraEffectRemoveFn(spell_xt002_gravity_bomb_aura_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_xt002_gravity_bomb_aura_AuraScript();
        }

        class spell_xt002_gravity_bomb_aura_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_xt002_gravity_bomb_aura_SpellScript);

            void SelectTarget(std::list<WorldObject*>& targets)
            {
                if (Unit* victim = GetCaster()->GetVictim())
                    targets.remove_if(acore::ObjectGUIDCheck(victim->GetGUID(), true)); 
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_xt002_gravity_bomb_aura_SpellScript::SelectTarget, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_xt002_gravity_bomb_aura_SpellScript();
        }
};

class spell_xt002_gravity_bomb_damage : public SpellScriptLoader
{
    public:
        spell_xt002_gravity_bomb_damage() : SpellScriptLoader("spell_xt002_gravity_bomb_damage") { }

        class spell_xt002_gravity_bomb_damage_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_xt002_gravity_bomb_damage_SpellScript);

            void HandleScript(SpellEffIndex /*eff*/)
            {
                Unit* caster = GetCaster();
                if (!caster)
                    return;

                if (GetHitDamage() >= int32(GetHitUnit()->GetHealth()))
                    if (caster->GetAI())
                        caster->GetAI()->DoAction(DATA_XT002_GRAVITY_ACHIEV);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_xt002_gravity_bomb_damage_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_xt002_gravity_bomb_damage_SpellScript();
        }
};

class spell_xt002_searing_light_spawn_life_spark : public SpellScriptLoader
{
    public:
        spell_xt002_searing_light_spawn_life_spark() : SpellScriptLoader("spell_xt002_searing_light_spawn_life_spark") { }

        class spell_xt002_searing_light_spawn_life_spark_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_xt002_searing_light_spawn_life_spark_AuraScript);

            void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
            {
                if (Player* player = GetOwner()->ToPlayer())
                    if (Unit* xt002 = GetCaster())
                        if (xt002->HasAura(aurEff->GetAmount()))   // Heartbreak aura indicating hard mode
                            xt002->SummonCreature(NPC_LIFE_SPARK, player->GetPositionX(), player->GetPositionY(), player->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 180000);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_xt002_searing_light_spawn_life_spark_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_xt002_searing_light_spawn_life_spark_AuraScript();
        }

        class spell_xt002_searing_light_spawn_life_spark_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_xt002_searing_light_spawn_life_spark_SpellScript);

            void SelectTarget(std::list<WorldObject*>& targets)
            {
                if (Unit* victim = GetCaster()->GetVictim())
                    targets.remove_if(acore::ObjectGUIDCheck(victim->GetGUID(), true)); 
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_xt002_searing_light_spawn_life_spark_SpellScript::SelectTarget, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_xt002_searing_light_spawn_life_spark_SpellScript();
        }
};

class achievement_xt002_nerf_engineering : public AchievementCriteriaScript
{
    public:
        achievement_xt002_nerf_engineering() : AchievementCriteriaScript("achievement_xt002_nerf_engineering") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (target)
                if (InstanceScript* instance = target->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(TYPE_XT002)))
                        return cr->AI()->GetData(DATA_XT002_NERF_ENGINEERING);
                        
            return false;
        }
};

class achievement_xt002_nerf_gravity_bombs : public AchievementCriteriaScript
{
    public:
        achievement_xt002_nerf_gravity_bombs() : AchievementCriteriaScript("achievement_xt002_nerf_gravity_bombs") {}

        bool OnCheck(Player*  /*player*/, Unit* target)
        {
            if (target)
                if (InstanceScript* instance = target->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*target, instance->GetData64(TYPE_XT002)))
                        return cr->AI()->GetData(DATA_XT002_GRAVITY_ACHIEV);
                        
            return false;
        }
};

void AddSC_boss_xt002()
{
    // Npcs
    new boss_xt002();
    new npc_xt002_heart();
    new npc_xt002_scrapbot();
    new npc_xt002_pummeller();
    new npc_xt002_boombot();
    new npc_xt002_life_spark();

    // Spells
    new spell_xt002_tympanic_tantrum();
    new spell_xt002_gravity_bomb_aura();
    new spell_xt002_gravity_bomb_damage();
    new spell_xt002_searing_light_spawn_life_spark();

    // Achievements
    new achievement_xt002_nerf_engineering();
    new achievement_xt002_nerf_gravity_bombs();
}
