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
#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

enum ThorimSpells
{
    // THORIM
    SPELL_LIGHTNING_DESTRUCTION             = 62393,
    SPELL_SHEATH_OF_LIGHTNING               = 62276,
    SPELL_STORMHAMMER                       = 62042,
    SPELL_BERSERK_FRIENDS                   = 62560,
    SPELL_CHAIN_LIGHTNING_10                = 62131,
    SPELL_CHAIN_LIGHTNING_25                = 64390,
    SPELL_UNBALANCING_STRIKE                = 62130,
    SPELL_BERSERK                           = 26662,

    SPELL_CHARGE_ORB                        = 62016,
    SPELL_LIGHTNING_PILLAR_P1               = 63238,

    SPELL_LIGHTNING_ORB_VISUAL              = 62186,
    SPELL_LIGHTNING_CHARGE_DAMAGE           = 62466,
    SPELL_LIGHTNING_CHARGE_BUFF             = 62279,
    SPELL_LIGHTNING_PILLAR_P2               = 62976,
    SPELL_LIGHTNING_ORB_CHARGER             = 62278,

    // SIF
    SPELL_TOUCH_OF_DOMINION                 = 62507,
    SPELL_SIF_TRANSFORM                     = 64778,
    SPELL_SIF_CHANNEL_HOLOGRAM              = 64324,
    SPELL_FROSTBOLT                         = 62601,
    SPELL_FROSTBOLT_VALLEY                  = 62604,
    SPELL_BLIZZARD_10                       = 62577,
    SPELL_BLIZZARD_25                       = 62603,
    SPELL_FROST_NOVA                        = 62605,

    // DARK RUNE ACOLYTE
    SPELL_GREATER_HEAL_10                   = 62334,
    SPELL_GREATER_HEAL_25                   = 62442,
    SPELL_HOLY_SMITE_10                     = 62335,
    SPELL_HOLY_SMITE_25                     = 62443,
    SPELL_RENEW_10                          = 62333,
    SPELL_RENEW_25                          = 62441,

    // CAPTURED MERCENARY SOLDIER
    SPELL_BARBED_SHOT                       = 62318,
    SPELL_WING_CLIP                         = 40652,
    SPELL_SHOOT                             = 16496,

    // CAPTURED MERCENARY CAPTAIN
    SPELL_DEVASTATE                         = 62317,
    SPELL_HEROIC_STRIKE                     = 62444,

    // JORMUNGAR BEHEMOTH
    SPELL_ACID_BREATH_10                    = 62315,
    SPELL_ACID_BREATH_25                    = 62415,
    SPELL_SWEEP_10                          = 62316,
    SPELL_SWEEP_25                          = 62417,

    // IRON RING GUARD
    SPELL_IMPALE_10                         = 62331,
    SPELL_IMPALE_25                         = 62418,
    SPELL_WHIRLING_TRIP                     = 64151,

    // IRON HONOR GUARD
    SPELL_SHIELD_SMASH_10                   = 62332,
    SPELL_SHIELD_SMASH_25                   = 62420,
    SPELL_CLEAVE                            = 42724,
    SPELL_HAMSTRING                         = 48639,

    // DARK RUNE WARBRINGER
    SPELL_AURA_OF_CELERITY                  = 62320,
    SPELL_RUNIC_STRIKE                      = 62322,

    // DARK RUNE EVOKER
    SPELL_RUNIC_LIGHTNING_10                = 62327,
    SPELL_RUNIC_LIGHTNING_25                = 62445,
    SPELL_RUNIC_MENDING_10                  = 62328,
    SPELL_RUNIC_MENDING_25                  = 62446,
    SPELL_RUNIC_SHIELD_10                   = 62321,
    SPELL_RUNIC_SHIELD_25                   = 62529,

    // DARK RUNE CHAMPION
    SPELL_CHARGE                            = 32323,
    SPELL_MORTAL_STRIKE                     = 35054,
    SPELL_WHIRLWIND                         = 15578,

    // DARK RUNE COMMONER
    SPELL_LOW_BLOW                          = 62326,
    SPELL_PUMMEL                            = 38313,

    // RUNIC COLOSSUS
    SPELL_COLOSSUS_CHARGE_10                = 62613,
    SPELL_COLOSSUS_CHARGE_25                = 62614,
    SPELL_RUNIC_BARRIER                     = 62338,
    SPELL_SMASH                             = 62339,
    SPELL_RUNIC_SMASH_LEFT                  = 62057,
    SPELL_RUNIC_SMASH_RIGHT                 = 62058,
    SPELL_RUNIC_SMASH_DAMAGE                = 62465,

    // ANCIENT RUNE GIANT
    SPELL_RUNE_DETONATION                   = 62526,
    SPELL_RUNIC_FORTIFICATION               = 62942,
    SPELL_STOMP_10                          = 62411,
    SPELL_STOMP_25                          = 62413,

    // TRAPS
    SPELL_LIGHTNING_FIELD                   = 64972,
    SPELL_PARALYTIC_FIELD_FIRST             = 62241,
    SPELL_PARALYTIC_FIELD_SECOND            = 63540,
};

#define SPELL_GREATER_HEAL          RAID_MODE(SPELL_GREATER_HEAL_10, SPELL_GREATER_HEAL_25)
#define SPELL_HOLY_SMITE            RAID_MODE(SPELL_HOLY_SMITE_10, SPELL_HOLY_SMITE_25)
#define SPELL_RENEW                 RAID_MODE(SPELL_RENEW_10, SPELL_RENEW_25)
#define SPELL_ACID_BREATH           RAID_MODE(SPELL_ACID_BREATH_10, SPELL_ACID_BREATH_25)
#define SPELL_SWEEP                 RAID_MODE(SPELL_SWEEP_10, SPELL_SWEEP_25)
#define SPELL_IMPALE                RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25)
#define SPELL_COLOSSUS_CHARGE       RAID_MODE(SPELL_COLOSSUS_CHARGE_10, SPELL_COLOSSUS_CHARGE_25)
#define SPELL_STOMP                 RAID_MODE(SPELL_STOMP_10, SPELL_STOMP_25)
#define SPELL_SHIELD_SMASH          RAID_MODE(SPELL_SHIELD_SMASH_10, SPELL_SHIELD_SMASH_25)
#define SPELL_RUNIC_LIGHTNING       RAID_MODE(SPELL_RUNIC_LIGHTNING_10, SPELL_RUNIC_LIGHTNING_25)
#define SPELL_RUNIC_MENDING         RAID_MODE(SPELL_RUNIC_MENDING_10, SPELL_RUNIC_MENDING_25)
#define SPELL_RUNIC_SHIELD          RAID_MODE(SPELL_RUNIC_SHIELD_10, SPELL_RUNIC_SHIELD_25)
#define SPELL_CHAIN_LIGHTNING       RAID_MODE(SPELL_CHAIN_LIGHTNING_10, SPELL_CHAIN_LIGHTNING_25)

enum ThormNPCandGOs : uint32
{
    // ARENA INIT
    NPC_DARK_RUNE_ACOLYTE_I                 = 32886,
    NPC_CAPTURED_MERCENARY_SOLDIER_ALLY     = 32885,
    NPC_CAPTURED_MERCENARY_SOLDIER_HORDE    = 32883,
    NPC_CAPTURED_MERCENARY_CAPTAIN_ALLY     = 32908,
    NPC_CAPTURED_MERCENARY_CAPTAIN_HORDE    = 32907,
    NPC_JORMUNGAR_BEHEMOT                   = 32882,

    // ARENA PHASE
    NPC_DARK_RUNE_WARBRINGER                = 32877,
    NPC_DARK_RUNE_EVOKER                    = 32878,
    NPC_DARK_RUNE_CHAMPION                  = 32876,
    NPC_DARK_RUNE_COMMONER                  = 32904,

    // GAUNTLET
    NPC_IRON_RING_GUARD                     = 32874,
    NPC_RUNIC_COLOSSUS                      = 32872,
    NPC_ANCIENT_RUNE_GIANT                  = 32873,
    NPC_DARK_RUNE_ACOLYTE_G                 = 33110,
    NPC_IRON_HONOR_GUARD                    = 32875,

    // TRIGGERS
    NPC_LIGHTNING_ORB                       = 33138,
    NPC_THUNDER_ORB                         = 33378,
    NPC_PILLAR                              = 32892,
    NPC_SIF_BLIZZARD                        = 32879,

