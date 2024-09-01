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
#include "CellImpl.h"
#include "CombatAI.h"
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "GridNotifiers.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Vehicle.h"
#include "ulduar.h"

/// @todo: this import is not necessary for compilation and marked as unused by the IDE
//  however, for some reasons removing it would cause a damn linking issue
//  there is probably some underlying problem with imports which should properly addressed
//  see: https://github.com/azerothcore/azerothcore-wotlk/issues/9766
#include "GridNotifiersImpl.h"

enum LeviathanSpells
{
    // Leviathan basic
    SPELL_PURSUED                       = 62374,
    SPELL_GATHERING_SPEED               = 62375,
    SPELL_BATTERING_RAM                 = 62376,
    SPELL_FLAME_VENTS                   = 62396,
    SPELL_MISSILE_BARRAGE               = 62400,
    SPELL_NAPALM_10                     = 63666,
    SPELL_NAPALM_25                     = 65026,
    SPELL_INVIS_AND_STEALTH_DETECT      = 18950,
    SPELL_TRANSITUS_SHIELD_IMPACT       = 48387,

    // Shutdown spells
    SPELL_SYSTEMS_SHUTDOWN              = 62475,
    SPELL_OVERLOAD_CIRCUIT              = 62399,

    // hard mode
    SPELL_TOWER_OF_STORMS               = 65076,
    SPELL_TOWER_OF_FLAMES               = 65075,
    SPELL_TOWER_OF_FROST                = 65077,
    SPELL_TOWER_OF_LIFE                 = 64482,

    SPELL_HODIRS_FURY                   = 62533,
    SPELL_FREYA_WARD                    = 62906, // removed spawn effect
    SPELL_MIMIRONS_INFERNO              = 62909,
    SPELL_THORIMS_HAMMER                = 62911,

    SPELL_FREYA_DUMMY_BLUE              = 63294,
    SPELL_FREYA_DUMMY_GREEN             = 63295,
    SPELL_FREYA_DUMMY_YELLOW            = 63292,

    // Leviathan turret spell
    SPELL_SEARING_FLAME                 = 62402,
    // On turret Destory
    SPELL_SMOKE_TRAIL                   = 63575,

    // Pool of tar blaze
    SPELL_BLAZE                         = 62292,

    // Pyrite
    SPELL_LIQUID_PYRITE                 = 62494,
    SPELL_DUSTY_EXPLOSION               = 63360,
    SPELL_DUST_CLOUD_IMPACT             = 54740,
};

enum GosNpcs
{
    NPC_FLAME_LEVIATHAN_TURRET          = 33139,
    NPC_SEAT                            = 33114,
    NPC_MECHANOLIFT                     = 33214,
    NPC_LIQUID                          = 33189,

    // Starting event
    NPC_ULDUAR_COLOSSUS                 = 33237,
    NPC_BRANN_RADIO                     = 34054,
    NPC_ULDUAR_GAUNTLET_GENERATOR       = 33571,
    NPC_DEFENDER_GENERATED              = 33572,

    // Hard Mode
    NPC_THORIM_HAMMER_TARGET            = 33364,
    NPC_THORIM_HAMMER                   = 33365,
    NPC_FREYA_WARD_TARGET               = 33366,
    NPC_FREYA_WARD                      = 33367,
    NPC_MIMIRONS_INFERNO_TARGET         = 33369,
    NPC_MIMIRONS_INFERNO                = 33370,
    NPC_HODIRS_FURY_TARGET              = 33108,
    NPC_HODIRS_FURY                     = 33212,
};

enum Events
{
    EVENT_PURSUE                        = 1,
    EVENT_MISSILE                       = 2,
    EVENT_VENT                          = 3,
    EVENT_SPEED                         = 4,
    EVENT_SUMMON                        = 5,
    EVENT_REINSTALL                     = 6,
    EVENT_HODIRS_FURY                   = 7,
    EVENT_FREYA                         = 8,
    EVENT_MIMIRONS_INFERNO              = 9,
    EVENT_THORIMS_HAMMER                = 10,
    EVENT_SOUND_BEGINNING               = 11,
    EVENT_POSITION_CHECK                = 12,
};

