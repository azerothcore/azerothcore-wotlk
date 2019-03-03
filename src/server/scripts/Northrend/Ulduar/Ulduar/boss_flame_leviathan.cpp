/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "ulduar.h"
#include "Vehicle.h"
#include "ScriptedEscortAI.h"
#include "SpellAuras.h"
#include "PassiveAI.h"
#include "SpellAuraEffects.h"
#include "ScriptedGossip.h"
#include "CombatAI.h"
#include "Spell.h"
#include "GridNotifiers.h"
#include "Player.h"
#include "Opcodes.h"

enum LeviathanSpells 
{
    // Leviathan basic
    SPELL_PURSUED                   = 62374,
    SPELL_GATHERING_SPEED           = 62375,
    SPELL_BATTERING_RAM             = 62376,
    SPELL_FLAME_VENTS               = 62396,
    SPELL_MISSILE_BARRAGE           = 62400,
    SPELL_NAPALM_10                 = 63666,
    SPELL_NAPALM_25                 = 65026,
    SPELL_INVIS_AND_STEALTH_DETECT  = 18950,

    // Shutdown spells
    SPELL_SYSTEMS_SHUTDOWN          = 62475,
    SPELL_OVERLOAD_CIRCUIT          = 62399,

    // hard mode
    SPELL_TOWER_OF_STORMS           = 65076,
    SPELL_TOWER_OF_FLAMES           = 65075,
    SPELL_TOWER_OF_FROST            = 65077,
    SPELL_TOWER_OF_LIFE             = 64482,

    SPELL_HODIRS_FURY               = 62533,
    SPELL_FREYA_WARD                = 62906, // removed spawn effect
    SPELL_MIMIRONS_INFERNO          = 62909,
    SPELL_THORIMS_HAMMER            = 62911,

    SPELL_FREYA_DUMMY_BLUE          = 63294,
    SPELL_FREYA_DUMMY_GREEN         = 63295,
    SPELL_FREYA_DUMMY_YELLOW        = 63292,

    // Leviathan turret spell
    SPELL_SEARING_FLAME             = 62402,
    // On turret Destory
    SPELL_SMOKE_TRAIL               = 63575,

    // Pool of tar blaze
    SPELL_BLAZE                     = 62292,

    // Pyrite
    SPELL_LIQUID_PYRITE             = 62494,
    SPELL_DUSTY_EXPLOSION           = 63360,
    SPELL_DUST_CLOUD_IMPACT         = 54740,
};

enum GosNpcs
{
    NPC_FLAME_LEVIATHAN_TURRET      = 33139,
    NPC_SEAT                        = 33114,
    NPC_MECHANOLIFT                 = 33214,
    NPC_LIQUID                      = 33189,

    // Starting event
    NPC_ULDUAR_COLOSSUS             = 33237,
    NPC_HIGH_EXPLORER_DELLORAH      = 33701,
    NPC_ARCHMAGE_RHYDIAN            = 33696,
    NPC_START_BRANN_BRONZEBEARD     = 33579,
    NPC_ARCHMAGE_PENTARUS           = 33624,
    NPC_BRANN_RADIO                 = 34054,
    NPC_ULDUAR_GAUNTLET_GENERATOR   = 33571,
    NPC_DEFENDER_GENERATED          = 33572,
    GO_STARTING_BARRIER             = 194484,

    // Hard Mode
    NPC_THORIM_HAMMER_TARGET        = 33364,
    NPC_THORIM_HAMMER               = 33365,
    NPC_FREYA_WARD_TARGET           = 33366,
    NPC_FREYA_WARD                  = 33367,
    NPC_MIMIRONS_INFERNO_TARGET     = 33369,
    NPC_MIMIRONS_INFERNO            = 33370,
    NPC_HODIRS_FURY_TARGET          = 33108,
    NPC_HODIRS_FURY                 = 33212,
};

enum Events
{
    EVENT_PURSUE = 1,
    EVENT_MISSILE,
    EVENT_VENT,
    EVENT_SPEED,
    EVENT_SUMMON,
    EVENT_REINSTALL,
    EVENT_HODIRS_FURY,
    EVENT_FREYA,
    EVENT_MIMIRONS_INFERNO,
    EVENT_THORIMS_HAMMER,
    EVENT_SOUND_BEGINNING,
    EVENT_POSITION_CHECK,
};

enum Texts
{
    FLAME_LEVIATHAN_SAY_AGGRO = 0,
    FLAME_LEVIATHAN_SAY_SLAY,
    FLAME_LEVIATHAN_SAY_DEATH,
    FLAME_LEVIATHAN_SAY_PURSUE,
    FLAME_LEVIATHAN_SAY_HARDMODE,
    FLAME_LEVIATHAN_SAY_TOWER_NONE,
    FLAME_LEVIATHAN_SAY_TOWER_FROST,
    FLAME_LEVIATHAN_SAY_TOWER_FLAME,
    FLAME_LEVIATHAN_SAY_TOWER_NATURE,
    FLAME_LEVIATHAN_SAY_TOWER_STORM,
    FLAME_LEVIATHAN_SAY_PLAYER_RIDING,
    FLAME_LEVIATHAN_SAY_OVERLOAD,
    FLAME_LEVIATHAN_EMOTE_PURSUE,
    FLAME_LEVIATHAN_EMOTE_OVERLOAD,
    FLAME_LEVIATHAN_EMOTE_REPAIR

};

enum Sounds
{
    RSOUND_L0                       = 15807,
    RSOUND_L1                       = 15804,
    RSOUND_L2                       = 15805,
    RSOUND_L3                       = 15806,
    RSOUND_ENGAGE                   = 15794,
    RSOUND_SILOS                    = 15795,
    RSOUND_GENERATORS               = 15796,
    RSOUND_HODIR                    = 15797,
    RSOUND_FREYA                    = 15798,
    RSOUND_MIMIRON                  = 15799,
    RSOUND_THORIM                   = 15801,
    RSOUND_STATION                  = 15803,
};

enum Seats
{
    SEAT_PLAYER                     = 0,
    SEAT_TURRET                     = 1,
    SEAT_DEVICE                     = 2,
    SEAT_CANNON                     = 7,
};

enum Misc
{
    DATA_EVENT_STARTED              = 1,
    DATA_GET_TOWER_COUNT            = 2,
    DATA_GET_SHUTDOWN               = 3,

    TOWER_OF_STORMS                 = 2,
    TOWER_OF_FLAMES                 = 1,
    TOWER_OF_FROST                  = 3,
    TOWER_OF_LIFE                   = 0,

    ACTION_START_NORGANNON_EVENT    = 1,
    ACTION_START_NORGANNON_BRANN    = 2,
    ACTION_START_BRANN_EVENT        = 3,
    ACTION_DESPAWN_ADDS             = 4,
    ACTION_DELAY_CANNON             = 5,
    ACTION_DESTROYED_TURRET         = 6
};

///////////////////////////////////////////
//
// BOSS CODE
//
///////////////////////////////////////////