    NPC_SIF                                 = 33196,
};

enum ThorimEvents
{
    EVENT_THORIM_START_PHASE1               = 1,
    EVENT_THORIM_STORMHAMMER                = 2,
    EVENT_THORIM_CHARGE_ORB                 = 3,
    EVENT_THORIM_LIGHTNING_ORB              = 4,
    EVENT_THORIM_NOT_REACH_IN_TIME          = 5,
    EVENT_THORIM_FILL_ARENA                 = 6,
    EVENT_THORIM_UNBALANCING_STRIKE         = 7,
    EVENT_THORIM_LIGHTNING_CHARGE           = 8,
    EVENT_THORIM_CHAIN_LIGHTNING            = 9,
    EVENT_THORIM_BERSERK                    = 10,
    EVENT_THORIM_AGGRO                      = 11,
    EVENT_THORIM_AGGRO2                     = 12,
    EVENT_THORIM_OUTRO1                     = 13,
    EVENT_THORIM_OUTRO2                     = 14,
    EVENT_THORIM_OUTRO3                     = 15,
    EVENT_THORIM_OUTRO4                     = 16,

    EVENT_DR_ACOLYTE_GH                     = 20,
    EVENT_DR_ACOLYTE_HS                     = 21,
    EVENT_DR_ACOLYTE_R                      = 22,

    EVENT_CM_SOLDIER_BS                     = 30,
    EVENT_CM_SOLDIER_S                      = 31,
    EVENT_CM_SOLDIER_WC                     = 32,

    EVENT_CM_CAPTAIN_D                      = 40,
    EVENT_CM_CAPTAIN_HC                     = 41,

    EVENT_JB_ACID_BREATH                    = 50,
    EVENT_JB_SWEEP                          = 51,

    EVENT_IR_GUARD_IMPALE                   = 60,
    EVENT_IR_GUARD_WHIRL                    = 61,

    EVENT_RC_RUNIC_BARRIER                  = 70,
    EVENT_RC_SMASH                          = 71,
    EVENT_RC_RUNIC_SMASH                    = 72,
    EVENT_RC_RUNIC_SMASH_TRIGGER            = 73,
    EVENT_RC_CHARGE                         = 74,

    EVENT_ARG_RD                            = 80,
    EVENT_ARG_RF                            = 81,
    EVENT_ARG_STOMP                         = 82,
    EVENT_ARG_SPAWN                         = 83,

    EVENT_IH_GUARD_CLEAVE                   = 90,
    EVENT_IH_GUARD_HAMSTRING                = 91,
    EVENT_IH_GUARD_SHIELD_SMASH             = 92,

    EVENT_SIF_START_TALK                    = 100,
    EVENT_SIF_JOIN_TALK                     = 101,
    EVENT_SIF_FINISH_DOMINION               = 102,
    EVENT_SIF_FROSTBOLT_VALLEY              = 103,
    EVENT_SIF_BLIZZARD                      = 104,
    EVENT_SIF_FROST_NOVA_START              = 105,
    EVENT_SIF_FROST_NOVA_CAST               = 106,

    EVENT_DR_WARBRINGER_RS                  = 110,

    EVENT_DR_EVOKER_RL                      = 120,
    EVENT_DR_EVOKER_RM                      = 121,
    EVENT_DR_EVOKER_RS                      = 122,

    EVENT_DR_CHAMPION_WH                    = 130,
    EVENT_DR_CHAMPION_CH                    = 131,
    EVENT_DR_CHAMPION_MS                    = 132,

    EVENT_DR_COMMONER_PM                    = 140,
    EVENT_DR_COMMONER_LB                    = 141,
};

const Position ArenaNPCs[] =
{
    {2178.5f,  -300.2f,  441.97f, 2.5f},
    {2188.12f, -295.1f,  443.75,  2.5f},
    {2180.9f,  -286.8f,  433.3f,  2.49f},
    {2193.2f,  -280.6f,  443.14f, 2.79f},
    {2191.8f,  -270.2f,  438.3f,  3.0f},
    {2186.84f, -238.5f,  439.7f,  3.4f},
    {2166.3f,  -213.0f,  440.0f,  4.1f},
    {2100.5f,  -213.5f,  441.66f, 5.4f},
    {2091.0f,  -231.26f, 435.17f, 5.5f},
    {2083.2f,  -239.2f,  438.77f, 5.85f},
    {2081.54f, -253.27f, 434.67f, 6.19f},
    {2077.65f, -272.73f, 439.12f, 0.15f},
    {2084.36f, -282.12f, 435.87f, 0.24f},
    {2087.46f, -298.71f, 440.5f,  0.59f}
};

enum Texts
{
    // Thorim
    SAY_AGGRO_1                 = 0,
    SAY_AGGRO_2                 = 1,
    SAY_SPECIAL_1               = 2, // Unused
    SAY_SPECIAL_2               = 3,
    SAY_SPECIAL_3               = 4, // Unused
    SAY_JUMPDOWN                = 5,
    SAY_SLAY                    = 6,
    SAY_BERSERK                 = 7,
    SAY_WIPE                    = 8,
    SAY_DEATH                   = 9,
    SAY_END_NORMAL_1            = 10,
    SAY_END_NORMAL_2            = 11,
    SAY_END_NORMAL_3            = 12,
    SAY_END_HARD_1              = 13,
    SAY_END_HARD_2              = 14,
    SAY_END_HARD_3              = 15,

    // Sif
    SAY_SIF_AGGRO               = 0,
    SAY_SIF_HM_MISSED           = 1,
    SAY_SIF_HM_REACHED          = 2,

    // Ancient Rune Giant
    SAY_GIANT_RUNIC_MIGHT       = 0,

    // Runic Colossus
    SAY_COLOSSUS_RUNIC_BARRIER  = 0,
};

enum Misc
{
    ACTION_START_TRASH_DIED     = 1,
    ACTION_ALLOW_HIT            = 2,
    ACTION_SIF_JOIN_FIGHT       = 3,
    ACTION_SIF_START_TALK       = 4,
    ACTION_SIF_START_DOMINION   = 5,
    ACTION_SIF_TRANSFORM        = 6,
    ACTION_IRON_HONOR_DIED      = 7,

    EVENT_PHASE_START           = 1,
    EVENT_PHASE_RING            = 2,
    EVENT_PHASE_OUTRO           = 3,

    DATA_HIT_BY_LIGHTNING       = 1,
    DATA_LOSE_YOUR_ILLUSION     = 2,
};

const Position Middle = {2134.68f, -263.13f, 419.44f, M_PI * 1.5f};

const uint32 RollTable[3] = { 32877, 32878, 32876 };

