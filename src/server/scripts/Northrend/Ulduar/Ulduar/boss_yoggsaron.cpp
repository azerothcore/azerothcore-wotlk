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
#include "CreatureAI.h"
#include "CreatureScript.h"
#include "Object.h"
#include "Opcodes.h"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "ulduar.h"

enum YoggSpells
{
    // KEEPERS
    SPELL_KEEPER_ACTIVE                 = 62647,
    SPELL_MIMIRON_PASSIVE               = 62671,
    SPELL_THORIM_PASSIVE                = 62702,
    SPELL_HODIR_PASSIVE                 = 62650,
    SPELL_FREYA_PASSIVE                 = 62670,

    SPELL_DESTABILIZATION_MATRIX        = 65206,
    SPELL_DESTABILIZATION_MATRIX_ATTACK = 65210,
    SPELL_SANITY_WELL_VISUAL            = 63288,
    SPELL_SANITY_WELL_BUFF              = 64169,
    SPELL_PROTECTIVE_GAZE               = 64174, // COOLDOWN 25 SECS BEFORE NEXT USE
    SPELL_HODIR_FLASH_FREEZE            = 64175,
    SPELL_CONJURE_SANITY_WELL           = 64170,

    SPELL_TITANIC_STORM_PASSIVE         = 64171,
    SPELL_WEAKENED                      = 64162,

    // GLOBAL
    SPELL_SANITY_BASE                   = 63786,
    SPELL_SANITY                        = 63050,
    SPELL_EXTINGUISH_ALL_LIFE           = 64166,
    SPELL_CLOUD_VISUAL                  = 63084,
    SPELL_SUMMON_GUARDIAN_OF_YS         = 63031,
    SPELL_INSANE1                       = 63120,
    SPELL_INSANE2                       = 64464,
    SPELL_INSANE_PERIODIC               = 64554, // this checks if player dc'ed and insanes him instantly after logging in

    // SARA P1
    SPELL_SARAS_FAVOR                       = 63138,
    SPELL_SARAS_FAVOR_TARGET_SELECTOR       = 63747,
    SPELL_SARAS_BLESSING                    = 63134,
    SPELL_SARAS_BLESSING_TARGET_SELECTOR    = 63745,
    SPELL_SARAS_ANGER                       = 63147,
    SPELL_SARAS_ANGER_TARGET_SELECTOR       = 63744,
    SPELL_SHADOWY_BARRIER                   = 64775,

    // GUARDIANS OF YOGG-SARON
    SPELL_SHADOW_NOVA                   = 62714,
    SPELL_DARK_VOLLEY                   = 63038,

    // SARA P2
    SPELL_SARA_PSYCHOSIS_10             = 63795,
    SPELL_SARA_PSYCHOSIS_25             = 65301,
    SPELL_MALADY_OF_THE_MIND            = 63830,
    SPELL_MALADY_OF_THE_MIND_TRIGGER    = 63881,
    SPELL_BRAIN_LINK                    = 63802,
    SPELL_BRAIN_LINK_DAMAGE             = 63803,
    SPELL_BRAIN_LINK_OK                 = 63804,

    SPELL_DEATH_RAY_DAMAGE_VISUAL       = 63886,
    SPELL_DEATH_RAY_ORIGIN_VISUAL       = 63893,
    SPELL_DEATH_RAY_WARNING             = 63882,
    SPELL_DEATH_RAY_DAMAGE              = 63883,
    SPELL_DEATH_RAY_DAMAGE_REAL         = 63884,

    // YOGG-SARON P2
    SPELL_SHADOW_BARRIER                = 63894,
    SPELL_KNOCK_AWAY                    = 64022,

    // TENTACLES
    SPELL_VOID_ZONE_SMALL               = 64384,
    SPELL_VOID_ZONE_LARGE               = 64017,
    SPELL_TENTACLE_ERUPT                = 64144,

    // CRUSHER TENTACLE
    SPELL_CRUSH                         = 64146,
    SPELL_DIMINISH_POWER                = 64145,
    SPELL_FOCUSED_ANGER                 = 57688,

    // CONSTRICTOR TENTACLE
    SPELL_LUNGE                         = 64123,
    SPELL_SQUEEZE_10                    = 64125,
    SPELL_SQUEEZE_25                    = 64126,

    // CORRUPTOR TENTACLE
    SPELL_APATHY                        = 64156,
    SPELL_BLACK_PLAGUE                  = 64153,
    SPELL_CURSE_OF_DOOM                 = 64157,
    SPELL_DRAINING_POISON               = 64152,

    // MISC
    SPELL_REVEALED_TENTACLE             = 64012,
    SPELL_IN_THE_MAWS_OF_THE_OLD_GOD    = 64184,

    // BRAIN OF YOGG-SARON
    SPELL_SHATTERED_ILLUSION            = 64173,
    SPELL_INDUCE_MADNESS                = 64059,
    SPELL_BRAIN_HURT_VISUAL             = 64361,

    // PORTALS
    SPELL_TELEPORT_TO_CHAMBER           = 63997,
    SPELL_TELEPORT_TO_ICECROWN          = 63998,
    SPELL_TELEPORT_TO_STORMWIND         = 63989,
    SPELL_TELEPORT_BACK                 = 63992,
    SPELL_CANCEL_ILLUSION_AURA          = 63993,

    // LAUGHING SKULL AND INFLUENCE TENTACLE AND OTHERS
    SPELL_LUNATIC_GAZE                  = 64167,
    SPELL_GRIM_REPRISAL                 = 63305,
    SPELL_GRIM_REPRISAL_DAMAGE          = 64039,
    SPELL_DEATHGRASP                    = 63037,

    // YOGG-SARON P3
    SPELL_LUNATIC_GAZE_YS               = 64163,
    SPELL_DEAFENING_ROAR                = 64189,
    SPELL_SHADOW_BEACON                 = 64465,

    // IMMORTAL GUARDIAN
    SPELL_SIMPLE_TELEPORT               = 64195,
    SPELL_EMPOWERED                     = 65294,
    SPELL_EMPOWERED_PASSIVE             = 64161,
    SPELL_DRAIN_LIFE_10                 = 64159,
    SPELL_DRAIN_LIFE_25                 = 64160,
    SPELL_RECENTLY_SPAWNED              = 64497,
};

#define SPELL_PSYCHOSIS         RAID_MODE(SPELL_SARA_PSYCHOSIS_10, SPELL_SARA_PSYCHOSIS_25)
#define SPELL_SQUEEZE           RAID_MODE(SPELL_SQUEEZE_10, SPELL_SQUEEZE_25)
#define SPELL_DRAIN_LIFE        RAID_MODE(SPELL_DRAIN_LIFE_10, SPELL_DRAIN_LIFE_25)

enum YoggEvents
{
    EVENT_SARA_P1_DOORS_CLOSE           = 1,
    EVENT_SARA_P1_SUMMON                = 2,
    EVENT_SARA_P1_SPELLS                = 3,
    EVENT_SARA_P1_BERSERK               = 4,

    EVENT_SARA_P2_START                 = 10,
    EVENT_SARA_P2_SUMMON_T1             = 11,
    EVENT_SARA_P2_SUMMON_T2             = 12,
    EVENT_SARA_P2_SUMMON_T3             = 13,
    EVENT_SARA_P2_BRAIN_LINK            = 14,
    EVENT_SARA_P2_DEATH_RAY             = 15,
    EVENT_SARA_P2_MALADY                = 16,
    EVENT_SARA_P2_PSYCHOSIS             = 17,
    EVENT_SARA_P2_OPEN_PORTALS          = 18,
    EVENT_SARA_P2_REMOVE_STUN           = 19,
    EVENT_SARA_P2_SPAWN_START_TENTACLES = 20,

    EVENT_YS_LUNATIC_GAZE               = 30,
    EVENT_YS_DEAFENING_ROAR             = 31,
    EVENT_YS_SUMMON_GUARDIAN            = 32,
    EVENT_YS_SHADOW_BEACON              = 33,
};

enum NPCsGOs
{
    // NPCs
    NPC_OMINOUS_CLOUD                   = 33292,
    NPC_GUARDIAN_OF_YS                  = 33136,
    NPC_SANITY_WELL                     = 33991,
    NPC_YOGG_SARON                      = 33288,
    NPC_VOICE_OF_YOGG_SARON             = 33280,
    NPC_YOGG_SARON_VISION               = 33552,

    NPC_CRUSHER_TENTACLE                = 33966, // 50 secs ?
    NPC_CONSTRICTOR_TENTACLE            = 33983, // 15-20 secs ?
    NPC_CORRUPTOR_TENTACLE              = 33985, // 30-40 secs ?

    NPC_INFLUENCE_TENTACLE              = 33943,
    NPC_DEATH_ORB                       = 33882,
    NPC_DESCEND_INTO_MADNESS            = 34072,
    NPC_LAUGHING_SKULL                  = 33990,

    NPC_IMMORTAL_GUARDIAN               = 33988,
    NPC_MARKED_IMMORTAL_GUARDIAN        = 36064,

    // CHAMBER ILLUSION
    NPC_CONSORT_FIRST                   = 33716,
    NPC_CONSORT_LAST                    = 33720,
    NPC_ALEXTRASZA                      = 33536,
    NPC_MALYGOS                         = 33535,
    NPC_NELTHARION                      = 33523,
    NPC_YSERA                           = 33495,
    GO_DRAGON_SOUL                      = 194462,

    // ICECROWN ILLUSION
    NPC_DEATHSWORN_ZEALOT               = 33567,
    NPC_LICH_KING                       = 33441,
    NPC_IMMOLATED_CHAMPION              = 33442,

    // STORMWIND ILLUSION
    NPC_SUIT_OF_ARMOR                   = 33433,
    NPC_GARONA                          = 33436,
    NPC_KING_LLANE                      = 33437,

    // GOs
    GO_DOORS                            = 194773,
    GO_FLEE_TO_THE_SURFACE_PORTAL       = 194625,
    GO_CHAMBER_ILLUSION_DOORS           = 194635,
    GO_ICECROWN_ILLUSION_DOORS          = 194636,
    GO_STORMWIND_ILLUSION_DOORS         = 194637,

    // MODELs
    SARA_TRANSFORM_MODEL                = 29182,
};

enum Misc
{
    ACTION_UNSUMMON_CLOUDS              = -16,
    ACTION_DESPAWN_ADDS                 = -15,
    ACTION_START_SUMMONING              = -14,
    ACTION_YOGG_SARON_APPEAR            = -13,
    ACTION_YOGG_SARON_DEATH             = -12,
    ACTION_YOGG_SARON_START_YELL        = -11,
    ACTION_YOGG_SARON_OPEN_PORTAL_YELL  = -10,
    ACTION_INFLUENCE_TENTACLE_DIED      = -9,
    ACTION_BRAIN_DAMAGED                = -8,
    ACTION_REMOVE_STUN                  = -7,
    ACTION_YOGG_SARON_START_P3          = -6,
    ACTION_YOGG_SARON_HARD_MODE         = -5,
    ACTION_YOGG_SARON_SHADOW_BEACON     = -4,
    ACTION_THORIM_START_STORM           = -3,
    ACTION_FAILED_DRIVE_ME_CRAZY        = -2,

    ACTION_ILLUSION_DRAGONS             = 1,
    ACTION_ILLUSION_ICECROWN            = 2,
    ACTION_ILLUSION_STORMWIND           = 3,

    // ACTION_SARA_UPDATE_SUMMON_KEEPERS = 4, // defined in ulduar.h

    EVENT_PHASE_ONE                     = 1,
    EVENT_PHASE_TWO                     = 2,
    EVENT_PHASE_THREE                   = 3,

    CRITERIA_NOT_GETTING_OLDER          = 21001,

    // YOGG-SARON (laugh)
    YS_P3_LUNATIC_GAZE                  = 15757,

    DATA_GET_KEEPERS_COUNT              = 1,
    DATA_GET_CURRENT_ILLUSION           = 2,
    DATA_GET_SARA_PHASE                 = 3,
    DATA_GET_DRIVE_ME_CRAZY             = 4,
};

struct LocationsXY
{
    float x, y, z;
};