class boss_flame_leviathan : public CreatureScript
{
public:
    boss_flame_leviathan() : CreatureScript("boss_flame_leviathan") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_flame_leviathanAI (pCreature);
    }

    struct boss_flame_leviathanAI : public ScriptedAI
    {
        boss_flame_leviathanAI(Creature* pCreature) : ScriptedAI(pCreature), vehicle(me->GetVehicleKit()), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
            assert(vehicle);
        }

        InstanceScript* m_pInstance;
        Vehicle* vehicle;
        EventMap events;
        SummonList summons;

        uint32 _startTimer;
        uint32 _speakTimer;
        uint8 _towersCount;
        bool _shutdown;
        uint32 _destroyedTurretCount;

        // Custom
        void BindPlayers();
        void RadioSay(const char* text, uint32 soundId);
        void ActivateTowers();
        void TurnGates(bool _start, bool _death);
        void TurnHealStations(bool _apply);
        void ScheduleEvents();
        void SummonTowerHelpers(uint8 towerId);

        // Original
        void JustReachedHome() override
        {
            // For achievement
            if (m_pInstance)
                m_pInstance->SetData(DATA_UNBROKEN_ACHIEVEMENT, 0);
            me->setActive(false);
        }

        void MoveInLineOfSight(Unit*) override {}
        void JustSummoned(Creature* cr)  override
        {
            if (cr->GetEntry() != NPC_FLAME_LEVIATHAN_TURRET && cr->GetEntry() != NPC_SEAT)
                summons.Summon(cr);
        }

        void SummonedCreatureDespawn(Creature* cr) override { summons.Despawn(cr); }
        void SpellHit(Unit* caster, const SpellInfo* spellInfo) override;
        void JustDied(Unit*) override;
        void KilledUnit(Unit* who) override;
        void SpellHitTarget(Unit* target, SpellInfo const* spell) override;

        void AttackStart(Unit* who) override
        {
            if (Unit* veh = who->GetVehicleBase())
                ScriptedAI::AttackStart(veh);
            else
                ScriptedAI::AttackStart(who);
        }

        void EnterCombat(Unit*) override
        {
            ScheduleEvents();
            Talk(FLAME_LEVIATHAN_SAY_AGGRO);

            me->setActive(true);
            me->SetHomePosition(322.4f, -14.3f, 409.8f, 3.23f);
            TurnGates(true, false);
            TurnHealStations(false);
            ActivateTowers();
            if (m_pInstance)
                m_pInstance->SetData(TYPE_LEVIATHAN, SPECIAL);

            BindPlayers();
            me->SetInCombatWithZone();
        }

        void InitializeAI() override
        {
            if (m_pInstance && m_pInstance->GetData(TYPE_LEVIATHAN) == SPECIAL)
            {
                me->SetHomePosition(322.4f, -14.3f, 409.8f, 3.23f);
                me->UpdatePosition(322.4f, -14.3f, 409.8f, 3.23f);
                me->StopMovingOnCurrentPos();
            }

            ScriptedAI::InitializeAI();
        }

        void Reset() override
        {
            // Special immunity case
            me->CastSpell(me, SPELL_INVIS_AND_STEALTH_DETECT, true);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_USE_NORMAL_MOVEMENT_SPEED, true);

            summons.DoAction(ACTION_DESPAWN_ADDS);
            summons.DespawnAll();
            events.Reset();

            _shutdown = false;
            _startTimer = 1;
            _speakTimer = 0;
            _towersCount = 0;
            _destroyedTurretCount = 0;

            if (m_pInstance)
            {
                if (m_pInstance->GetData(TYPE_LEVIATHAN) != SPECIAL)
                {
                    m_pInstance->SetData(TYPE_LEVIATHAN, NOT_STARTED);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                }
                else
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    m_pInstance->SetData(DATA_VEHICLE_SPAWN, VEHICLE_POS_LEVIATHAN);
                    _startTimer = 0;
                }
            }

            TurnGates(false, false);
            TurnHealStations(true);
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_GET_TOWER_COUNT)
                return _towersCount;
            if (param == DATA_GET_SHUTDOWN)
                return !_shutdown;

            return 0;
        }

        void UpdateAI(uint32 diff) override
        {
            // THIS IS USED ONLY FOR FIRST ENGAGE!
            if (_startTimer)
            {
                _startTimer += diff;
                if (_startTimer >= 4000)
                {
                    // Colossus dead, players in range
                    if (me->FindNearestCreature(NPC_ULDUAR_COLOSSUS, 250.0f, true) || !SelectTargetFromPlayerList(250.0f))
                        _startTimer = 1;
                    else
                    {
                        _startTimer = 0;
                        _speakTimer = 1;
                    }
                }
                return;
            }

            if (_speakTimer)
            {
                _speakTimer += diff;
                if (_speakTimer <= 10000)
                {
                    RadioSay("You've done it! You've broken the defenses of Ulduar. In a few moments, we will be dropping in to...", RSOUND_L1);
                    _speakTimer = 10000;
                }
                else if (_speakTimer > 16000 && _speakTimer < 20000)
                {
                    _speakTimer = 20000;
                    RadioSay("What is that? Be careful! Something's headed your way!", RSOUND_L2);
                }
                else if (_speakTimer > 24000 && _speakTimer < 40000)
                {
                    _speakTimer = 40000;
                    RadioSay("Quicly! Evasive action! Evasive act--", RSOUND_L3);
                }
                else if (_speakTimer > 41000 && _speakTimer < 60000)
                {
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->SendMonsterMove(380.4f, -14.3f, 409.8f, 2000);
                    me->UpdatePosition(380.4f, -14.3f, 409.8f, me->GetOrientation());
                    _speakTimer = 60000;
                }
                else if (_speakTimer > 61500)
                {
                    me->SetInCombatWithZone();
                    if (!me->GetVictim())
                    {
                        me->CastSpell(me, SPELL_PURSUED, false);
                        events.RescheduleEvent(EVENT_PURSUE, 31000);
                    }
                    _speakTimer = 0;
                }
                return;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_POSITION_CHECK:
                    if (me->GetPositionX() > 450 || me->GetPositionX() < 120)
                    {
                        EnterEvadeMode();
                        return;
                    }
                    events.RepeatEvent(5000);
                    break;
                case EVENT_PURSUE:
                    Talk(FLAME_LEVIATHAN_SAY_PURSUE);
                    me->CastSpell(me, SPELL_PURSUED, false);
                    events.RescheduleEvent(EVENT_PURSUE, 31000);
                    return;
                case EVENT_SPEED:
                    me->CastSpell(me, SPELL_GATHERING_SPEED, false);
                    events.RepeatEvent(15000);
                    return;
                case EVENT_MISSILE:
                    me->CastSpell(me, SPELL_MISSILE_BARRAGE, true);
                    events.RepeatEvent(4000);
                    return;
                case EVENT_VENT:
                    me->CastSpell(me, SPELL_FLAME_VENTS, false);
                    events.RepeatEvent(20000);
                    return;
                case EVENT_SUMMON:
                    if(summons.size() < 20)
                        if (Creature* lift = DoSummonFlyer(NPC_MECHANOLIFT, me, 30.0f, 50.0f, 0))
                            lift->GetMotionMaster()->MoveRandom(100);

                    events.RepeatEvent(4000);
                    return;
                case EVENT_SOUND_BEGINNING:
                    if (_towersCount)
                        Talk(FLAME_LEVIATHAN_SAY_HARDMODE);
                    else
                        Talk(FLAME_LEVIATHAN_SAY_TOWER_NONE);
                    events.PopEvent();
                    return;
                case EVENT_REINSTALL:
                    events.PopEvent();
                    for (uint8 i = RAID_MODE(0, 2); i < 4; ++i)
                        if (Unit* seat = vehicle->GetPassenger(i))
                            if (seat->GetTypeId() == TYPEID_UNIT)
                                seat->ToCreature()->AI()->EnterEvadeMode();
                    me->MonsterTextEmote("Flame Leviathan reactivated. Resumming combat functions.", 0, true);
                    return;
                case EVENT_THORIMS_HAMMER:
                    SummonTowerHelpers(TOWER_OF_STORMS);
                    events.RepeatEvent(60000+rand()%60000);
                    me->MonsterTextEmote("Flame Leviathan activates Thorim's Hammer.", 0, true);
                    Talk(FLAME_LEVIATHAN_SAY_TOWER_STORM);
                    return;
                case EVENT_FREYA:
                    SummonTowerHelpers(TOWER_OF_LIFE);
                    events.PopEvent();
                    me->MonsterTextEmote("Flame Leviathan activates Freya's Ward.", 0, true);
                    Talk(FLAME_LEVIATHAN_SAY_TOWER_NATURE);
                    return;
                case EVENT_MIMIRONS_INFERNO:
                    SummonTowerHelpers(TOWER_OF_FLAMES);
                    events.PopEvent();
                    me->MonsterTextEmote("Flame Leviathan activates Mimiron's Inferno.", 0, true);
                    Talk(FLAME_LEVIATHAN_SAY_TOWER_FLAME);
                    return;
                case EVENT_HODIRS_FURY:
                    SummonTowerHelpers(TOWER_OF_FROST);
                    events.PopEvent();
                    me->MonsterTextEmote("Flame Leviathan activates Hodir's Fury.", 0, true);
                    Talk(FLAME_LEVIATHAN_SAY_TOWER_FROST);
                    return;
            }

            if(me->isAttackReady() && !me->HasUnitState(UNIT_STATE_STUNNED))
            {
                if(me->IsWithinCombatRange(me->GetVictim(), 15.0f))
                {
                    me->CastSpell(me->GetVictim(), SPELL_BATTERING_RAM, false);
                    me->resetAttackTimer();
                }
            }
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_DESTROYED_TURRET)
            {
                ++_destroyedTurretCount;

                if (_destroyedTurretCount == RAID_MODE<uint32>(2, 4))
                {
                    _destroyedTurretCount = 0;
                    me->CastSpell(me,SPELL_SYSTEMS_SHUTDOWN,true);
                }
            }
        }
    };
};

void boss_flame_leviathan::boss_flame_leviathanAI::BindPlayers()
{
    me->GetMap()->ToInstanceMap()->PermBindAllPlayers();
}