enum Texts
{
    FLAME_LEVIATHAN_SAY_AGGRO           = 0,
    FLAME_LEVIATHAN_SAY_SLAY            = 1,
    FLAME_LEVIATHAN_SAY_DEATH           = 2,
    FLAME_LEVIATHAN_SAY_PURSUE          = 3,
    FLAME_LEVIATHAN_SAY_HARDMODE        = 4,
    FLAME_LEVIATHAN_SAY_TOWER_NONE      = 5,
    FLAME_LEVIATHAN_SAY_TOWER_FROST     = 6,
    FLAME_LEVIATHAN_SAY_TOWER_FLAME     = 7,
    FLAME_LEVIATHAN_SAY_TOWER_NATURE    = 8,
    FLAME_LEVIATHAN_SAY_TOWER_STORM     = 9,
    FLAME_LEVIATHAN_SAY_PLAYER_RIDING   = 10,
    FLAME_LEVIATHAN_SAY_OVERLOAD        = 11,
    FLAME_LEVIATHAN_EMOTE_PURSUE        = 12,
    FLAME_LEVIATHAN_EMOTE_OVERLOAD      = 13,
    FLAME_LEVIATHAN_EMOTE_REPAIR        = 14,
    FLAME_LEVIATHAN_EMOTE_FROST         = 15,
    FLAME_LEVIATHAN_EMOTE_FLAME         = 16,
    FLAME_LEVIATHAN_EMOTE_NATURE        = 17,
    FLAME_LEVIATHAN_EMOTE_STORM         = 18,
    FLAME_LEVIATHAN_EMOTE_REACTIVATE    = 19,

    // NPC_BRANN_RADIO
    BRANN_RADIO_SAY_FL_START_0          = 0,
    BRANN_RADIO_SAY_FL_START_1          = 1,
    BRANN_RADIO_SAY_FL_START_2          = 2,
    BRANN_RADIO_SAY_GENERATORS          = 3,
    BRANN_RADIO_SAY_STATIONS            = 4,
    BRANN_RADIO_SAY_TOWER_THORIM        = 5,
    BRANN_RADIO_SAY_TOWER_HODIR         = 6,
    BRANN_RADIO_SAY_TOWER_FREYA         = 7,
    BRANN_RADIO_SAY_TOWER_MIMIRON       = 8,

    // Vehicle Repair - Said by a spell, BroadcastTextID, same as FLAME_LEVIATHAN_EMOTE_REPAIR
    VEHICLE_EMOTE_REPAIR                = 33538,
};

enum Seats
{
    SEAT_PLAYER                         = 0,
    SEAT_TURRET                         = 1,
    SEAT_DEVICE                         = 2,
    SEAT_CANNON                         = 7,
};

enum Misc
{
    DATA_EVENT_STARTED                  = 1,
    DATA_GET_TOWER_COUNT                = 2,
    DATA_GET_SHUTDOWN                   = 3,

    TOWER_OF_STORMS                     = 2,
    TOWER_OF_FLAMES                     = 1,
    TOWER_OF_FROST                      = 3,
    TOWER_OF_LIFE                       = 0,

    ACTION_START_NORGANNON_EVENT        = 1,
    ACTION_START_NORGANNON_BRANN        = 2,
    ACTION_START_BRANN_EVENT            = 3,
    ACTION_DESPAWN_ADDS                 = 4,
    ACTION_DELAY_CANNON                 = 5,
    ACTION_DESTROYED_TURRET             = 6,
};

const Position homePos = {322.39f, -14.5f, 409.8f, 3.14f};

class boss_flame_leviathan : public CreatureScript
{
public:
    boss_flame_leviathan() : CreatureScript("boss_flame_leviathan") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_flame_leviathanAI>(pCreature);
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
        void RadioSay(uint8 textid);
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
        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override;
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

        void JustEngagedWith(Unit*) override
        {
            ScheduleEvents();
            Talk(FLAME_LEVIATHAN_SAY_AGGRO);

            me->setActive(true);
            me->SetHomePosition(homePos);
            TurnHealStations(false);
            ActivateTowers();
            if (m_pInstance)
                m_pInstance->SetData(TYPE_LEVIATHAN, SPECIAL);

            BindPlayers();
            me->SetInCombatWithZone();

            if (!_startTimer)
            {
                TurnGates(true, false);
            }
        }