class boss_thorim : public CreatureScript
{
public:
    boss_thorim() : CreatureScript("boss_thorim") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorimAI>(pCreature);
    }

    struct boss_thorimAI : public ScriptedAI
    {
        boss_thorimAI(Creature* pCreature) : ScriptedAI(pCreature), summons(me)
        {
            m_pInstance = pCreature->GetInstanceScript();
            if ((_encounterFinished = (!me->IsAlive())))
                if (m_pInstance)
                    m_pInstance->SetData(TYPE_THORIM, DONE);
        }

        bool _isArenaEmpty;
        bool _encounterFinished;
        bool _spawnCommoners;
        bool _hardMode;
        bool _isHitAllowed;
        bool _isAlly;
        uint8 _trashCounter;

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;

        bool _hitByLightning;

        void DisableThorim(bool apply)
        {
            if (apply)
            {
                me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_PACIFIED);
                me->DisableRotate(true);
                me->AddUnitState(UNIT_STATE_ROOT);
            }
            else
            {
                me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_PACIFIED);
                me->DisableRotate(false);
                me->ClearUnitState(UNIT_STATE_ROOT);
                me->resetAttackTimer(BASE_ATTACK);
            }
        }

        GameObject* GetThorimObject(uint32 entry)
        {
            if (m_pInstance)
                return ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(entry));
            return nullptr;
        }

        void JustSummoned(Creature* cr) override { summons.Summon(cr); }

        void SpawnAllNPCs()
        {
            // Jormungar Behemoth 32882
            me->SummonCreature(NPC_JORMUNGAR_BEHEMOT, 2149.68f, -263.477f, 419.679f, 3.12102f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

            // Captured Mercenary Soldier 32885
            me->SummonCreature(_isAlly ? NPC_CAPTURED_MERCENARY_SOLDIER_ALLY : NPC_CAPTURED_MERCENARY_SOLDIER_HORDE, 2127.24f, -251.309f, 419.793f, 5.89921f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
            me->SummonCreature(_isAlly ? NPC_CAPTURED_MERCENARY_SOLDIER_ALLY : NPC_CAPTURED_MERCENARY_SOLDIER_HORDE, 2120.1f, -258.99f, 419.764f, 6.24828f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
            me->SummonCreature(_isAlly ? NPC_CAPTURED_MERCENARY_SOLDIER_ALLY : NPC_CAPTURED_MERCENARY_SOLDIER_HORDE, 2123.32f, -254.771f, 419.789f, 6.17846f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

            // Captured Mercenary Captain 32908
            me->SummonCreature(_isAlly ? NPC_CAPTURED_MERCENARY_CAPTAIN_ALLY : NPC_CAPTURED_MERCENARY_CAPTAIN_HORDE, 2131.31f, -259.182f, 419.974f, 5.91667f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

            // Dark Rune Acolyte (arena) 32886
            me->SummonCreature(NPC_DARK_RUNE_ACOLYTE_I, 2129.09f, -277.142f, 419.756f, 1.22173f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

            // Iron Ring Guard 32874
            me->SummonCreature(NPC_IRON_RING_GUARD, 2217.69f, -337.394f, 412.177f, 1.23918f);
            me->SummonCreature(NPC_IRON_RING_GUARD, 2218.38f, -297.505f, 412.176f, 1.02974f);
            me->SummonCreature(NPC_IRON_RING_GUARD, 2235.26f, -338.345f, 412.134f, 1.58979f);
            me->SummonCreature(NPC_IRON_RING_GUARD, 2235.07f, -297.985f, 412.134f, 1.61336f);

            // Dark Rune Acolyte (gauntlet) 33110
            me->SummonCreature(NPC_DARK_RUNE_ACOLYTE_G, 2198.29f, -436.92f, 419.985f, 0.261799f);
            me->SummonCreature(NPC_DARK_RUNE_ACOLYTE_G, 2227.58f, -308.303f, 412.134f, 1.59372f);
            me->SummonCreature(NPC_DARK_RUNE_ACOLYTE_G, 2227.47f, -345.375f, 412.134f, 1.56622f);

            // Iron Honor Guard 32875
            me->SummonCreature(NPC_IRON_HONOR_GUARD, 2198.05f, -428.769f, 419.985f, 6.05629f);
            me->SummonCreature(NPC_IRON_HONOR_GUARD, 2220.31f, -436.22f, 412.26f, 1.06465f);

            // Runic Colossus 32872
            me->SummonCreature(NPC_RUNIC_COLOSSUS, 2227.5f, -396.179f, 412.176f, 1.79769f);

            // Ancient Rune Giant 32873
            me->SummonCreature(NPC_ANCIENT_RUNE_GIANT, 2134.57f, -440.318f, 438.331f, 0.226893f);

            // Sif 33196
            me->SummonCreature(NPC_SIF, 2147.86f, -301.2f, 438.246f, 2.488f);
        }

        void CloseDoors()
        {
            GameObject* go;
            if ((go = GetThorimObject(DATA_THORIM_LEVER)))
            {
                go->ReplaceAllGameObjectFlags((GameObjectFlags)48);
                go->SetGoState(GO_STATE_READY);
            }
            if ((go = GetThorimObject(DATA_THORIM_FIRST_DOORS)))
                go->SetGoState(GO_STATE_READY);

            if ((go = GetThorimObject(DATA_THORIM_SECOND_DOORS)))
                go->SetGoState(GO_STATE_READY);

            if ((go = GetThorimObject(DATA_THORIM_FENCE)))
                go->SetGoState(GO_STATE_ACTIVE);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            DisableThorim(false);
            CreatureAI::EnterEvadeMode(why);
        }

        void Reset() override
        {
            if (m_pInstance && !_encounterFinished)
                m_pInstance->SetData(TYPE_THORIM, NOT_STARTED);

            events.Reset();
            events.SetPhase(0);
            summons.DespawnAll();

            _trashCounter = 0;
            _isAlly = true;
            _isHitAllowed = false;
            _spawnCommoners = false;
            _hardMode = false;
            _isArenaEmpty = false;
            _hitByLightning = false;

            if (Player* t = SelectTargetFromPlayerList(1000))
                if (t->GetTeamId() == TEAM_HORDE)
                    _isAlly = false;

            SpawnAllNPCs();

            CloseDoors();
            DisableThorim(false);
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_HIT_BY_LIGHTNING)
                return !_hitByLightning;
            if (param == DATA_LOSE_YOUR_ILLUSION)
                return _hardMode;

            return 0;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_START_TRASH_DIED)
            {
                _trashCounter++;
                // activate levar
                if (_trashCounter >= 6)
                {
                    if (GameObject* go = GetThorimObject(DATA_THORIM_LEVER))
                        go->RemoveGameObjectFlag((GameObjectFlags)48);

                    events.ScheduleEvent(EVENT_THORIM_AGGRO, 0ms);
                    events.SetPhase(EVENT_PHASE_START);
                    events.ScheduleEvent(EVENT_THORIM_START_PHASE1, 20s);
                    _trashCounter = 0;
                }
            }
            else if (param == ACTION_ALLOW_HIT)
                _isHitAllowed = true;
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustReachedHome() override { me->setActive(false); }

        void JustEngagedWith(Unit*) override
        {
            if (m_pInstance && !_encounterFinished)
                m_pInstance->SetData(TYPE_THORIM, IN_PROGRESS);
            me->setActive(true);
            DisableThorim(true);
            me->CastSpell(me, SPELL_SHEATH_OF_LIGHTNING, true);
            //me->CastSpell(me, SPELL_TOUCH_OF_DOMINION, true);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (who && _isHitAllowed && who->GetPositionZ() > 430 && who->GetTypeId() == TYPEID_PLAYER)
            {
                _isHitAllowed = false;
                DisableThorim(false);

                events.SetPhase(EVENT_PHASE_RING);
                events.ScheduleEvent(EVENT_THORIM_UNBALANCING_STRIKE, 8s, 0, EVENT_PHASE_RING);
                events.ScheduleEvent(EVENT_THORIM_LIGHTNING_CHARGE, 12s + 500ms, 0, EVENT_PHASE_RING);
                events.ScheduleEvent(EVENT_THORIM_CHAIN_LIGHTNING, 13s, 0, EVENT_PHASE_RING);
                events.ScheduleEvent(EVENT_THORIM_BERSERK, 5min, 0, EVENT_PHASE_RING);

                me->GetMotionMaster()->MoveChase(me->GetVictim());
                me->GetMotionMaster()->MoveJump(Middle.GetPositionX(), Middle.GetPositionY(), Middle.GetPositionZ(), 20, 20);
                me->RemoveAura(SPELL_SHEATH_OF_LIGHTNING);

                Talk(SAY_JUMPDOWN);

                // Hard Mode
                if (!me->HasAura(62565 /*TOUCH OF DOMINION TRIGGER*/))
                {
                    if (m_pInstance)
                        m_pInstance->DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 64980 /*SIFFED ACHIEVEMENT*/);

                    _hardMode = true;
                    EntryCheckPredicate pred(NPC_SIF);
                    summons.DoAction(ACTION_SIF_JOIN_FIGHT, pred);
                }

                DoResetThreatList();
                if (Player* player = GetArenaPlayer())
                    me->AddThreat(player, 1000.0f);
            }

            if (damage >= me->GetHealth())
            {
                damage = 0;
                if (!_encounterFinished)
                {
                    _encounterFinished = true;
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    me->SetFaction(FACTION_FRIENDLY);
                    me->SetHealth(me->GetMaxHealth());
                    me->CombatStop();
                    me->RemoveAllAuras();
                    events.Reset();
                    DisableThorim(true);

                    Talk(SAY_DEATH);

                    events.SetPhase(EVENT_PHASE_OUTRO);
                    events.ScheduleEvent(EVENT_THORIM_OUTRO1, 2s, 0, EVENT_PHASE_OUTRO);

                    GameObject* go = nullptr;
                    if ((go = GetThorimObject(DATA_THORIM_FENCE)))
                        go->SetGoState(GO_STATE_ACTIVE);

                    uint32 chestId = me->GetMap()->Is25ManRaid() ? GO_THORIM_CHEST_HERO : GO_THORIM_CHEST;
                    if (_hardMode)
                        chestId += 1; // hard mode offset

                    if ((go = me->SummonGameObject(chestId, 2134.73f, -286.32f, 419.51f, 4.65f, 0, 0, 0, 0, 0)))
                    {
                        go->ReplaceAllGameObjectFlags((GameObjectFlags)0);
                        go->SetLootRecipient(me->GetMap());
                    }

                    // Defeat credit
                    if (m_pInstance)
                    {
                        me->CastSpell(me, 64985, true); // credit
                        m_pInstance->SetData(TYPE_THORIM, DONE);
                    }
                }
            }
        }

        void SpawnArenaNPCs()
        {
            Creature* cr;
            uint8 rnd;
            if (_spawnCommoners || urand(0, 2))
                _spawnCommoners = !_spawnCommoners;

            for (uint8 i = 0; i < (_spawnCommoners ? 7 : 2); ++i)
            {
                rnd = urand(0, 13);
                if ((cr = me->SummonCreature((_spawnCommoners ? NPC_DARK_RUNE_COMMONER : RollTable[urand(0, 2)]), ArenaNPCs[rnd], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000)))
                    cr->GetMotionMaster()->MoveJump(
                        Middle.GetPositionX() + urand(19, 24) * cos(Middle.GetAngle(cr)),
                        Middle.GetPositionY() + urand(19, 24) * std::sin(Middle.GetAngle(cr)),
                        Middle.GetPositionZ(), 20, 20);
            }
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_LIGHTNING_ORB_CHARGER)
            {
                me->SetOrientation(me->GetAngle(caster));
                me->CastSpell(caster, SPELL_LIGHTNING_CHARGE_DAMAGE, true);
                me->CastSpell(me, SPELL_LIGHTNING_CHARGE_BUFF, true);
                events.RescheduleEvent(EVENT_THORIM_LIGHTNING_CHARGE, 10s, 0, EVENT_PHASE_RING);
            }
            else if (spellInfo->Id == SPELL_TELEPORT)
            {
                me->DespawnOrUnsummon();
                m_pInstance->SetData(EVENT_KEEPER_TELEPORTED, DONE);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_LIGHTNING_CHARGE_DAMAGE && target->GetTypeId() == TYPEID_PLAYER)
                _hitByLightning = true;
        }

        Player* GetArenaPlayer()
        {
            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
                if (Player* p = itr->GetSource())
                    if (p->GetPositionX() > 2085 && p->GetPositionX() < 2185 && p->GetPositionY() < -214 && p->GetPositionY() > -305 && p->IsAlive() && p->GetPositionZ() < 425)
                        return p;
            return nullptr;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!_encounterFinished && !UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_THORIM_AGGRO:
                    Talk(SAY_AGGRO_1);
                    events.ScheduleEvent(EVENT_THORIM_AGGRO2, 9s);

                    if (GameObject* go = GetThorimObject(DATA_THORIM_FENCE))
                        go->SetGoState(GO_STATE_READY);

                    break;
                case EVENT_THORIM_AGGRO2:
                    {
                        Talk(SAY_AGGRO_2);

                        EntryCheckPredicate pred(NPC_SIF);
                        summons.DoAction(ACTION_SIF_START_TALK, pred);
                        break;
                    }
                case EVENT_THORIM_START_PHASE1:
                    {
                        events.ScheduleEvent(EVENT_THORIM_STORMHAMMER, 8s, 0, EVENT_PHASE_START);
                        events.ScheduleEvent(EVENT_THORIM_CHARGE_ORB, 14s, 0, EVENT_PHASE_START);
                        events.ScheduleEvent(EVENT_THORIM_FILL_ARENA, 0ms, 0, EVENT_PHASE_START);
                        events.ScheduleEvent(EVENT_THORIM_LIGHTNING_ORB, 5s, 0, EVENT_PHASE_START); // checked every 5 secs if there are players on arena
                        events.ScheduleEvent(EVENT_THORIM_NOT_REACH_IN_TIME, 5min, 0, EVENT_PHASE_START);

                        EntryCheckPredicate pred(NPC_SIF);
                        summons.DoAction(ACTION_SIF_START_DOMINION, pred);
                        break;
                    }
                case EVENT_THORIM_STORMHAMMER:
                    me->CastCustomSpell(SPELL_STORMHAMMER, SPELLVALUE_MAX_TARGETS, 1, me->GetVictim(), false);
                    events.Repeat(16s);
                    break;
                case EVENT_THORIM_CHARGE_ORB:
                    me->CastCustomSpell(SPELL_CHARGE_ORB, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.Repeat(16s);
                    break;
                case EVENT_THORIM_LIGHTNING_ORB:
                    {
                        if (GetArenaPlayer())
                        {
                            // Player found, repeat and return
                            events.Repeat(5s);
                            return;
                        }

                        // No players found
                        Talk(SAY_WIPE);
                        me->SummonCreature(NPC_LIGHTNING_ORB, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());

                        _isArenaEmpty = true;
                        events.CancelEvent(EVENT_THORIM_NOT_REACH_IN_TIME);
                        break;
                    }
                case EVENT_THORIM_NOT_REACH_IN_TIME:
                    _isArenaEmpty = true;
                    events.CancelEvent(EVENT_THORIM_LIGHTNING_ORB);
                    me->CastSpell(me, SPELL_BERSERK_FRIENDS, true);
                    me->SummonCreature(NPC_LIGHTNING_ORB, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());
                    break;
                case EVENT_THORIM_FILL_ARENA:
                    SpawnArenaNPCs();
                    events.Repeat(10s);
                    break;
                case EVENT_THORIM_UNBALANCING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_UNBALANCING_STRIKE, false);
                    events.Repeat(20s);
                    break;
                case EVENT_THORIM_LIGHTNING_CHARGE:
                    me->CastSpell(me, SPELL_LIGHTNING_PILLAR_P2, true);
                    break;
                case EVENT_THORIM_CHAIN_LIGHTNING:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_CHAIN_LIGHTNING, false);
                    events.Repeat(15s);
                    break;
                case EVENT_THORIM_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    Talk(SAY_BERSERK);
                    break;
                case EVENT_THORIM_OUTRO1:
                    if (_hardMode)
                    {
                        Talk(SAY_END_HARD_1);
                        events.ScheduleEvent(EVENT_THORIM_OUTRO2, 5s, 0, 3);
                        EntryCheckPredicate pred(NPC_SIF);
                        summons.DoAction(ACTION_SIF_TRANSFORM, pred);
                    }
                    else
                    {
                        Talk(SAY_END_NORMAL_1);
                        events.ScheduleEvent(EVENT_THORIM_OUTRO2, 9s, 0, 3);
                    }
                    break;
                case EVENT_THORIM_OUTRO2:
                    if (_hardMode)
                    {
                        Talk(SAY_END_HARD_2);
                        events.ScheduleEvent(EVENT_THORIM_OUTRO3, 12s, 0, 3);
                    }
                    else
                    {
                        Talk(SAY_END_NORMAL_2);
                        events.ScheduleEvent(EVENT_THORIM_OUTRO3, 10s, 0, 3);
                    }
                    break;
                case EVENT_THORIM_OUTRO3:
                    if (_hardMode)
                    {
                        Talk(SAY_END_HARD_3);
                    }
                    else
                    {
                        Talk(SAY_END_NORMAL_3);
                    }
                    // Defeat credit
                    if (m_pInstance)
                        m_pInstance->SetData(TYPE_THORIM, DONE);
                    events.ScheduleEvent(EVENT_THORIM_OUTRO4, 14s, 0, 3);
                    break;
                case EVENT_THORIM_OUTRO4:
                    DoCastSelf(SPELL_TELEPORT);
                    break;
            }

            if (!_encounterFinished)
                DoMeleeAttackIfReady();
        }
    };
};