void boss_flame_leviathan::boss_flame_leviathanAI::RadioSay(const char* text, uint32 soundId)
{
    if (Creature *r = me->SummonCreature(NPC_BRANN_RADIO, me->GetPositionX()-150, me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 5000))
    {
        WorldPacket data;
        ChatHandler::BuildChatPacket(data, CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, r, nullptr, text);
        r->SendMessageToSetInRange(&data, 200, true);
        r->PlayDirectSound(soundId);
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::ActivateTowers()
{
    _towersCount = 0;
    me->ResetLootMode();
    for (uint32 i = EVENT_TOWER_OF_LIFE_DESTROYED; i <= EVENT_TOWER_OF_FLAMES_DESTROYED; ++i)
    {
        if (m_pInstance->GetData(i))
        {
            ++_towersCount;

            me->AddLootMode(1<<_towersCount);
            switch (i)
            {
                case EVENT_TOWER_OF_LIFE_DESTROYED: 
                    me->AddAura(SPELL_TOWER_OF_LIFE, me);
                    events.RescheduleEvent(EVENT_FREYA, 30000);
                    break;
                case EVENT_TOWER_OF_STORM_DESTROYED: 
                    me->AddAura(SPELL_TOWER_OF_STORMS, me);
                    events.RescheduleEvent(EVENT_THORIMS_HAMMER, 60000);
                    break;
                case EVENT_TOWER_OF_FROST_DESTROYED: 
                    me->AddAura(SPELL_TOWER_OF_FROST, me);
                    events.RescheduleEvent(EVENT_HODIRS_FURY, 20000);
                    break;
                case EVENT_TOWER_OF_FLAMES_DESTROYED: 
                    me->AddAura(SPELL_TOWER_OF_FLAMES, me);
                    events.RescheduleEvent(EVENT_MIMIRONS_INFERNO, 42000);
                    break;
            }
        }
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::TurnGates(bool _start, bool _death)
{
    if (!m_pInstance)
        return;

    if (_start)
    {
        // first one is ALWAYS turned on, unless leviathan is beaten
        GameObject* go = nullptr;
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(DATA_LIGHTNING_WALL2))))
            go->SetGoState(GO_STATE_READY);

        if (m_pInstance->GetData(TYPE_LEVIATHAN) == NOT_STARTED)
            if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(GO_LEVIATHAN_DOORS))))
                go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
    }
    else
    {
        GameObject* go = nullptr;
        if (_death)
            if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(DATA_LIGHTNING_WALL1))))
                go->SetGoState(GO_STATE_ACTIVE);

        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(DATA_LIGHTNING_WALL2))))
            go->SetGoState(GO_STATE_ACTIVE);

        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(GO_LEVIATHAN_DOORS))))
        {
            if (m_pInstance->GetData(TYPE_LEVIATHAN) == SPECIAL || m_pInstance->GetData(TYPE_LEVIATHAN) == DONE)
                go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
            else
                go->SetGoState(GO_STATE_READY);
        }
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::TurnHealStations(bool _apply)
{
    if (!m_pInstance)
        return;

    GameObject* go = nullptr;
    if (_apply)
    {
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(DATA_REPAIR_STATION1))))
            go->SetLootState(GO_READY);
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(DATA_REPAIR_STATION2))))
            go->SetLootState(GO_READY);
    }
    else
    {
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(DATA_REPAIR_STATION1))))
            go->SetLootState(GO_ACTIVATED);
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetData64(DATA_REPAIR_STATION2))))
            go->SetLootState(GO_ACTIVATED);
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::ScheduleEvents()
{
    events.RescheduleEvent(EVENT_MISSILE, 5000);
    events.RescheduleEvent(EVENT_VENT, 20000);
    events.RescheduleEvent(EVENT_SPEED, 15000);
    events.RescheduleEvent(EVENT_SUMMON, 10000);
    events.RescheduleEvent(EVENT_SOUND_BEGINNING, 10000);
    events.RescheduleEvent(EVENT_POSITION_CHECK, 5000);

    events.RescheduleEvent(EVENT_PURSUE, 0);
}

void boss_flame_leviathan::boss_flame_leviathanAI::SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo)
{
    if (spellInfo->Id == SPELL_SYSTEMS_SHUTDOWN)
    {
        _shutdown = true; // ACHIEVEMENT

        Talk(FLAME_LEVIATHAN_EMOTE_OVERLOAD);
        Talk(FLAME_LEVIATHAN_EMOTE_REPAIR);
        Talk(FLAME_LEVIATHAN_SAY_OVERLOAD);

        events.DelayEvents(20 * IN_MILLISECONDS + 1);
        events.ScheduleEvent(EVENT_REINSTALL, 20*IN_MILLISECONDS);
    }
    else if (spellInfo->Id == 62522 /*SPELL_ELECTROSHOCK*/)
        me->InterruptNonMeleeSpells(false);
}

void boss_flame_leviathan::boss_flame_leviathanAI::JustDied(Unit*)
{
    // Despawn Lashers, do before summons clear
    summons.DoAction(ACTION_DESPAWN_ADDS);
    summons.DespawnAll();

    if (m_pInstance)
    {
        m_pInstance->SetData(TYPE_LEVIATHAN, DONE);
        m_pInstance->SetData(DATA_VEHICLE_SPAWN, VEHICLE_POS_NONE);
    }

    Talk(FLAME_LEVIATHAN_SAY_DEATH);

    TurnGates(false, true);
    BindPlayers();
}

void boss_flame_leviathan::boss_flame_leviathanAI::KilledUnit(Unit* who)
{
    if (who == me->GetVictim())
        events.RescheduleEvent(EVENT_PURSUE, 0);

    if (who->GetTypeId() == TYPEID_PLAYER)
        Talk(FLAME_LEVIATHAN_SAY_SLAY);
}

void boss_flame_leviathan::boss_flame_leviathanAI::SummonTowerHelpers(uint8 towerId)
{
    if (towerId == TOWER_OF_LIFE)
    {
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 374, -141, 411, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 374, -141, 411+40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 382.9f, 74, 411.6f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 382.9f, 74, 411.6f+40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 159.4f, 64.1f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 159.4f, 64.1f, 409.8f+40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 157.7f, -140.26f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 157.7f, -140.26f, 409.8f+40, 0, TEMPSUMMON_MANUAL_DESPAWN);
    }
    else if (towerId == TOWER_OF_FROST)
    {
        me->SummonCreature(NPC_HODIRS_FURY_TARGET, 343.4f, -77.5f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_HODIRS_FURY_TARGET, 222, 41, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
    }
    else if (towerId == TOWER_OF_FLAMES)
    {
        me->SummonCreature(NPC_MIMIRONS_INFERNO_TARGET, 364.4f, -9.7f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        //me->SummonCreature(NPC_MIMIRONS_INFERNO, 364.4f, -9.7f, 409.8f+40, 0, TEMPSUMMON_MANUAL_DESPAWN);
    }
    else if (towerId == TOWER_OF_STORMS)
    {
        for (uint8 i = 0; i < 8; ++i)
            me->SummonCreature(NPC_THORIM_HAMMER_TARGET, 157+rand()%200, -140+rand()%200, 409.8f, 0, TEMPSUMMON_TIMED_DESPAWN, 24000);
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::SpellHitTarget(Unit* target, SpellInfo const* spell)
{
    if (spell->Id != SPELL_PURSUED)
        return;

    for (SeatMap::const_iterator itr = target->GetVehicleKit()->Seats.begin(); itr != target->GetVehicleKit()->Seats.end(); ++itr)
    {
        if (Player* passenger = ObjectAccessor::GetPlayer(*me, itr->second.Passenger.Guid))
        {
            Talk(FLAME_LEVIATHAN_EMOTE_PURSUE, passenger);
            return;
        }
    }
}

class boss_flame_leviathan_seat : public CreatureScript
{
public:
    boss_flame_leviathan_seat() : CreatureScript("boss_flame_leviathan_seat") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_flame_leviathan_seatAI (pCreature);
    }

    struct boss_flame_leviathan_seatAI : public VehicleAI
    {
        boss_flame_leviathan_seatAI(Creature *creature) : VehicleAI(creature), vehicle(creature->GetVehicleKit())
        {
            ASSERT(vehicle);
            me->SetReactState(REACT_PASSIVE);
        }

        Vehicle* vehicle;
        uint32 _despawnTimer;

        void EnterEvadeMode() override
        {
            vehicle->InstallAllAccessories(false);
        }

        void Reset() override
        {
            _despawnTimer = !me->GetMap()->Is25ManRaid();
        }

        void UpdateAI(uint32 diff) override
        {
            if (_despawnTimer)
            {
                _despawnTimer += diff;
                if (_despawnTimer >= 2000)
                {
                    _despawnTimer = 0;
                    if (Vehicle* veh = me->GetVehicle())
                        if (veh->GetPassenger(0) == me || veh->GetPassenger(1) == me)
                            me->DespawnOrUnsummon(1);
                }
            }

            VehicleAI::UpdateAI(diff);
        }

        void AttackStart(Unit*) override { }

        void PassengerBoarded(Unit* who, int8 seatId, bool apply) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER || !me->GetVehicle())
                return;

            who->ApplySpellImmune(63847, IMMUNITY_ID, 63847, apply); // SPELL_FLAME_VENTS_TRIGGER
            who->ApplySpellImmune(SPELL_MISSILE_BARRAGE, IMMUNITY_ID, SPELL_MISSILE_BARRAGE, apply);
            who->ApplySpellImmune(SPELL_BATTERING_RAM, IMMUNITY_ID, SPELL_BATTERING_RAM, apply);

            if (seatId == SEAT_PLAYER)
            {
                if (Unit* turret = me->GetVehicleKit()->GetPassenger(SEAT_TURRET))
                {
                    if (apply)
                    {
                        turret->SetUInt32Value(UNIT_FIELD_FLAGS, 0);
                        turret->GetAI()->AttackStart(who);
                        if (Creature* leviathan = me->GetVehicleCreatureBase())
                            leviathan->AI()->Talk(FLAME_LEVIATHAN_SAY_PLAYER_RIDING);
                    }
                    else
                    {
                        turret->SetUInt32Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE|UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                        if (turret->GetTypeId() == TYPEID_UNIT)
                            turret->ToCreature()->AI()->EnterEvadeMode();
                    }
                }
            }
        }
    };
};

class boss_flame_leviathan_defense_turret : public CreatureScript
{
    public:
        boss_flame_leviathan_defense_turret() : CreatureScript("boss_flame_leviathan_defense_turret") { }

        struct boss_flame_leviathan_defense_turretAI : public TurretAI
        {
            boss_flame_leviathan_defense_turretAI(Creature* creature) : TurretAI(creature)
            {
                _setHealth = false;
                _instance = creature->GetInstanceScript();
            }