Position const GossipKeepersPos[4] =
{
    {1945.6823f, 33.342014f, 411.44083f, 5.270895f}, // Freya
    {1945.7609f, -81.52171f,  411.4407f, 1.029744f}, // Hodir
    {2028.7656f,  17.42014f, 411.44458f, 3.857178f}, // Mimiron
    {2028.8219f, -65.73573f, 411.44257f, 2.460914f}  // Thorim
};

const Position KeepersPos[4] =
{
    {1939.32f,   42.165f, 338.415f, 5.17955f}, // Freya
    {1939.13f, -90.8332f, 338.415f, 1.00123f}, // Hodir
    {2036.81f,  25.6646f, 338.415f, 3.74227f}, // Mimiron
    {2036.59f, -73.8499f, 338.415f, 2.34819f}  // Thorim
};

const uint32 TABLE_KEEPER_ENTRY[4] = {NPC_FREYA_KEEPER, NPC_HODIR_KEEPER, NPC_MIMIRON_KEEPER, NPC_THORIM_KEEPER};
const uint32 TABLE_GOSSIP_ENTRY[4] = {NPC_FREYA_GOSSIP, NPC_HODIR_GOSSIP, NPC_MIMIRON_GOSSIP, NPC_THORIM_GOSSIP};
const uint32 TABLE_KEEPER_TYPE[4]  = {TYPE_FREYA,             TYPE_HODIR,       TYPE_MIMIRON,       TYPE_THORIM};

static LocationsXY yoggPortalLoc[] =
{
    {1970.48f, -9.75f, 325.5f},
    {1992.76f, -10.21f, 325.5f},
    {1995.53f, -39.78f, 325.5f},
    {1969.25f, -42.00f, 325.5f},
    {1960.62f, -32.00f, 325.5f},
    {1981.98f, -5.69f, 325.5f},
    {1982.78f, -45.73f, 325.5f},
    {2000.66f, -29.68f, 325.5f},
    {1999.88f, -19.61f, 325.5f},
    {1961.37f, -19.54f, 325.5f}
};

enum Texts
{
    // Sara
    SAY_SARA_ULDUAR_SCREAM_0            = 0, // Unused
    SAY_SARA_ULDUAR_SCREAM_1            = 1, // Unused
    SAY_SARA_AGGRO                      = 2,
    SAY_SARA_FERVOR_HIT                 = 3,
    SAY_SARA_ANGER                      = 4, // Comment in DB is for BLESSING_HIT, but it's wrong.
    SAY_SARA_KILL                       = 5,
    SAY_SARA_TRANSFORM_1                = 6, // "I am the lucid dream."
    SAY_SARA_TRANSFORM_2                = 7, // "The monster in your nightmares."
    SAY_SARA_TRANSFORM_3                = 8, // "The fiend of a thousand faces."
    SAY_SARA_TRANSFORM_4                = 9, // "Cower before my true form."
    SAY_SARA_DEATH_RAY                  = 10,
    SAY_SARA_PSYCHOSIS_HIT              = 11,

    // Voice of Yogg-Saron
    WHISPER_VOICE_PHASE_1_WIPE          = 0,
    WHISPER_VOICE_INSANE                = 1,

    // Brain of Yogg-Saron
    EMOTE_YOGG_SARON_BRAIN_SHATTERED    = 0,

    // Yogg-Saron
    SAY_YOGG_SARON_SPAWN                = 0,
    SAY_YOGG_SARON_MADNESS              = 1, // Open Portals
    EMOTE_YOGG_SARON_MADNESS            = 2,
    SAY_YOGG_SARON_PHASE_3              = 3,
    SAY_YOGG_SARON_DEAFENING_ROAR       = 4,
    EMOTE_YOGG_SARON_DEAFENING_ROAR     = 5,
    SAY_YOGG_SARON_DEATH                = 6,
    EMOTE_YOGG_SARON_EMPOWERING_SHADOWS = 7, // Shadow Beacon
    EMOTE_YOGG_SARON_BERSERK            = 8,

    // Visions - Text is in order of Roleplay
    // The Assassination of King Llane vision
    SAY_GARONA_1                        = 0,
    SAY_GARONA_2                        = 1,
    SAY_GARONA_3                        = 2,
    SAY_YOGG_1                          = 0,
    SAY_YOGG_2                          = 1,
    SAY_LLANE_1                         = 0,
    SAY_GARONA_4                        = 3,
    SAY_YOGG_3                          = 2,

    // The Forging of the Demon Soul vision
    SAY_NEL_1                           = 0,
    SAY_YAS_1                           = 0,
    SAY_NEL_2                           = 1,
    SAY_MAL_1                           = 0,
    SAY_YOGG_4                          = 5,

    // The Tortured Champion vision
    SAY_LK_1                            = 0,
    SAY_IC_1                            = 0,
    SAY_IC_2                            = 1,
    SAY_LK_2                            = 1,
    SAY_YOGG_5                          = 3,
    SAY_YOGG_6                          = 4,
};

const Position Middle = {1980.28f, -25.5868f, 329.397f, M_PI * 1.5f};