        void InitializeAI() override
        {
            if (m_pInstance && m_pInstance->GetData(TYPE_LEVIATHAN) == SPECIAL)
            {
                me->SetHomePosition(homePos);
                me->UpdatePosition(homePos);
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
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                }
                else
                {
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
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
                    _speakTimer = 10000;
                    RadioSay(BRANN_RADIO_SAY_FL_START_0);
                }
                else if (_speakTimer > 16000 && _speakTimer < 20000)
                {
                    _speakTimer = 20000;
                    RadioSay(BRANN_RADIO_SAY_FL_START_1);
                }
                else if (_speakTimer > 24000 && _speakTimer < 40000)
                {
                    _speakTimer = 40000;
                    RadioSay(BRANN_RADIO_SAY_FL_START_2);
                }
                else if (_speakTimer > 41000 && _speakTimer < 60000)
                {
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    TurnGates(true, false);
                    me->MonsterMoveWithSpeed(homePos.GetPositionX(), homePos.GetPositionY(), homePos.GetPositionZ(), 100.0f);
                    me->UpdatePosition(homePos);
                    _speakTimer = 60000;
                }
                else if (_speakTimer > 63500)
                {
                    me->SetInCombatWithZone();
                    if (!me->GetVictim())
                    {
                        me->CastSpell(me, SPELL_PURSUED, false);
                        events.RescheduleEvent(EVENT_PURSUE, 31s);
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

            switch (events.ExecuteEvent())
            {
                case EVENT_POSITION_CHECK:
                    if (me->GetPositionX() > 450 || me->GetPositionX() < 120)
                    {
                        EnterEvadeMode();
                        return;
                    }
                    events.Repeat(5s);
                    break;
                case EVENT_PURSUE:
                    Talk(FLAME_LEVIATHAN_SAY_PURSUE);
                    me->CastSpell(me, SPELL_PURSUED, false);
                    events.RescheduleEvent(EVENT_PURSUE, 31s);
                    return;
                case EVENT_SPEED:
                    me->CastSpell(me, SPELL_GATHERING_SPEED, false);
                    events.Repeat(15s);
                    return;
                case EVENT_MISSILE:
                    me->CastSpell(me, SPELL_MISSILE_BARRAGE, true);
                    events.Repeat(4s);
                    return;
                case EVENT_VENT:
                    me->CastSpell(me, SPELL_FLAME_VENTS, false);
                    events.Repeat(20s);
                    return;
                case EVENT_SUMMON:
                    if(summons.size() < 20)
                        if (Creature* lift = DoSummonFlyer(NPC_MECHANOLIFT, me, 30.0f, 50.0f, 0))
                            lift->GetMotionMaster()->MoveRandom(100);

                    events.Repeat(4s);
                    return;
                case EVENT_SOUND_BEGINNING:
                    if (_towersCount)
                        Talk(FLAME_LEVIATHAN_SAY_HARDMODE);
                    else
                        Talk(FLAME_LEVIATHAN_SAY_TOWER_NONE);
                    return;
                case EVENT_REINSTALL:
                    for (uint8 i = RAID_MODE(0, 2); i < 4; ++i)
                        if (Unit* seat = vehicle->GetPassenger(i))
                            if (seat->IsCreature())
                                seat->ToCreature()->AI()->EnterEvadeMode();
                    Talk(FLAME_LEVIATHAN_EMOTE_REACTIVATE);
                    return;
                case EVENT_THORIMS_HAMMER:
                    SummonTowerHelpers(TOWER_OF_STORMS);
                    events.Repeat(1min, 2min);
                    Talk(FLAME_LEVIATHAN_EMOTE_STORM);
                    Talk(FLAME_LEVIATHAN_SAY_TOWER_STORM);
                    return;
                case EVENT_FREYA:
                    SummonTowerHelpers(TOWER_OF_LIFE);
                    Talk(FLAME_LEVIATHAN_EMOTE_NATURE);
                    Talk(FLAME_LEVIATHAN_SAY_TOWER_NATURE);
                    return;
                case EVENT_MIMIRONS_INFERNO:
                    SummonTowerHelpers(TOWER_OF_FLAMES);
                    Talk(FLAME_LEVIATHAN_EMOTE_FLAME);
                    Talk(FLAME_LEVIATHAN_SAY_TOWER_FLAME);
                    return;
                case EVENT_HODIRS_FURY:
                    SummonTowerHelpers(TOWER_OF_FROST);
                    Talk(FLAME_LEVIATHAN_EMOTE_FROST);
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
                    me->CastSpell(me, SPELL_SYSTEMS_SHUTDOWN, true);
                }
            }
        }
    };
};

void boss_flame_leviathan::boss_flame_leviathanAI::BindPlayers()
{
    me->GetMap()->ToInstanceMap()->PermBindAllPlayers();
}