class boss_thorim_sif : public CreatureScript
{
public:
    boss_thorim_sif() : CreatureScript("boss_thorim_sif") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_sifAI>(pCreature);
    }

    struct boss_thorim_sifAI : public ScriptedAI
    {
        boss_thorim_sifAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        void MoveInLineOfSight(Unit*) override {}
        void AttackStart(Unit*) override {}

        bool _allowCast;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            me->SetReactState(REACT_PASSIVE);
            _allowCast = false;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_SIF_START_TALK)
                events.ScheduleEvent(EVENT_SIF_START_TALK, 9s);
            else if (param == ACTION_SIF_START_DOMINION)
            {
                if (me->GetInstanceScript())
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_THORIM)))
                        me->CastSpell(cr, SPELL_TOUCH_OF_DOMINION, false);

                events.ScheduleEvent(EVENT_SIF_FINISH_DOMINION, 150s);
            }
            else if (param == ACTION_SIF_JOIN_FIGHT)
            {
                me->InterruptNonMeleeSpells(false);
                events.ScheduleEvent(EVENT_SIF_JOIN_TALK, 9s);
                events.CancelEvent(EVENT_SIF_START_TALK);
                events.CancelEvent(EVENT_SIF_FINISH_DOMINION);
            }
            else if (param == ACTION_SIF_TRANSFORM)
            {
                me->CastSpell(me, SPELL_SIF_TRANSFORM, true);
                me->DespawnOrUnsummon(5000);
                events.Reset();
                _allowCast = false;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SIF_FINISH_DOMINION:
                    Talk(SAY_SIF_HM_MISSED);
                    me->DespawnOrUnsummon(5000);
                    break;
                case EVENT_SIF_START_TALK:
                    Talk(SAY_SIF_AGGRO);
                    break;
                case EVENT_SIF_JOIN_TALK:
                    Talk(SAY_SIF_HM_REACHED);
                    events.ScheduleEvent(EVENT_SIF_FROST_NOVA_START, 1s);
                    events.ScheduleEvent(EVENT_SIF_FROSTBOLT_VALLEY, 11s);
                    events.ScheduleEvent(EVENT_SIF_BLIZZARD, 15s);
                    break;
                case EVENT_SIF_FROSTBOLT_VALLEY:
                    me->CastSpell(me, SPELL_FROSTBOLT_VALLEY, false);
                    events.Repeat(13s);
                    return;
                case EVENT_SIF_BLIZZARD:
                    me->SummonCreature(NPC_SIF_BLIZZARD, 2108.7f, -280.04f, 419.42f, 0, TEMPSUMMON_TIMED_DESPAWN, 30000);
                    events.Repeat(30s);
                    return;
                case EVENT_SIF_FROST_NOVA_START:
                    me->NearTeleportTo(2108 + urand(0, 42), -238 - irand(0, 46), 420.02f, me->GetAngle(&Middle));
                    events.Repeat(20s);
                    events.DelayEvents(5s);
                    events.ScheduleEvent(EVENT_SIF_FROST_NOVA_CAST, 2500ms);
                    _allowCast = false;
                    return;
                case EVENT_SIF_FROST_NOVA_CAST:
                    _allowCast = true;
                    me->CastSpell(me, SPELL_FROST_NOVA, false);
                    return;
            }

            // has casting check before event select (return in events)
            if (_allowCast)
                if (Player* target = SelectTargetFromPlayerList(70))
                {
                    me->CastSpell(target, SPELL_FROSTBOLT, false);
                    me->StopMoving();
                }
        }
    };
};