class boss_yoggsaron_sara : public CreatureScript
{
public:
    boss_yoggsaron_sara() : CreatureScript("boss_yoggsaron_sara") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_saraAI>(pCreature);
    }

    struct boss_yoggsaron_saraAI : public ScriptedAI
    {
        boss_yoggsaron_saraAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature)
        {
            m_pInstance = pCreature->GetInstanceScript();
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;

        uint32 _initFight;
        uint8 _summonedGuardiansCount;
        uint32 _p2TalkTimer;
        bool _secondPhase;
        float _summonSpeed;
        uint8 _currentIllusion;
        bool _isIllusionReversed;

        void AttackStart(Unit*) override { }
        void MoveInLineOfSight(Unit*) override { }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
        }

        void SpawnClouds()
        {
            for (uint8 i = 0; i < 6; ++i)
            {
                float Zplus = i > 2 ? (i - 2) * 1.6f : 0;
                if (i % 2)
                    me->SummonCreature(NPC_OMINOUS_CLOUD, me->GetPositionX() + 8 + i * 7, me->GetPositionY() + 8 + i * 7, 326 + Zplus, 0);
                else
                    me->SummonCreature(NPC_OMINOUS_CLOUD, me->GetPositionX() - 8 - i * 7, me->GetPositionY() - 8 - i * 7, 326 + Zplus, 0);
            }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!_EnterEvadeMode(why))
                return;

            Position pos;
            pos = me->GetHomePosition();
            me->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation());
            Reset();
            me->setActive(false);
        }

        void EnableSara(bool apply)
        {
            if (apply)
            {
                me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                me->DisableRotate(false);
                me->ClearUnitState(UNIT_STATE_ROOT);
            }
            else
            {
                me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                me->DisableRotate(true);
                me->AddUnitState(UNIT_STATE_ROOT);
            }
        }

        void Reset() override
        {
            if (!_secondPhase) // Phase 1 wipe
            {
                me->GetMap()->DoForAllPlayers([&](Player* player)
                {
                    if (Creature* voice = me->FindNearestCreature(NPC_VOICE_OF_YOGG_SARON, 10.0f))
                    {
                        voice->AI()->Talk(WHISPER_VOICE_PHASE_1_WIPE, player);
                    }
                });
            }

            summons.DoAction(ACTION_DESPAWN_ADDS);
            events.Reset();
            summons.DespawnAll();

            me->SetVisible(true);
            me->SetDisplayId(me->GetNativeDisplayId());
            me->SetDisableGravity(true);
            EnableSara(false);
            SpawnClouds();

            _initFight = 1;

            UpdateKeeperSpawns();
            _summonedGuardiansCount = 0;
            _p2TalkTimer = 0;
            _secondPhase = false;
            _summonSpeed = 1.0f;
            _currentIllusion = urand(1, 3);
            _isIllusionReversed = urand(0, 1);

            if (m_pInstance)
            {
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, CRITERIA_NOT_GETTING_OLDER);
                m_pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_SANITY);
                m_pInstance->SetData(TYPE_YOGGSARON, NOT_STARTED);
                if (GameObject* go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(GO_YOGG_SARON_DOORS)))
                    go->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void InitFight(Unit* target)
        {
            if (!m_pInstance)
                return;

            // some simple hack checks
            if (m_pInstance->GetData(TYPE_VEZAX) != DONE || m_pInstance->GetData(TYPE_XT002) != DONE)
                return;

            m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, CRITERIA_NOT_GETTING_OLDER);
            m_pInstance->SetData(TYPE_YOGGSARON, IN_PROGRESS);
            me->SetInCombatWithZone();
            AttackStart(target);

            DespawnGossipKeepers();
            // Engage Keepers
            summons.DoZoneInCombat();

            me->CastSpell(me, SPELL_SANITY_BASE, true);

            events.ScheduleEvent(EVENT_SARA_P1_DOORS_CLOSE, 15s, 0, EVENT_PHASE_ONE);
            events.ScheduleEvent(EVENT_SARA_P1_BERSERK, 15min, 0, 0);
            events.ScheduleEvent(EVENT_SARA_P1_SUMMON, 0ms, 0, EVENT_PHASE_ONE);
            events.SetPhase(EVENT_PHASE_ONE);

            Talk(SAY_SARA_AGGRO);
            me->setActive(true);
        }

        void DespawnGossipKeepers()
        {
            for (uint8 i = KEEPER_FREYA; i <= KEEPER_THORIM; i++)
                summons.DespawnEntry(TABLE_GOSSIP_ENTRY[i]);
        }

        void UpdateKeeperSpawns()
        {
            for (uint8 i = KEEPER_FREYA; i <= KEEPER_THORIM; i++)
            {
                if (m_pInstance->GetData(TYPE_WATCHERS) & (1 << i))
                {
                    if (!summons.HasEntry(TABLE_KEEPER_ENTRY[i]))
                        me->SummonCreature(TABLE_KEEPER_ENTRY[i], KeepersPos[i]);
                }
                else if (m_pInstance->GetData(TABLE_KEEPER_TYPE[i]) == DONE)
                {
                    if (!summons.HasEntry(TABLE_GOSSIP_ENTRY[i]))
                        me->SummonCreature(TABLE_GOSSIP_ENTRY[i], GossipKeepersPos[i]);
                }
            }
        }

        void InformCloud()
        {
            Creature* cloud = nullptr;
            for (SummonList::const_iterator itr = summons.begin(); itr != summons.end();)
            {
                Creature* summon = ObjectAccessor::GetCreature(*me, *itr);
                ++itr;
                if (!summon || summon->GetEntry() != NPC_OMINOUS_CLOUD || me->GetDistance(summon) < 20)
                    continue;

                if ((!cloud || (urand(0, 1) && !summon->HasAura(SPELL_SUMMON_GUARDIAN_OF_YS))))
                    cloud = summon;
            }

            if (cloud)
                cloud->AI()->DoAction(ACTION_START_SUMMONING);
        }

        void SpawnTentacle(uint32 entry)
        {
            uint32 dist = urand(38, 48);
            float o = rand_norm() * M_PI * 2;
            float Zplus = (dist - 38) / 6.5f;
            if (Creature* cr = me->SummonCreature(entry, me->GetPositionX() + dist * cos(o), me->GetPositionY() + dist * std::sin(o), 327.2 + Zplus, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000))
            {
                cr->CastSpell(cr, SPELL_TENTACLE_ERUPT, true);
                cr->CastSpell(cr, SPELL_VOID_ZONE_SMALL, true);
                cr->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
            }
        }

        void SummonDeathOrbs()
        {
            for (uint8 i = 0; i < 4; ++i)
            {
                uint32 dist = urand(38, 48);
                float o = rand_norm() * M_PI * 2;
                float Zplus = (dist - 38) / 6.5f;
                me->SummonCreature(NPC_DEATH_ORB, me->GetPositionX() + dist * cos(o), me->GetPositionY() + dist * std::sin(o), 327.2 + Zplus, 0, TEMPSUMMON_TIMED_DESPAWN, 20000);
            }
        }

        void AddPortals()
        {
            _summonSpeed -= 0.1f;
            Creature* cr = nullptr;

            // Spawn Portals
            for (uint8 i = 0; i < RAID_MODE(4, 10); ++i)
            {
                if ((cr = me->SummonCreature(NPC_DESCEND_INTO_MADNESS, yoggPortalLoc[i].x, yoggPortalLoc[i].y, yoggPortalLoc[i].z, 0, TEMPSUMMON_TIMED_DESPAWN, 25000)))
                {
                    cr->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_NON_ATTACKABLE);
                    cr->SetArmor(_currentIllusion);
                }
            }

            EntryCheckPredicate pred(NPC_BRAIN_OF_YOGG_SARON);
            summons.DoAction(_currentIllusion, pred);

            if (_isIllusionReversed)
                _currentIllusion = _currentIllusion == 3 ? 1 : (_currentIllusion + 1);
            else
                _currentIllusion = _currentIllusion == 1 ? 3 : (_currentIllusion - 1);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer())
            {
                Talk(SAY_SARA_KILL);
            }
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SANITY)
                if (Aura* aur = target->GetAura(SPELL_SANITY))
                    aur->SetStackAmount(100);
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_GET_KEEPERS_COUNT)
            {
                uint8 _count = 0;
                for (uint8 i = 0; i < 4; ++i)
                    if (m_pInstance->GetData(TYPE_WATCHERS) & (1 << i))
                        ++_count;
                return _count;
            }
            else if (param == DATA_GET_SARA_PHASE)
                return _secondPhase;

            return 4; // just to be sure, return max numer of keepers
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_SARA_UPDATE_SUMMON_KEEPERS)
            {
                UpdateKeeperSpawns();
            }
            else if (param == ACTION_BRAIN_DAMAGED)
            {
                summons.DoAction(ACTION_REMOVE_STUN);

                EntryCheckPredicate pred2(NPC_YOGG_SARON);
                summons.DoAction(ACTION_YOGG_SARON_START_P3, pred2);

                EntryCheckPredicate pred3(NPC_THORIM_KEEPER);
                summons.DoAction(ACTION_THORIM_START_STORM, pred3);

                if (me->GetMap()->Is25ManRaid() && (GetData(DATA_GET_KEEPERS_COUNT) > 0))
                    summons.DoAction(ACTION_YOGG_SARON_HARD_MODE, pred2);

                summons.DespawnEntry(NPC_DEATH_ORB);
                events.SetPhase(EVENT_PHASE_THREE);

                me->RemoveAllAuras();
                me->SetVisible(false);
                return;
            }
            else if (param == ACTION_YOGG_SARON_DEATH)
            {
                // Despawn everything but Yogg-Saron's corpse
                summons.DoAction(ACTION_DESPAWN_ADDS);
                summons.DespawnEntry(NPC_CRUSHER_TENTACLE);
                summons.DespawnEntry(NPC_CONSTRICTOR_TENTACLE);
                summons.DespawnEntry(NPC_CORRUPTOR_TENTACLE);
                summons.DespawnEntry(NPC_VOICE_OF_YOGG_SARON);
                summons.DespawnEntry(NPC_BRAIN_OF_YOGG_SARON);
                summons.DespawnEntry(NPC_MIMIRON_GOSSIP);
                summons.DespawnEntry(NPC_HODIR_GOSSIP);
                summons.DespawnEntry(NPC_FREYA_GOSSIP);
                summons.DespawnEntry(NPC_THORIM_GOSSIP);
                summons.DespawnEntry(NPC_MIMIRON_KEEPER);
                summons.DespawnEntry(NPC_HODIR_KEEPER);
                summons.DespawnEntry(NPC_FREYA_KEEPER);
                summons.DespawnEntry(NPC_THORIM_KEEPER);
                summons.DespawnEntry(NPC_SANITY_WELL);
                me->KillSelf();
                return;
            }

            // Determine shatter duration
            if (param <= 0)
                return;

            // Illusion shatters (param - stun time)
            if (Creature* yoggb = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(NPC_BRAIN_OF_YOGG_SARON)))
            {
                yoggb->AI()->Talk(EMOTE_YOGG_SARON_BRAIN_SHATTERED);
            }

            uint32 timer = events.GetNextEventTime(EVENT_SARA_P2_OPEN_PORTALS);
            uint32 portalTime = (timer > events.GetTimer() ? timer - events.GetTimer() : 0);
            events.DelayEvents(param + 100);
            events.RescheduleEvent(EVENT_SARA_P2_OPEN_PORTALS, portalTime, 0, EVENT_PHASE_TWO);
            events.ScheduleEvent(EVENT_SARA_P2_REMOVE_STUN, param, 0, EVENT_PHASE_TWO);
            me->CastSpell(me, SPELL_SHATTERED_ILLUSION, true);
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (who && who->GetEntry() == NPC_GUARDIAN_OF_YS && !_secondPhase)
            {
                damage = 25000;

                // START PHASE 2
                if (me->GetHealth() <= damage)
                {
                    _secondPhase = true;
                    damage = 0;

                    events.SetPhase(EVENT_PHASE_TWO);
                    me->SetHealth(me->GetMaxHealth());

                    if (Creature* cr = me->SummonCreature(NPC_YOGG_SARON, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), M_PI))
                        cr->SetVisible(false);

                    _p2TalkTimer++;
                    Talk(SAY_SARA_TRANSFORM_1);
                }
                return;
            }

            damage = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_initFight)
            {
                _initFight += diff;
                if (_initFight > 5000)
                {
                    if (Unit* target = SelectTargetFromPlayerList(90))
                    {
                        _initFight = 0;
                        InitFight(target);
                    }
                    else
                        _initFight = 1;
                }
                return;
            }

            if (!SelectTargetFromPlayerList(90, SPELL_INSANE1))
            {
                m_pInstance->DoRemoveAurasDueToSpellOnPlayers(SPELL_INSANE1);
                EnterEvadeMode(EVADE_REASON_OTHER);
                return;
            }

            if (_p2TalkTimer)
            {
                _p2TalkTimer += diff;
                if (_p2TalkTimer >= 4000 && _p2TalkTimer < 20000)
                {
                    EntryCheckPredicate pred(NPC_OMINOUS_CLOUD);
                    summons.DoAction(ACTION_UNSUMMON_CLOUDS, pred);
                    Talk(SAY_SARA_TRANSFORM_2);
                    _p2TalkTimer = 20000;
                }
                else if (_p2TalkTimer >= 25000 && _p2TalkTimer < 40000)
                {
                    summons.DespawnEntry(NPC_OMINOUS_CLOUD);
                    Talk(SAY_SARA_TRANSFORM_3);
                    _p2TalkTimer = 40000;
                }
                else if (_p2TalkTimer >= 44500 && _p2TalkTimer < 60000)
                {
                    Talk(SAY_SARA_TRANSFORM_4);
                    _p2TalkTimer = 60000;
                }
                else if (_p2TalkTimer >= 64000)
                {
                    EntryCheckPredicate pred(NPC_YOGG_SARON);
                    summons.DoAction(ACTION_YOGG_SARON_START_YELL, pred);
                    _p2TalkTimer = 0;
                    events.ScheduleEvent(EVENT_SARA_P2_START, 500ms, 0, EVENT_PHASE_TWO);
                }
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch(events.ExecuteEvent())
            {
                case EVENT_SARA_P1_DOORS_CLOSE:
                    // Whispers of YS
                    me->SummonCreature(NPC_VOICE_OF_YOGG_SARON, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ());

                    if (m_pInstance)
                        if (GameObject* go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(GO_YOGG_SARON_DOORS)))
                            go->SetGoState(GO_STATE_READY);

                    events.ScheduleEvent(EVENT_SARA_P1_SPELLS, 0ms, 1, EVENT_PHASE_ONE);
                    break;
                case EVENT_SARA_P1_SUMMON:
                    events.RepeatEvent(20000 - (std::min(_summonedGuardiansCount, (uint8)5) * 2000));
                    ++_summonedGuardiansCount;
                    InformCloud();
                    break;
                case EVENT_SARA_P1_SPELLS:
                    {
                        uint32 spell = RAND(SPELL_SARAS_ANGER_TARGET_SELECTOR, SPELL_SARAS_BLESSING_TARGET_SELECTOR, SPELL_SARAS_FAVOR_TARGET_SELECTOR);
                        if (urand(0, 2))
                        {
                            if (spell == SPELL_SARAS_ANGER_TARGET_SELECTOR)
                            {
                                Talk(SAY_SARA_ANGER);
                            }
                            else if (spell == SPELL_SARAS_FAVOR_TARGET_SELECTOR)
                            {
                                Talk(SAY_SARA_FERVOR_HIT);
                            }
                        }

                        me->CastCustomSpell(spell, SPELLVALUE_MAX_TARGETS, 1, nullptr, false);
                        events.RepeatEvent(me->GetMap()->Is25ManRaid() ? urand(0, 3000) : 4000 + urand(0, 2000));
                        break;
                    }
                case EVENT_SARA_P2_START:
                    {
                        EntryCheckPredicate pred(NPC_YOGG_SARON);
                        summons.DoAction(ACTION_YOGG_SARON_APPEAR, pred);
                        events.RescheduleEvent(EVENT_SARA_P2_SPAWN_START_TENTACLES, 500, 0, EVENT_PHASE_TWO);

                        // Spawn Brain!
                        me->SummonCreature(NPC_BRAIN_OF_YOGG_SARON, 1981.3f, -25.43f, 265);
                        break;
                    }
                case EVENT_SARA_P2_MALADY:
                    me->CastCustomSpell(SPELL_MALADY_OF_THE_MIND, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.Repeat(20s);
                    break;
                case EVENT_SARA_P2_PSYCHOSIS:
                    if ((urand(0, 9)) == 0)  // Rarely said (as it's casted every 3.5s)
                    {
                        Talk(SAY_SARA_PSYCHOSIS_HIT);
                    }
                    me->CastCustomSpell(SPELL_PSYCHOSIS, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.Repeat(3500ms);
                    break;
                case EVENT_SARA_P2_DEATH_RAY:
                    Talk(SAY_SARA_DEATH_RAY);
                    SummonDeathOrbs();
                    events.Repeat(20s);
                    break;
                case EVENT_SARA_P2_SUMMON_T1: // CRUSHER
                    SpawnTentacle(NPC_CRUSHER_TENTACLE);
                    events.RepeatEvent((50000 + urand(0, 10000)) * _summonSpeed);
                    break;
                case EVENT_SARA_P2_SUMMON_T2: // CONSTRICTOR
                    SpawnTentacle(NPC_CONSTRICTOR_TENTACLE);
                    events.RepeatEvent((15000 + urand(0, 5000)) * _summonSpeed);
                    break;
                case EVENT_SARA_P2_SUMMON_T3: // CORRUPTOR
                    SpawnTentacle(NPC_CORRUPTOR_TENTACLE);
                    events.RepeatEvent((30000 + urand(0, 10000)) * _summonSpeed);
                    break;
                case EVENT_SARA_P2_BRAIN_LINK:
                    me->CastCustomSpell(SPELL_BRAIN_LINK, SPELLVALUE_MAX_TARGETS, 1, me, false);
                    events.Repeat(30s);
                    break;
                case EVENT_SARA_P2_OPEN_PORTALS:
                    {
                        AddPortals();
                        EntryCheckPredicate pred(NPC_YOGG_SARON);
                        summons.DoAction(ACTION_YOGG_SARON_OPEN_PORTAL_YELL, pred);
                        events.Repeat(80s);
                        break;
                    }
                case EVENT_SARA_P2_REMOVE_STUN:
                    {
                        me->RemoveAura(SPELL_SHATTERED_ILLUSION);
                        summons.DoAction(ACTION_REMOVE_STUN);
                        break;
                    }
                case EVENT_SARA_P2_SPAWN_START_TENTACLES:
                    me->SetOrientation(M_PI);
                    me->SetDisplayId(SARA_TRANSFORM_MODEL);

                    me->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), 355, me->GetOrientation());
                    me->SetPosition(me->GetPositionX(), me->GetPositionY(), 355, me->GetOrientation());

                    SpawnTentacle(NPC_CRUSHER_TENTACLE);
                    SpawnTentacle(NPC_CONSTRICTOR_TENTACLE);
                    SpawnTentacle(NPC_CORRUPTOR_TENTACLE);
                    SpawnTentacle(NPC_CORRUPTOR_TENTACLE);

                    events.ScheduleEvent(EVENT_SARA_P2_MALADY, 7s, 0, EVENT_PHASE_TWO);
                    events.ScheduleEvent(EVENT_SARA_P2_PSYCHOSIS, 3s, 0, EVENT_PHASE_TWO);
                    events.ScheduleEvent(EVENT_SARA_P2_DEATH_RAY, 15s, 0, EVENT_PHASE_TWO);
                    events.ScheduleEvent(EVENT_SARA_P2_SUMMON_T1, 50s, 60s, 0, EVENT_PHASE_TWO);
                    events.ScheduleEvent(EVENT_SARA_P2_SUMMON_T2, 15s, 20s, 0, EVENT_PHASE_TWO);
                    events.ScheduleEvent(EVENT_SARA_P2_SUMMON_T3, 30000 + urand(0, 10000), 0, EVENT_PHASE_TWO);
                    events.ScheduleEvent(EVENT_SARA_P2_BRAIN_LINK, 0, 0, EVENT_PHASE_TWO);
                    events.ScheduleEvent(EVENT_SARA_P2_OPEN_PORTALS, 60000, 0, EVENT_PHASE_TWO);
                    break;
                case EVENT_SARA_P1_BERSERK:
                    if (me->GetInstanceScript())
                    {
                        if (Creature* yogg = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_YOGGSARON)))
                        {
                            yogg->AI()->Talk(EMOTE_YOGG_SARON_BERSERK);
                        }
                    }
                    me->CastSpell(me, SPELL_EXTINGUISH_ALL_LIFE, true);
                    events.Repeat(5s);
                    break;
            }
        }
    };
};