void boss_flame_leviathan::boss_flame_leviathanAI::RadioSay(uint8 textid)
{
    if (Creature* r = me->SummonCreature(NPC_BRANN_RADIO, me->GetPositionX() - 150, me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TEMPSUMMON_TIMED_DESPAWN, 5000))
    {
        r->AI()->Talk(textid);
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

            me->AddLootMode(1 << _towersCount);
            switch (i)
            {
                case EVENT_TOWER_OF_LIFE_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_LIFE, me);
                    events.RescheduleEvent(EVENT_FREYA, 30s);
                    break;
                case EVENT_TOWER_OF_STORM_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_STORMS, me);
                    events.RescheduleEvent(EVENT_THORIMS_HAMMER, 1min);
                    break;
                case EVENT_TOWER_OF_FROST_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_FROST, me);
                    events.RescheduleEvent(EVENT_HODIRS_FURY, 20s);
                    break;
                case EVENT_TOWER_OF_FLAMES_DESTROYED:
                    me->AddAura(SPELL_TOWER_OF_FLAMES, me);
                    events.RescheduleEvent(EVENT_MIMIRONS_INFERNO, 42s);
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
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_LIGHTNING_WALL2))))
            go->SetGoState(GO_STATE_READY);

        if (m_pInstance->GetData(TYPE_LEVIATHAN) == NOT_STARTED)
            if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(GO_LEVIATHAN_DOORS))))
                go->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);
    }
    else
    {
        GameObject* go = nullptr;
        if (_death)
            if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_LIGHTNING_WALL1))))
                go->SetGoState(GO_STATE_ACTIVE);

        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_LIGHTNING_WALL2))))
            go->SetGoState(GO_STATE_ACTIVE);

        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(GO_LEVIATHAN_DOORS))))
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
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION1))))
            go->SetLootState(GO_READY);
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION2))))
            go->SetLootState(GO_READY);
    }
    else
    {
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION1))))
            go->SetLootState(GO_ACTIVATED);
        if ((go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(DATA_REPAIR_STATION2))))
            go->SetLootState(GO_ACTIVATED);
    }
}

void boss_flame_leviathan::boss_flame_leviathanAI::ScheduleEvents()
{
    events.RescheduleEvent(EVENT_MISSILE, 5s);
    events.RescheduleEvent(EVENT_VENT, 20s);
    events.RescheduleEvent(EVENT_SPEED, 15s);
    events.RescheduleEvent(EVENT_SUMMON, 10s);
    events.RescheduleEvent(EVENT_SOUND_BEGINNING, 10s);
    events.RescheduleEvent(EVENT_POSITION_CHECK, 5s);

    events.RescheduleEvent(EVENT_PURSUE, 0ms);
}

void boss_flame_leviathan::boss_flame_leviathanAI::SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo)
{
    if (spellInfo->Id == SPELL_SYSTEMS_SHUTDOWN)
    {
        _shutdown = true; // ACHIEVEMENT

        Talk(FLAME_LEVIATHAN_EMOTE_OVERLOAD);
        Talk(FLAME_LEVIATHAN_EMOTE_REPAIR);
        Talk(FLAME_LEVIATHAN_SAY_OVERLOAD);

        events.DelayEvents(21ms);
        events.ScheduleEvent(EVENT_REINSTALL, 20ms);
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
        events.RescheduleEvent(EVENT_PURSUE, 0ms);

    if (who->IsPlayer())
        Talk(FLAME_LEVIATHAN_SAY_SLAY);
}

void boss_flame_leviathan::boss_flame_leviathanAI::SummonTowerHelpers(uint8 towerId)
{
    if (towerId == TOWER_OF_LIFE)
    {
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 374, -141, 411, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 374, -141, 411 + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 382.9f, 74, 411.6f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 382.9f, 74, 411.6f + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 159.4f, 64.1f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 159.4f, 64.1f, 409.8f + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD_TARGET, 157.7f, -140.26f, 409.8f, 0, TEMPSUMMON_MANUAL_DESPAWN);
        me->SummonCreature(NPC_FREYA_WARD, 157.7f, -140.26f, 409.8f + 40, 0, TEMPSUMMON_MANUAL_DESPAWN);
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
            me->SummonCreature(NPC_THORIM_HAMMER_TARGET, 157 + rand() % 200, -140 + rand() % 200, 409.8f, 0, TEMPSUMMON_TIMED_DESPAWN, 24000);
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
        return GetUlduarAI<boss_flame_leviathan_seatAI>(pCreature);
    }

    struct boss_flame_leviathan_seatAI : public VehicleAI
    {
        boss_flame_leviathan_seatAI(Creature* creature) : VehicleAI(creature), vehicle(creature->GetVehicleKit())
        {
            ASSERT(vehicle);
            me->SetReactState(REACT_PASSIVE);
        }

        Vehicle* vehicle;
        uint32 _despawnTimer;

        void EnterEvadeMode(EvadeReason /*why*/) override
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
            if (!who->IsPlayer() || !me->GetVehicle())
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
                        turret->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                        turret->GetAI()->AttackStart(who);
                        if (Creature* leviathan = me->GetVehicleCreatureBase())
                            leviathan->AI()->Talk(FLAME_LEVIATHAN_SAY_PLAYER_RIDING);
                    }
                    else
                    {
                        turret->ReplaceAllUnitFlags(UNIT_FLAG_NOT_SELECTABLE);
                        turret->SetImmuneToAll(true);
                        if (turret->IsCreature())
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
        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!CanAIAttack(who))
            {
                _setHealth = true;
                damage = 0;
            }
        }

        void JustDied(Unit* killer) override
        {
            if (Player* player = killer->ToPlayer())
                player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_GET_KILLING_BLOWS, 1, 0, me);

            if (Vehicle* vehicle = me->GetVehicle())
                if (Unit* device = vehicle->GetPassenger(SEAT_DEVICE))
                    device->ReplaceAllUnitFlags(UNIT_FLAG_NONE); // unselectable

            if (Creature* leviathan = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(TYPE_LEVIATHAN)))
                leviathan->AI()->DoAction(ACTION_DESTROYED_TURRET);
        }

        bool CanAIAttack(Unit const* who) const override
        {
            if (!who || !who->IsPlayer() || !who->GetVehicle() || who->GetVehicleBase()->GetEntry() != NPC_SEAT)
                return false;
            return true;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_setHealth)
            {
                me->SetHealth(std::min(me->GetHealth() + 1, me->GetMaxHealth()));
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
        return GetUlduarAI<boss_flame_leviathan_defense_turretAI>(creature);
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
                me->RemoveNpcFlag(UNIT_NPC_FLAG_SPELLCLICK);
                me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);

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
        return GetUlduarAI<boss_flame_leviathan_overload_deviceAI>(creature);
    }
};