class boss_thorim_lightning_orb : public CreatureScript
{
public:
    boss_thorim_lightning_orb() : CreatureScript("boss_thorim_lightning_orb") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_lightning_orbAI>(pCreature);
    }

    struct boss_thorim_lightning_orbAI : public npc_escortAI
    {
        boss_thorim_lightning_orbAI(Creature* pCreature) : npc_escortAI(pCreature)
        {
            InitWaypoint();
            Reset();
            Start(false, true);
        }

        uint32 Timer;

        void EnterEvadeMode(EvadeReason /*why*/) override {}
        void MoveInLineOfSight(Unit*) override {}
        void AttackStart(Unit*) override {}

        void InitWaypoint()
        {
            AddWaypoint(1, 2135, -304, 438.24f, 0);
            AddWaypoint(2, 2132, -441, 438.24f, 0);
            AddWaypoint(3, 2167, -442, 438.24f, 0);
            AddWaypoint(4, 2227, -432, 412.18f, 0);
            AddWaypoint(5, 2227, -263, 412.17f, 0);
            AddWaypoint(6, 2179, -262, 414.7f, 0);
            AddWaypoint(7, 2169, -261, 419.3f, 0);
            AddWaypoint(8, 2110, -251, 419.42f, 0);
        }

        void Reset() override
        {
            me->CastSpell(me, SPELL_LIGHTNING_DESTRUCTION, true);
        }

        void WaypointReached(uint32  /*point*/) override
        {
        }
    };
};

class boss_thorim_trap : public CreatureScript
{
public:
    boss_thorim_trap() : CreatureScript("boss_thorim_trap") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_trapAI>(pCreature);
    }

    struct boss_thorim_trapAI : public NullCreatureAI
    {
        boss_thorim_trapAI(Creature* pCreature) : NullCreatureAI(pCreature) { }

        uint32 _checkTimer;

        void Reset() override { _checkTimer = 1; }
        void UpdateAI(uint32 diff) override
        {
            if (_checkTimer)
            {
                _checkTimer += diff;
                if ((_checkTimer >= 1000 && _checkTimer < 10000) || _checkTimer >= 60000)
                {
                    if (me->SelectNearbyTarget(nullptr, 12.0f))
                    {
                        me->CastSpell(me, SPELL_LIGHTNING_FIELD, true);
                        me->CastSpell(me, (me->GetEntry() == 33054 /*NPC_THORIM_TRAP_BUNNY*/ ? SPELL_PARALYTIC_FIELD_FIRST : SPELL_PARALYTIC_FIELD_SECOND), true);
                        _checkTimer = 10000;
                        return;
                    }
                    _checkTimer = 1;
                }
            }
        }
    };
};

class boss_thorim_sif_blizzard : public CreatureScript
{
public:
    boss_thorim_sif_blizzard() : CreatureScript("boss_thorim_sif_blizzard") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_sif_blizzardAI>(pCreature);
    }

    struct boss_thorim_sif_blizzardAI : public npc_escortAI
    {
        boss_thorim_sif_blizzardAI(Creature* pCreature) : npc_escortAI(pCreature)
        {
            InitWaypoint();
            Reset();
            Start(false, true);
            SetDespawnAtEnd(false);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}
        void JustEngagedWith(Unit* /*who*/) override {}
        void AttackStart(Unit* /*who*/) override {}

        void InitWaypoint()
        {
            AddWaypoint(1, 2104.6f, -268.5f, 419.4f, 0);
            AddWaypoint(2, 2104.3f, -256.3f, 419.4f, 0);
            AddWaypoint(3, 2109.3f, -246.4f, 419.4f, 0);
            AddWaypoint(4, 2117.9f, -238.6f, 419.4f, 0);
            AddWaypoint(5, 2128.8f, -232.1f, 419.4f, 0);
            AddWaypoint(6, 2151.9f, -237.5f, 419.4f, 0);
            AddWaypoint(7, 2164.9f, -256.3f, 419.4f, 0);
            AddWaypoint(8, 2161.5f, -280.0f, 419.4f, 0);
        }

        void Reset() override
        {
            me->SetSpeed(MOVE_RUN, 1);
            me->SetSpeed(MOVE_WALK, 1);
            me->CastSpell(me, RAID_MODE(SPELL_BLIZZARD_10, SPELL_BLIZZARD_25), true);
        }

        void WaypointReached(uint32  /*point*/) override
        {
        }
    };
};

class boss_thorim_pillar : public CreatureScript
{
public:
    boss_thorim_pillar() : CreatureScript("boss_thorim_pillar") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_pillarAI>(pCreature);
    }

    struct boss_thorim_pillarAI : public NullCreatureAI
    {
        boss_thorim_pillarAI(Creature* pCreature) : NullCreatureAI(pCreature) { }

        uint32 _resetTimer;

        void Reset() override
        {
            _resetTimer = 0;
            me->SetControlled(true, UNIT_STATE_STUNNED);
            me->SetDisableGravity(true);
        }

        void SpellHit(Unit*, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_CHARGE_ORB)
                me->CastSpell(me, SPELL_LIGHTNING_PILLAR_P1, true);
            else if (spellInfo->Id == SPELL_LIGHTNING_PILLAR_P2)
            {
                if (Creature* cr = me->FindNearestCreature(NPC_THUNDER_ORB, 100))
                    cr->CastSpell(cr, SPELL_LIGHTNING_ORB_VISUAL, true);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _resetTimer += diff;
            if (_resetTimer >= 10000)
                Reset(); // _resetTimer set to 0
        }
    };
};