class boss_yoggsaron_cloud : public CreatureScript
{
public:
    boss_yoggsaron_cloud() : CreatureScript("boss_yoggsaron_cloud") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_cloudAI>(pCreature);
    }

    struct boss_yoggsaron_cloudAI : public npc_escortAI
    {
        boss_yoggsaron_cloudAI(Creature* pCreature) : npc_escortAI(pCreature)
        {
            InitWaypoint();
            Reset();
            Start(false, true, ObjectGuid::Empty, nullptr, false, true);
        }

        uint32 _checkTimer;
        bool _isSummoning;

        void JustSummoned(Creature* cr) override
        {
            cr->ToTempSummon()->SetTempSummonType(TEMPSUMMON_CORPSE_DESPAWN);

            _isSummoning = false;
            if (me->GetInstanceScript())
                if (Creature* sara = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(NPC_SARA)))
                    sara->AI()->JustSummoned(cr);
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}
        void AttackStart(Unit*  /*who*/) override {}
        void WaypointReached(uint32  /*point*/) override {}

        void Reset() override
        {
            me->CastSpell(me, SPELL_CLOUD_VISUAL, true);
            _checkTimer = 0;
            _isSummoning = false;
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_UNSUMMON_CLOUDS)
            {
                me->RemoveAllAuras();
            }
            else if (param == ACTION_START_SUMMONING)
            {
                _isSummoning = true;
                me->CastSpell(me, SPELL_SUMMON_GUARDIAN_OF_YS, true);
            }
        }

        void InitWaypoint()
        {
            float dist = Middle.GetExactDist(me);
            if (me->GetPositionX() > Middle.GetPositionX())
            {
                for (uint8 i = 0; i <= dist; ++i)
                {
                    float angle = M_PI * 2 / dist * i;
                    AddWaypoint(i, Middle.GetPositionX() + dist * cos(angle), Middle.GetPositionY() + dist * std::sin(angle), me->GetPositionZ(), 0);
                }
            }
            else
            {
                for (uint8 i = 0; i <= dist; ++i)
                {
                    float angle = M_PI * 2 - (M_PI * 2 / dist * i);
                    AddWaypoint(i, Middle.GetPositionX() + dist * cos(angle), Middle.GetPositionY() + dist * std::sin(angle), me->GetPositionZ(), 0);
                }
            }
        }

        void UpdateEscortAI(uint32 diff) override
        {
            _checkTimer += diff;
            if (_checkTimer >= 500 && !_isSummoning)
            {
                Unit* who = me->SelectNearbyTarget(nullptr, 6.0f);
                if (who && who->IsPlayer() && !me->HasAura(SPELL_SUMMON_GUARDIAN_OF_YS) && !who->HasAura(SPELL_HODIR_FLASH_FREEZE))
                {
                    _isSummoning = true;
                    Talk(0, who);
                    me->CastSpell(me, SPELL_SUMMON_GUARDIAN_OF_YS, true);
                }

                _checkTimer = 0;
            }
        }
    };
};

class boss_yoggsaron_guardian_of_ys : public CreatureScript
{
public:
    boss_yoggsaron_guardian_of_ys() : CreatureScript("boss_yoggsaron_guardian_of_ys") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_guardian_of_ysAI>(pCreature);
    }

    struct boss_yoggsaron_guardian_of_ysAI : public ScriptedAI
    {
        boss_yoggsaron_guardian_of_ysAI(Creature* pCreature) : ScriptedAI(pCreature) { }

        uint32 _spellTimer;

        void Reset() override
        {
            _spellTimer = 0;
            me->SetInCombatWithZone();
        }

        void JustDied(Unit*) override
        {
            me->CastSpell((Unit*)nullptr, SPELL_SHADOW_NOVA, true);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _spellTimer += diff;
            if (_spellTimer > 8000)
            {
                me->CastSpell(me, SPELL_DARK_VOLLEY, false);
                _spellTimer = 0;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_yoggsaron : public CreatureScript
{
public:
    boss_yoggsaron() : CreatureScript("boss_yoggsaron") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaronAI>(pCreature);
    }

    struct boss_yoggsaronAI : public ScriptedAI
    {
        boss_yoggsaronAI(Creature* pCreature) : ScriptedAI(pCreature), summons(pCreature)
        {
            m_pInstance = me->GetInstanceScript();
            _thirdPhase = false;
            _usedInsane = false;
            summons.DespawnAll();
            events.Reset();

            uint8 _count = 4;
            me->SetLootMode(31); // 1 + 2 + 4 + 8 + 16, remove with watchers addition
            if (m_pInstance)
            {
                for (uint8 i = 0; i < 4; ++i)
                    if (m_pInstance->GetData(TYPE_WATCHERS) & (1 << i))
                    {
                        me->RemoveLootMode(1 << _count);
                        --_count;
                    }
            }
        }

        InstanceScript* m_pInstance;
        EventMap events;
        SummonList summons;
        bool _thirdPhase;
        bool _usedInsane;

        void AttackStart(Unit*) override { }

        void JustSummoned(Creature* cr) override { summons.Summon(cr); }

        void SummonImmortalGuardian()
        {
            uint32 dist = urand(38, 48);
            float o = rand_norm() * M_PI * 2;
            float Zplus = (dist - 38) / 6.5f;
            me->SummonCreature(NPC_IMMORTAL_GUARDIAN, me->GetPositionX() + dist * cos(o), me->GetPositionY() + dist * std::sin(o), 327.2 + Zplus, 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
        }

        void JustDied(Unit*  /*who*/) override
        {
            summons.DespawnAll();
            events.Reset();

            Talk(SAY_YOGG_SARON_DEATH);

            if (m_pInstance)
            {
                m_pInstance->SetData(TYPE_YOGGSARON, DONE);
                if (Creature* sara = ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(NPC_SARA)))
                    sara->AI()->DoAction(ACTION_YOGG_SARON_DEATH);
                if (GameObject* go = ObjectAccessor::GetGameObject(*me, m_pInstance->GetGuidData(GO_YOGG_SARON_DOORS)))
                    go->SetGoState(GO_STATE_ACTIVE);
            }

            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr)
            {
                itr->GetSource()->RemoveAura(SPELL_SANITY);
                itr->GetSource()->RemoveAura(SPELL_INSANE1);
                itr->GetSource()->RemoveAura(SPELL_INSANE2);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_DESPAWN_ADDS)
                summons.DespawnAll();
            else if (param == ACTION_YOGG_SARON_APPEAR)
            {
                me->SetVisible(true);
                me->CastSpell(me, SPELL_SHADOW_BARRIER, true);
                me->CastSpell(me, SPELL_KNOCK_AWAY, true);
                me->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                me->SetInCombatWithZone();

                me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE | UNIT_FLAG_PACIFIED);
            }
            else if (param == ACTION_YOGG_SARON_START_YELL)
            {
                Talk(SAY_YOGG_SARON_SPAWN);
            }
            else if (param == ACTION_YOGG_SARON_OPEN_PORTAL_YELL)
            {
                Talk(SAY_YOGG_SARON_MADNESS);
                Talk(EMOTE_YOGG_SARON_MADNESS);
            }
            else if (param == ACTION_YOGG_SARON_START_P3)
            {
                me->SetHealth(me->GetMaxHealth() * 0.3f);
                me->LowerPlayerDamageReq(me->GetMaxHealth() * 0.7f);

                me->RemoveAura(SPELL_SHADOW_BARRIER);

                events.ScheduleEvent(EVENT_YS_LUNATIC_GAZE, 7000);
                events.ScheduleEvent(EVENT_YS_SHADOW_BEACON, 20000);
                events.ScheduleEvent(EVENT_YS_SUMMON_GUARDIAN, 0);
                _thirdPhase = true;

                Talk(SAY_YOGG_SARON_PHASE_3);
            }
            else if (param == ACTION_YOGG_SARON_HARD_MODE)
            {
                events.ScheduleEvent(EVENT_YS_DEAFENING_ROAR, 50000);
            }
            else if (param == ACTION_YOGG_SARON_SHADOW_BEACON)
            {
                events.RescheduleEvent(EVENT_YS_SHADOW_BEACON, 40000);
            }
            else if (param == ACTION_REMOVE_STUN)
            {
                me->RemoveAura(SPELL_SHATTERED_ILLUSION);
                me->SetControlled(true, UNIT_STATE_ROOT);
            }
            else if (param == ACTION_FAILED_DRIVE_ME_CRAZY)
                _usedInsane = true;
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_GET_DRIVE_ME_CRAZY)
                return !_usedInsane;

            return 0;
        }

        void SpellHit(Unit*  /*caster*/, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_IN_THE_MAWS_OF_THE_OLD_GOD)
                me->AddLootMode(32);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!_thirdPhase)
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_YS_LUNATIC_GAZE:
                    me->PlayDirectSound(YS_P3_LUNATIC_GAZE);
                    me->CastSpell(me, SPELL_LUNATIC_GAZE_YS, true);
                    events.Repeat(12s);
                    break;
                case EVENT_YS_DEAFENING_ROAR:
                    Talk(SAY_YOGG_SARON_DEAFENING_ROAR);
                    Talk(EMOTE_YOGG_SARON_DEAFENING_ROAR);
                    me->CastSpell(me, SPELL_DEAFENING_ROAR, false);
                    events.Repeat(50s);
                    break;
                case EVENT_YS_SHADOW_BEACON:
                    events.Repeat(5s);
                    Talk(EMOTE_YOGG_SARON_EMPOWERING_SHADOWS);
                    me->CastCustomSpell(SPELL_SHADOW_BEACON, SPELLVALUE_MAX_TARGETS, RAID_MODE(1, 3), me, false);
                    break;
                case EVENT_YS_SUMMON_GUARDIAN:
                    SummonImmortalGuardian();
                    events.Repeat(10s);
                    break;
            }
        }
    };
};