class npc_freya_ward : public CreatureScript
{
public:
    npc_freya_ward() : CreatureScript("npc_freya_ward") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_freya_wardAI>(pCreature);
    }

    struct npc_freya_wardAI : public NullCreatureAI
    {
        npc_freya_wardAI(Creature* c) : NullCreatureAI(c), summons(c)
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
            if (_castTimer >= 29 * IN_MILLISECONDS)
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
        return GetUlduarAI<npc_hodirs_furyAI>(pCreature);
    }

    struct npc_hodirs_furyAI : public NullCreatureAI
    {
        npc_hodirs_furyAI(Creature* c) : NullCreatureAI(c)
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
                    if (Creature* cr = me->SummonCreature(NPC_HODIRS_FURY, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 40, 0, TEMPSUMMON_TIMED_DESPAWN, 10000))
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
        return GetUlduarAI<npc_mimirons_infernoAI>(creature);
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
            Start(false, false, ObjectGuid::Empty, nullptr, false, true);
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
                if (Creature* cr = me->SummonCreature(NPC_MIMIRONS_INFERNO, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 40.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN, 30000))
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
        return GetUlduarAI<npc_thorims_hammerAI>(pCreature);
    }

    struct npc_thorims_hammerAI : public NullCreatureAI
    {
        npc_thorims_hammerAI(Creature* c) : NullCreatureAI(c)
        {
        }

        uint32 _beamTimer;
        uint32 _finishTime;
        uint32 _removeTimer;

        void Reset() override
        {
            _finishTime = 5000 + rand() % 15000;
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
                    if (Creature* cr = me->SummonCreature(NPC_THORIM_HAMMER, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 40, 0, TEMPSUMMON_TIMED_DESPAWN, 5000))
                        cr->CastSpell(me, SPELL_THORIMS_HAMMER, false);

                    _beamTimer = 0;
                    _removeTimer = 1;
                    me->DespawnOrUnsummon(5 * IN_MILLISECONDS);
                }
            }
            if (_removeTimer)
            {
                _removeTimer += diff;
                if (_removeTimer >= 3 * IN_MILLISECONDS)
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
        return GetUlduarAI<npc_pool_of_tarAI>(pCreature);
    }

    struct npc_pool_of_tarAI : public NullCreatureAI
    {
        npc_pool_of_tarAI(Creature* c) : NullCreatureAI(c)
        {
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            damage = 0;
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->SchoolMask & SPELL_SCHOOL_MASK_FIRE && !me->HasAura(SPELL_BLAZE))
                me->CastSpell(me, SPELL_BLAZE, true);
        }
    };
};