            InstanceScript* _instance;

            bool _setHealth;
            void DamageTaken(Unit* who, uint32 &damage, DamageEffectType, SpellSchoolMask) override
            {
                if (!CanAIAttack(who))
                {
                    _setHealth = true;
                    damage = 0;
                }
            }

            void JustDied(Unit* who) override
            {
                if (Player* killer = who->ToPlayer())
                    killer->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, me);

                if (Vehicle* vehicle = me->GetVehicle())
                    if (Unit* device = vehicle->GetPassenger(SEAT_DEVICE))
                        device->SetUInt32Value(UNIT_FIELD_FLAGS, 0); // unselectable

                if (Creature* leviathan = ObjectAccessor::GetCreature(*me, _instance->GetData64(TYPE_LEVIATHAN)))
                    leviathan->AI()->DoAction(ACTION_DESTROYED_TURRET);
            }

            bool CanAIAttack(Unit const* who) const override
            {
                if (!who || who->GetTypeId() != TYPEID_PLAYER || !who->GetVehicle() || who->GetVehicleBase()->GetEntry() != NPC_SEAT)
                    return false;
                return true;
            }

            void UpdateAI(uint32 diff) override
            {
                if (_setHealth)
                {
                    me->SetHealth(std::min(me->GetHealth()+1, me->GetMaxHealth()));
                    _setHealth = false;
                }

                TurretAI::UpdateAI(diff);
            }

            void KilledUnit(Unit* who) override
            {
                if (Player* plr = who->ToPlayer()) // make sure that there's no death player on the seat.
                    if (plr->GetVehicle())
                        plr->ExitVehicle();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new boss_flame_leviathan_defense_turretAI(creature);
        }
};

class boss_flame_leviathan_overload_device : public CreatureScript
{
    public:
        boss_flame_leviathan_overload_device() : CreatureScript("boss_flame_leviathan_overload_device") { }

        struct boss_flame_leviathan_overload_deviceAI : public NullCreatureAI
        {
            boss_flame_leviathan_overload_deviceAI(Creature* creature) : NullCreatureAI(creature)
            {
            }

            void OnSpellClick(Unit* /*clicker*/, bool& result) override
            {
                if (!result)
                    return;

                if (me->GetVehicle())
                {
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);

                    if (Unit* player = me->GetVehicle()->GetPassenger(SEAT_PLAYER))
                    {
                        me->GetVehicleBase()->CastSpell(player, SPELL_SMOKE_TRAIL, true);
                        player->ExitVehicle();
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new boss_flame_leviathan_overload_deviceAI(creature);
        }
};

class npc_freya_ward : public CreatureScript
{
public:
    npc_freya_ward() : CreatureScript("npc_freya_ward") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_freya_wardAI (pCreature);
    }

    struct npc_freya_wardAI : public NullCreatureAI
    {
        npc_freya_wardAI(Creature *c) : NullCreatureAI(c), summons(c)
        { 
        }

        SummonList summons;
        uint32 _castTimer;
        bool _summoned;

        void Reset() override
        {
            _summoned = false;
            _castTimer = 25000;
            summons.DespawnAll();
            if (Creature* cr = me->FindNearestCreature(NPC_FREYA_WARD_TARGET, 60.0f, true))
                if (Aura* aur = cr->AddAura(SPELL_FREYA_DUMMY_GREEN, cr))
                {
                    aur->SetMaxDuration(-1);
                    aur->SetDuration(-1);
                }
        }

        void JustSummoned(Creature* cr) override
        {
            _summoned = true;
            summons.Summon(cr);
        }

        void SummonedCreatureDespawn(Creature* cr) override { summons.Despawn(cr); }

        void UpdateAI(uint32 diff) override
        {
            if (_summoned)
            {
                for (SummonList::const_iterator itr = summons.begin(); itr != summons.end();)
                {
                    Creature* summon = ObjectAccessor::GetCreature(*me, *itr);
                    ++itr;
                    if (summon)
                    {
                        summon->ToTempSummon()->SetTempSummonType(TEMPSUMMON_MANUAL_DESPAWN);
                        if (Unit* target = summon->SelectNearestTarget(200.0f))
                            summon->AI()->AttackStart(target);
                    }
                }
                _summoned = false;
            }

            _castTimer += diff;
            if (_castTimer >= 29*IN_MILLISECONDS)
            {
                if (Creature* cr = me->FindNearestCreature(NPC_FREYA_WARD_TARGET, 60.0f, true))
                {
                    me->CastSpell(cr, SPELL_FREYA_WARD, false);
                    me->CastSpell(cr, 62947 /*SPELL_FREYA_WARD_SECOND_SUMMON*/, false);
                }

                _castTimer = 0;
            }
        }
        
        void DoAction(int32 param) override
        {
            if (param == ACTION_DESPAWN_ADDS)
                summons.DespawnAll();
        }
    };
};

class npc_hodirs_fury : public CreatureScript
{
public:
    npc_hodirs_fury() : CreatureScript("npc_hodirs_fury") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_hodirs_furyAI (pCreature);
    }

    struct npc_hodirs_furyAI : public NullCreatureAI
    {
        npc_hodirs_furyAI(Creature *c) : NullCreatureAI(c)
        { 
        }

        uint32 _timeToHit;
        uint32 _switchTargetTimer;

        void Reset() override
        {
            _timeToHit = 0;
            _switchTargetTimer = 30000;
            me->SetWalk(true);

            if (Aura* aur = me->AddAura(SPELL_FREYA_DUMMY_BLUE, me))
            {
                aur->SetMaxDuration(-1);
                aur->SetDuration(-1);
            }
        }

        void MovementInform(uint32 type, uint32  /*param*/) override
        {
            if (type == FOLLOW_MOTION_TYPE && !_timeToHit)
            {
                _timeToHit = 1;
                _switchTargetTimer = 0;
                me->SetControlled(true, UNIT_STATE_STUNNED);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_timeToHit)
            {
                _timeToHit += diff;
                if (_timeToHit >= 5000)
                {
                    if (Creature* cr = me->SummonCreature(NPC_HODIRS_FURY, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+40, 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
                        cr->CastSpell(me, SPELL_HODIRS_FURY, true);

                    _switchTargetTimer = 25000; // Switch target soon
                    _timeToHit = 0;
                }
                return;
            }

            _switchTargetTimer += diff;
            if (_switchTargetTimer >= 30000)
            {
                if(Unit* target = me->SelectNearbyTarget(nullptr, 200.0f))
                {
                    if (target->GetVehicleBase() && target->GetVehicleBase()->GetEntry() == NPC_SEAT)
                    {
                        _switchTargetTimer = 20000;
                        return;
                    }
                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    me->GetMotionMaster()->MoveFollow(target, 0.0f, 0.0f);
                    _switchTargetTimer = 0;
                }
                else
                    _switchTargetTimer = 25000;     
            }
        }
    };
};

class npc_mimirons_inferno : public CreatureScript
{
public:
    npc_mimirons_inferno() : CreatureScript("npc_mimirons_inferno") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_mimirons_infernoAI(creature);
    }

    struct npc_mimirons_infernoAI : public npc_escortAI
    {
        npc_mimirons_infernoAI(Creature* creature) : npc_escortAI(creature), summons(me)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        SummonList summons;
        uint32 _spellTimer;
        uint32 _recastTimer;

        void AttackStart(Unit*) override { }
        void MoveInLineOfSight(Unit*) override { }
        void WaypointReached(uint32 /*waypointId*/) override { }

        void DoAction(int32 param) override
        {
            if (param == ACTION_DESPAWN_ADDS)
                summons.DespawnAll();
        }

        void Reset() override
        {
            summons.DespawnAll();
            _spellTimer = 0;
            Start(false, false, 0, nullptr, false, true);
            if (Aura* aur = me->AddAura(SPELL_FREYA_DUMMY_YELLOW, me))
            {
                aur->SetMaxDuration(-1);
                aur->SetDuration(-1);
            }
        }

        void JustSummoned(Creature* cr) override { summons.Summon(cr); }
        void SummonedCreatureDespawn(Creature* cr)  override { summons.Despawn(cr); }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            _spellTimer += diff;
            if (_spellTimer >= 2000)
            {
                if (Creature* cr = me->SummonCreature(NPC_MIMIRONS_INFERNO, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+40.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 30000))
                    cr->CastSpell(me, SPELL_MIMIRONS_INFERNO, true);

                _spellTimer = 0;
            }
        }
    };

};

class npc_thorims_hammer : public CreatureScript
{
public:
    npc_thorims_hammer() : CreatureScript("npc_thorims_hammer") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_thorims_hammerAI (pCreature);
    }

    struct npc_thorims_hammerAI : public NullCreatureAI
    {
        npc_thorims_hammerAI(Creature *c) : NullCreatureAI(c)
        { 
        }

        uint32 _beamTimer;
        uint32 _finishTime;
        uint32 _removeTimer;

        void Reset() override
        {
            _finishTime = 5000+rand()%15000;
            _beamTimer = 1;
            _removeTimer = 0;
            me->CastSpell(me, SPELL_FREYA_DUMMY_BLUE, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (_beamTimer)
            {
                _beamTimer += diff;
                if (_beamTimer >= _finishTime)
                {
                    if (Creature* cr = me->SummonCreature(NPC_THORIM_HAMMER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+40, 0, TEMPSUMMON_TIMED_DESPAWN, 5000))
                        cr->CastSpell(me, SPELL_THORIMS_HAMMER, false);

                    _beamTimer = 0;
                    _removeTimer = 1;
                    me->DespawnOrUnsummon(5*IN_MILLISECONDS);
                }
            }
            if (_removeTimer)
            {
                _removeTimer += diff;
                if (_removeTimer >= 3*IN_MILLISECONDS)
                {
                    _removeTimer = 0;
                    me->RemoveAura(SPELL_FREYA_DUMMY_BLUE);
                }
            }
        }
    };
};