class boss_yoggsaron_brain : public CreatureScript
{
public:
    boss_yoggsaron_brain() : CreatureScript("boss_yoggsaron_brain") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_brainAI>(pCreature);
    }

    struct boss_yoggsaron_brainAI : public NullCreatureAI
    {
        boss_yoggsaron_brainAI(Creature* pCreature) : NullCreatureAI(pCreature), summons(pCreature)
        {
            me->SetDisableGravity(true);
            _tentacleCount = 0;
            _activeIllusion = 0;
            _induceTimer = 0;
            _brainDamaged = false;
            me->SetRegeneratingHealth(false);
        }

        bool _brainDamaged;
        uint8 _tentacleCount;
        uint8 _activeIllusion;
        uint32 _induceTimer;
        SummonList summons;

        void Reset() override { }
        void JustSummoned(Creature* cr) override
        {
            if (cr->GetEntry() == NPC_INFLUENCE_TENTACLE)
            {
                // Dragons Illusion
                if (cr->GetPositionX() > 2000.0f && cr->GetPositionX() < 2150.0f)
                    cr->UpdateEntry(urand(NPC_CONSORT_FIRST, NPC_CONSORT_LAST));
                // Icecrown Illusion
                else if (cr->GetPositionY() > -150.0f && cr->GetPositionY() < -90.0f)
                {
                    cr->SetStandState(UNIT_STAND_STATE_KNEEL);
                    cr->UpdateEntry(NPC_DEATHSWORN_ZEALOT);
                }
                // Stormwind Illusion
                else
                    cr->UpdateEntry(NPC_SUIT_OF_ARMOR);
            }
            else if (cr->GetEntry() == NPC_LICH_KING)
                cr->CastSpell(cr, SPELL_DEATHGRASP, false);

            summons.Summon(cr);
        }

        void PrepareChamberIllusion()
        {
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 2126.13f, -65.488f, 239.721f, 1.99171f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 2141.05f, -50.5146f, 239.751f, 2.72998f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 2148.83f, -23.9568f, 239.721f, 3.04807f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 2064.39f, -42.0691f, 239.719f, 0.0949586f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 2064.29f, -7.13128f, 239.756f, 5.96974f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 2117.31f, 14.897f, 239.731f, 4.32041f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 2136.7f, 2.43262f, 239.72f, 3.90023f);

            // Laughing Skulls
            if (urand(0, 1))
                me->SummonCreature(NPC_LAUGHING_SKULL, 2139.13f, -59.0848f, 239.728f, 2.2974f);
            else
                me->SummonCreature(NPC_LAUGHING_SKULL, 2083, -25.66f, 244, 0);
            if (urand(0, 1))
                me->SummonCreature(NPC_LAUGHING_SKULL, 2066.67f, -59.8984f, 239.72f, 0.718747f);
            else
                me->SummonCreature(NPC_LAUGHING_SKULL, 2126.22f, -25.86f, 244, 0);

            me->SummonCreature(NPC_LAUGHING_SKULL, 2133.09f, 15.341f, 239.72f, 4.0724f);
            me->SummonCreature(NPC_LAUGHING_SKULL, 2065.83f, 12.3772f, 239.792f, 5.49789f);

            // Aspects
            me->SummonCreature(NPC_ALEXTRASZA, 2091.92f, -25.8f, 242.647f, 0);
            me->SummonCreature(NPC_YSERA, 2116, -25.8f, 242.647f, 3.14f);
            me->SummonCreature(NPC_NELTHARION, 2103.6f, -35.8f, 242.64f, 1.5f);
            me->SummonCreature(NPC_MALYGOS, 2103.6f, -15.8f, 242.64f, 4.7f);

            // Yogg Vision
            me->SummonCreature(NPC_YOGG_SARON_VISION, 2109.695f, -25.09549f, 222.3250f, 0);
        }

        void PrepareIceCrownIllusion()
        {
            // Laughing Skulls
            me->SummonCreature(NPC_LAUGHING_SKULL, 1931.12f, -92.702f, 239.991f, 5.2819f);
            if (urand(0, 1))
                me->SummonCreature(NPC_LAUGHING_SKULL, 1969.88f, -147.729f, 239.991f, 2.37593f);
            else
                me->SummonCreature(NPC_LAUGHING_SKULL, 1878, -93.3f, 240, 0);
            if (urand(0, 1))
                me->SummonCreature(NPC_LAUGHING_SKULL, 1950.78f, -167.902f, 239.991f, 2.34844f);
            else
                me->SummonCreature(NPC_LAUGHING_SKULL, 1938.45f, -116.5f, 240, 0);
            if (urand(0, 1))
                me->SummonCreature(NPC_LAUGHING_SKULL, 1896.45f, -141.469f, 239.991f, 6.12227f);
            else
                me->SummonCreature(NPC_LAUGHING_SKULL, 1921, -158, 240, 0);

            // Influence
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1958.29f, -128.65f, 239.99f, 3.61293f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1957.78f, -134.368f, 239.99f, 3.35375f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1953.04f, -137.843f, 239.99f, 3.55796f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1900.31f, -93.5241f, 239.99f, 4.50043f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1895.03f, -98.0773f, 239.99f, 4.88135f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1895.19f, -104.587f, 239.99f, 5.02271f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1923.31f, -125.98f, 240, 4.2f);

            // Others
            me->SummonCreature(NPC_LICH_KING, 1906.98f, -153, 240, 4.2f);
            me->SummonCreature(NPC_IMMOLATED_CHAMPION, 1902.03f, -161.7f, 240, 1.07f);

            // Yogg Vision
            me->SummonCreature(NPC_YOGG_SARON_VISION, 1906.226f, -155.8941f, 223.4727, 0);
        }

        void PrepareStormwindIllusion()
        {
            // Laughing Skulls
            if (urand(0, 1))
                me->SummonCreature(NPC_LAUGHING_SKULL, 1916.36f, 28.05f, 239.666f, 1.30238f);
            else
                me->SummonCreature(NPC_LAUGHING_SKULL, 1966.7f, 57.8f, 239.66f, 0);
            if (urand(0, 1))
                me->SummonCreature(NPC_LAUGHING_SKULL, 1902, 75.1362f, 239.666f, 6.06189f);
            else
                me->SummonCreature(NPC_LAUGHING_SKULL, 1933, 91, 240, 0);
            me->SummonCreature(NPC_LAUGHING_SKULL, 1914.42f, 90.8465f, 239.666f, 5.25294f);
            me->SummonCreature(NPC_LAUGHING_SKULL, 1963.68f, 89.7549f, 239.667f, 3.70571f);

            // Influence
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1931.41f, 39.0711f, 239.66f, 1.82467f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1908.67f, 45.5867f, 239.666f, 0.72119f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1897.68f, 66.1274f, 239.666f, 6.27395f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1950.73f, 49.3446f, 239.666f, 2.63756f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1923.16f, 97.5586f, 239.666f, 4.74635f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1956.16f, 72.1403f, 239.666f, 3.19518f);
            me->SummonCreature(NPC_INFLUENCE_TENTACLE, 1944.81f, 92.3154f, 239.666f, 4.03556f);

            // Others
            me->SummonCreature(NPC_GARONA, 1928.58f, 65.64f, 242.37f, 2.1f);
            me->SummonCreature(NPC_KING_LLANE, 1925.14f, 71.74f, 242.37f, 5.17f);

            // Yogg Vision
            me->SummonCreature(NPC_YOGG_SARON_VISION, 1929.160f, 67.75694f, 221.7322f, 0);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_DESPAWN_ADDS)
            {
                summons.DespawnAll();
                return;
            }
            else if (param == ACTION_INFLUENCE_TENTACLE_DIED)
            {
                _tentacleCount++;
                if (_tentacleCount >= 7 /*TENTACLES COUNT*/)
                {
                    // Stun
                    if (me->GetInstanceScript())
                        if(Creature* sara = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(NPC_SARA)))
                            sara->AI()->DoAction(MINUTE * IN_MILLISECONDS - std::min((uint32)MINUTE * IN_MILLISECONDS, _induceTimer));

                    _induceTimer = 0;
                    summons.DespawnEntry(NPC_LAUGHING_SKULL);
                    if (GameObject* go = me->FindNearestGameObject(GO_CHAMBER_ILLUSION_DOORS + _activeIllusion, 150.0f))
                        go->SetGoState(GO_STATE_ACTIVE);
                }
                return;
            }
            else if (param == ACTION_REMOVE_STUN)
                return;

            summons.DespawnAll();
            switch(param)
            {
                case ACTION_ILLUSION_STORMWIND:
                    PrepareStormwindIllusion();
                    break;
                case ACTION_ILLUSION_DRAGONS:
                    PrepareChamberIllusion();
                    break;
                case ACTION_ILLUSION_ICECROWN:
                    PrepareIceCrownIllusion();
                    break;
            }

            for (uint32 i = GO_CHAMBER_ILLUSION_DOORS; i <= GO_STORMWIND_ILLUSION_DOORS; ++i)
                if (GameObject* go = me->FindNearestGameObject(i, 150.0f))
                    go->SetGoState(GO_STATE_READY);

            _activeIllusion = param - 1;
            _tentacleCount = 0;
            _induceTimer = 1;

            me->CastSpell(me, SPELL_INDUCE_MADNESS, false);
        }

        uint32 GetData(uint32 param) const override
        {
            if (param == DATA_GET_CURRENT_ILLUSION)
                return _activeIllusion + 1;

            return 0;
        }

        void DamageTaken(Unit* who, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_tentacleCount < 7) // if all tentacles aren't killed
            {
                damage = 0;
                if (who)
                    Unit::Kill(who, who);
                return;
            }

            if (!_brainDamaged)
            {
                // START PHASE 3
                if (me->HealthBelowPctDamaged(30, damage))
                {
                    me->SetRegeneratingHealth(false);
                    _EnterEvadeMode();
                    _brainDamaged = true;

                    me->CastSpell(me, SPELL_BRAIN_HURT_VISUAL, true);
                    if (me->GetInstanceScript())
                        if(Creature* sara = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(NPC_SARA)))
                            sara->AI()->DoAction(ACTION_BRAIN_DAMAGED);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_induceTimer)
                _induceTimer += diff;
        }
    };
};

class boss_yoggsaron_death_orb : public CreatureScript
{
public:
    boss_yoggsaron_death_orb() : CreatureScript("boss_yoggsaron_death_orb") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_death_orbAI>(pCreature);
    }

    struct boss_yoggsaron_death_orbAI : public NullCreatureAI
    {
        boss_yoggsaron_death_orbAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            me->CastSpell(me, SPELL_DEATH_RAY_WARNING, true);
            _startTimer = 1;
        }

        uint32 _startTimer;

        void UpdateAI(uint32 diff) override
        {
            if (_startTimer)
            {
                _startTimer += diff;
                if (_startTimer > 4000)
                {
                    me->CastSpell(me, SPELL_DEATH_RAY_DAMAGE_VISUAL, true);
                    me->CastSpell(me, SPELL_DEATH_RAY_DAMAGE, true);

                    _startTimer = 0;
                    me->SetSpeed(MOVE_WALK, 2);
                    me->SetSpeed(MOVE_RUN, 2);
                    me->GetMotionMaster()->MoveRandom(20.0f);
                }
            }
        }
    };
};

class boss_yoggsaron_crusher_tentacle : public CreatureScript
{
public:
    boss_yoggsaron_crusher_tentacle() : CreatureScript("boss_yoggsaron_crusher_tentacle") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_crusher_tentacleAI>(pCreature);
    }

    struct boss_yoggsaron_crusher_tentacleAI : public ScriptedAI
    {
        boss_yoggsaron_crusher_tentacleAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetCombatMovement(false);
            me->CastSpell(me, SPELL_CRUSH, true);
            me->CastSpell(me, SPELL_FOCUSED_ANGER, true);
            me->CastSpell(me, SPELL_DIMINISH_POWER, false);
        }

        void Reset() override
        {
            me->SetInCombatWithZone();
        }

        void DamageTaken(Unit* who, uint32&, DamageEffectType damagetype, SpellSchoolMask) override
        {
            if (who && damagetype == DIRECT_DAMAGE)
            {
                DoResetThreatList();
                me->AddThreat(who, 100000);
                AttackStart(who);
                me->InterruptNonMeleeSpells(false);
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_REMOVE_STUN)
                me->RemoveAura(SPELL_SHATTERED_ILLUSION);
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            if (me->IsWithinMeleeRange(me->GetVictim()))
            {
                DoMeleeAttackIfReady();
                return;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            me->CastSpell(me, SPELL_DIMINISH_POWER, false);
            DoResetThreatList();
        }
    };
};