class boss_thorim_start_npcs : public CreatureScript
{
public:
    boss_thorim_start_npcs() : CreatureScript("boss_thorim_start_npcs") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_start_npcsAI>(pCreature);
    }

    struct boss_thorim_start_npcsAI : public ScriptedAI
    {
        boss_thorim_start_npcsAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        EventMap events;
        bool _isCaster;
        bool _playerAttack;

        void Reset() override
        {
            events.Reset();
            _isCaster = (me->GetEntry() == NPC_DARK_RUNE_ACOLYTE_I);
            _playerAttack = false;
            if (me->GetEntry() != NPC_JORMUNGAR_BEHEMOT)
                if (Creature* cr = me->FindNearestCreature(NPC_JORMUNGAR_BEHEMOT, 30.0f))
                    AttackStart(cr);
        }

        void DamageTaken(Unit* who, uint32&, DamageEffectType, SpellSchoolMask) override
        {
            if (!_playerAttack && who && (who->GetTypeId() == TYPEID_PLAYER || who->GetOwnerGUID().IsPlayer()))
            {
                if (me->GetInstanceScript())
                    if (Creature* thorim = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_THORIM)))
                    {
                        if (!thorim->IsInCombat())
                        {
                            thorim->SetInCombatWithZone();
                            thorim->AI()->AttackStart(who);
                        }
                    }
                _playerAttack = true;
                me->GetThreatMgr().ResetAllThreat();
                me->CallForHelp(40.0f);
                AttackStart(who);
            }

            if (!_playerAttack && me->HealthBelowPct(60))
                me->SetHealth(me->GetMaxHealth());
        }

        void JustDied(Unit*) override
        {
            if (me->GetInstanceScript())
                if (Creature* thorim = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_THORIM)))
                    thorim->AI()->DoAction(ACTION_START_TRASH_DIED);
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            if (me->GetEntry() == NPC_DARK_RUNE_ACOLYTE_I)
            {
                events.ScheduleEvent(EVENT_DR_ACOLYTE_GH, 10s);
                events.ScheduleEvent(EVENT_DR_ACOLYTE_HS, 5s);
                events.ScheduleEvent(EVENT_DR_ACOLYTE_R, 7s);
            }
            else if (me->GetEntry() == NPC_CAPTURED_MERCENARY_SOLDIER_ALLY || me->GetEntry() == NPC_CAPTURED_MERCENARY_SOLDIER_HORDE)
            {
                events.ScheduleEvent(EVENT_CM_SOLDIER_BS, 9s);
                events.ScheduleEvent(EVENT_CM_SOLDIER_WC, 5s);
                events.ScheduleEvent(EVENT_CM_SOLDIER_S, 0ms);
            }
            else if (me->GetEntry() == NPC_CAPTURED_MERCENARY_CAPTAIN_ALLY || me->GetEntry() == NPC_CAPTURED_MERCENARY_CAPTAIN_HORDE)
            {
                events.ScheduleEvent(EVENT_CM_CAPTAIN_D, 9s);
                events.ScheduleEvent(EVENT_CM_CAPTAIN_HC, 5s);
            }
            else if (me->GetEntry() == NPC_JORMUNGAR_BEHEMOT)
            {
                events.ScheduleEvent(EVENT_JB_ACID_BREATH, 12s);
                events.ScheduleEvent(EVENT_JB_SWEEP, 5s);
            }

            me->CallForHelp(10);
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
                case EVENT_DR_ACOLYTE_GH:
                    if (HealthBelowPct(60))
                        me->CastSpell(me, SPELL_GREATER_HEAL, false);
                    else if (Unit* target = DoSelectLowestHpFriendly(60.0f, 20))
                        me->CastSpell(target, SPELL_GREATER_HEAL, false);
                    events.Repeat(10s);
                    break;
                case EVENT_DR_ACOLYTE_HS:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_HOLY_SMITE, false);
                    events.Repeat(1600ms);
                    break;
                case EVENT_DR_ACOLYTE_R:
                    if (HealthBelowPct(75) && !me->HasAura(SPELL_RENEW))
                        me->CastSpell(me, SPELL_GREATER_HEAL, false);
                    else if (Unit* target = DoSelectLowestHpFriendly(60.0f, 10))
                        me->CastSpell(target, SPELL_RENEW, false);
                    events.Repeat(7s);
                    break;
                case EVENT_CM_SOLDIER_BS:
                    me->CastSpell(me->GetVictim(), SPELL_BARBED_SHOT, false);
                    events.Repeat(9s);
                    break;
                case EVENT_CM_SOLDIER_WC:
                    me->CastSpell(me->GetVictim(), SPELL_WING_CLIP, false);
                    events.Repeat(5s);
                    break;
                case EVENT_CM_SOLDIER_S:
                    if (me->GetDistance(me->GetVictim()) > 8)
                        me->CastSpell(me->GetVictim(), SPELL_SHOOT, false);

                    events.Repeat(1500ms);
                    break;
                case EVENT_CM_CAPTAIN_D:
                    me->CastSpell(me->GetVictim(), SPELL_DEVASTATE, false);
                    events.Repeat(9s);
                    break;
                case EVENT_CM_CAPTAIN_HC:
                    me->CastSpell(me->GetVictim(), SPELL_HEROIC_STRIKE, false);
                    events.Repeat(5s);
                    break;
                case EVENT_JB_ACID_BREATH:
                    me->CastSpell(me->GetVictim(), SPELL_ACID_BREATH, false);
                    events.Repeat(12s);
                    break;
                case EVENT_JB_SWEEP:
                    me->CastSpell(me->GetVictim(), SPELL_SWEEP, false);
                    events.Repeat(5s);
                    break;
            }

            if (!_isCaster || (me->GetPower(POWER_MANA) * 100 / me->GetMaxPower(POWER_MANA) < 10))
                DoMeleeAttackIfReady();
        }
    };
};

class boss_thorim_gauntlet_npcs : public CreatureScript
{
public:
    boss_thorim_gauntlet_npcs() : CreatureScript("boss_thorim_gauntlet_npcs") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_gauntlet_npcsAI>(pCreature);
    }

    struct boss_thorim_gauntlet_npcsAI : public ScriptedAI
    {
        boss_thorim_gauntlet_npcsAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        EventMap events;
        bool _isCaster;

        void Reset() override
        {
            events.Reset();
            _isCaster = (me->GetEntry() == NPC_DARK_RUNE_ACOLYTE_G);
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            if (me->GetEntry() == NPC_IRON_RING_GUARD)
            {
                events.ScheduleEvent(EVENT_IR_GUARD_IMPALE, 12s);
                events.ScheduleEvent(EVENT_IR_GUARD_WHIRL, 5s);
            }
            else if (me->GetEntry() == NPC_DARK_RUNE_ACOLYTE_I)
            {
                events.ScheduleEvent(EVENT_DR_ACOLYTE_GH, 10s);
                events.ScheduleEvent(EVENT_DR_ACOLYTE_HS, 5s);
                events.ScheduleEvent(EVENT_DR_ACOLYTE_R, 7s);
            }
            else if (me->GetEntry() == NPC_IRON_HONOR_GUARD)
            {
                events.ScheduleEvent(EVENT_IH_GUARD_CLEAVE, 6s);
                events.ScheduleEvent(EVENT_IH_GUARD_HAMSTRING, 9s);
                events.ScheduleEvent(EVENT_IH_GUARD_SHIELD_SMASH, 15s);

                if (Creature* runeGiant = me->FindNearestCreature(NPC_ANCIENT_RUNE_GIANT, 200.0f))
                    runeGiant->AI()->DoAction(ACTION_IRON_HONOR_DIED);
            }

            me->CallForHelp(25);
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
                case EVENT_IR_GUARD_IMPALE:
                    me->CastSpell(me->GetVictim(), SPELL_IMPALE, false);
                    events.Repeat(12s);
                    break;
                case EVENT_IR_GUARD_WHIRL:
                    me->CastSpell(me->GetVictim(), SPELL_WHIRLING_TRIP, false);
                    events.Repeat(5s);
                    break;
                case EVENT_DR_ACOLYTE_GH:
                    if (HealthBelowPct(60))
                        me->CastSpell(me, SPELL_GREATER_HEAL, false);
                    else if (Unit* target = DoSelectLowestHpFriendly(60.0f, 20))
                        me->CastSpell(target, SPELL_GREATER_HEAL, false);
                    events.Repeat(10s);
                    break;
                case EVENT_DR_ACOLYTE_HS:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_HOLY_SMITE, false);
                    events.Repeat(1600ms);
                    break;
                case EVENT_DR_ACOLYTE_R:
                    if (HealthBelowPct(75) && !me->HasAura(SPELL_RENEW))
                        me->CastSpell(me, SPELL_GREATER_HEAL, false);
                    else if (Unit* target = DoSelectLowestHpFriendly(60.0f, 10))
                        me->CastSpell(target, SPELL_RENEW, false);
                    events.Repeat(7s);
                    break;
                case EVENT_IH_GUARD_CLEAVE:
                    me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    events.Repeat(6s);
                    break;
                case EVENT_IH_GUARD_HAMSTRING:
                    me->CastSpell(me->GetVictim(), SPELL_HAMSTRING, false);
                    events.Repeat(9s);
                    break;
                case EVENT_IH_GUARD_SHIELD_SMASH:
                    me->CastSpell(me->GetVictim(), SPELL_SHIELD_SMASH, false);
                    events.Repeat(15s);
                    break;
            }

            if (!_isCaster || (me->GetPower(POWER_MANA) * 100 / me->GetMaxPower(POWER_MANA) < 10))
                DoMeleeAttackIfReady();
        }
    };
};