class npc_pool_of_tar : public CreatureScript
{
public:
    npc_pool_of_tar() : CreatureScript("npc_pool_of_tar") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_pool_of_tarAI (pCreature);
    }

    struct npc_pool_of_tarAI : public NullCreatureAI
    {
        npc_pool_of_tarAI(Creature *c) : NullCreatureAI(c)
        {
        }

        void DamageTaken(Unit*, uint32 &damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }

        void SpellHit(Unit*  /*caster*/, const SpellInfo* spellInfo) override
        {
            if (spellInfo->SchoolMask & SPELL_SCHOOL_MASK_FIRE && !me->HasAura(SPELL_BLAZE))
                me->CastSpell(me, SPELL_BLAZE, true);
        }
    };
};

enum ScriptedTextNorgannonDellorah
{
    DELLORAH_SAY_1 = 0,
    DELLORAH_SAY_2 = 1,
    DELLORAH_SAY_3 = 2,
    DELLORAH_SAY_4 = 3,
    DELLORAH_SAY_5 = 4,
    DELLORAH_SAY_6 = 5,
    DELLORAH_SAY_7 = 6,

    NORGANNON_SAY_1 = 0,
    NORGANNON_SAY_2 = 1,
    NORGANNON_SAY_3 = 2,
    NORGANNON_SAY_4 = 3,
    NORGANNON_SAY_5 = 4,

    RHYDIAN_EMOTE = 0,
};

class npc_lore_keeper_of_norgannon_ulduar : public CreatureScript
{
public:
    npc_lore_keeper_of_norgannon_ulduar() : CreatureScript("npc_lore_keeper_of_norgannon_ulduar") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->GetInstanceScript() && creature->GetInstanceScript()->GetData(TYPE_LEVIATHAN) == NOT_STARTED && !creature->AI()->GetData(DATA_EVENT_STARTED))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Activate secondary defensive systems.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);

        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32  /*uiSender*/, uint32 uiAction) override
    {
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF+1:
                creature->MonsterSay("Activating secondary defensive systems will result in the extermination of unauthorized life forms via orbital emplacements. You are an unauthorized life form.", LANG_UNIVERSAL, 0);
                player->PlayerTalkClass->ClearMenus();
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Confirmed.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
                player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF+2:
                creature->MonsterSay("Security override permitted. Secondary defensive systems activated. Backup deactivation for secondary systems can be accessed via individual generators located on the concourse. ", LANG_UNIVERSAL, 0);
                creature->AI()->DoAction(ACTION_START_NORGANNON_EVENT);

                player->CLOSE_GOSSIP_MENU();
        }
        return true;
    }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_lore_keeper_of_norgannon_ulduarAI (pCreature);
    }

    struct npc_lore_keeper_of_norgannon_ulduarAI : public ScriptedAI
    {
        npc_lore_keeper_of_norgannon_ulduarAI(Creature* c) : ScriptedAI(c)
        {
            _eventStarted = false;
        }

        bool _eventStarted;
        bool _running;
        int32 _checkTimer;
        uint8 _step;
        Creature* _dellorah;

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_EVENT_STARTED)
                return _eventStarted;
            return 0;
        }

        void Reset() override
        {
            _running = false;
            _checkTimer = 0;
            _step = 0;
            _dellorah = me->FindNearestCreature(NPC_HIGH_EXPLORER_DELLORAH, 20.0f, true);
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void NextStep(const uint32 time)
        {
            ++_step;
            _checkTimer = time;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_running)
            {
                if (_checkTimer != 0)
                {
                    _checkTimer -= diff;
                    if (_checkTimer < 0 )
                        _checkTimer = 0;
                }
                else
                    switch (_step)
                    {
                        case 0:
                            NextStep(14000);
                            break;
                        case 1:
                            _dellorah->AI()->Talk(DELLORAH_SAY_1);
                            NextStep(10000);
                            break;
                        case 2:
                            Talk(NORGANNON_SAY_1);
                            NextStep(14000);
                            break;
                        case 3:
                            _dellorah->AI()->Talk(DELLORAH_SAY_2);
                            NextStep(11000);
                            break;
                        case 4:
                            Talk(NORGANNON_SAY_2);
                            NextStep(12000);
                            break;
                        case 5:
                            _dellorah->AI()->Talk(DELLORAH_SAY_3);
                            NextStep(8000);
                            break;
                        case 6:
                            Talk(NORGANNON_SAY_3);
                            NextStep(7000);
                            break;
                        case 7:
                            Talk(NORGANNON_SAY_4);
                            NextStep(11000);
                            break;
                        case 8:
                            _dellorah->AI()->Talk(DELLORAH_SAY_4);
                            NextStep(7000);
                            break;
                        case 9:
                            _dellorah->AI()->Talk(DELLORAH_SAY_5);
                            NextStep(7000);
                            break;
                        case 10:
                            if (Creature* c = me->FindNearestCreature(NPC_ARCHMAGE_RHYDIAN, 15.0f))
                            {
                                c->AI()->Talk(RHYDIAN_EMOTE);
                                c->GetMotionMaster()->MovePoint(0, -720.6f, -61.7f, 429.84f);
                            }
                            _dellorah->AI()->Talk(DELLORAH_SAY_6);
                            NextStep(6000);
                            break;
                        case 11:
                            Talk(NORGANNON_SAY_5);
                            NextStep(9000);
                            break;
                        case 12:
                            _dellorah->AI()->Talk(DELLORAH_SAY_7);
                            
                            if (Creature* c = me->FindNearestCreature(NPC_START_BRANN_BRONZEBEARD, 110.0f, true) )
                                c->AI()->DoAction(ACTION_START_NORGANNON_BRANN);

                            _running = false;
                            _checkTimer = 0;
                            _step = 0;
                            return;
                    }
            }
        }

        void DoAction(int32 param) override
        {
            if (_eventStarted)
                return;

            if (param == ACTION_START_NORGANNON_EVENT)
            {
                if (Creature* cr = me->FindNearestCreature(NPC_HIGH_EXPLORER_DELLORAH, 20.0f, true))
                    _dellorah = cr;

                _eventStarted = true;
                _running = true;
                me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            }
        }
    };
};

class npc_brann_ulduar : public CreatureScript
{
public:
    npc_brann_ulduar() : CreatureScript("npc_brann_ulduar") { }

    bool OnGossipHello(Player*  /*player*/, Creature* creature) override
    {
        if (creature->GetInstanceScript() && creature->GetInstanceScript()->GetData(TYPE_LEVIATHAN) == NOT_STARTED && !creature->AI()->GetData(DATA_EVENT_STARTED))
            creature->AI()->DoAction(ACTION_START_BRANN_EVENT);
        return true;
    }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_brann_ulduarAI (pCreature);
    }

    struct npc_brann_ulduarAI : public ScriptedAI
    {
        npc_brann_ulduarAI(Creature* c) : ScriptedAI(c)
        {
            _eventStarted = false;
            Reset();
        }

        bool _eventStarted;
        bool _running;
        int32 _checkTimer;
        uint8 _step;
        uint64 _pentarusGUID;

        void Reset() override
        {
            _running = false;
            _checkTimer = 0;
            _step = 0;
            _pentarusGUID = 0;
            me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }

        void NextStep(const uint32 time)
        {
            _step++;
            _checkTimer = time;
        }

        void Say(std::string text, bool self)
        {
            WorldPacket data;
            
            if (self)
                ChatHandler::BuildChatPacket(data, CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, me, nullptr, text);
            else if (Creature* c = ObjectAccessor::GetCreature(*me, _pentarusGUID))
                ChatHandler::BuildChatPacket(data, CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, c, nullptr, text);

            me->SendMessageToSetInRange(&data, 100.0f, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (_running)
            {
                if (_checkTimer != 0)
                {
                    _checkTimer -= diff;
                    if (_checkTimer < 0 )
                        _checkTimer = 0;
                }
                else
                    switch (_step)
                    {
                        case 0:
                            Say("Pentarus, you heard the man. Have your mages release the shield and let these brave souls through!", true);
                            NextStep(8000);
                            break;
                        case 1:
                            Say("Of course, Brann: We will have the shield down momentarily.", false);
                            NextStep(7000);
                            break;
                        case 2:
                            if (Creature* cr = me->SummonCreature(NPC_BRANN_RADIO, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 5000))
                            {
                                cr->PlayDirectSound(RSOUND_L0);
                                cr->MonsterSay("Okay! Let's move out. Get into your machines; I'll speak to you from here via the radio.", LANG_UNIVERSAL, 0);
                            }
                            NextStep(8000);
                            break;
                        case 3:
                            if (GameObject* go = me->FindNearestGameObject(GO_STARTING_BARRIER, 200.0f))
                                go->Delete();

                            Say("Mages of the Kirin Tor, on Brann's Command, release the shield! Defend this platform and our allies with your lives! For Dalaran!", false);
                            NextStep(9000);
                            break;
                        case 4:
                            Say("Our allies are ready. Bring down the shield and make way!", true);
                            _running = false;
                            me->MonsterTextEmote("Go to your vehicles!", 0, true);
                            if (me->GetInstanceScript())
                                me->GetInstanceScript()->SetData(DATA_VEHICLE_SPAWN, VEHICLE_POS_START);
                            return;
                    }
            }
        }

        void DoAction(int32 param) override
        {
            if (_eventStarted)
                return;

            if (me->GetInstanceScript())
            {
                // deactivate towers, easy mode
                if (param != ACTION_START_NORGANNON_BRANN)
                {
                    me->GetInstanceScript()->ProcessEvent(nullptr, EVENT_TOWER_OF_STORM_DESTROYED);
                    me->GetInstanceScript()->ProcessEvent(nullptr, EVENT_TOWER_OF_FROST_DESTROYED);
                    me->GetInstanceScript()->ProcessEvent(nullptr, EVENT_TOWER_OF_FLAMES_DESTROYED);
                    me->GetInstanceScript()->ProcessEvent(nullptr, EVENT_TOWER_OF_LIFE_DESTROYED);
                }
            }

            if (Creature* cr = me->FindNearestCreature(NPC_ARCHMAGE_PENTARUS, 50.0f, true))
                _pentarusGUID = cr->GetGUID();

            _eventStarted = true;
            _running = true;
            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        }
    };
};