class boss_yoggsaron_corruptor_tentacle : public CreatureScript
{
public:
    boss_yoggsaron_corruptor_tentacle() : CreatureScript("boss_yoggsaron_corruptor_tentacle") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_corruptor_tentacleAI>(pCreature);
    }

    struct boss_yoggsaron_corruptor_tentacleAI : public ScriptedAI
    {
        boss_yoggsaron_corruptor_tentacleAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetCombatMovement(false);
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_REMOVE_STUN)
                me->RemoveAura(SPELL_SHATTERED_ILLUSION);
        }

        Unit* SelectCorruptionTarget()
        {
            Player* target = nullptr;
            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            uint8 num = urand(0, pList.getSize() - 1);
            uint8 count = 0;
            for (Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr, ++count)
            {
                if (me->GetDistance(itr->GetSource()) > 200 || itr->GetSource()->GetPositionZ() < 300 || !itr->GetSource()->IsAlive() || itr->GetSource()->IsGameMaster())
                    continue;

                if (count <= num || !target)
                    target = itr->GetSource();
                else
                    break;
            }

            return target;
        }

        void UpdateAI(uint32  /*diff*/) override
        {
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (Unit* target = SelectCorruptionTarget())
            {
                uint32 spellid = RAND(SPELL_APATHY, SPELL_BLACK_PLAGUE, SPELL_DRAINING_POISON, SPELL_CURSE_OF_DOOM);
                me->CastSpell(target, spellid, false);
            }
        }
    };
};

class boss_yoggsaron_constrictor_tentacle : public CreatureScript
{
public:
    boss_yoggsaron_constrictor_tentacle() : CreatureScript("boss_yoggsaron_constrictor_tentacle") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_constrictor_tentacleAI>(pCreature);
    }

    struct boss_yoggsaron_constrictor_tentacleAI : public ScriptedAI
    {
        boss_yoggsaron_constrictor_tentacleAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            me->SetCombatMovement(false);
            _checkTimer = 1;
            _playerGUID.Clear();
        }

        uint32 _checkTimer;
        ObjectGuid _playerGUID;

        Unit* SelectConstrictTarget()
        {
            Player* target = nullptr;
            Map::PlayerList const& pList = me->GetMap()->GetPlayers();
            uint8 num = urand(0, pList.getSize() - 1);
            uint8 count = 0;
            for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr, ++count)
            {
                if (me->GetDistance(itr->GetSource()) > 10 || !itr->GetSource()->IsAlive() || itr->GetSource()->IsGameMaster())
                    continue;
                if (itr->GetSource()->HasAura(SPELL_SQUEEZE) || itr->GetSource()->HasAura(SPELL_INSANE1))
                    continue;

                if (count <= num || !target)
                    target = itr->GetSource();
                else
                    break;
            }

            return target;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_checkTimer)
            {
                _checkTimer += diff;
                if (_checkTimer >= 1000 && !me->HasUnitState(UNIT_STATE_STUNNED))
                {
                    if (Unit* target = SelectConstrictTarget())
                    {
                        target->CastSpell(me, SPELL_LUNGE, true);
                        target->CastSpell(target, SPELL_SQUEEZE, true);
                        _playerGUID = target->GetGUID();
                        _checkTimer = 0;
                        return;
                    }

                    _checkTimer = 1;
                }
            }
        }

        void DoAction(int32 param) override
        {
            if (param == ACTION_REMOVE_STUN)
                me->RemoveAura(SPELL_SHATTERED_ILLUSION);
        }

        void JustDied(Unit*) override
        {
            if (Unit* player = ObjectAccessor::GetUnit(*me, _playerGUID))
                player->RemoveAura(SPELL_SQUEEZE);
        }
    };
};

struct boss_yoggsaron_keeper : public NullCreatureAI
{
    boss_yoggsaron_keeper(Creature* creature) : NullCreatureAI(creature), _summons(creature) { }

    void DoAction(int32 param) override
    {
        if (me->GetEntry() == NPC_THORIM_KEEPER && param == ACTION_THORIM_START_STORM)
            me->CastSpell(me, SPELL_TITANIC_STORM_PASSIVE, false);
        else if (param == ACTION_DESPAWN_ADDS)
            _summons.DespawnAll();
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        switch (me->GetEntry())
        {
            case NPC_FREYA_KEEPER:
                me->AddAura(SPELL_FREYA_PASSIVE, me);
                me->CastSpell(me, SPELL_CONJURE_SANITY_WELL, false);
                break;
            case NPC_HODIR_KEEPER:
                me->AddAura(SPELL_HODIR_PASSIVE, me);
                me->AddAura(SPELL_PROTECTIVE_GAZE, me);
                break;
            case NPC_MIMIRON_KEEPER:
                me->AddAura(SPELL_MIMIRON_PASSIVE, me);
                scheduler.Schedule(2s, [this](TaskContext context)
                {
                    if (!me->HasUnitState(UNIT_STATE_CASTING))
                        me->CastSpell(me, SPELL_DESTABILIZATION_MATRIX, false);
                    context.Repeat(2s);
                });
                break;
            case NPC_THORIM_KEEPER:
                me->AddAura(SPELL_THORIM_PASSIVE, me);
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);
    }
private:
    SummonList _summons;
};

class boss_yoggsaron_descend_portal : public CreatureScript
{
public:
    boss_yoggsaron_descend_portal() : CreatureScript("boss_yoggsaron_descend_portal") { }

    struct boss_yoggsaron_descend_portalAI : public PassiveAI
    {
        boss_yoggsaron_descend_portalAI(Creature* creature) : PassiveAI(creature), _instance(creature->GetInstanceScript()) {}

        void OnSpellClick(Unit* clicker, bool& spellClickHandled) override
        {
            if (!spellClickHandled)
                return;

            if (!me->GetUInt32Value(UNIT_NPC_FLAGS))
                return;

            switch (me->GetArmor())
            {
                case ACTION_ILLUSION_DRAGONS:
                    clicker->CastSpell(clicker, SPELL_TELEPORT_TO_CHAMBER, true);
                    break;
                case ACTION_ILLUSION_ICECROWN:
                    clicker->CastSpell(clicker, SPELL_TELEPORT_TO_ICECROWN, true);
                    break;
                case ACTION_ILLUSION_STORMWIND:
                    clicker->CastSpell(clicker, SPELL_TELEPORT_TO_STORMWIND, true);
                    break;
            }

            me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
            me->DespawnOrUnsummon(1000);
        }

    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetUlduarAI<boss_yoggsaron_descend_portalAI>(creature);
    }
};

class boss_yoggsaron_influence_tentacle : public CreatureScript
{
public:
    boss_yoggsaron_influence_tentacle() : CreatureScript("boss_yoggsaron_influence_tentacle") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_influence_tentacleAI>(pCreature);
    }

    struct boss_yoggsaron_influence_tentacleAI : public NullCreatureAI
    {
        boss_yoggsaron_influence_tentacleAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            me->CastSpell(me, SPELL_GRIM_REPRISAL, true);
        }

        void DamageTaken(Unit*, uint32&, DamageEffectType, SpellSchoolMask) override
        {
            if (me->GetEntry() != NPC_INFLUENCE_TENTACLE)
                me->UpdateEntry(NPC_INFLUENCE_TENTACLE, 0, false);
        }

        void JustDied(Unit*) override
        {
            if (me->IsSummon())
                if (Unit* sara = me->ToTempSummon()->GetSummonerUnit())
                    sara->GetAI()->DoAction(ACTION_INFLUENCE_TENTACLE_DIED);
        }
    };
};

class boss_yoggsaron_immortal_guardian : public CreatureScript
{
public:
    boss_yoggsaron_immortal_guardian() : CreatureScript("boss_yoggsaron_immortal_guardian") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_immortal_guardianAI>(pCreature);
    }

    struct boss_yoggsaron_immortal_guardianAI : public ScriptedAI
    {
        boss_yoggsaron_immortal_guardianAI(Creature* pCreature) : ScriptedAI(pCreature)
        {
            Reset();
        }

        uint32 _visualTimer;
        uint32 _spellTimer;

        void Reset() override
        {
            me->CastSpell(me, SPELL_RECENTLY_SPAWNED, true);
            //me->CastSpell(me, SPELL_EMPOWERED_PASSIVE, true);
            if (Aura* aur = me->AddAura(SPELL_EMPOWERED_PASSIVE, me))
                aur->SetStackAmount(9);

            _spellTimer = 0;
            _visualTimer = 1;
            me->SetControlled(true, UNIT_STATE_ROOT);
            me->SetInCombatWithZone();
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_SHADOW_BEACON)
                caster->GetAI()->DoAction(ACTION_YOGG_SARON_SHADOW_BEACON);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (_visualTimer)
            {
                _visualTimer += diff;
                if (_visualTimer >= 100 && _visualTimer < 10000 )
                {
                    me->CastSpell(me, SPELL_SIMPLE_TELEPORT, false);
                    _visualTimer = 10000;
                }
                else if (_visualTimer >= 11000)
                {
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    _visualTimer = 0;
                }
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            _spellTimer += diff;
            if (_spellTimer >= 9500)
            {
                if (me->HealthBelowPct(85))
                {
                    if (Unit* target = SelectTargetFromPlayerList(40.0f))
                    {
                        me->CastSpell(target, SPELL_DRAIN_LIFE, false);
                        _spellTimer = 0;
                    }
                }
                else
                    _spellTimer = 7500;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class boss_yoggsaron_lich_king : public CreatureScript
{
public:
    boss_yoggsaron_lich_king() : CreatureScript("boss_yoggsaron_lich_king") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_lich_kingAI>(pCreature);
    }

    struct boss_yoggsaron_lich_kingAI : public NullCreatureAI
    {
        boss_yoggsaron_lich_kingAI(Creature* c) : NullCreatureAI(c) { }

        bool _running;
        int32 _checkTimer;
        uint8 _step;

        void Reset() override
        {
            _running = true;
            _checkTimer = 0;
            _step = 0;
        }

        void NextStep(const uint32 time)
        {
            _step++;
            _checkTimer = time;
        }

        void Say(uint8 text, uint32 id)
        {
            Creature* creature = me->FindNearestCreature(id, 50);
            if (!creature)
                return;

            creature->AI()->Talk(text);
                return;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!_running)
                return;

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
                        NextStep(5000);
                        break;
                    case 1:
                        Say(SAY_LK_1, NPC_LICH_KING);
                        NextStep(7000);
                        break;
                    case 2:
                        Say(SAY_IC_1, NPC_IMMOLATED_CHAMPION);
                        NextStep(6000);
                        break;
                    case 3:
                        Say(SAY_IC_2, NPC_IMMOLATED_CHAMPION);
                        NextStep(6500);
                        break;
                    case 4:
                        Say(SAY_LK_2, NPC_LICH_KING);
                        NextStep(7500);
                        break;
                    case 5:
                        Say(SAY_YOGG_5, NPC_YOGG_SARON_VISION);
                        NextStep(5000);
                        break;
                    case 6:
                        Say(SAY_YOGG_6, NPC_YOGG_SARON_VISION);
                        _running = false;
                        break;
                }
        }
    };
};

class boss_yoggsaron_llane : public CreatureScript
{
public:
    boss_yoggsaron_llane() : CreatureScript("boss_yoggsaron_llane") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_llaneAI>(pCreature);
    }

    struct boss_yoggsaron_llaneAI : public NullCreatureAI
    {
        boss_yoggsaron_llaneAI(Creature* c) : NullCreatureAI(c) { }

        bool _running;
        int32 _checkTimer;
        uint8 _step;

        void Reset() override
        {
            _running = true;
            _checkTimer = 0;
            _step = 0;
        }

        void NextStep(const uint32 time)
        {
            _step++;
            _checkTimer = time;
        }

        void Say(uint8 text, uint32 id)
        {
            Creature* creature = me->FindNearestCreature(id, 50);
            if (!creature)
                return;

            creature->AI()->Talk(text);
                return;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!_running)
                return;

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
                        NextStep(5000);
                        break;
                    case 1:
                        Say(SAY_GARONA_1, NPC_GARONA);
                        NextStep(2000);
                        break;
                    case 2:
                        Say(SAY_GARONA_2, NPC_GARONA);
                        NextStep(6500);
                        break;
                    case 3:
                        Say(SAY_GARONA_3, NPC_GARONA);
                        NextStep(11000);
                        break;
                    case 4:
                        Say(SAY_YOGG_1, NPC_YOGG_SARON_VISION);
                        NextStep(2500);
                        break;
                    case 5:
                        Say(SAY_YOGG_2, NPC_YOGG_SARON_VISION);
                        NextStep(2500);
                        break;
                    case 6:
                        Say(SAY_LLANE_1, NPC_KING_LLANE);
                        NextStep(10000);
                        break;
                    case 7:
                        Say(SAY_GARONA_4, NPC_GARONA);
                        NextStep(5000);
                        break;
                    case 8:
                        Say(SAY_YOGG_3, NPC_YOGG_SARON_VISION);
                        _running = false;
                        break;
                }
        }
    };
};