class npc_brann_radio : public CreatureScript
{
public:
    npc_brann_radio() : CreatureScript("npc_brann_radio") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<npc_brann_radioAI>(pCreature);
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

        void MoveInLineOfSight(Unit* who) override
        {
            if (!_lock)
            {
                if (!who->IsPlayer() && !who->IsVehicle())
                    return;

                // MIMIRON
                else if (me->GetDistance2d(-81.9207f, 111.432f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 60.0f && who->GetPositionZ() > 430.0f)
                    {
                        Talk(BRANN_RADIO_SAY_TOWER_MIMIRON);
                        _lock = true;
                    }
                }
                // FREYA
                else if (me->GetDistance2d(-221.475f, -271.087f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 60.0f && who->GetPositionZ() < 380.0f)
                    {
                        Talk(BRANN_RADIO_SAY_TOWER_FREYA);
                        _lock = true;
                    }
                }
                // STATIONS
                else if (me->GetDistance2d(73.8978f, -29.3306f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 40.0f)
                    {
                        Talk(BRANN_RADIO_SAY_STATIONS);
                        _lock = true;
                    }
                }
                // HODIR
                else if (me->GetDistance2d(68.7679f, -325.026f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 40.0f)
                    {
                        Talk(BRANN_RADIO_SAY_TOWER_HODIR);
                        _lock = true;
                    }
                }
                // THORIM
                else if (me->GetDistance2d(174.442f, 345.679f) < 5.0f)
                {
                    if (me->GetDistance2d(who) <= 60.0f)
                    {
                        Talk(BRANN_RADIO_SAY_TOWER_THORIM);
                        _lock = true;
                    }
                }
                // COME A BIT CLOSER
                else if (me->GetDistance2d(-508.898f, -32.9631f) < 5.0f)
                {
                    if (who->GetPositionX() >= -480.0f)
                    {
                        Talk(BRANN_RADIO_SAY_GENERATORS);
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
        return GetUlduarAI<npc_storm_beacon_spawnAI>(pCreature);
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
                        if (Creature* cr = me->SummonCreature(NPC_DEFENDER_GENERATED, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ() + 4, me->GetOrientation(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 900000))
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
        return GetUlduarAI<boss_flame_leviathan_safety_containerAI>(pCreature);
    }

    struct boss_flame_leviathan_safety_containerAI : public NullCreatureAI
    {
        boss_flame_leviathan_safety_containerAI(Creature* c) : NullCreatureAI(c)
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
                z = me->GetMapHeight(x, y, z);
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
        return GetUlduarAI<npc_mechanoliftAI>(pCreature);
    }

    struct npc_mechanoliftAI : public NullCreatureAI
    {
        npc_mechanoliftAI(Creature* c) : NullCreatureAI(c)
        {
            me->SetSpeed(MOVE_RUN, rand_norm() + 0.5f);
        }

        int32 _startTimer;
        uint32 _evadeTimer;

        void Reset() override
        {
            _startTimer = urand(1, 5000);
            _evadeTimer = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_startTimer)
            {
                _startTimer -= diff;
                if (_startTimer <= 0)
                {
                    me->GetMotionMaster()->MovePath(3000000 + urand(0, 11), true);
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

enum LoadIntoCataPult
{
    SPELL_PASSENGER_LOADED = 62340
};

class spell_load_into_catapult_aura : public AuraScript
{
    PrepareAuraScript(spell_load_into_catapult_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PASSENGER_LOADED });
    }

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
        OnEffectApply += AuraEffectApplyFn(spell_load_into_catapult_aura::OnApply, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_load_into_catapult_aura::OnRemove, EFFECT_0, SPELL_AURA_CONTROL_VEHICLE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

enum AutoRepair
{
    SPELL_AUTO_REPAIR = 62705,
};

class spell_auto_repair : public SpellScript
{
    PrepareSpellScript(spell_auto_repair);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_AUTO_REPAIR });
    }

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

        Unit* driver = vehicle->GetPassenger(0);
        if (!driver)
            return;

        //driver->TextEmote(VEHICLE_EMOTE_REPAIR, driver, true); // No source

        // Actually should/could use basepoints (100) for this spell effect as percentage of health, but oh well.
        vehicle->GetBase()->SetFullHealth();

        // Achievement
        if (InstanceScript* instance = vehicle->GetBase()->GetInstanceScript())
            instance->SetData(DATA_UNBROKEN_ACHIEVEMENT, 0);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_auto_repair::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_auto_repair::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_systems_shutdown_aura : public AuraScript
{
    PrepareAuraScript(spell_systems_shutdown_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GATHERING_SPEED });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Creature* owner = GetOwner()->ToCreature();
        if (!owner)
            return;

        owner->SetControlled(true, UNIT_STATE_STUNNED);
        owner->RemoveAurasDueToSpell(SPELL_GATHERING_SPEED);
        if (Vehicle* vehicle = owner->GetVehicleKit())
            if (Unit* cannon = vehicle->GetPassenger(SEAT_CANNON))
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
        OnEffectApply += AuraEffectApplyFn(spell_systems_shutdown_aura::OnApply, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_systems_shutdown_aura::OnRemove, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_TAKEN, AURA_EFFECT_HANDLE_REAL);
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
            if (itr->second.Passenger.Guid.IsPlayer())
                playerFound = true;

        return !playerFound;
    }
};

class spell_pursue : public SpellScript
{
    PrepareSpellScript(spell_pursue);

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
            WorldObject* _target = Acore::Containers::SelectRandomContainerElement(targets);
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

        caster->GetThreatMgr().ResetAllThreat();
        caster->GetAI()->AttackStart(target);    // Chase target
        caster->AddThreat(target, 10000000.0f);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_pursue::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_pursue::HandleScript, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

class spell_vehicle_throw_passenger : public SpellScript
{
    PrepareSpellScript(spell_vehicle_throw_passenger);

    void HandleScript()
    {
        Spell* baseSpell = GetSpell();
        SpellCastTargets targets = baseSpell->m_targets;
        if (Vehicle* vehicle = GetCaster()->GetVehicleKit())
            if (Unit* passenger = vehicle->GetPassenger(3))
            {
                // use 99 because it is 3d search
                std::list<WorldObject*> targetList;
                Acore::WorldObjectSpellAreaTargetCheck check(99, GetExplTargetDest(), GetCaster(), GetCaster(), GetSpellInfo(), TARGET_CHECK_DEFAULT, nullptr);
                Acore::WorldObjectListSearcher<Acore::WorldObjectSpellAreaTargetCheck> searcher(GetCaster(), targetList, check);
                Cell::VisitAllObjects(GetCaster(), searcher, 99.0f);
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
        AfterCast += SpellCastFn(spell_vehicle_throw_passenger::HandleScript);
    }
};

class spell_tar_blaze_aura : public AuraScript
{
    PrepareAuraScript(spell_tar_blaze_aura);

    void OnPeriodic(AuraEffect const* aurEff)
    {
        GetUnitOwner()->CastSpell((Unit*)nullptr, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_tar_blaze_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

enum VehicleGrabPyrite
{
    SPELL_ADD_PYRITE = 62496
};

class spell_vehicle_grab_pyrite : public SpellScript
{
    PrepareSpellScript(spell_vehicle_grab_pyrite);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ADD_PYRITE });
    }

    void HandleScript(SpellEffIndex  /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            if (Unit* seat = GetCaster()->GetVehicleBase())
            {
                if (Vehicle* vehicle = seat->GetVehicleKit())
                    if (Unit* pyrite = vehicle->GetPassenger(1))
                        pyrite->ExitVehicle();

                if (Unit* parent = seat->GetVehicleBase())
                {
                    GetCaster()->CastSpell(parent, SPELL_ADD_PYRITE, true);
                    target->CastSpell(seat, GetEffectValue());

                    if (target->IsCreature())
                        target->ToCreature()->DespawnOrUnsummon(1300);
                }
            }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_vehicle_grab_pyrite::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_vehicle_circuit_overload_aura : public AuraScript
{
    PrepareAuraScript(spell_vehicle_circuit_overload_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SYSTEMS_SHUTDOWN });
    }

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
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_vehicle_circuit_overload_aura::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_orbital_supports_aura : public AuraScript
{
    PrepareAuraScript(spell_orbital_supports_aura);

    bool CheckAreaTarget(Unit* target)
    {
        return target->GetEntry() == NPC_LEVIATHAN;
    }
    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_orbital_supports_aura::CheckAreaTarget);
    }
};

class spell_thorims_hammer : public SpellScript
{
    PrepareSpellScript(spell_thorims_hammer);

    void RecalculateDamage(SpellEffIndex effIndex)
    {
        if (!GetHitUnit() || effIndex == EFFECT_1)
        {
            PreventHitDefaultEffect(effIndex);
            return;
        }

        float dist = GetHitUnit()->GetExactDist2d(GetCaster());
        if (dist <= 7.0f)
        {
            SetHitDamage(GetSpellInfo()->Effects[EFFECT_1].CalcValue());
        }
        else
        {
            dist -= 6.0f;
            SetHitDamage(int32(GetSpellInfo()->Effects[EFFECT_1].CalcValue() / std::max(dist, 1.0f)));
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_thorims_hammer::RecalculateDamage, EFFECT_ALL, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

class spell_transitus_shield_beam_aura : public AuraScript
{
    PrepareAuraScript(spell_transitus_shield_beam_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TRANSITUS_SHIELD_IMPACT });
    }

    void HandleOnEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
        {
            return;
        }

        Unit* target = GetTarget();

        if (!target)
        {
            return;
        }

        switch (aurEff->GetEffIndex())
        {
        case EFFECT_0:
            caster->AddAura(SPELL_TRANSITUS_SHIELD_IMPACT, target);
            break;
        }
    }

    void HandleOnEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* caster = GetCaster();

        if (!caster)
        {
            return;
        }

        Unit* target = GetTarget();

        if (target)
        {
            target->RemoveAurasDueToSpell(SPELL_TRANSITUS_SHIELD_IMPACT);
        }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_transitus_shield_beam_aura::HandleOnEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        OnEffectRemove += AuraEffectRemoveFn(spell_transitus_shield_beam_aura::HandleOnEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
    }
};

class spell_shield_generator_aura : public AuraScript
{
    PrepareAuraScript(spell_shield_generator_aura);

    bool Load() override
    {
        _absorbPct = GetSpellInfo()->Effects[EFFECT_0].CalcValue(GetCaster());
        return true;
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        absorbAmount = CalculatePct(dmgInfo.GetDamage(), _absorbPct);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_shield_generator_aura::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_shield_generator_aura::Absorb, EFFECT_0);
    }

private:
    uint32 _absorbPct;
};

class spell_demolisher_ride_vehicle : public SpellScript
{
    PrepareSpellScript(spell_demolisher_ride_vehicle);

    SpellCastResult CheckCast()
    {
        if (!GetCaster()->IsPlayer())
            return SPELL_CAST_OK;

        Unit* target = this->GetExplTargetUnit();
        if (!target || target->GetEntry() != NPC_SALVAGED_DEMOLISHER)
            return SPELL_FAILED_DONT_REPORT;

        Vehicle* vehicle = target->GetVehicleKit();
        if (vehicle && vehicle->GetPassenger(0))
            if (Unit* target2 = vehicle->GetPassenger(1))
                if (Vehicle* vehicle2 = target2->GetVehicleKit())
                {
                    if (!vehicle2->GetPassenger(0))
                        target2->HandleSpellClick(GetCaster());

                    return SPELL_FAILED_DONT_REPORT;
                }

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_demolisher_ride_vehicle::CheckCast);
    }
};

class achievement_flame_leviathan_towers : public AchievementCriteriaScript
{
public:
    achievement_flame_leviathan_towers(char const* name, uint32 count) : AchievementCriteriaScript(name),
        _towerCount(count)
    {
    }

    bool OnCheck(Player*  /*player*/, Unit* target /*Flame Leviathan*/, uint32 /*criteria_id*/) override
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

    bool OnCheck(Player*  /*player*/, Unit* target /*Flame Leviathan*/, uint32 /*criteria_id*/) override
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

    bool OnCheck(Player* player, Unit*, uint32 /*criteria_id*/) override
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

    bool OnCheck(Player* player, Unit*, uint32 /*criteria_id*/) override
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
    new npc_brann_radio();
    new npc_storm_beacon_spawn();
    new boss_flame_leviathan_safety_container();
    new npc_mechanolift();

    // GOs
    new go_ulduar_tower();

    // Spells
    RegisterSpellScript(spell_load_into_catapult_aura);
    RegisterSpellScript(spell_auto_repair);
    RegisterSpellScript(spell_systems_shutdown_aura);
    RegisterSpellScript(spell_pursue);
    RegisterSpellScript(spell_vehicle_throw_passenger);
    RegisterSpellScript(spell_tar_blaze_aura);
    RegisterSpellScript(spell_vehicle_grab_pyrite);
    RegisterSpellScript(spell_vehicle_circuit_overload_aura);
    RegisterSpellScript(spell_orbital_supports_aura);
    RegisterSpellScript(spell_thorims_hammer);
    RegisterSpellScript(spell_transitus_shield_beam_aura);
    RegisterSpellScript(spell_shield_generator_aura);
    RegisterSpellScript(spell_demolisher_ride_vehicle);

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