class npc_brann_radio : public CreatureScript
{
public:
    npc_brann_radio() : CreatureScript("npc_brann_radio") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_brann_radioAI (pCreature);
    }

    struct npc_brann_radioAI : public NullCreatureAI
    {
        npc_brann_radioAI(Creature* c) : NullCreatureAI(c)
        {
            _lock = (me->GetInstanceScript() && me->GetInstanceScript()->GetData(TYPE_LEVIATHAN) > NOT_STARTED); 
            _helpLock = _lock;
        } 

        bool _lock;
        bool _helpLock;

        void Reset() override
        {
            me->SetReactState(REACT_AGGRESSIVE);
        }

        void Say(const char* text)
        {
            WorldPacket data;
            ChatHandler::BuildChatPacket(data, CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, me, nullptr, text);
            me->SendMessageToSetInRange(&data, 100.0f, true);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!_lock)
            {
                if (who->GetTypeId() != TYPEID_PLAYER && !who->IsVehicle())
                    return;
            
                // ENGAGE
                if (!_helpLock && me->GetDistance2d(-508.898f, -32.9631f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 60.0f)
                    {
                        Say("The iron dwarves have been seen emerging from the bunkers at the base of the pillars straight ahead of you. Destroy the bunkers and they will be forced to fall back.");
                        me->PlayDirectSound(RSOUND_ENGAGE);
                        _helpLock = true;
                    }
                }
                // MIMIRON
                else if (me->GetDistance2d(-81.9207f, 111.432f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 60.0f && who->GetPositionZ() > 430.0f)
                    {
                        Say("This generator powers Mimiron's Gaze. In moments, it can turn earth to ash, stone to magma--we cannot let it reach full power!");
                        me->PlayDirectSound(RSOUND_MIMIRON);
                        _lock = true;
                    }
                }
                // FREYA
                else if (me->GetDistance2d(-221.475f, -271.087f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 60.0f && who->GetPositionZ() < 380.0f)
                    {
                        Say("You're approaching the tower of Freya. It contains the power to turn barren wastelands into jungles teeming with life overnight");
                        me->PlayDirectSound(RSOUND_FREYA);
                        _lock = true;
                    }
                }
                // STATIONS
                else if (me->GetDistance2d(73.8978f, -29.3306f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 40.0f)
                    {
                        Say("It appears you are near a repair station. Drive your vehicle on to the platform and it should be automatically repaired.");
                        me->PlayDirectSound(RSOUND_STATION);
                        _lock = true;
                    }
                }
                // HODIR
                else if (me->GetDistance2d(68.7679f, -325.026f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 40.0f)
                    {
                        Say("This tower powers the hammer of Hodir. It is said to have the power to turn entire armies to ice!");
                        me->PlayDirectSound(RSOUND_HODIR);
                        _lock = true;
                    }
                }
                // THORIM
                else if (me->GetDistance2d(174.442f, 345.679f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 60.0f)
                    {
                        Say("Aaaah, the tower of Krolmir. It is said that the power of Thorim has been used only once. And that it turned an entire continent to dust...");
                        me->PlayDirectSound(RSOUND_THORIM);
                        _lock = true;
                    }
                }
                // COME A BIT CLOSER
                else if (me->GetDistance2d(-508.898f, -32.9631f) < 5.0f)
                {
                    if (who->GetPositionX() >= -480.0f)
                    {
                        Say("There are four generators powering the defense structures. If you sabotage the generators, the missile attacks will stop!");
                        me->PlayDirectSound(RSOUND_GENERATORS);
                        _lock = true;
                    }
                }
            }
        }
    };
};

class npc_storm_beacon_spawn : public CreatureScript
{
public:
    npc_storm_beacon_spawn() : CreatureScript("npc_storm_beacon_spawn") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_storm_beacon_spawnAI (pCreature);
    }

    struct npc_storm_beacon_spawnAI : public NullCreatureAI
    {
        npc_storm_beacon_spawnAI(Creature* c) : NullCreatureAI(c) 
        {
            _amount = 0;
            _checkTimer = 0;
        }

        uint8 _amount;
        uint32 _checkTimer;

        void UpdateAI(uint32 diff) override
        {
            if (_amount < 40)
            {
                _checkTimer += diff;
                if (_checkTimer >= 4000)
                {
                    _checkTimer = 0;
                    if (Unit* target = me->SelectNearbyTarget(nullptr, 80.0f))
                    {
                        ++_amount;
                        if (Creature* cr = me->SummonCreature(NPC_DEFENDER_GENERATED, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()+4, me->GetOrientation(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 900000))
                            cr->AI()->AttackStart(target);
                    }
                }
            }
        }
    };
};

class boss_flame_leviathan_safety_container : public CreatureScript
{
public:
    boss_flame_leviathan_safety_container() : CreatureScript("boss_flame_leviathan_safety_container") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_flame_leviathan_safety_containerAI (pCreature);
    }

    struct boss_flame_leviathan_safety_containerAI : public NullCreatureAI
    {
        boss_flame_leviathan_safety_containerAI(Creature *c) : NullCreatureAI(c) 
        {
            _allowTimer = 0;
        }

        uint32 _allowTimer;

        void MovementInform(uint32  /*type*/, uint32 id) override
        {
            if (id == me->GetEntry())
            {
                if (Creature* liquid = me->SummonCreature(NPC_LIQUID, *me))
                {
                    liquid->CastSpell(liquid, SPELL_LIQUID_PYRITE, true);
                    liquid->CastSpell(liquid, SPELL_DUST_CLOUD_IMPACT, true);
                }
                
                me->DespawnOrUnsummon(1);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _allowTimer += diff;
            if (_allowTimer >= 5000 && !me->GetVehicle() && me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
            {
                float x, y, z;
                me->GetPosition(x, y, z);
                z = me->GetMap()->GetHeight(me->GetPhaseMask(), x, y, z);
                me->GetMotionMaster()->MovePoint(me->GetEntry(), x, y, z);
                me->SetPosition(x, y, z, 0);
            }
        }
    };
};

class npc_mechanolift : public CreatureScript
{
public:
    npc_mechanolift() : CreatureScript("npc_mechanolift") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new npc_mechanoliftAI (pCreature);
    }

    struct npc_mechanoliftAI : public NullCreatureAI
    {
        npc_mechanoliftAI(Creature *c) : NullCreatureAI(c) 
        { 
            me->SetSpeed(MOVE_RUN, rand_norm()+0.5f);
        }

        int32 _startTimer;
        uint32 _evadeTimer;

        void Reset() override
        {
            _startTimer = urand(1,5000);
            _evadeTimer = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_startTimer)
            {
                _startTimer -= diff;
                if (_startTimer <= 0)
                {
                    me->GetMotionMaster()->MovePath(3000000+urand(0,11), true);
                    _startTimer = 0;
                }
            }

            _evadeTimer += diff;
            if (_evadeTimer >= 10000)
            {
                _EnterEvadeMode();
                _evadeTimer = 0;
            }
        }
    };
};

class go_ulduar_tower : public GameObjectScript
{
    public:
        go_ulduar_tower() : GameObjectScript("go_ulduar_tower") { }

        void OnDestroyed(GameObject* go, Player* /*player*/) override
        {
            Creature* trigger = go->FindNearestCreature(NPC_ULDUAR_GAUNTLET_GENERATOR, 15.0f, true);
            if (trigger)
                trigger->DisappearAndDie();
        }
};

class spell_load_into_catapult : public SpellScriptLoader
{
    enum Spells
    {
        SPELL_PASSENGER_LOADED = 62340,
    };

    public:
        spell_load_into_catapult() : SpellScriptLoader("spell_load_into_catapult") { }