class boss_yoggsaron_neltharion : public CreatureScript
{
public:
    boss_yoggsaron_neltharion() : CreatureScript("boss_yoggsaron_neltharion") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_neltharionAI>(pCreature);
    }

    struct boss_yoggsaron_neltharionAI : public ScriptedAI
    {
        boss_yoggsaron_neltharionAI(Creature* c) : ScriptedAI(c) { }

        bool _running;
        int32 _checkTimer;
        uint8 _step;

        void Reset() override
        {
            _running = true;
            _checkTimer = 0;
            _step = 0;
        }

        void NextStep(const uint32 time)
        {
            _step++;
            _checkTimer = time;
        }

        void Say(uint8 text, uint32 id)
        {
            Creature* creature = me->FindNearestCreature(id, 50);
            if (!creature)
                return;

            creature->AI()->Talk(text);
                return;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!_running)
                return;

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
                        NextStep(5000);
                        break;
                    case 1:
                        Say(SAY_NEL_1, NPC_NELTHARION);
                        NextStep(10000);
                        break;
                    case 2:
                        Say(SAY_YAS_1, NPC_YSERA);
                        NextStep(4000);
                        break;
                    case 3:
                        Say(SAY_NEL_2, NPC_NELTHARION);
                        NextStep(4000);
                        break;
                    case 4:
                        Say(SAY_MAL_1, NPC_MALYGOS);
                        NextStep(8000);
                        break;
                    case 5:
                        Say(SAY_YOGG_4, NPC_YOGG_SARON_VISION);
                        _running = false;
                        break;
                }
        }
    };
};

class boss_yoggsaron_voice : public CreatureScript
{
public:
    boss_yoggsaron_voice() : CreatureScript("boss_yoggsaron_voice") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetUlduarAI<boss_yoggsaron_voiceAI>(pCreature);
    }

    struct boss_yoggsaron_voiceAI : public NullCreatureAI
    {
        boss_yoggsaron_voiceAI(Creature* pCreature) : NullCreatureAI(pCreature)
        {
            _targets.clear();
            _current = 0;
        }

        EventMap events;
        GuidVector _targets;
        uint32 _current;

        void Reset() override
        {
            me->CastSpell(me, SPELL_INSANE_PERIODIC, true);
        }

        void SpellHitTarget(Unit* target, SpellInfo const* spellInfo) override
        {
            if (spellInfo->Id == SPELL_INSANE1)
            {
                // Drive Me Crazy achievement failed
                if (me->GetInstanceScript())
                    if (Creature* yogg = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(TYPE_YOGGSARON)))
                        yogg->AI()->DoAction(ACTION_FAILED_DRIVE_ME_CRAZY);

                events.ScheduleEvent(40, 2s);
                _targets.push_back(target->GetGUID());
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            switch (events.ExecuteEvent())
            {
                case 40:
                    {
                        ObjectGuid _guid = _targets.at(_current);
                        ++_current;

                        if (Player* player = ObjectAccessor::GetPlayer(*me, _guid))
                        {
                            Talk(WHISPER_VOICE_INSANE, player);
                        }
                        break;
                    }
            }
        }
    };
};

// 63830, 63881 - Malady of the Mind
class spell_yogg_saron_malady_of_the_mind_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_malady_of_the_mind_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DEATH_RAY_DAMAGE_REAL, SPELL_MALADY_OF_THE_MIND_TRIGGER });
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ApplySpellImmune(SPELL_DEATH_RAY_DAMAGE_REAL, IMMUNITY_ID, SPELL_DEATH_RAY_DAMAGE_REAL, true);
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetUnitOwner()->ApplySpellImmune(SPELL_DEATH_RAY_DAMAGE_REAL, IMMUNITY_ID, SPELL_DEATH_RAY_DAMAGE_REAL, false);
        GetUnitOwner()->CastCustomSpell(SPELL_MALADY_OF_THE_MIND_TRIGGER, SPELLVALUE_MAX_TARGETS, 1, GetUnitOwner(), true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_yogg_saron_malady_of_the_mind_aura::OnApply, EFFECT_1, SPELL_AURA_MOD_FEAR, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_yogg_saron_malady_of_the_mind_aura::OnRemove, EFFECT_1, SPELL_AURA_MOD_FEAR, AURA_EFFECT_HANDLE_REAL);
    }
};

// 63802 - Brain Link
class spell_yogg_saron_brain_link : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_brain_link);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        std::list<WorldObject*> tempList;
        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if ((*itr)->GetPositionZ() > 300.0f)
                tempList.push_back(*itr);

        targets.clear();
        for (std::list<WorldObject*>::iterator itr = tempList.begin(); itr != tempList.end(); ++itr)
            targets.push_back(*itr);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_yogg_saron_brain_link::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_yogg_saron_brain_link_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_brain_link_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BRAIN_LINK_DAMAGE, SPELL_BRAIN_LINK_OK });
    }

    void HandleOnEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        PreventDefaultAction();
        Player* target = nullptr;
        Map::PlayerList const& pList = GetUnitOwner()->GetMap()->GetPlayers();
        uint8 _offset = urand(0, pList.getSize() - 1);
        uint8 _counter = 0;
        for(Map::PlayerList::const_iterator itr = pList.begin(); itr != pList.end(); ++itr, ++_counter)
        {
            if (itr->GetSource() == GetUnitOwner() || GetUnitOwner()->GetDistance(itr->GetSource()) > 50.0f || !itr->GetSource()->IsAlive() || itr->GetSource()->IsGameMaster())
                continue;

            if (_counter <= _offset || !target)
                target = itr->GetSource();
            else
                break;
        }

        if (!target)
            SetDuration(0);
        else
            _targetGUID = target->GetGUID();
    }

    void OnPeriodic(AuraEffect const*  /*aurEff*/)
    {
        Unit* owner = GetUnitOwner();
        if (!owner)
        {
            SetDuration(0);
            return;
        }

        Unit* _target = ObjectAccessor::GetUnit(*owner, _targetGUID);
        if (!_target || !_target->IsAlive() || std::fabs(owner->GetPositionZ() - _target->GetPositionZ()) > 10.0f) // Target or owner underground
        {
            SetDuration(0);
            return;
        }

        if (owner->GetDistance(_target) > 20.0f)
        {
            owner->CastSpell(_target, SPELL_BRAIN_LINK_DAMAGE, true);
            owner->CastSpell(owner, SPELL_BRAIN_LINK_DAMAGE, true);
        }
        else
            owner->CastSpell(_target, SPELL_BRAIN_LINK_OK, true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_yogg_saron_brain_link_aura::HandleOnEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_yogg_saron_brain_link_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }

protected:
    ObjectGuid _targetGUID;
};

// 64465 - Shadow Beacon
class spell_yogg_saron_shadow_beacon_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_shadow_beacon_aura);

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* target = GetTarget()->ToCreature())
            {
                target->SetEntry(NPC_MARKED_IMMORTAL_GUARDIAN);
            }
        }

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Creature* target = GetTarget()->ToCreature())
            {
                target->SetEntry(NPC_IMMORTAL_GUARDIAN);
            }
        }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_yogg_saron_shadow_beacon_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_yogg_saron_shadow_beacon_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

// 65206 - Destabilization Matrix
class spell_yogg_saron_destabilization_matrix : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_destabilization_matrix);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DESTABILIZATION_MATRIX_ATTACK });
    }

    void HandleDummyEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, SPELL_DESTABILIZATION_MATRIX_ATTACK, false);
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        WorldObject* target = nullptr;
        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if (!(*itr)->ToUnit()->HasAura(SPELL_DESTABILIZATION_MATRIX_ATTACK))
            {
                target = *itr;
                break;
            }

        targets.clear();
        if (target)
            targets.push_back(target);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_yogg_saron_destabilization_matrix::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_yogg_saron_destabilization_matrix::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
    }
};

// 64172 - Titanic Storm
class spell_yogg_saron_titanic_storm : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_titanic_storm);

    void HandleDummyEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            Unit::Kill(GetCaster(), target);
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        WorldObject* target = nullptr;
        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if ((*itr)->ToUnit()->HasAura(SPELL_WEAKENED))
            {
                target = *itr;
                break;
            }

        targets.clear();
        if (target)
            targets.push_back(target);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_yogg_saron_titanic_storm::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_yogg_saron_titanic_storm::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
    }
};

// 64164, 64168 - Lunatic Gaze
class spell_yogg_saron_lunatic_gaze : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_lunatic_gaze);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        std::list<WorldObject*> tmplist;
        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if ((*itr)->HasInArc(M_PI, GetCaster()))
                tmplist.push_back(*itr);

        targets.clear();
        for (std::list<WorldObject*>::iterator itr = tmplist.begin(); itr != tmplist.end(); ++itr)
            targets.push_back(*itr);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_yogg_saron_lunatic_gaze::FilterTargets, EFFECT_ALL, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// 64174 - Protective Gaze
class spell_yogg_saron_protective_gaze_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_protective_gaze_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HODIR_FLASH_FREEZE });
    }

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        Unit* target = GetTarget();
        if (dmgInfo.GetDamage() < target->GetHealth() || !GetCaster() || GetCaster()->ToCreature()->HasSpellCooldown(SPELL_HODIR_FLASH_FREEZE))
            return;

        target->CastSpell(target, SPELL_HODIR_FLASH_FREEZE, true);
        GetCaster()->AddSpellCooldown(SPELL_HODIR_FLASH_FREEZE, 0, 0);
        absorbAmount = dmgInfo.GetDamage();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_yogg_saron_protective_gaze_aura::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_yogg_saron_protective_gaze_aura::Absorb, EFFECT_0);
    }
};

// 64161 - Empowered
class spell_yogg_saron_empowered_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_empowered_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EMPOWERED, SPELL_WEAKENED });
    }

    void OnPeriodic(AuraEffect const*  /*aurEff*/)
    {
        Unit* target = GetUnitOwner();
        uint8 stack = std::min(uint8(target->GetHealthPct() / 10), (uint8)9);

        if (!stack)
        {
            target->RemoveAura(SPELL_EMPOWERED);
            target->CastSpell(target, SPELL_WEAKENED, true);
        }
        else if (Aura* aur = target->AddAura(SPELL_EMPOWERED, target))
        {
            aur->SetStackAmount(stack);
            target->RemoveAurasDueToSpell(SPELL_WEAKENED);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_yogg_saron_empowered_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 64555 - Insane Periodic
class spell_yogg_saron_insane_periodic_trigger : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_insane_periodic_trigger);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_INSANE1, SPELL_INSANE2 });
    }

    void HandleDummyEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Player* target = GetHitPlayer();
        if (!target)
            return;

        Unit* caster = GetCaster();
        caster->CastSpell(target, SPELL_INSANE1, true);
        target->CastSpell(target, SPELL_INSANE2, true);
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        std::list<WorldObject*> tmplist;
        for (std::list<WorldObject*>::iterator itr = targets.begin(); itr != targets.end(); ++itr)
            if ((*itr)->IsPlayer() && !(*itr)->ToPlayer()->HasAuraType(SPELL_AURA_AOE_CHARM) && !(*itr)->ToPlayer()->HasAura(SPELL_SANITY))
                tmplist.push_back(*itr);

        targets.clear();
        for (std::list<WorldObject*>::iterator itr = tmplist.begin(); itr != tmplist.end(); ++itr)
            targets.push_back(*itr);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_yogg_saron_insane_periodic_trigger::HandleDummyEffect, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_yogg_saron_insane_periodic_trigger::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// 63120 - Insane
class spell_yogg_saron_insane_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_insane_aura);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit::Kill(GetUnitOwner(), GetUnitOwner());
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_yogg_saron_insane_aura::OnRemove, EFFECT_0, SPELL_AURA_AOE_CHARM, AURA_EFFECT_HANDLE_REAL);
    }
};