class boss_thorim_runic_colossus : public CreatureScript
{
public:
    boss_thorim_runic_colossus() : CreatureScript("boss_thorim_runic_colossus") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_runic_colossusAI>(pCreature);
    }

    struct boss_thorim_runic_colossusAI : public ScriptedAI
    {
        boss_thorim_runic_colossusAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        EventMap events;
        bool _leftHand;
        bool _checkTarget;
        float _nextTriggerPos;
        ObjectGuid _triggerLeftGUID[2], _triggerRightGUID[2];

        void Reset() override
        {
            _nextTriggerPos = 0.0f;
            _leftHand = false;
            _checkTarget = false;
            events.Reset();
            events.ScheduleEvent(EVENT_RC_RUNIC_SMASH, 0ms);
            Creature* c;

            if ((c = me->SummonCreature(33140, 2221, -385, me->GetPositionZ())))
                _triggerRightGUID[0] = c->GetGUID();
            if ((c = me->SummonCreature(33140, 2210, -385, me->GetPositionZ())))
                _triggerRightGUID[1] = c->GetGUID();

            if ((c = me->SummonCreature(33141, 2235, -385, me->GetPositionZ())))
                _triggerLeftGUID[0] = c->GetGUID();
            if ((c = me->SummonCreature(33141, 2246, -385, me->GetPositionZ())))
                _triggerLeftGUID[1] = c->GetGUID();
        }

        void JustDied(Unit*) override
        {
            if (me->GetInstanceScript())
            {
                if (GameObject* go = ObjectAccessor::GetGameObject(*me, me->GetInstanceScript()->GetGuidData(DATA_THORIM_FIRST_DOORS)))
                    go->SetGoState(GO_STATE_ACTIVE);

                if (Creature* cr = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_THORIM)))
                    cr->AI()->Talk(SAY_SPECIAL_2);
            }
        }

        void JustEngagedWith(Unit*) override
        {
            events.CancelEvent(EVENT_RC_RUNIC_SMASH);
            events.ScheduleEvent(EVENT_RC_RUNIC_BARRIER, 10s);
            events.ScheduleEvent(EVENT_RC_SMASH, 18s);
            events.ScheduleEvent(EVENT_RC_CHARGE, 15s);

            me->InterruptNonMeleeSpells(false);
            _checkTarget = true;
        }

        void SpellHit(Unit*, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_RUNIC_SMASH_LEFT || spellInfo->Id == SPELL_RUNIC_SMASH_RIGHT)
            {
                _leftHand = spellInfo->Id == SPELL_RUNIC_SMASH_LEFT;
                events.RescheduleEvent(EVENT_RC_RUNIC_SMASH_TRIGGER, 1s);
            }
        }

        void RunRunicSmash(bool cast)
        {
            if (Creature* cr = ObjectAccessor::GetCreature(*me, _leftHand ? _triggerLeftGUID[0] : _triggerRightGUID[0]) )
            {
                if (cast)
                    cr->CastSpell(cr, SPELL_RUNIC_SMASH_DAMAGE, true);
                cr->SetPosition(_leftHand ? 2235.0f : 2221.0f, _nextTriggerPos, cr->GetPositionZ(), 0.0f);
                cr->StopMovingOnCurrentPos();
            }
            if( Creature* cr = ObjectAccessor::GetCreature(*me, _leftHand ? _triggerLeftGUID[1] : _triggerRightGUID[1]) )
            {
                if (cast)
                    cr->CastSpell(cr, SPELL_RUNIC_SMASH_DAMAGE, true);
                cr->SetPosition(_leftHand ? 2246.0f : 2210.0f, _nextTriggerPos, cr->GetPositionZ(), 0.0f);
                cr->StopMovingOnCurrentPos();
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_checkTarget && !UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_RC_RUNIC_SMASH_TRIGGER:
                    _nextTriggerPos += 16.0f;
                    if (_nextTriggerPos <= -260.0f)
                    {
                        events.RescheduleEvent(EVENT_RC_RUNIC_SMASH_TRIGGER, 500ms);
                    }

                    RunRunicSmash(true);
                    break;
                case EVENT_RC_RUNIC_SMASH:
                    if (urand(0, 1))
                        me->CastSpell(me, SPELL_RUNIC_SMASH_LEFT, false);
                    else
                        me->CastSpell(me, SPELL_RUNIC_SMASH_RIGHT, false);

                    _nextTriggerPos = -385.0f;
                    RunRunicSmash(false);
                    events.Repeat(11s);
                    break;
                case EVENT_RC_RUNIC_BARRIER:
                    me->CastSpell(me, SPELL_RUNIC_BARRIER, false);
                    Talk(SAY_COLOSSUS_RUNIC_BARRIER);
                    events.Repeat(20s);
                    break;
                case EVENT_RC_SMASH:
                    me->CastSpell(me->GetVictim(), SPELL_SMASH, false);
                    events.Repeat(10s);
                    break;
                case EVENT_RC_CHARGE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_CHARGE, false);
                    events.Repeat(15s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_thorim_ancient_rune_giant : public CreatureScript
{
public:
    boss_thorim_ancient_rune_giant() : CreatureScript("boss_thorim_ancient_rune_giant") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_ancient_rune_giantAI>(pCreature);
    }

    struct boss_thorim_ancient_rune_giantAI : public ScriptedAI
    {
        boss_thorim_ancient_rune_giantAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        EventMap events;
        bool _isInCombat;

        void Reset() override
        {
            _isInCombat = false;
            events.Reset();
        }

        void JustEngagedWith(Unit*) override
        {
            _isInCombat = true;
            events.CancelEvent(EVENT_ARG_SPAWN);
            events.ScheduleEvent(EVENT_ARG_RD, 12s);
            events.ScheduleEvent(EVENT_ARG_STOMP, 8s);

            me->CastSpell(me, SPELL_RUNIC_FORTIFICATION, false);
            Talk(SAY_GIANT_RUNIC_MIGHT);
        }

        void JustDied(Unit*) override
        {
            if (InstanceScript* pInstance = me->GetInstanceScript())
            {
                if (GameObject* go = ObjectAccessor::GetGameObject(*me, pInstance->GetGuidData(DATA_THORIM_SECOND_DOORS)))
                    go->SetGoState(GO_STATE_ACTIVE);

                if (Creature* thorim = ObjectAccessor::GetCreature(*me, pInstance->GetGuidData(TYPE_THORIM)))
                    thorim->AI()->DoAction(ACTION_ALLOW_HIT);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_IRON_HONOR_DIED)
                events.RescheduleEvent(EVENT_ARG_SPAWN, 20s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (_isInCombat && !UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_ARG_RD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_RUNE_DETONATION, false);
                    events.Repeat(12s);
                    break;
                case EVENT_ARG_STOMP:
                    me->CastSpell(me->GetVictim(), SPELL_STOMP, false);
                    events.Repeat(8s);
                    break;
                case EVENT_ARG_SPAWN:
                    if (Creature* cr = me->SummonCreature(NPC_IRON_HONOR_GUARD, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 20000))
                        if (Unit* target = SelectTargetFromPlayerList(150.0f))
                            cr->AI()->AttackStart(target);
                    events.Repeat(10s);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_thorim_arena_npcs : public CreatureScript
{
public:
    boss_thorim_arena_npcs() : CreatureScript("boss_thorim_arena_npcs") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_thorim_arena_npcsAI>(pCreature);
    }

    struct boss_thorim_arena_npcsAI : public ScriptedAI
    {
        boss_thorim_arena_npcsAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        EventMap events;
        bool _isCaster;

        void Reset() override
        {
            _isCaster = (me->GetEntry() == NPC_DARK_RUNE_EVOKER);
            events.Reset();
            if (me->GetEntry() == NPC_DARK_RUNE_WARBRINGER)
                me->CastSpell(me, SPELL_AURA_OF_CELERITY, true);
        }

        void JustEngagedWith(Unit*) override
        {
            if (me->GetEntry() == NPC_DARK_RUNE_WARBRINGER)
            {
                events.ScheduleEvent(EVENT_DR_WARBRINGER_RS, 8s);
            }
            else if (me->GetEntry() == NPC_DARK_RUNE_EVOKER)
            {
                events.ScheduleEvent(EVENT_DR_EVOKER_RL, 2500ms);
                events.ScheduleEvent(EVENT_DR_EVOKER_RM, 4s);
                events.ScheduleEvent(EVENT_DR_EVOKER_RS, 10s);
            }
            else if (me->GetEntry() == NPC_DARK_RUNE_CHAMPION)
            {
                events.ScheduleEvent(EVENT_DR_CHAMPION_WH, 6s);
                events.ScheduleEvent(EVENT_DR_CHAMPION_CH, 12s);
                events.ScheduleEvent(EVENT_DR_CHAMPION_MS, 8s);
            }
            else if (me->GetEntry() == NPC_DARK_RUNE_COMMONER)
            {
                events.ScheduleEvent(EVENT_DR_COMMONER_LB, 5s);
                events.ScheduleEvent(EVENT_DR_COMMONER_PM, 6s);
            }
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetPositionX() < 2180 && target->GetPositionZ() < 425;
        }

        bool SelectT()
        {
            Player* target = nullptr;
            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            uint8 num = urand(0, pList.getSize() - 1);
            uint8 count = 0;
            for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr, ++count)
            {
                if (itr->GetSource()->GetPositionX() > 2180 || !itr->GetSource()->IsAlive() || itr->GetSource()->GetPositionZ() > 425)
                    continue;

                if (count <= num || !target)
                    target = itr->GetSource();
                else
                    break;
            }

            if (target)
            {
                AttackStart(target);
                me->AddThreat(target, 500.0f);
                if (me->GetEntry() == NPC_DARK_RUNE_EVOKER && urand(0, 1))
                    me->CastSpell(me, SPELL_RUNIC_SHIELD, false);
                else if (me->GetEntry() == NPC_DARK_RUNE_CHAMPION && !urand(0, 2))
                    me->CastSpell(target, SPELL_CHARGE, false);
                return true;
            }
            return false;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() && !SelectT())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_DR_WARBRINGER_RS:
                    me->CastSpell(me->GetVictim(), SPELL_RUNIC_STRIKE, false);
                    events.Repeat(8s);
                    break;
                case EVENT_DR_EVOKER_RL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_RUNIC_LIGHTNING, false);
                    events.Repeat(2500ms);
                    break;
                case EVENT_DR_EVOKER_RM:
                    if (Unit* target = DoSelectLowestHpFriendly(40.0f, 15))
                        me->CastSpell(target, SPELL_RUNIC_MENDING, false);
                    else
                        me->CastSpell(me, SPELL_RUNIC_MENDING, false);
                    events.Repeat(4s);
                    break;
                case EVENT_DR_EVOKER_RS:
                    me->CastSpell(me, SPELL_RUNIC_SHIELD, false);
                    events.Repeat(10s);
                    break;
                case EVENT_DR_CHAMPION_CH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_CHARGE, false);
                    events.Repeat(12s);
                    break;
                case EVENT_DR_CHAMPION_WH:
                    if (!me->HasUnitFlag(UNIT_FLAG_DISARMED))
                        me->CastSpell(me, SPELL_WHIRLWIND, false);
                    events.Repeat(6s);
                    break;
                case EVENT_DR_CHAMPION_MS:
                    me->CastSpell(me->GetVictim(), SPELL_MORTAL_STRIKE, false);
                    events.Repeat(8s);
                    break;
                case EVENT_DR_COMMONER_LB:
                    me->CastSpell(me->GetVictim(), SPELL_LOW_BLOW, false);
                    events.Repeat(5s);
                    break;
                case EVENT_DR_COMMONER_PM:
                    me->CastSpell(me->GetVictim(), SPELL_PUMMEL, false);
                    events.Repeat(6s);
                    break;
            }

            if (!_isCaster || (me->GetPower(POWER_MANA) * 100 / me->GetMaxPower(POWER_MANA) < 10))
                DoMeleeAttackIfReady();
        }
    };
};