        class spell_load_into_catapult_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_load_into_catapult_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* owner = GetOwner()->ToUnit();
                if (!owner)
                    return;

                owner->CastSpell(owner, SPELL_PASSENGER_LOADED, true);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* owner = GetOwner()->ToUnit();
                if (!owner)
                    return;

                owner->RemoveAurasDueToSpell(SPELL_PASSENGER_LOADED);
            }

            void Register() override
            {
                OnEffectApply += AuraEffectApplyFn(spell_load_into_catapult_AuraScript::OnApply, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_load_into_catapult_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_load_into_catapult_AuraScript();
        }
};

class spell_auto_repair : public SpellScriptLoader
{
    enum Spells
    {
        SPELL_AUTO_REPAIR = 62705,
    };

    public:
        spell_auto_repair() : SpellScriptLoader("spell_auto_repair") {}

        class spell_auto_repair_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_auto_repair_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                std::list<WorldObject*> tmplist;
                for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
                    if (!(*itr)->ToUnit()->HasAura(SPELL_AUTO_REPAIR))
                        tmplist.push_back(*itr);

                 targets.clear();
                 for (std::list<WorldObject*>::iterator itr = tmplist.begin(); itr != tmplist.end(); ++itr)
                     targets.push_back(*itr);
            }

            void HandleScript(SpellEffIndex /*eff*/)
            {
                Vehicle* vehicle = GetHitUnit()->GetVehicleKit();
                if (!vehicle)
                    return;

                Player* driver = vehicle->GetPassenger(0) ? vehicle->GetPassenger(0)->ToPlayer() : nullptr;
                if (!driver)
                    return;

                driver->MonsterTextEmote("Automatic repair sequence initiated.", driver, true);

                // Actually should/could use basepoints (100) for this spell effect as percentage of health, but oh well.
                vehicle->GetBase()->SetFullHealth();

                // Achievement
                if (InstanceScript* instance = vehicle->GetBase()->GetInstanceScript())
                    instance->SetData(DATA_UNBROKEN_ACHIEVEMENT, 0);
            }

            void Register() override
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_auto_repair_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENTRY);
                OnEffectHitTarget += SpellEffectFn(spell_auto_repair_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_auto_repair_SpellScript();
        }
};

class spell_systems_shutdown : public SpellScriptLoader
{
    public:
        spell_systems_shutdown() : SpellScriptLoader("spell_systems_shutdown") { }

        class spell_systems_shutdown_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_systems_shutdown_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Creature* owner = GetOwner()->ToCreature();
                if (!owner)
                    return;

                owner->SetControlled(true, UNIT_STATE_STUNNED);
                owner->RemoveAurasDueToSpell(SPELL_GATHERING_SPEED);
                if (Vehicle* veh = owner->GetVehicleKit())
                     if (Unit* cannon = veh->GetPassenger(SEAT_CANNON))
                         cannon->GetAI()->DoAction(ACTION_DELAY_CANNON);
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Creature* owner = GetOwner()->ToCreature();
                if (!owner)
                    return;

                owner->SetControlled(false, UNIT_STATE_STUNNED);
            }

            void Register() override
            {
                OnEffectApply += AuraEffectApplyFn(spell_systems_shutdown_AuraScript::OnApply, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_systems_shutdown_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_systems_shutdown_AuraScript();
        }
};

class FlameLeviathanPursuedTargetSelector
{
    enum Area
    {
        AREA_FORMATION_GROUNDS = 4652,
    };

    public:
        explicit FlameLeviathanPursuedTargetSelector() {};

        bool operator()(WorldObject* target) const
        {
            //! No players, only vehicles (todo: check if blizzlike)
            Creature* creatureTarget = target->ToCreature();
            if (!creatureTarget)
                return true;

            //! NPC entries must match
            if (creatureTarget->GetEntry() != NPC_SALVAGED_DEMOLISHER && creatureTarget->GetEntry() != NPC_SALVAGED_SIEGE_ENGINE)
                return true;

            //! NPC must be a valid vehicle installation
            Vehicle* vehicle = creatureTarget->GetVehicleKit();
            if (!vehicle)
                return true;

            //! Entity needs to be in appropriate area
            if (target->GetAreaId() != AREA_FORMATION_GROUNDS)
                return true;

            //! Vehicle must be in use by player
            bool playerFound = false;
            for (SeatMap::const_iterator itr = vehicle->Seats.begin(); itr != vehicle->Seats.end() && !playerFound; ++itr)
                if (IS_PLAYER_GUID(itr->second.Passenger.Guid))
                    playerFound = true;

            return !playerFound;
        }
};

class spell_pursue : public SpellScriptLoader
{
    public:
        spell_pursue() : SpellScriptLoader("spell_pursue") {}

        class spell_pursue_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_pursue_SpellScript);

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.remove_if(FlameLeviathanPursuedTargetSelector());
                if (targets.empty())
                {
                    if (Creature* caster = GetCaster()->ToCreature())
                        caster->AI()->EnterEvadeMode();
                }
                else
                {
                    //! In the end, only one target should be selected
                    WorldObject* _target = Trinity::Containers::SelectRandomContainerElement(targets);
                    targets.clear();
                    if (_target)
                        targets.push_back(_target);
                }
            }


            void HandleScript(SpellEffIndex /*eff*/)
            {
                Creature* target = GetHitCreature();
                Unit* caster = GetCaster();
                if (!target || !caster)
                    return;

                caster->getThreatManager().resetAllAggro();
                caster->GetAI()->AttackStart(target);    // Chase target
                caster->AddThreat(target, 10000000.0f);
            }

            void Register() override
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pursue_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_pursue_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_pursue_SpellScript();
        }
};

class spell_vehicle_throw_passenger : public SpellScriptLoader
{
    public:
        spell_vehicle_throw_passenger() : SpellScriptLoader("spell_vehicle_throw_passenger") {}

        class spell_vehicle_throw_passenger_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_vehicle_throw_passenger_SpellScript);
            void HandleScript()
            {
                Spell* baseSpell = GetSpell();
                SpellCastTargets targets = baseSpell->m_targets;
                if (Vehicle* vehicle = GetCaster()->GetVehicleKit())
                    if (Unit* passenger = vehicle->GetPassenger(3))
                    {
                        // use 99 because it is 3d search
                        std::list<WorldObject*> targetList;
                        Trinity::WorldObjectSpellAreaTargetCheck check(99, GetExplTargetDest(), GetCaster(), GetCaster(), GetSpellInfo(), TARGET_CHECK_DEFAULT, nullptr);
                        Trinity::WorldObjectListSearcher<Trinity::WorldObjectSpellAreaTargetCheck> searcher(GetCaster(), targetList, check);
                        GetCaster()->GetMap()->VisitAll(GetCaster()->m_positionX, GetCaster()->m_positionY, 99, searcher);
                        float minDist = 99 * 99;
                        Unit* target = nullptr;
                        for (std::list<WorldObject*>::iterator itr = targetList.begin(); itr != targetList.end(); ++itr)
                        {
                            if (Unit* unit = (*itr)->ToUnit())
                                if (unit->GetEntry() == NPC_SEAT)
                                    if (Vehicle* seat = unit->GetVehicleKit())
                                        if (!seat->GetPassenger(0))
                                            if (Unit* device = seat->GetPassenger(2))
                                                if (!device->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
                                                {
                                                    float dist = unit->GetExactDistSq(targets.GetDstPos());
                                                    if (dist < minDist)
                                                    {
                                                        minDist = dist;
                                                        target = unit;
                                                    }
                                                }
                        }
                        if (target && target->IsWithinDist2d(targets.GetDstPos(), GetSpellInfo()->Effects[EFFECT_0].CalcRadius() * 2)) // now we use *2 because the location of the seat is not correct
                        {
                            passenger->ExitVehicle();
                            passenger->EnterVehicle(target, 0);
                        }
                        else
                        {
                            passenger->ExitVehicle();
                            float x, y, z;
                            targets.GetDstPos()->GetPosition(x, y, z);
                            passenger->GetMotionMaster()->MoveJump(x, y, z, targets.GetSpeedXY(), targets.GetSpeedZ());
                        }
                    }
            }

            void Register() override
            {
                AfterCast += SpellCastFn(spell_vehicle_throw_passenger_SpellScript::HandleScript);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_vehicle_throw_passenger_SpellScript();
        }
};

class spell_tar_blaze : public SpellScriptLoader
{
    public:
        spell_tar_blaze() : SpellScriptLoader("spell_tar_blaze") { }

        class spell_tar_blaze_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_tar_blaze_AuraScript);

            void OnPeriodic(AuraEffect const* aurEff)
            {
                GetUnitOwner()->CastSpell((Unit*)nullptr, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
            }

            void Register() override
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_tar_blaze_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_tar_blaze_AuraScript();
        }
};

class spell_vehicle_grab_pyrite : public SpellScriptLoader
{
    public:
        spell_vehicle_grab_pyrite() : SpellScriptLoader("spell_vehicle_grab_pyrite") {}