// 64169 - Sanity Well
class spell_yogg_saron_sanity_well_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_sanity_well_aura);

    void HandleEffectCalcPeriodic(AuraEffect const* /*aurEff*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = 2 * IN_MILLISECONDS;
    }

    void HandleEffectPeriodic(AuraEffect const*   /*aurEff*/)
    {
        Unit* target = GetTarget();
        if (!target || !target->IsPlayer())
            return;

        if (Aura* aur = target->GetAura(SPELL_SANITY))
            aur->SetStackAmount(std::min(100, aur->GetStackAmount() + 20));
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_yogg_saron_sanity_well_aura::HandleEffectCalcPeriodic, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_yogg_saron_sanity_well_aura::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    }
};

const Position SanityWellsPos[5] =
{
    {2042.56f,  -40.3667f,  329.274f,  0.0f},
    {1975.89f,   40.0216f,    331.1f,  0.0f},
    {1987.12f,  -91.2702f,  330.186f,  0.0f},
    {1900.48f,  -51.2386f,   332.13f,  0.0f},
    {1899.94f,  0.330621f,  332.296f,  0.0f}
};

// 64170 - Sanity Well
class spell_keeper_freya_summon_sanity_well : public SpellScript
{
    PrepareSpellScript(spell_keeper_freya_summon_sanity_well);

    void OnEffect(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            for (int i = 0; i < 5; i++)
                caster->SummonCreature(NPC_SANITY_WELL, SanityWellsPos[i]);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_keeper_freya_summon_sanity_well::OnEffect, EFFECT_0, SPELL_EFFECT_SEND_EVENT);
    }
};

/* 63881 - Malady of the Mind
   63795 - Psychosis
   63830 - Malady of the Mind
   64164 - Lunatic Gaze
   64059 - Induce Madness
   63803 - Brain Link
   65301 - Psychosis
   64168 - Lunatic Gaze */
enum SanityReduce
{
    SPELL_SANITY_SCREEN_EFFECT    = 63752,
    SPELL_LUNATIC_GAZE_TRIGGER    = 64168,
    SPELL_YS_LUNATIC_GAZE_TRIGGER = 64164
};

class spell_yogg_saron_sanity_reduce : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_sanity_reduce);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CANCEL_ILLUSION_AURA, SPELL_SANITY_SCREEN_EFFECT });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Player* target = GetHitPlayer();
        if (!target)
            return;

        uint8 _reduceAmount = 0;
        switch (GetSpellInfo()->Id)
        {
            case SPELL_SARA_PSYCHOSIS_10:
                _reduceAmount = 9;
                break;
            case SPELL_SARA_PSYCHOSIS_25:
                _reduceAmount = 12;
                break;
            case SPELL_MALADY_OF_THE_MIND:
                _reduceAmount = 3;
                break;
            case SPELL_MALADY_OF_THE_MIND_TRIGGER:
                _reduceAmount = 3;
                break;
            case SPELL_BRAIN_LINK_DAMAGE:
                _reduceAmount = 2;
                break;
            case SPELL_LUNATIC_GAZE_TRIGGER:
                _reduceAmount = 2;
                break;
            case SPELL_YS_LUNATIC_GAZE_TRIGGER:
                _reduceAmount = 4;
                break;
            case SPELL_INDUCE_MADNESS:
                // Teleported out of brain
                if (target->GetPositionZ() > 300.0f)
                    return;
                else
                    target->CastSpell(target, SPELL_CANCEL_ILLUSION_AURA, true); // else we are underground, remove illusion aura and teleport outside
                _reduceAmount = 100;
                break;
        }

        if (Aura* aur = target->GetAura(SPELL_SANITY))
        {
            if ((aur->GetStackAmount() - _reduceAmount) <= 20)
                target->CastSpell(target, SPELL_SANITY_SCREEN_EFFECT, true);
            aur->ModStackAmount(-_reduceAmount);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_yogg_saron_sanity_reduce::HandleScriptEffect, EFFECT_FIRST_FOUND, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 64467 - Empowering Shadows
enum EmpoweringShadows
{
    SPELL_EMPOWERING_SHADOWS_HEAL_10 = 64468,
    SPELL_EMPOWERING_SHADOWS_HEAL_25 = 64486
};

class spell_yogg_saron_empowering_shadows : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_empowering_shadows);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EMPOWERING_SHADOWS_HEAL_10, SPELL_EMPOWERING_SHADOWS_HEAL_25 });
    }

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, target->GetMap()->Is25ManRaid() ? SPELL_EMPOWERING_SHADOWS_HEAL_25 : SPELL_EMPOWERING_SHADOWS_HEAL_10, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_yogg_saron_empowering_shadows::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 64184 - In the Maws of the Old God
class spell_yogg_saron_in_the_maws_of_the_old_god : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_in_the_maws_of_the_old_god);

    SpellCastResult CheckCast()
    {
        if (!GetCaster()->IsPlayer())
            return SPELL_FAILED_BAD_TARGETS;

        Unit* target = GetCaster()->ToPlayer()->GetSelectedUnit();
        if (!target || target->GetEntry() != NPC_YOGG_SARON)
            return SPELL_FAILED_BAD_TARGETS;

        Spell* spell = target->GetCurrentSpell(CURRENT_GENERIC_SPELL);
        if (!spell || spell->GetSpellInfo()->Id != SPELL_DEAFENING_ROAR)
            return SPELL_FAILED_TARGET_AURASTATE;

        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(spell_yogg_saron_in_the_maws_of_the_old_god::CheckCast);
    }
};

/* 63744 - Sara's Anger
   63747 - Sara's Fervor
   63745 - Sara's Blessing */
class spell_yogg_saron_target_selectors : public SpellScript
{
    PrepareSpellScript(spell_yogg_saron_target_selectors);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
        {
            GetCaster()->SetFacingToObject(target);
            GetCaster()->CastSpell(target, uint32(GetEffectValue()));
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_yogg_saron_target_selectors::HandleScript, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 63305 - Grim Reprisal
class spell_yogg_saron_grim_reprisal_aura : public AuraScript
{
    PrepareAuraScript(spell_yogg_saron_grim_reprisal_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GRIM_REPRISAL_DAMAGE });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetDamage())
        {
            return;
        }

        int32 damage = CalculatePct(static_cast<int32>(damageInfo->GetDamage()), 60);
        GetTarget()->CastCustomSpell(SPELL_GRIM_REPRISAL_DAMAGE, SPELLVALUE_BASE_POINT0, damage, damageInfo->GetAttacker(), true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_yogg_saron_grim_reprisal_aura::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class achievement_yogg_saron_drive_me_crazy : public AchievementCriteriaScript
{
public:
    achievement_yogg_saron_drive_me_crazy() : AchievementCriteriaScript("achievement_yogg_saron_drive_me_crazy") {}

    bool OnCheck(Player*  /*player*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target && target->GetAI()->GetData(DATA_GET_DRIVE_ME_CRAZY); // target = Yogg-Saron
    }
};

class achievement_yogg_saron_darkness : public AchievementCriteriaScript
{
public:
    achievement_yogg_saron_darkness(char const* name, uint32 count) : AchievementCriteriaScript(name),
        _keepersCount(count)
    {
    }

    bool OnCheck(Player* player, Unit*  /*target*/ /*Yogg-Saron*/, uint32 /*criteria_id*/) override
    {
        if (player->GetInstanceScript())
            if (Creature* sara = ObjectAccessor::GetCreature(*player, player->GetInstanceScript()->GetGuidData(NPC_SARA)))
                return sara->GetAI()->GetData(DATA_GET_KEEPERS_COUNT) <= _keepersCount;

        return false;
    }

private:
    uint32 const _keepersCount;
};

class achievement_yogg_saron_he_waits_dreaming : public AchievementCriteriaScript
{
public:
    achievement_yogg_saron_he_waits_dreaming(char const* name, uint8 illusion) : AchievementCriteriaScript(name),
        _requiredIllusion(illusion)
    {
    }

    bool OnCheck(Player* player, Unit*  /*target*/ /*Yogg-Saron*/, uint32 /*criteria_id*/) override
    {
        if (player->GetInstanceScript())
            if (Creature* sara = ObjectAccessor::GetCreature(*player, player->GetInstanceScript()->GetGuidData(NPC_BRAIN_OF_YOGG_SARON)))
                return sara->GetAI()->GetData(DATA_GET_CURRENT_ILLUSION) == _requiredIllusion;

        return false;
    }

private:
    uint8 const _requiredIllusion;
};

class achievement_yogg_saron_kiss_and_make_up : public AchievementCriteriaScript
{
public:
    achievement_yogg_saron_kiss_and_make_up() : AchievementCriteriaScript("achievement_yogg_saron_kiss_and_make_up") {}

    bool OnCheck(Player*  /*player*/, Unit* target /*Sara*/, uint32 /*criteria_id*/) override
    {
        return target && target->GetEntry() == NPC_SARA && target->GetAI() && target->GetAI()->GetData(DATA_GET_SARA_PHASE);
    }
};

void AddSC_boss_yoggsaron()
{
    new boss_yoggsaron();
    new boss_yoggsaron_sara();
    new boss_yoggsaron_cloud();
    new boss_yoggsaron_guardian_of_ys();
    new boss_yoggsaron_brain();
    new boss_yoggsaron_death_orb();
    new boss_yoggsaron_crusher_tentacle();
    new boss_yoggsaron_corruptor_tentacle();
    new boss_yoggsaron_constrictor_tentacle();
    RegisterUlduarCreatureAI(boss_yoggsaron_keeper);
    new boss_yoggsaron_descend_portal();
    new boss_yoggsaron_influence_tentacle();
    new boss_yoggsaron_immortal_guardian();
    new boss_yoggsaron_lich_king();
    new boss_yoggsaron_llane();
    new boss_yoggsaron_neltharion();
    new boss_yoggsaron_voice();

    // SPELLS
    RegisterSpellScript(spell_yogg_saron_malady_of_the_mind_aura);
    RegisterSpellAndAuraScriptPair(spell_yogg_saron_brain_link, spell_yogg_saron_brain_link_aura);
    RegisterSpellScript(spell_yogg_saron_shadow_beacon_aura);
    RegisterSpellScript(spell_yogg_saron_destabilization_matrix);
    RegisterSpellScript(spell_yogg_saron_titanic_storm);
    RegisterSpellScript(spell_yogg_saron_lunatic_gaze);
    RegisterSpellScript(spell_yogg_saron_protective_gaze_aura);
    RegisterSpellScript(spell_yogg_saron_empowered_aura);
    RegisterSpellScript(spell_yogg_saron_insane_periodic_trigger);
    RegisterSpellScript(spell_yogg_saron_insane_aura);
    RegisterSpellScript(spell_yogg_saron_sanity_well_aura);
    RegisterSpellScript(spell_keeper_freya_summon_sanity_well);
    RegisterSpellScript(spell_yogg_saron_sanity_reduce);
    RegisterSpellScript(spell_yogg_saron_empowering_shadows);
    RegisterSpellScript(spell_yogg_saron_in_the_maws_of_the_old_god);
    RegisterSpellScript(spell_yogg_saron_target_selectors);
    RegisterSpellScript(spell_yogg_saron_grim_reprisal_aura);

    // ACHIEVEMENTS
    new achievement_yogg_saron_drive_me_crazy();
    new achievement_yogg_saron_darkness("achievement_yogg_saron_three_lights_in_the_darkness", 3);
    new achievement_yogg_saron_darkness("achievement_yogg_saron_two_lights_in_the_darkness", 2);
    new achievement_yogg_saron_darkness("achievement_yogg_saron_one_light_in_the_darkness", 1);
    new achievement_yogg_saron_darkness("achievement_yogg_saron_alone_in_the_darkness", 0);
    new achievement_yogg_saron_he_waits_dreaming("achievement_yogg_saron_he_waits_dreaming_stormwind", ACTION_ILLUSION_STORMWIND);
    new achievement_yogg_saron_he_waits_dreaming("achievement_yogg_saron_he_waits_dreaming_chamber", ACTION_ILLUSION_DRAGONS);
    new achievement_yogg_saron_he_waits_dreaming("achievement_yogg_saron_he_waits_dreaming_icecrown", ACTION_ILLUSION_ICECROWN);
    new achievement_yogg_saron_kiss_and_make_up();
}