class go_thorim_lever : public GameObjectScript
{
public:
    go_thorim_lever() : GameObjectScript("go_thorim_lever") { }

    bool OnGossipHello(Player* pPlayer, GameObject* go) override
    {
        if (GameObject* g = pPlayer->FindNearestGameObject(GO_ARENA_LEVER_GATE, 50))
            g->UseDoorOrButton();

        go->UseDoorOrButton();
        return true;
    }
};

class spell_thorim_lightning_pillar_P2_aura : public AuraScript
{
    PrepareAuraScript(spell_thorim_lightning_pillar_P2_aura);

    void OnPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        if (Unit* caster = GetCaster())
            GetUnitOwner()->CastSpell(caster, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_thorim_lightning_pillar_P2_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_thorim_trash_impale_aura : public AuraScript
{
    PrepareAuraScript(spell_thorim_trash_impale_aura);

    void OnPeriodic(AuraEffect const*  /*aurEff*/)
    {
        // deals damage until target is healed above 90%
        if (GetUnitOwner()->HealthAbovePct(90))
            SetDuration(0);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_thorim_trash_impale_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class achievement_thorim_stand_in_the_lightning : public AchievementCriteriaScript
{
public:
    achievement_thorim_stand_in_the_lightning() : AchievementCriteriaScript("achievement_thorim_stand_in_the_lightning") {}

    bool OnCheck(Player* player, Unit*, uint32 /*criteria_id*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (Creature* cr = ObjectAccessor::GetCreature(*player, instance->GetGuidData(TYPE_THORIM)))
                return cr->AI()->GetData(DATA_HIT_BY_LIGHTNING);

        return false;
    }
};

class achievement_thorim_lose_your_illusion : public AchievementCriteriaScript
{
public:
    achievement_thorim_lose_your_illusion() : AchievementCriteriaScript("achievement_thorim_lose_your_illusion") {}

    bool OnCheck(Player* player, Unit*, uint32 /*criteria_id*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
            if (Creature* cr = ObjectAccessor::GetCreature(*player, instance->GetGuidData(TYPE_THORIM)))
                return cr->AI()->GetData(DATA_LOSE_YOUR_ILLUSION);

        return false;
    }
};

void AddSC_boss_thorim()
{
    // Main encounter
    new boss_thorim();
    new boss_thorim_sif();
    new boss_thorim_lightning_orb();
    new boss_thorim_trap();
    new boss_thorim_pillar();
    new boss_thorim_sif_blizzard();

    // Trash
    new boss_thorim_start_npcs();
    new boss_thorim_gauntlet_npcs();
    new boss_thorim_arena_npcs();

    // Mini bosses
    new boss_thorim_runic_colossus();
    new boss_thorim_ancient_rune_giant();

    // GOs
    new go_thorim_lever();

    // Spells
    RegisterSpellScript(spell_thorim_lightning_pillar_P2_aura);
    RegisterSpellScript(spell_thorim_trash_impale_aura);

    // Achievements
    new achievement_thorim_stand_in_the_lightning();
    new achievement_thorim_lose_your_illusion();
}