        class spell_vehicle_grab_pyrite_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_vehicle_grab_pyrite_SpellScript);
            void HandleScript(SpellEffIndex  /*effIndex*/)
            {
                if (Unit* target = GetHitUnit())
                    if (Unit* seat = GetCaster()->GetVehicleBase())
                    {
                        if (Vehicle* vSeat = seat->GetVehicleKit())
                            if (Unit* pyrite = vSeat->GetPassenger(1))
                                pyrite->ExitVehicle();

                        if (Unit* parent = seat->GetVehicleBase())
                        {
                            GetCaster()->CastSpell(parent, 62496 /*SPELL_ADD_PYRITE*/, true);
                            target->CastSpell(seat, GetEffectValue());

                            if (target->GetTypeId() == TYPEID_UNIT)
                                target->ToCreature()->DespawnOrUnsummon(1300);
                        }
                    }
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_vehicle_grab_pyrite_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_vehicle_grab_pyrite_SpellScript();
        }
};

class spell_vehicle_circuit_overload : public SpellScriptLoader
{
    public:
        spell_vehicle_circuit_overload() : SpellScriptLoader("spell_vehicle_circuit_overload") { }

        class spell_vehicle_circuit_overload_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_vehicle_circuit_overload_AuraScript);

            void OnPeriodic(AuraEffect const*  /*aurEff*/)
            {
                if (Unit* target = GetTarget())
                    if (int(target->GetAppliedAuras().count(SPELL_OVERLOAD_CIRCUIT)) >= (target->GetMap()->Is25ManRaid() ? 4 : 2))
                    {
                         target->CastSpell(target, SPELL_SYSTEMS_SHUTDOWN, true);
                         target->RemoveAurasDueToSpell(SPELL_OVERLOAD_CIRCUIT);
                    }
            }

            void Register() override
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_vehicle_circuit_overload_AuraScript::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_vehicle_circuit_overload_AuraScript();
        }
};

class spell_orbital_supports : public SpellScriptLoader
{
    public:
        spell_orbital_supports() : SpellScriptLoader("spell_orbital_supports") { }

        class spell_orbital_supports_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_orbital_supports_AuraScript);

            bool CheckAreaTarget(Unit* target)
            {
                return target->GetEntry() == NPC_LEVIATHAN;
            }
            void Register() override
            {
                DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_orbital_supports_AuraScript::CheckAreaTarget);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_orbital_supports_AuraScript();
        }
};

class spell_thorims_hammer : public SpellScriptLoader
{
    public:
        spell_thorims_hammer() : SpellScriptLoader("spell_thorims_hammer") { }

        class spell_thorims_hammer_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_thorims_hammer_SpellScript);

            void RecalculateDamage(SpellEffIndex effIndex)
            {
                if (!GetHitUnit() || effIndex == EFFECT_1)
                {
                    PreventHitDefaultEffect(effIndex);
                    return;
                }

                float dist = GetHitUnit()->GetExactDist2d(GetCaster());
                if (dist <= 7.0f)
                    SetHitDamage(GetSpellInfo()->Effects[EFFECT_1].CalcValue());
                else
                {
                    dist -= 6.0f;
                    SetHitDamage(int32(GetSpellInfo()->Effects[EFFECT_1].CalcValue() / std::max(dist, 1.0f)));
                }
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_thorims_hammer_SpellScript::RecalculateDamage, EFFECT_ALL, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_thorims_hammer_SpellScript();
        }
};

class spell_shield_generator : public SpellScriptLoader
{
    public:
        spell_shield_generator() : SpellScriptLoader("spell_shield_generator") { }

        class spell_shield_generator_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_shield_generator_AuraScript);

            uint32 absorbPct;

            bool Load() override
            {
                absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
                return true;
            }

            void CalculateAmount(AuraEffect const* /*aurEff*/, int32 & amount, bool & /*canBeRecalculated*/)
            {
                // Set absorbtion amount to unlimited
                amount = -1;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                absorbAmount = CalculatePct(dmgInfo.GetDamage(), absorbPct);
            }

            void Register() override
            {
                 DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_shield_generator_AuraScript::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
                 OnEffectAbsorb += AuraEffectAbsorbFn(spell_shield_generator_AuraScript::Absorb, EFFECT_0);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_shield_generator_AuraScript();
        }
};


class spell_demolisher_ride_vehicle : public SpellScriptLoader
{
    public:
        spell_demolisher_ride_vehicle() : SpellScriptLoader("spell_demolisher_ride_vehicle") {}

        class spell_demolisher_ride_vehicle_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_demolisher_ride_vehicle_SpellScript);

            SpellCastResult CheckCast()
            {
                if (GetCaster()->GetTypeId() != TYPEID_PLAYER)
                    return SPELL_CAST_OK;

                Unit* target = this->GetExplTargetUnit();
                if (!target || target->GetEntry() != NPC_SALVAGED_DEMOLISHER)
                    return SPELL_FAILED_DONT_REPORT;

                Vehicle* veh = target->GetVehicleKit();
                if (veh && veh->GetPassenger(0))
                    if (Unit* target2 = veh->GetPassenger(1))
                        if (Vehicle* veh2 = target2->GetVehicleKit())
                        {
                            if (!veh2->GetPassenger(0))
                                target2->HandleSpellClick(GetCaster());

                            return SPELL_FAILED_DONT_REPORT;
                        }

                return SPELL_CAST_OK;
            }

            void Register() override
            {
                OnCheckCast += SpellCheckCastFn(spell_demolisher_ride_vehicle_SpellScript::CheckCast);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_demolisher_ride_vehicle_SpellScript();
        }
};

class achievement_flame_leviathan_towers : public AchievementCriteriaScript
{
    public:
        achievement_flame_leviathan_towers(char const* name, uint32 count) : AchievementCriteriaScript(name),
            _towerCount(count)
        {
        }

        bool OnCheck(Player*  /*player*/, Unit* target /*Flame Leviathan*/) override
        {
            return target && _towerCount <= target->GetAI()->GetData(DATA_GET_TOWER_COUNT);
        }
        
    private:
        uint32 const _towerCount;
};

class achievement_flame_leviathan_shutout : public AchievementCriteriaScript
{
    public:
        achievement_flame_leviathan_shutout() : AchievementCriteriaScript("achievement_flame_leviathan_shutout") {}

        bool OnCheck(Player*  /*player*/, Unit* target /*Flame Leviathan*/) override
        {
            if (target)
                if (target->GetAI()->GetData(DATA_GET_SHUTDOWN))
                    return true;
            return false;
        }
};

class achievement_flame_leviathan_garage : public AchievementCriteriaScript
{
    public:
        achievement_flame_leviathan_garage(char const* name, uint32 entry1, uint32 entry2) : AchievementCriteriaScript(name),
            _entry1(entry1), _entry2(entry2)
        {
        }

        bool OnCheck(Player* player, Unit*) override
        {
            if (Vehicle* vehicle = player->GetVehicle())
                if (vehicle->GetCreatureEntry() == _entry1 || vehicle->GetCreatureEntry() == _entry2)
                    return true;
            return false;
        }
        
    private:
        uint32 const _entry1;
        uint32 const _entry2;
};

class achievement_flame_leviathan_unbroken : public AchievementCriteriaScript
{
    public:
        achievement_flame_leviathan_unbroken() : AchievementCriteriaScript("achievement_flame_leviathan_unbroken") {}

        bool OnCheck(Player* player, Unit*) override
        {
            if (player->GetInstanceScript())
                if (player->GetInstanceScript()->GetData(DATA_UNBROKEN_ACHIEVEMENT))
                    return true;
            return false;
        }
};

void AddSC_boss_flame_leviathan()
{
    new boss_flame_leviathan();
    new boss_flame_leviathan_seat();
    new boss_flame_leviathan_defense_turret();
    new boss_flame_leviathan_overload_device();
    new npc_pool_of_tar();

    // Hard Mode
    new npc_freya_ward();
    new npc_thorims_hammer();
    new npc_mimirons_inferno();
    new npc_hodirs_fury();

    // Helpers
    new npc_lore_keeper_of_norgannon_ulduar();
    new npc_brann_ulduar();
    new npc_brann_radio();
    new npc_storm_beacon_spawn();
    new boss_flame_leviathan_safety_container();
    new npc_mechanolift();

    // GOs
    new go_ulduar_tower();

    // Spells
    new spell_load_into_catapult();
    new spell_auto_repair();
    new spell_systems_shutdown();
    new spell_pursue();
    new spell_vehicle_throw_passenger();
    new spell_tar_blaze();
    new spell_vehicle_grab_pyrite();
    new spell_vehicle_circuit_overload();
    new spell_orbital_supports();
    new spell_thorims_hammer();
    new spell_shield_generator();
    new spell_demolisher_ride_vehicle();

    // Achievements
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_orbital_bombardment", 1);
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_orbital_devastation", 2);
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_nuked_from_orbit", 3);
    new achievement_flame_leviathan_towers("achievement_flame_leviathan_orbituary", 4);
    new achievement_flame_leviathan_shutout();
    new achievement_flame_leviathan_garage("achievement_flame_leviathan_garage_chopper", NPC_VEHICLE_CHOPPER, 0);
    new achievement_flame_leviathan_garage("achievement_flame_leviathan_garage_siege_engine", NPC_SALVAGED_SIEGE_ENGINE, NPC_SALVAGED_SIEGE_ENGINE_TURRET);
    new achievement_flame_leviathan_garage("achievement_flame_leviathan_garage_demolisher", NPC_SALVAGED_DEMOLISHER, NPC_SALVAGED_DEMOLISHER_TURRET);
    new achievement_flame_leviathan_unbroken();
}
