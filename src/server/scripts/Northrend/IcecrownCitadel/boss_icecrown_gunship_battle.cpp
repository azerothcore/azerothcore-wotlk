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
#include "Config.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "GameTime.h"
#include "MoveSpline.h"
#include "MoveSplineInit.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Transport.h"
#include "TransportMgr.h"
#include "Vehicle.h"
#include "icecrown_citadel.h"

//npcbot
#include "botmgr.h"
//end npcbot

enum Texts
{
    // High Overlord Saurfang
    SAY_SAURFANG_INTRO_1                = 0,
    SAY_SAURFANG_INTRO_2                = 1,
    SAY_SAURFANG_INTRO_3                = 2,
    SAY_SAURFANG_INTRO_4                = 3,
    SAY_SAURFANG_INTRO_5                = 4,
    SAY_SAURFANG_INTRO_6                = 5,
    SAY_SAURFANG_INTRO_A                = 6,
    SAY_SAURFANG_BOARD                  = 7,
    SAY_SAURFANG_ENTER_SKYBREAKER       = 8,
    SAY_SAURFANG_AXETHROWERS            = 9,
    SAY_SAURFANG_ROCKETEERS             = 10,
    SAY_SAURFANG_MAGES                  = 11,
    SAY_SAURFANG_VICTORY                = 12,
    SAY_SAURFANG_WIPE                   = 13,

    // Muradin Bronzebeard
    SAY_MURADIN_INTRO_1                 = 0,
    SAY_MURADIN_INTRO_2                 = 1,
    SAY_MURADIN_INTRO_3                 = 2,
    SAY_MURADIN_INTRO_4                 = 3,
    SAY_MURADIN_INTRO_5                 = 4,
    SAY_MURADIN_INTRO_6                 = 5,
    SAY_MURADIN_INTRO_7                 = 6,
    SAY_MURADIN_INTRO_H                 = 7,
    SAY_MURADIN_BOARD                   = 8,
    SAY_MURADIN_ENTER_ORGRIMMS_HAMMER   = 9,
    SAY_MURADIN_RIFLEMAN                = 10,
    SAY_MURADIN_MORTAR                  = 11,
    SAY_MURADIN_SORCERERS               = 12,
    SAY_MURADIN_VICTORY                 = 13,
    SAY_MURADIN_WIPE                    = 14,

    SAY_ZAFOD_ROCKET_PACK_ACTIVE        = 0,
    SAY_ZAFOD_ROCKET_PACK_DISABLED      = 1,

    SAY_OVERHEAT                        = 0
};

enum Events
{
    // High Overlord Saurfang
    EVENT_INTRO_H_1                 = 1,
    EVENT_INTRO_H_2                 = 2,
    EVENT_INTRO_SUMMON_SKYBREAKER   = 3,
    EVENT_INTRO_H_3                 = 4,
    EVENT_INTRO_H_4                 = 5,
    EVENT_INTRO_H_5                 = 6,
    EVENT_INTRO_H_6                 = 7,

    // Muradin Bronzebeard
    EVENT_INTRO_A_1                 = 1,
    EVENT_INTRO_A_2                 = 2,
    EVENT_INTRO_SUMMON_ORGRIMS_HAMMER = 3,
    EVENT_INTRO_A_3                 = 4,
    EVENT_INTRO_A_4                 = 5,
    EVENT_INTRO_A_5                 = 6,
    EVENT_INTRO_A_6                 = 7,
    EVENT_INTRO_A_7                 = 8,

    EVENT_KEEP_PLAYER_IN_COMBAT     = 9,
    EVENT_SUMMON_MAGE               = 10,
    EVENT_ADDS                      = 11,
    EVENT_ADDS_BOARD_YELL           = 12,
    EVENT_CHECK_RIFLEMAN            = 13,
    EVENT_CHECK_MORTAR              = 14,
    EVENT_CLEAVE                    = 15,
    EVENT_BLADESTORM                = 16,
    EVENT_WOUNDING_STRIKE           = 17
};

#define EVENT_CHARGE_PREPATH 13371337

enum Spells
{
    // Applied on friendly transport NPCs
    SPELL_FRIENDLY_BOSS_DAMAGE_MOD          = 70339,
    SPELL_CHECK_FOR_PLAYERS                 = 70332,
    SPELL_GUNSHIP_FALL_TELEPORT             = 67335,
    SPELL_TELEPORT_PLAYERS_ON_RESET_A       = 70446,
    SPELL_TELEPORT_PLAYERS_ON_RESET_H       = 71284,
    SPELL_TELEPORT_PLAYERS_ON_VICTORY       = 72340,
    SPELL_ACHIEVEMENT                       = 72959,
    SPELL_AWARD_REPUTATION_BOSS_KILL        = 73843,

    // Gunship Hull
    SPELL_EXPLOSION_WIPE                    = 72134,
    SPELL_EXPLOSION_VICTORY                 = 72137,
    SPELL_BURNING_PITCH_A                   = 70403,
    SPELL_BURNING_PITCH_H                   = 70397,
    SPELL_BURNING_PITCH                     = 69660,
    SPELL_BURNING_PITCH_DAMAGE_A            = 70383,
    SPELL_BURNING_PITCH_DAMAGE_H            = 70374,

    // Murading Bronzebeard
    // High Overlord Saurfang
    SPELL_CLEAVE                            = 15284,
    SPELL_BATTLE_FURY                       = 69637,

    // Skybreaker Sorcerer
    // Kor'kron Battle-Mage
    SPELL_SHADOW_CHANNELING                 = 43897,

    // Skybreaker Rifleman
    // Kor'kron Axethrower
    SPELL_SHOOT                             = 70162,
    SPELL_HURL_AXE                          = 70161,

    // Skybreaker Sorcerer
    // Kor'kron Battle-Mage
    SPELL_BELOW_ZERO                        = 69705,

    // Skybreaker Mortar Soldier
    // Kor'kron Rocketeer
    SPELL_ROCKET_ARTILLERY_A                = 70609,
    SPELL_ROCKET_ARTILLERY_H                = 69678,

    // Murading Bronzebeard
    // High Overlord Saurfang
    SPELL_RENDING_THROW                     = 70309,
    SPELL_TASTE_OF_BLOOD                    = 69634,

    // Hostile NPCs
    SPELL_TELEPORT_TO_ENEMY_SHIP            = 70104,
    SPELL_BATTLE_EXPERIENCE                 = 71201,
    SPELL_EXPERIENCED                       = 71188,
    SPELL_VETERAN                           = 71193,
    SPELL_ELITE                             = 71195,
    SPELL_ADDS_BERSERK                      = 72525,

    // Skybreaker Sergeant
    // Kor'kron Sergeant
    SPELL_BLADESTORM                        = 69652,
    SPELL_WOUNDING_STRIKE                   = 69651,
    SPELL_DESPERATE_RESOLVE                 = 69647,

    //
    SPELL_LOCK_PLAYERS_AND_TAP_CHEST        = 72347,
    SPELL_ON_SKYBREAKER_DECK                = 70120,
    SPELL_ON_ORGRIMS_HAMMER_DECK            = 70121,

    // Rocket Pack
    SPELL_CREATE_ROCKET_PACK                = 70055,
    SPELL_ROCKET_PACK_DAMAGE                = 69193,
    SPELL_ROCKET_BURST                      = 69192,
    SPELL_ROCKET_PACK_USEABLE               = 70348,

    // Alliance Gunship Cannon
    // Horde Gunship Cannon
    SPELL_OVERHEAT                          = 69487,
    SPELL_EJECT_ALL_PASSENGERS              = 68576,
};

enum MiscData
{
    MUSIC_ENCOUNTER         = 17289
};

enum EncounterActions
{
    ACTION_SPAWN_MAGE           = 1,
    ACTION_SPAWN_ALL_ADDS       = 2,
    ACTION_CLEAR_SLOT           = 3,
    ACTION_SET_SLOT             = 4,
    ACTION_SHIP_VISITS_SELF     = 5,
    ACTION_SHIP_VISITS_ENEMY    = 6,
    ACTION_SHIP_VISITS_SELF_2   = 7,
    ACTION_SHIP_VISITS_ENEMY_2  = 8
};

Position const SkybreakerAddsSpawnPos = { 15.91131f, 0.0f, 20.4628f, M_PI };
Position const OrgrimsHammerAddsSpawnPos = { 60.728395f, 0.0f, 38.93467f, M_PI };

// Horde encounter
Position const SkybreakerTeleportPortal  = { 6.666975f, 0.013001f, 20.87888f, 0.0f };
Position const OrgrimsHammerTeleportExit = { 7.461699f, 0.158853f, 35.72989f, 0.0f };

// Alliance encounter
Position const OrgrimsHammerTeleportPortal = { 47.550990f, -0.101778f, 37.61111f, 0.0f };
Position const SkybreakerTeleportExit      = { -17.55738f, -0.090421f, 21.18366f, 0.0f };

uint32 const MuradinExitPathSize = 10;
Position const MuradinExitPath[MuradinExitPathSize] =
{
    { 8.130936f, -0.2699585f, 20.31728f, 0.0f },
    { 6.380936f, -0.2699585f, 20.31728f, 0.0f },
    { 3.507703f, 0.02986573f, 20.78463f, 0.0f },
    { -2.767633f, 3.743143f, 20.37663f, 0.0f },
    { -4.017633f, 4.493143f, 20.12663f, 0.0f },
    { -7.242224f, 6.856013f, 20.03468f, 0.0f },
    { -7.742224f, 8.606013f, 20.78468f, 0.0f },
    { -7.992224f, 9.856013f, 21.28468f, 0.0f },
    { -12.24222f, 23.10601f, 21.28468f, 0.0f },
    { -14.88477f, 25.20844f, 21.59985f, 0.0f },
};

uint32 const SaurfangExitPathSize = 13;
Position const SaurfangExitPath[SaurfangExitPathSize] =
{
    { 30.43987f, 0.1475817f, 36.10674f, 0.0f },
    { 21.36141f, -3.056458f, 35.42970f, 0.0f },
    { 19.11141f, -3.806458f, 35.42970f, 0.0f },
    { 19.01736f, -3.299440f, 35.39428f, 0.0f },
    { 18.6747f, -5.862823f, 35.66611f, 0.0f },
    { 18.6747f, -7.862823f, 35.66611f, 0.0f },
    { 18.1747f, -17.36282f, 35.66611f, 0.0f },
    { 18.1747f, -22.61282f, 35.66611f, 0.0f },
    { 17.9247f, -24.36282f, 35.41611f, 0.0f },
    { 17.9247f, -26.61282f, 35.66611f, 0.0f },
    { 17.9247f, -27.86282f, 35.66611f, 0.0f },
    { 17.9247f, -29.36282f, 35.66611f, 0.0f },
    { 15.33203f, -30.42621f, 35.93796f, 0.0f }
};

enum PassengerSlots
{
    // Freezing the cannons
    SLOT_FREEZE_MAGE    = 0,

    // Channeling the portal, refilled with adds that board player's ship
    SLOT_MAGE_1         = 1,
    SLOT_MAGE_2         = 2,

    // Rifleman
    SLOT_RIFLEMAN_1     = 3,
    SLOT_RIFLEMAN_2     = 4,
    SLOT_RIFLEMAN_3     = 5,
    SLOT_RIFLEMAN_4     = 6,

    // Additional Rifleman on 25 man
    SLOT_RIFLEMAN_5     = 7,
    SLOT_RIFLEMAN_6     = 8,
    SLOT_RIFLEMAN_7     = 9,
    SLOT_RIFLEMAN_8     = 10,

    // Mortar
    SLOT_MORTAR_1       = 11,
    SLOT_MORTAR_2       = 12,

    // Additional spawns on 25 man
    SLOT_MORTAR_3       = 13,
    SLOT_MORTAR_4       = 14,

    // Marines
    SLOT_MARINE_1       = 15,
    SLOT_MARINE_2       = 16,

    // Additional spawns on 25 man
    SLOT_MARINE_3       = 17,
    SLOT_MARINE_4       = 18,

    // Sergeants
    SLOT_SERGEANT_1     = 19,

    // Additional spawns on 25 man
    SLOT_SERGEANT_2     = 20,

    MAX_SLOTS
};

struct SlotInfo
{
    uint32 Entry;
    Position TargetPosition;
    uint32 Cooldown;
};

SlotInfo const SkybreakerSlotInfo[MAX_SLOTS] =
{
    { NPC_SKYBREAKER_SORCERER, { -9.479858f, 0.05663967f, 20.77026f, 4.729842f }, 0 },

    { NPC_SKYBREAKER_SORCERER, { 6.385986f,  4.978760f, 20.55417f, 4.694936f }, 0 },
    { NPC_SKYBREAKER_SORCERER, { 6.579102f, -4.674561f, 20.55060f, 1.553343f }, 0 },

    { NPC_SKYBREAKER_RIFLEMAN, { -29.563900f, -17.95801f, 20.73837f, 4.747295f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -18.017210f, -18.82056f, 20.79150f, 4.747295f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -9.1193850f, -18.79102f, 20.58887f, 4.712389f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -0.3364258f, -18.87183f, 20.56824f, 4.712389f }, 30 },

    { NPC_SKYBREAKER_RIFLEMAN, { -34.705810f, -17.67261f, 20.51523f, 4.729842f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -23.562010f, -18.28564f, 20.67859f, 4.729842f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -13.602780f, -18.74268f, 20.59622f, 4.712389f }, 30 },
    { NPC_SKYBREAKER_RIFLEMAN, { -4.3350220f, -18.84619f, 20.58234f, 4.712389f }, 30 },

    { NPC_SKYBREAKER_MORTAR_SOLDIER, { -31.70142f, 18.02783f, 20.77197f, 4.712389f }, 30 },
    { NPC_SKYBREAKER_MORTAR_SOLDIER, { -9.368652f, 18.75806f, 20.65335f, 4.712389f }, 30 },

    { NPC_SKYBREAKER_MORTAR_SOLDIER, { -20.40851f, 18.40381f, 20.50647f, 4.694936f }, 30 },
    { NPC_SKYBREAKER_MORTAR_SOLDIER, { 0.1585693f, 18.11523f, 20.41949f, 4.729842f }, 30 },

    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },
    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },

    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },
    { NPC_SKYBREAKER_MARINE, SkybreakerTeleportPortal, 0 },

    { NPC_SKYBREAKER_SERGEANT, SkybreakerTeleportPortal, 0 },

    { NPC_SKYBREAKER_SERGEANT, SkybreakerTeleportPortal, 0 }
};

SlotInfo const OrgrimsHammerSlotInfo[MAX_SLOTS] =
{
    { NPC_KOR_KRON_BATTLE_MAGE, { 13.58548f, 0.3867192f, 34.99243f, 1.53589f }, 0 },

    { NPC_KOR_KRON_BATTLE_MAGE, { 47.29290f, -4.308941f, 37.55550f, 1.570796f }, 0 },
    { NPC_KOR_KRON_BATTLE_MAGE, { 47.34621f,  4.032004f, 37.70952f, 4.817109f }, 0 },

    { NPC_KOR_KRON_AXETHROWER, { -12.09280f, 27.65942f, 33.58557f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { -3.170555f, 28.30652f, 34.21082f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { 14.928040f, 26.18018f, 35.47803f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { 24.703310f, 25.36584f, 35.97845f, 1.53589f }, 30 },

    { NPC_KOR_KRON_AXETHROWER, { -16.65302f, 27.59668f, 33.18726f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { -8.084572f, 28.21448f, 33.93805f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, {  7.594765f, 27.41968f, 35.00775f, 1.53589f }, 30 },
    { NPC_KOR_KRON_AXETHROWER, { 20.763390f, 25.58215f, 35.75287f, 1.53589f }, 30 },

    { NPC_KOR_KRON_ROCKETEER, { -11.44849f, -25.71838f, 33.64343f, 1.518436f }, 30 },
    { NPC_KOR_KRON_ROCKETEER, {  12.30336f, -25.69653f, 35.32373f, 1.518436f }, 30 },

    { NPC_KOR_KRON_ROCKETEER, { -0.05931854f, -25.46399f, 34.50592f, 1.518436f }, 30 },
    { NPC_KOR_KRON_ROCKETEER, { 27.62149000f, -23.48108f, 36.12708f, 1.518436f }, 30 },

    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },
    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },

    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },
    { NPC_KOR_KRON_REAVER, OrgrimsHammerTeleportPortal, 0 },

    { NPC_KOR_KRON_SERGEANT, OrgrimsHammerTeleportPortal, 0 },

    { NPC_KOR_KRON_SERGEANT, OrgrimsHammerTeleportPortal, 0 }
};

class BattleExperienceEvent : public BasicEvent
{
public:
    static uint32 const ExperiencedSpells[5];
    static uint32 const ExperiencedTimes[5];

    BattleExperienceEvent(Creature* creature) : _creature(creature), _level(0) { }

    bool Execute(uint64 timer, uint32 /*diff*/) override
    {
        if (!_creature->IsAlive())
            return true;

        _creature->RemoveAurasDueToSpell(ExperiencedSpells[_level]);
        ++_level;

        _creature->CastSpell(_creature, ExperiencedSpells[_level], true);
        if (_level < (_creature->GetMap()->IsHeroic() ? 4 : 3))
        {
            _creature->m_Events.AddEvent(this, timer + ExperiencedTimes[_level]);
            return false;
        }

        return true;
    }

private:
    Creature* _creature;
    int32 _level;
};

uint32 const BattleExperienceEvent::ExperiencedSpells[5] = { 0, SPELL_EXPERIENCED, SPELL_VETERAN, SPELL_ELITE, SPELL_ADDS_BERSERK };
uint32 const BattleExperienceEvent::ExperiencedTimes[5] = { 100000, 70000, 60000, 90000, 0 };

class PassengerController
{
public:
    PassengerController()
    {
        ResetSlots(TEAM_HORDE, nullptr);
    }

    void ResetSlots(TeamId teamId, MotionTransport* t)
    {
        _transport = t;

        for (uint8 i = 0; i < MAX_SLOTS; ++i)
        {
            _controlledSlots[i].Clear();
            _respawnCooldowns[i] = time_t(0);
        }

        _spawnPoint = teamId == TEAM_HORDE ? &OrgrimsHammerAddsSpawnPos : &SkybreakerAddsSpawnPos;
        _slotInfo = teamId == TEAM_HORDE ? OrgrimsHammerSlotInfo : SkybreakerSlotInfo;
    }

    bool SummonCreatures(Creature* summoner, PassengerSlots first, PassengerSlots last)
    {
        if (!_transport)
            return false;

        bool summoned = false;
        time_t now = GameTime::GetGameTime().count();
        for (int32 i = first; i <= last; ++i)
        {
            if (_respawnCooldowns[i] > now)
                continue;

            if (_controlledSlots[i])
            {
                Creature* current = ObjectAccessor::GetCreature(*_transport, _controlledSlots[i]);
                if (current && current->IsAlive())
                    continue;
            }

            Position spawnPos = SelectSpawnPoint();
            if (Creature* passenger = summoner->SummonCreature(_slotInfo[i].Entry, spawnPos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 15000))
            {
                if (!passenger->GetTransport())
                    _transport->AddPassenger(passenger, true);
                passenger->ApplySpellImmune(0, IMMUNITY_ID, 49576, true); // death grip

                if (i >= SLOT_MAGE_1 && i <= SLOT_MORTAR_4) // only these npcs are pooled
                {
                    _controlledSlots[i] = passenger->GetGUID();
                    _respawnCooldowns[i] = time_t(0);
                }
                passenger->AI()->SetData(ACTION_SET_SLOT, i);
                summoned = true;
            }
        }

        return summoned;
    }

    void ClearSlot(PassengerSlots slot)
    {
        _controlledSlots[slot].Clear();
        _respawnCooldowns[slot] = GameTime::GetGameTime().count() + _slotInfo[slot].Cooldown;
    }

private:
    Position SelectSpawnPoint() const
    {
        float angle = frand(-M_PI * 0.5f, M_PI * 0.5f);
        Position newPos;
        newPos.m_positionX = _spawnPoint->GetPositionX() + 2.0f * std::cos(angle);
        newPos.m_positionY = _spawnPoint->GetPositionY() + 2.0f * std::sin(angle);
        newPos.m_positionZ = _spawnPoint->GetPositionZ();
        newPos.SetOrientation(_spawnPoint->GetOrientation());
        _transport->CalculatePassengerPosition(newPos.m_positionX, newPos.m_positionY, newPos.m_positionZ, &(newPos.m_orientation));
        return newPos;
    }

    ObjectGuid _controlledSlots[MAX_SLOTS];
    time_t _respawnCooldowns[MAX_SLOTS];
    MotionTransport* _transport;
    Position const* _spawnPoint;
    SlotInfo const* _slotInfo;
};

class DelayedMovementEvent : public BasicEvent
{
public:
    DelayedMovementEvent(Creature* owner, Position const& dest) : _owner(owner), _dest(dest) { }

    bool Execute(uint64, uint32) override
    {
        if (!_owner->IsAlive() || !_owner->GetTransport())
            return true;

        float x, y, z, o;
        _dest.GetPosition(x, y, z, o);
        _owner->GetTransport()->CalculatePassengerPosition(x, y, z, &o);
        _owner->GetMotionMaster()->MovePoint(EVENT_CHARGE_PREPATH, x, y, z, false);
        return true;
    }

private:
    Creature* _owner;
    Position const& _dest;
};

class ResetEncounterEvent : public BasicEvent
{
public:
    ResetEncounterEvent(Unit* caster, uint32 spellId, ObjectGuid otherTransport) : _caster(caster), _spellId(spellId), _otherTransport(otherTransport) { }

    bool Execute(uint64, uint32) override
    {
        _caster->CastSpell(_caster, _spellId, true);
        _caster->GetTransport()->ToMotionTransport()->UnloadNonStaticPassengers();
        _caster->GetTransport()->AddObjectToRemoveList();

        if (Transport* transport = ObjectAccessor::GetTransport(*_caster, _otherTransport))
        {
            transport->ToMotionTransport()->UnloadNonStaticPassengers();
            transport->AddObjectToRemoveList();
        }

        return true;
    }

private:
    Unit* _caster;
    uint32 _spellId;
    ObjectGuid _otherTransport;
};

class npc_gunship : public CreatureScript
{
public:
    npc_gunship() : CreatureScript("npc_gunship") { }

    struct npc_gunshipAI : public NullCreatureAI
    {
        npc_gunshipAI(Creature* creature) : NullCreatureAI(creature), _instance(creature->GetInstanceScript()), _teamIdInInstance(TeamId(creature->GetInstanceScript()->GetData(DATA_TEAMID_IN_INSTANCE))), _died(false), _summonedFirstMage(false)
        {
            me->SetRegeneratingHealth(false);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
            {
                damage = 0;
                return;
            }

            if (damage >= me->GetHealth())
            {
                JustDied(nullptr);
                damage = me->GetHealth() - 1;
                return;
            }

            if (_summonedFirstMage)
                return;

            if (me->GetTransport()->GetEntry() != uint32(_teamIdInInstance == TEAM_HORDE ? GO_THE_SKYBREAKER_H : GO_ORGRIMS_HAMMER_A))
                return;

            if (!me->HealthBelowPctDamaged(90, damage))
                return;

            _summonedFirstMage = true;
            if (Creature* captain = me->FindNearestCreature(_teamIdInInstance == TEAM_HORDE ? NPC_IGB_MURADIN_BRONZEBEARD : NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                captain->AI()->DoAction(ACTION_SPAWN_MAGE);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (_died || _instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            _died = true;

            bool isVictory = me->GetTransport()->GetEntry() == GO_THE_SKYBREAKER_H || me->GetTransport()->GetEntry() == GO_ORGRIMS_HAMMER_A;
            _instance->SetBossState(DATA_ICECROWN_GUNSHIP_BATTLE, isVictory ? DONE : FAIL);
            me->GetMap()->SetZoneMusic(AREA_ICECROWN_CITADEL, 0);

            if (Creature* creature = _instance->GetCreature(me->GetEntry() == NPC_ORGRIMS_HAMMER ? DATA_THE_SKYBREAKER : DATA_ORGRIMS_HAMMER))
            {
                _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, creature);
                if (Aura* a = creature->GetAura(SPELL_CHECK_FOR_PLAYERS))
                    a->SetDuration(0);
            }
            _instance->SendEncounterUnit(ENCOUNTER_FRAME_DISENGAGE, me);
            if (Aura* a = me->GetAura(SPELL_CHECK_FOR_PLAYERS))
                a->SetDuration(0);

            uint32 explosionSpell = isVictory ? SPELL_EXPLOSION_VICTORY : SPELL_EXPLOSION_WIPE;
            if (MotionTransport* t = (me->GetTransport() ? me->GetTransport()->ToMotionTransport() : nullptr))
            {
                Transport::PassengerSet const& passengers = t->GetStaticPassengers();
                for (Transport::PassengerSet::const_iterator itr = passengers.begin(); itr != passengers.end(); ++itr)
                {
                    if ((*itr)->GetTypeId() != TYPEID_UNIT || (*itr)->GetEntry() != NPC_GUNSHIP_HULL)
                        continue;
                    (*itr)->ToCreature()->CastSpell((*itr)->ToCreature(), explosionSpell, true);
                }

                //npcbot: kill bots
                Transport::PassengerSet const& allpassengers = t->GetPassengers();
                for (Transport::PassengerSet::const_iterator citr = allpassengers.begin(); citr != allpassengers.end(); ++citr)
                {
                    if ((*citr)->GetTypeId() == TYPEID_PLAYER && (*citr)->ToPlayer()->HaveBot())
                        (*citr)->ToPlayer()->GetBotMgr()->KillAllBots();
                }
                //end npcbot
            }

            uint32 cannonEntry = _teamIdInInstance == TEAM_HORDE ? NPC_HORDE_GUNSHIP_CANNON : NPC_ALLIANCE_GUNSHIP_CANNON;
            if (GameObject* go = _instance->instance->GetGameObject(_instance->GetGuidData(DATA_ICECROWN_GUNSHIP_BATTLE)))
                if (MotionTransport* t = go->ToMotionTransport())
                {
                    Transport::PassengerSet const& passengers = t->GetStaticPassengers();
                    for (Transport::PassengerSet::const_iterator itr = passengers.begin(); itr != passengers.end(); ++itr)
                    {
                        if ((*itr)->GetTypeId() != TYPEID_UNIT || (*itr)->GetEntry() != cannonEntry)
                            continue;
                        Creature* cannon = (*itr)->ToCreature();
                        cannon->CastSpell(cannon, SPELL_EJECT_ALL_PASSENGERS, true);

                        WorldPacket data(SMSG_PLAYER_VEHICLE_DATA, cannon->GetPackGUID().size() + 4);
                        data << cannon->GetPackGUID();
                        data << uint32(0);
                        cannon->SendMessageToSet(&data, true);

                        cannon->RemoveVehicleKit();
                    }
                }

            uint32 creatureEntry = NPC_IGB_MURADIN_BRONZEBEARD;
            uint8 textId = isVictory ? SAY_MURADIN_VICTORY : SAY_MURADIN_WIPE;
            if (_teamIdInInstance == TEAM_HORDE)
            {
                creatureEntry = NPC_IGB_HIGH_OVERLORD_SAURFANG;
                textId = isVictory ? SAY_SAURFANG_VICTORY : SAY_SAURFANG_WIPE;
            }
            if (Creature* creature = me->FindNearestCreature(creatureEntry, 200.0f))
                creature->AI()->Talk(textId);

            if (isVictory)
            {
                if (Transport * transport = _instance->instance->GetTransport(_instance->GetGuidData(DATA_ICECROWN_GUNSHIP_BATTLE)))
                    if (MotionTransport* otherTransport = transport->ToMotionTransport())
                        otherTransport->EnableMovement(true);

                me->GetTransport()->ToMotionTransport()->EnableMovement(true);

                if (Creature* ship = _instance->GetCreature(_teamIdInInstance == TEAM_HORDE ? DATA_ORGRIMS_HAMMER : DATA_THE_SKYBREAKER))
                {
                    ship->CastSpell(ship, SPELL_TELEPORT_PLAYERS_ON_VICTORY, true);
                    ship->CastSpell(ship, SPELL_ACHIEVEMENT, true);
                    ship->CastSpell(ship, SPELL_AWARD_REPUTATION_BOSS_KILL, true);
                }

                for (uint8 i = 0; i < 2; ++i)
                    if (GameObject* go = _instance->instance->GetGameObject(_instance->GetGuidData(i == 0 ? DATA_ICECROWN_GUNSHIP_BATTLE : DATA_ENEMY_GUNSHIP)))
                        if (MotionTransport* t = go->ToMotionTransport())
                        {
                            Transport::PassengerSet const& passengers = t->GetPassengers();
                            for (Transport::PassengerSet::const_iterator itr = passengers.begin(); itr != passengers.end(); ++itr)
                            {
                                if ((*itr)->GetTypeId() != TYPEID_UNIT)
                                    continue;
                                Creature* c = (*itr)->ToCreature();
                                if (c->GetEntry() == NPC_SKYBREAKER_MARINE || c->GetEntry() == NPC_SKYBREAKER_SERGEANT || c->GetEntry() == NPC_KOR_KRON_REAVER || c->GetEntry() == NPC_KOR_KRON_SERGEANT)
                                    c->DespawnOrUnsummon(1);
                            }
                        }
            }
            else
            {
                uint32 teleportSpellId = _teamIdInInstance == TEAM_HORDE ? SPELL_TELEPORT_PLAYERS_ON_RESET_H : SPELL_TELEPORT_PLAYERS_ON_RESET_A;
                me->m_Events.AddEvent(new ResetEncounterEvent(me, teleportSpellId, _instance->GetGuidData(DATA_ENEMY_GUNSHIP)), me->m_Events.CalculateTime(8000));
            }
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!sConfigMgr->GetOption<int32>("WipeGunshipBlizzlike.Enable", 1))
                return;

            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;

            bool playerOnDeck = false;
            me->GetMap()->DoForAllPlayers([&](Player* player)
                {
                    if (!player->GetVehicle() && player->IsAlive())
                        playerOnDeck = true;
                });

            // Wipe if no player is on the deck
            if (!playerOnDeck)
            {
                // Script runs on enemy ship. We want to kill our ship.
                if (Creature* ship = _instance->GetCreature(_teamIdInInstance == TEAM_HORDE ? DATA_ORGRIMS_HAMMER : DATA_THE_SKYBREAKER))
                    Creature::Kill(me, ship);
            }
        }

        void SetGUID(ObjectGuid guid, int32 id/* = 0*/) override
        {
            if (id != ACTION_SHIP_VISITS_ENEMY && id != ACTION_SHIP_VISITS_SELF)
                return;

            std::map<ObjectGuid, uint32>::iterator itr = _shipVisits.find(guid);
            if (itr == _shipVisits.end())
            {
                if (id == ACTION_SHIP_VISITS_ENEMY)
                    _shipVisits[guid] = ACTION_SHIP_VISITS_ENEMY;
            }
            else if (itr->second) // if 0 then achiev already failed
            {
                if (id == ACTION_SHIP_VISITS_SELF)
                {
                    if (itr->second == ACTION_SHIP_VISITS_ENEMY)
                        itr->second = ACTION_SHIP_VISITS_SELF;
                    else if (itr->second == ACTION_SHIP_VISITS_ENEMY_2)
                        itr->second = ACTION_SHIP_VISITS_SELF_2;
                }
                else
                {
                    if (itr->second == ACTION_SHIP_VISITS_SELF)
                    {
                        if (me->GetMap()->Is25ManRaid())
                            itr->second = 0;
                        else
                            itr->second = ACTION_SHIP_VISITS_ENEMY_2;
                    }
                    else if (itr->second == ACTION_SHIP_VISITS_SELF_2)
                        itr->second = 0;
                }
            }
        }

        uint32 GetData(uint32 id) const override
        {
            if (id != ACTION_SHIP_VISITS_ENEMY)
                return 0;

            for (std::map<ObjectGuid, uint32>::const_iterator itr = _shipVisits.begin(); itr != _shipVisits.end(); ++itr)
                if (itr->second == 0)
                    return 0;

            return 1;
        }

    private:
        InstanceScript* _instance;
        TeamId _teamIdInInstance;
        std::map<ObjectGuid, uint32> _shipVisits;
        bool _died;
        bool _summonedFirstMage;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        if (!creature->GetTransport())
            return nullptr;

        return GetIcecrownCitadelAI<npc_gunshipAI>(creature);
    }
};

class npc_high_overlord_saurfang_igb : public CreatureScript
{
public:
    npc_high_overlord_saurfang_igb() : CreatureScript("npc_high_overlord_saurfang_igb") { }

    struct npc_high_overlord_saurfang_igbAI : public ScriptedAI
    {
        npc_high_overlord_saurfang_igbAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
        {
            _events.Reset();
            _controller.ResetSlots(TEAM_HORDE, creature->GetTransport()->ToMotionTransport());
            me->SetRegeneratingHealth(false);
            me->m_CombatDistance = 70.0f;
            _firstMageCooldown = GameTime::GetGameTime().count() + 45;
            _axethrowersYellCooldown = time_t(0);
            _rocketeersYellCooldown = time_t(0);
            checkTimer = 1000;
        }

        void sGossipSelect(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/) override
        {
            if (!me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
                return;
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->GetTransport()->setActive(true);
            me->GetTransport()->ToMotionTransport()->EnableMovement(true);
            _events.ScheduleEvent(EVENT_INTRO_H_1, 5s);
            _events.ScheduleEvent(EVENT_INTRO_H_2, 16s);
            _events.ScheduleEvent(EVENT_INTRO_SUMMON_SKYBREAKER, 24s + 600ms);
            _events.ScheduleEvent(EVENT_INTRO_H_3, 29s + 600ms);
            _events.ScheduleEvent(EVENT_INTRO_H_4, 39s + 200ms);
        }

        void JustEngagedWith(Unit* /*target*/) override
        {
            if (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE && !me->HasAura(SPELL_FRIENDLY_BOSS_DAMAGE_MOD))
                me->CastSpell(me, SPELL_FRIENDLY_BOSS_DAMAGE_MOD, true);
            if (!me->HasAura(SPELL_BATTLE_FURY))
                me->CastSpell(me, SPELL_BATTLE_FURY, true);
            _events.CancelEvent(EVENT_CLEAVE);
            _events.ScheduleEvent(EVENT_CLEAVE, 3s, 6s);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (!me->IsAlive())
                return;
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->GetMotionMaster()->MoveTargetedHome();
            Reset();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_ENEMY_GUNSHIP_TALK)
            {
                _instance->SetBossState(DATA_ICECROWN_GUNSHIP_BATTLE, IN_PROGRESS);
                me->GetMap()->SetZoneMusic(AREA_ICECROWN_CITADEL, MUSIC_ENCOUNTER);

                if (Creature* muradin = me->FindNearestCreature(NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                    muradin->AI()->DoAction(ACTION_SPAWN_ALL_ADDS);

                Talk(SAY_SAURFANG_INTRO_5);
                _events.ScheduleEvent(EVENT_INTRO_H_5, 4s);
                _events.ScheduleEvent(EVENT_INTRO_H_6, 11s);
                _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 1ms);

                if (Creature* skybreaker = _instance->GetCreature(DATA_THE_SKYBREAKER))
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, skybreaker, 1);
                if (Creature* orgrimsHammer = _instance->GetCreature(DATA_ORGRIMS_HAMMER))
                {
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, orgrimsHammer, 2);
                    orgrimsHammer->CastSpell(orgrimsHammer, SPELL_CHECK_FOR_PLAYERS, true);
                }
            }
            else if (action == ACTION_SPAWN_MAGE)
            {
                time_t now = GameTime::GetGameTime().count();
                if (_firstMageCooldown > now)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, (_firstMageCooldown - now) * IN_MILLISECONDS);
                else
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, 1ms);
            }
            else if (action == ACTION_SPAWN_ALL_ADDS)
            {
                _events.ScheduleEvent(EVENT_ADDS, 12s);
                _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 13s);
                _events.ScheduleEvent(EVENT_CHECK_MORTAR, 13s);
                if (Is25ManRaid())
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MORTAR_4);
                else
                {
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MORTAR_1, SLOT_MORTAR_2);
                    _controller.SummonCreatures(me, SLOT_RIFLEMAN_1, SLOT_RIFLEMAN_4);
                }
            }
            else if (action == ACTION_EXIT_SHIP)
            {
                G3D::Vector3 points[SaurfangExitPathSize];
                for (uint8 i = 0; i < SaurfangExitPathSize; ++i)
                {
                    points[i].x = SaurfangExitPath[i].GetPositionX();
                    points[i].y = SaurfangExitPath[i].GetPositionY();
                    points[i].z = SaurfangExitPath[i].GetPositionZ();
                }
                Movement::PointsArray path(points, points + SaurfangExitPathSize);
                me->SetWalk(true);
                Movement::MoveSplineInit init(me);
                init.DisableTransportPathTransformations();
                init.MovebyPath(path, 0);
                init.Launch();
                me->DespawnOrUnsummon(18000);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == ACTION_CLEAR_SLOT)
            {
                _controller.ClearSlot(PassengerSlots(data));
                if (data == SLOT_FREEZE_MAGE)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, 30s, 33s + 500ms);
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (me->HealthBelowPctDamaged(65, damage) && !me->HasAura(SPELL_TASTE_OF_BLOOD))
                me->CastSpell(me, SPELL_TASTE_OF_BLOOD, true);

            if (damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
            {
                if (me->GetVictim())
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                    {
                        if (me->GetVictim()->GetPositionZ() >= 478.0f)
                        {
                            float x, y, z, o;
                            me->GetHomePosition(x, y, z, o);
                            me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                        }
                    }
                    else
                    {
                        if (me->GetVictim()->GetPositionZ() < 478.0f)
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                    }
                }

                if (checkTimer <= diff)
                {
                    checkTimer = 1000;
                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                            {
                                me->SetInCombatWith(p);
                                p->SetInCombatWith(me);
                                me->AddThreat(p, 0.0f);
                            }
                }
                else
                    checkTimer -= diff;
            }

            UpdateVictim();
            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_INTRO_H_1:
                    Talk(SAY_SAURFANG_INTRO_1);
                    break;
                case EVENT_INTRO_H_2:
                    Talk(SAY_SAURFANG_INTRO_2);
                    break;
                case EVENT_INTRO_SUMMON_SKYBREAKER:
                    sTransportMgr->CreateTransport(GO_THE_SKYBREAKER_H, 0, me->GetMap());
                    break;
                case EVENT_INTRO_H_3:
                    Talk(SAY_SAURFANG_INTRO_3);
                    break;
                case EVENT_INTRO_H_4:
                    Talk(SAY_SAURFANG_INTRO_4);
                    break;
                case EVENT_INTRO_H_5:
                    if (Creature* muradin = me->FindNearestCreature(NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                        muradin->AI()->Talk(SAY_MURADIN_INTRO_H);
                    break;
                case EVENT_INTRO_H_6:
                    Talk(SAY_SAURFANG_INTRO_6);
                    break;
                case EVENT_KEEP_PLAYER_IN_COMBAT:
                    if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
                    {
                        //_instance->DoCastSpellOnPlayers(SPELL_LOCK_PLAYERS_AND_TAP_CHEST);
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            if (Player* p = itr->GetSource())
                                if (!p->IsGameMaster())
                                    p->SetInCombatState(true);
                        _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 4s);
                    }
                    break;

                case EVENT_SUMMON_MAGE:
                    Talk(SAY_SAURFANG_MAGES);
                    _controller.SummonCreatures(me, SLOT_FREEZE_MAGE, SLOT_FREEZE_MAGE);
                    break;
                case EVENT_ADDS:
                    Talk(SAY_SAURFANG_ENTER_SKYBREAKER);
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MARINE_1, Is25ManRaid() ? SLOT_MARINE_4 : SLOT_MARINE_2);
                    _controller.SummonCreatures(me, SLOT_SERGEANT_1, Is25ManRaid() ? SLOT_SERGEANT_2 : SLOT_SERGEANT_1);
                    if (MotionTransport* orgrimsHammer = (me->GetTransport() ? me->GetTransport()->ToMotionTransport() : nullptr))
                    {
                        float x, y, z, o;
                        OrgrimsHammerTeleportPortal.GetPosition(x, y, z, o);
                        orgrimsHammer->CalculatePassengerPosition(x, y, z, &o);
                        me->SummonCreature(NPC_TELEPORT_PORTAL, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 21000);
                    }

                    if (Transport* transport = _instance->instance->GetTransport(_instance->GetGuidData(DATA_ICECROWN_GUNSHIP_BATTLE)))
                        if (MotionTransport* skybreaker = transport->ToMotionTransport())
                        {
                            float x, y, z, o;
                            SkybreakerTeleportExit.GetPosition(x, y, z, o);
                            skybreaker->CalculatePassengerPosition(x, y, z, &o);
                            me->SummonCreature(NPC_TELEPORT_EXIT, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 23000);
                        }

                    _events.ScheduleEvent(EVENT_ADDS_BOARD_YELL, 6s);
                    _events.ScheduleEvent(EVENT_ADDS, 1min);
                    break;
                case EVENT_ADDS_BOARD_YELL:
                    if (Creature* muradin = me->FindNearestCreature(NPC_IGB_MURADIN_BRONZEBEARD, 200.0f))
                        muradin->AI()->Talk(SAY_MURADIN_BOARD);
                    break;
                case EVENT_CHECK_RIFLEMAN:
                    if (_controller.SummonCreatures(me, SLOT_RIFLEMAN_1, Is25ManRaid() ? SLOT_RIFLEMAN_8 : SLOT_RIFLEMAN_4))
                    {
                        if (_axethrowersYellCooldown < GameTime::GetGameTime().count())
                        {
                            Talk(SAY_SAURFANG_AXETHROWERS);
                            _axethrowersYellCooldown = GameTime::GetGameTime().count() + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 1500ms);
                    break;
                case EVENT_CHECK_MORTAR:
                    if (_controller.SummonCreatures(me, SLOT_MORTAR_1, Is25ManRaid() ? SLOT_MORTAR_4 : SLOT_MORTAR_2))
                    {
                        if (_rocketeersYellCooldown < GameTime::GetGameTime().count())
                        {
                            Talk(SAY_SAURFANG_ROCKETEERS);
                            _rocketeersYellCooldown = GameTime::GetGameTime().count() + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_MORTAR, 1500ms);
                    break;
                case EVENT_CLEAVE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    _events.ScheduleEvent(EVENT_CLEAVE, 4s, 8s);
                    break;

                default:
                    break;
            }

            if (!me->GetVictim() || me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->IsWithinMeleeRange(me->GetVictim()))
                DoMeleeAttackIfReady();
            else if (me->isAttackReady())
            {
                me->SetOrientation(me->GetAngle(me->GetVictim()));
                me->CastSpell(me->GetVictim(), SPELL_RENDING_THROW, false);
                me->resetAttackTimer();
            }
        }

        void AttackStart(Unit* victim) override
        {
            if (victim && me->Attack(victim, true))
            {
                if (victim->GetPositionZ() < 478.0f)
                    me->GetMotionMaster()->MoveChase(victim);
                else
                {
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                }
            }
        }

        bool CanAIAttack(Unit const* target) const override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return false;
            if (target->GetEntry() == NPC_SKYBREAKER_MARINE || target->GetEntry() == NPC_SKYBREAKER_SERGEANT)
                return target->ToCreature()->GetReactState() != REACT_PASSIVE;
            return target->GetTransport() == me->GetTransport() && target->GetPositionY() < (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? 2431.0f : 2025.0f);
        }

    private:
        EventMap _events;
        PassengerController _controller;
        InstanceScript* _instance;
        time_t _firstMageCooldown;
        time_t _axethrowersYellCooldown;
        time_t _rocketeersYellCooldown;
        uint16 checkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_high_overlord_saurfang_igbAI>(creature);
    }
};

class npc_muradin_bronzebeard_igb : public CreatureScript
{
public:
    npc_muradin_bronzebeard_igb() : CreatureScript("npc_muradin_bronzebeard_igb") { }

    struct npc_muradin_bronzebeard_igbAI : public ScriptedAI
    {
        npc_muradin_bronzebeard_igbAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
        {
            _events.Reset();
            _controller.ResetSlots(TEAM_ALLIANCE, creature->GetTransport()->ToMotionTransport());
            me->SetRegeneratingHealth(false);
            me->m_CombatDistance = 70.0f;
            _firstMageCooldown = GameTime::GetGameTime().count() + 45;
            _riflemanYellCooldown = time_t(0);
            _mortarYellCooldown = time_t(0);
            checkTimer = 1000;
        }

        void sGossipSelect(Player* /*player*/, uint32 /*sender*/, uint32 /*action*/) override
        {
            if (!me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP))
                return;
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->GetTransport()->setActive(true);
            me->GetTransport()->ToMotionTransport()->EnableMovement(true);
            _events.ScheduleEvent(EVENT_INTRO_A_1, 5s);
            _events.ScheduleEvent(EVENT_INTRO_A_2, 10s);
            _events.ScheduleEvent(EVENT_INTRO_SUMMON_ORGRIMS_HAMMER, 28s);
            _events.ScheduleEvent(EVENT_INTRO_A_3, 33s);
            _events.ScheduleEvent(EVENT_INTRO_A_4, 39s);
            _events.ScheduleEvent(EVENT_INTRO_A_5, 45s);
        }

        void JustEngagedWith(Unit* /*target*/) override
        {
            if (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE && !me->HasAura(SPELL_FRIENDLY_BOSS_DAMAGE_MOD))
                me->CastSpell(me, SPELL_FRIENDLY_BOSS_DAMAGE_MOD, true);
            if (!me->HasAura(SPELL_BATTLE_FURY))
                me->CastSpell(me, SPELL_BATTLE_FURY, true);
            _events.CancelEvent(EVENT_CLEAVE);
            _events.ScheduleEvent(EVENT_CLEAVE, 3s, 6s);
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (!me->IsAlive())
                return;
            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(true);
            me->GetMotionMaster()->MoveTargetedHome();
            Reset();
        }

        void DoAction(int32 action) override
        {
            if (action == ACTION_ENEMY_GUNSHIP_TALK)
            {
                _instance->SetBossState(DATA_ICECROWN_GUNSHIP_BATTLE, IN_PROGRESS);
                me->GetMap()->SetZoneMusic(AREA_ICECROWN_CITADEL, MUSIC_ENCOUNTER);

                if (Creature* saurfang = me->FindNearestCreature(NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                    saurfang->AI()->DoAction(ACTION_SPAWN_ALL_ADDS);

                Talk(SAY_MURADIN_INTRO_6);
                _events.ScheduleEvent(EVENT_INTRO_A_6, 5s);
                _events.ScheduleEvent(EVENT_INTRO_A_7, 11s);
                _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 1ms);

                if (Creature* orgrimsHammer = _instance->GetCreature(DATA_ORGRIMS_HAMMER))
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, orgrimsHammer, 1);
                if (Creature* skybreaker = _instance->GetCreature(DATA_THE_SKYBREAKER))
                {
                    _instance->SendEncounterUnit(ENCOUNTER_FRAME_ENGAGE, skybreaker, 2);
                    skybreaker->CastSpell(skybreaker, SPELL_CHECK_FOR_PLAYERS, true);
                }
            }
            else if (action == ACTION_SPAWN_MAGE)
            {
                time_t now = GameTime::GetGameTime().count();
                if (_firstMageCooldown > now)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, (_firstMageCooldown - now) * IN_MILLISECONDS);
                else
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, 1ms);
            }
            else if (action == ACTION_SPAWN_ALL_ADDS)
            {
                _events.ScheduleEvent(EVENT_ADDS, 12s);
                _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 13s);
                _events.ScheduleEvent(EVENT_CHECK_MORTAR, 13s);
                if (Is25ManRaid())
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MORTAR_4);
                else
                {
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MORTAR_1, SLOT_MORTAR_2);
                    _controller.SummonCreatures(me, SLOT_RIFLEMAN_1, SLOT_RIFLEMAN_4);
                }
            }
            else if (action == ACTION_EXIT_SHIP)
            {
                G3D::Vector3 points[MuradinExitPathSize];
                for (uint8 i = 0; i < MuradinExitPathSize; ++i)
                {
                    points[i].x = MuradinExitPath[i].GetPositionX();
                    points[i].y = MuradinExitPath[i].GetPositionY();
                    points[i].z = MuradinExitPath[i].GetPositionZ();
                }
                Movement::PointsArray path(points, points + MuradinExitPathSize);
                me->SetWalk(true);
                Movement::MoveSplineInit init(me);
                init.DisableTransportPathTransformations();
                init.MovebyPath(path, 0);
                init.Launch();
                me->DespawnOrUnsummon(18000);
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == ACTION_CLEAR_SLOT)
            {
                _controller.ClearSlot(PassengerSlots(data));
                if (data == SLOT_FREEZE_MAGE)
                    _events.ScheduleEvent(EVENT_SUMMON_MAGE, 30s, 33s + 500ms);
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (me->HealthBelowPctDamaged(65, damage) && !me->HasAura(SPELL_TASTE_OF_BLOOD))
                me->CastSpell(me, SPELL_TASTE_OF_BLOOD, true);

            if (damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void UpdateAI(uint32 diff) override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
            {
                if (me->GetVictim())
                {
                    if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() == CHASE_MOTION_TYPE)
                    {
                        if (me->GetVictim()->GetPositionZ() >= 478.0f)
                        {
                            float x, y, z, o;
                            me->GetHomePosition(x, y, z, o);
                            me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                        }
                    }
                    else
                    {
                        if (me->GetVictim()->GetPositionZ() < 478.0f)
                            me->GetMotionMaster()->MoveChase(me->GetVictim());
                    }
                }

                if (checkTimer <= diff)
                {
                    checkTimer = 1000;
                    Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                    for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                        if (Player* p = itr->GetSource())
                            if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                            {
                                me->SetInCombatWith(p);
                                p->SetInCombatWith(me);
                                me->AddThreat(p, 0.0f);
                            }
                }
                else
                    checkTimer -= diff;
            }

            UpdateVictim();
            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_INTRO_A_1:
                    Talk(SAY_MURADIN_INTRO_1);
                    break;
                case EVENT_INTRO_A_2:
                    Talk(SAY_MURADIN_INTRO_2);
                    break;
                case EVENT_INTRO_SUMMON_ORGRIMS_HAMMER:
                    sTransportMgr->CreateTransport(GO_ORGRIMS_HAMMER_A, 0, me->GetMap());
                    break;
                case EVENT_INTRO_A_3:
                    Talk(SAY_MURADIN_INTRO_3);
                    break;
                case EVENT_INTRO_A_4:
                    Talk(SAY_MURADIN_INTRO_4);
                    break;
                case EVENT_INTRO_A_5:
                    Talk(SAY_MURADIN_INTRO_5);
                    break;
                case EVENT_INTRO_A_6:
                    if (Creature* saurfang = me->FindNearestCreature(NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                        saurfang->AI()->Talk(SAY_SAURFANG_INTRO_A);
                    break;
                case EVENT_INTRO_A_7:
                    Talk(SAY_MURADIN_INTRO_7);
                    break;
                case EVENT_KEEP_PLAYER_IN_COMBAT:
                    if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS)
                    {
                        //_instance->DoCastSpellOnPlayers(SPELL_LOCK_PLAYERS_AND_TAP_CHEST);
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            if (Player* p = itr->GetSource())
                                if (!p->IsGameMaster())
                                    p->SetInCombatState(true);
                        _events.ScheduleEvent(EVENT_KEEP_PLAYER_IN_COMBAT, 4s);
                    }
                    break;

                case EVENT_SUMMON_MAGE:
                    Talk(SAY_MURADIN_SORCERERS);
                    _controller.SummonCreatures(me, SLOT_FREEZE_MAGE, SLOT_FREEZE_MAGE);
                    break;
                case EVENT_ADDS:
                    Talk(SAY_MURADIN_ENTER_ORGRIMMS_HAMMER);
                    _controller.SummonCreatures(me, SLOT_MAGE_1, SLOT_MAGE_2);
                    _controller.SummonCreatures(me, SLOT_MARINE_1, Is25ManRaid() ? SLOT_MARINE_4 : SLOT_MARINE_2);
                    _controller.SummonCreatures(me, SLOT_SERGEANT_1, Is25ManRaid() ? SLOT_SERGEANT_2 : SLOT_SERGEANT_1);
                    if (MotionTransport* skybreaker = (me->GetTransport() ? me->GetTransport()->ToMotionTransport() : nullptr))
                    {
                        float x, y, z, o;
                        SkybreakerTeleportPortal.GetPosition(x, y, z, o);
                        skybreaker->CalculatePassengerPosition(x, y, z, &o);
                        me->SummonCreature(NPC_TELEPORT_PORTAL, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 21000);
                    }

                    if (Transport* transport = _instance->instance->GetTransport(_instance->GetGuidData(DATA_ICECROWN_GUNSHIP_BATTLE)))
                        if (MotionTransport* orgrimsHammer = transport->ToMotionTransport())
                        {
                            float x, y, z, o;
                            OrgrimsHammerTeleportExit.GetPosition(x, y, z, o);
                            orgrimsHammer->CalculatePassengerPosition(x, y, z, &o);
                            me->SummonCreature(NPC_TELEPORT_EXIT, x, y, z, o, TEMPSUMMON_TIMED_DESPAWN, 23000);
                        }

                    _events.ScheduleEvent(EVENT_ADDS_BOARD_YELL, 6s);
                    _events.ScheduleEvent(EVENT_ADDS, 1min);
                    break;
                case EVENT_ADDS_BOARD_YELL:
                    if (Creature* saurfang = me->FindNearestCreature(NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                        saurfang->AI()->Talk(SAY_SAURFANG_BOARD);
                    break;
                case EVENT_CHECK_RIFLEMAN:
                    if (_controller.SummonCreatures(me, SLOT_RIFLEMAN_1, Is25ManRaid() ? SLOT_RIFLEMAN_8 : SLOT_RIFLEMAN_4))
                    {
                        if (_riflemanYellCooldown < GameTime::GetGameTime().count())
                        {
                            Talk(SAY_MURADIN_RIFLEMAN);
                            _riflemanYellCooldown = GameTime::GetGameTime().count() + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_RIFLEMAN, 1500ms);
                    break;
                case EVENT_CHECK_MORTAR:
                    if (_controller.SummonCreatures(me, SLOT_MORTAR_1, Is25ManRaid() ? SLOT_MORTAR_4 : SLOT_MORTAR_2))
                    {
                        if (_mortarYellCooldown < GameTime::GetGameTime().count())
                        {
                            Talk(SAY_MURADIN_MORTAR);
                            _mortarYellCooldown = GameTime::GetGameTime().count() + 5;
                        }
                    }
                    _events.ScheduleEvent(EVENT_CHECK_MORTAR, 1500ms);
                    break;
                case EVENT_CLEAVE:
                    if (me->GetVictim())
                        me->CastSpell(me->GetVictim(), SPELL_CLEAVE, false);
                    _events.ScheduleEvent(EVENT_CLEAVE, 4s, 8s);
                    break;

                default:
                    break;
            }

            if (!me->GetVictim() || me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->IsWithinMeleeRange(me->GetVictim()))
                DoMeleeAttackIfReady();
            else if (me->isAttackReady())
            {
                me->SetOrientation(me->GetAngle(me->GetVictim()));
                me->CastSpell(me->GetVictim(), SPELL_RENDING_THROW, false);
                me->resetAttackTimer();
            }
        }

        void AttackStart(Unit* victim) override
        {
            if (victim && me->Attack(victim, true))
            {
                if (victim->GetPositionZ() < 478.0f)
                    me->GetMotionMaster()->MoveChase(victim);
                else
                {
                    float x, y, z, o;
                    me->GetHomePosition(x, y, z, o);
                    me->GetMotionMaster()->MovePoint(0, x, y, z, false);
                }
            }
        }

        bool CanAIAttack(Unit const* target) const override
        {
            if (_instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return false;
            if (target->GetEntry() == NPC_KOR_KRON_REAVER || target->GetEntry() == NPC_KOR_KRON_SERGEANT)
                return target->ToCreature()->GetReactState() != REACT_PASSIVE;
            return target->GetTransport() == me->GetTransport() && target->GetPositionY() > (_instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_ALLIANCE ? 2042.0f : 2445.0f);
        }

    private:
        EventMap _events;
        PassengerController _controller;
        InstanceScript* _instance;
        time_t _firstMageCooldown;
        time_t _riflemanYellCooldown;
        time_t _mortarYellCooldown;
        uint16 checkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_muradin_bronzebeard_igbAI>(creature);
    }
};

class npc_zafod_boombox : public CreatureScript
{
public:
    npc_zafod_boombox() : CreatureScript("npc_zafod_boombox") { }

    struct npc_zafod_boomboxAI : public NullCreatureAI
    {
        npc_zafod_boomboxAI(Creature* creature) : NullCreatureAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 /*action*/) override
        {
            me->CastSpell(player, SPELL_CREATE_ROCKET_PACK);
            player->PlayerTalkClass->SendCloseGossip();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_zafod_boomboxAI>(creature);
    }
};

class npc_igb_ship_crew : public CreatureScript
{
public:
    npc_igb_ship_crew() : CreatureScript("npc_igb_ship_crew") { }

    struct npc_igb_ship_crewAI : public ScriptedAI
    {
        npc_igb_ship_crewAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

        bool CanAIAttack(Unit const* target) const override
        {
            return _instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS && target->GetTransport() == me->GetTransport() && target->GetPositionZ() < 478.0f && (me->GetEntry() == NPC_SKYBREAKER_DECKHAND ? (target->GetPositionY() > 2042.0f) : (target->GetPositionY() < 2431.0f));
        }
    private:
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_igb_ship_crewAI>(creature);
    }
};

void TriggerBurningPitch(Creature* c)
{
    InstanceScript* i = c->GetInstanceScript();
    uint32 spellId = i->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SPELL_BURNING_PITCH_A : SPELL_BURNING_PITCH_H;
    if (!c->HasSpellCooldown(spellId))
    {
        c->CastSpell((Unit*)nullptr, spellId, false);
        c->_AddCreatureSpellCooldown(spellId, 0, urand(3000, 4000));
    }
}

struct gunship_npc_AI : public ScriptedAI
{
    gunship_npc_AI(Creature* creature) : ScriptedAI(creature), Instance(creature->GetInstanceScript()), Slot(nullptr), Index(uint32(-1))
    {
        me->SetRegeneratingHealth(false);
    }

    void SetData(uint32 type, uint32 data) override
    {
        if (type == ACTION_SET_SLOT)
        {
            SetSlotInfo(data);
            me->SetReactState(REACT_PASSIVE);
            float x, y, z, o;
            Slot->TargetPosition.GetPosition(x, y, z, o);
            me->SetTransportHomePosition(Slot->TargetPosition);
            me->GetTransport()->CalculatePassengerPosition(x, y, z, &o);
            me->SetHomePosition(x, y, z, o);
            me->GetMotionMaster()->MovePoint(EVENT_CHARGE_PREPATH, x, y, z, false);
        }
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        if (!me->IsAlive() || !me->IsInCombat())
            return;
        me->GetThreatMgr().ClearAllThreat();
        me->CombatStop(true);
        me->GetMotionMaster()->MoveTargetedHome();
        Reset();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Slot)
            if (Creature* captain = me->FindNearestCreature(Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? NPC_IGB_MURADIN_BRONZEBEARD : NPC_IGB_HIGH_OVERLORD_SAURFANG, 200.0f))
                captain->AI()->SetData(ACTION_CLEAR_SLOT, Index);
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH && Slot)
        {
            me->SetFacingTo(Slot->TargetPosition.GetOrientation());
            me->m_Events.AddEvent(new BattleExperienceEvent(me), me->m_Events.CalculateTime(BattleExperienceEvent::ExperiencedTimes[0]));
            me->CastSpell(me, SPELL_BATTLE_EXPERIENCE, true);
            me->SetReactState(REACT_AGGRESSIVE);
        }
    }

protected:
    void SetSlotInfo(uint32 index)
    {
        Index = index;
        Slot = &((Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SkybreakerSlotInfo : OrgrimsHammerSlotInfo)[Index]);
    }

    InstanceScript* Instance;
    SlotInfo const* Slot;
    uint32 Index;
};

struct npc_gunship_boarding_addAI : public ScriptedAI
{
    npc_gunship_boarding_addAI(Creature* creature) : ScriptedAI(creature), Instance(creature->GetInstanceScript()), Slot(nullptr), Index(uint32(-1))
    {
        anyValid = true;
        checkTimer = 1000;
        _usedDesperateResolve = false;
        me->m_CombatDistance = 70.0f;
        me->SetRegeneratingHealth(false);
    }

    void SetData(uint32 type, uint32 data) override
    {
        if (type == ACTION_SET_SLOT)
        {
            SetSlotInfo(data);
            me->SetReactState(REACT_PASSIVE);
            me->m_Events.AddEvent(new DelayedMovementEvent(me, Slot->TargetPosition), me->m_Events.CalculateTime(3000 * (Index - SLOT_MARINE_1)));
        }
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        if (!me->IsAlive() || !me->IsInCombat())
            return;
        me->GetThreatMgr().ClearAllThreat();
        me->CombatStop(true);
        me->GetMotionMaster()->MoveTargetedHome();
        Reset();
    }

    void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
    {
        if (_usedDesperateResolve)
            return;
        if (!me->HealthBelowPctDamaged(25, damage))
            return;
        _usedDesperateResolve = true;
        me->CastSpell(me, SPELL_DESPERATE_RESOLVE, true);
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH && Slot)
        {
            me->SetFacingTo(Slot->TargetPosition.GetOrientation());
            me->m_Events.AddEvent(new BattleExperienceEvent(me), me->m_Events.CalculateTime(BattleExperienceEvent::ExperiencedTimes[0]));
            me->CastSpell(me, SPELL_BATTLE_EXPERIENCE, true);
            me->SetReactState(REACT_AGGRESSIVE);

            Position const& otherTransportPos = Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? OrgrimsHammerTeleportExit : SkybreakerTeleportExit;
            float x, y, z, o;
            otherTransportPos.GetPosition(x, y, z, o);

            Transport* myTransport = me->GetTransport();
            if (!myTransport)
                return;

            if (Transport* transport = Instance->instance->GetTransport(Instance->GetGuidData(DATA_ICECROWN_GUNSHIP_BATTLE)))
                if (Transport* destTransport = transport->ToTransport())
                    destTransport->CalculatePassengerPosition(x, y, z, &o);

            float angle = frand(0, M_PI * 2.0f);
            x += 2.0f * std::cos(angle);
            y += 2.0f * std::sin(angle);

            me->SetHomePosition(x, y, z, o);
            myTransport->CalculatePassengerOffset(x, y, z, &o);
            me->SetTransportHomePosition(x, y, z, o);

            me->CastSpell(me, SPELL_TELEPORT_TO_ENEMY_SHIP, true);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (checkTimer <= diff)
        {
            checkTimer = 1000;
            anyValid = false;
            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                if (Player* p = itr->GetSource())
                {
                    if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                    {
                        anyValid = true;
                        me->SetInCombatWith(p);
                        p->SetInCombatWith(me);
                        me->AddThreat(p, 0.0f);
                    }
                    //npcbot: check bots
                    else if (p->HaveBot())
                    {
                        BotMap const* bmap = p->GetBotMgr()->GetBotMap();
                        for (BotMap::const_iterator citr = bmap->begin(); citr != bmap->end(); ++citr)
                        {
                            if (citr->second && CanAIAttack(citr->second) && me->IsValidAttackTarget(citr->second))
                            {
                                anyValid = true;
                                me->SetInCombatWith(citr->second);
                                citr->second->SetInCombatWith(me);
                                me->AddThreat(citr->second, 0.0f);
                            }
                        }
                    }
                    //end npcbot
                }
        }
        else
            checkTimer -= diff;
    }

    bool CanAIAttack(Unit const* target) const override
    {
        return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS && target->GetTransport() && target->GetTransport() != me->GetTransport() && target->GetPositionZ() < 478.0f && (me->GetEntry() == NPC_SKYBREAKER_SERGEANT || me->GetEntry() == NPC_SKYBREAKER_MARINE ? (target->GetPositionY() < 2431.0f) : (target->GetPositionY() > 2042.0f));
    }

protected:
    void SetSlotInfo(uint32 index)
    {
        Index = index;
        Slot = &((Instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SkybreakerSlotInfo : OrgrimsHammerSlotInfo)[Index]);
    }

    bool anyValid;
    uint16 checkTimer;
    bool _usedDesperateResolve;
    InstanceScript* Instance;
    SlotInfo const* Slot;
    uint32 Index;
};

class npc_gunship_boarding_leader : public CreatureScript
{
public:
    npc_gunship_boarding_leader() : CreatureScript("npc_gunship_boarding_leader") { }

    struct npc_gunship_boarding_leaderAI : public npc_gunship_boarding_addAI
    {
        npc_gunship_boarding_leaderAI(Creature* creature) : npc_gunship_boarding_addAI(creature)
        {
        }

        void JustEngagedWith(Unit*  /*target*/) override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_BLADESTORM, 13s, 18s);
            _events.ScheduleEvent(EVENT_WOUNDING_STRIKE, 5s, 10s);
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            npc_gunship_boarding_addAI::UpdateAI(diff);
            _events.Update(diff);
            UpdateVictim();
            if (me->HasUnitState(UNIT_STATE_CASTING) || me->HasAura(SPELL_BLADESTORM))
                return;
            if (!anyValid)
            {
                TriggerBurningPitch(me);
                return;
            }
            if (!me->GetVictim())
                return;
            switch (_events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_BLADESTORM:
                    me->CastSpell(me->GetVictim(), SPELL_BLADESTORM, false);
                    _events.ScheduleEvent(EVENT_BLADESTORM, 25s, 30s);
                    break;
                case EVENT_WOUNDING_STRIKE:
                    me->CastSpell(me->GetVictim(), SPELL_WOUNDING_STRIKE, false);
                    _events.ScheduleEvent(EVENT_WOUNDING_STRIKE, 7s, 13s);
                    break;
                default:
                    break;
            }
            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_boarding_leaderAI>(creature);
    }
};

class npc_gunship_boarding_add : public CreatureScript
{
public:
    npc_gunship_boarding_add() : CreatureScript("npc_gunship_boarding_add") { }

    struct npc_gunship_boarding_add_realAI : public npc_gunship_boarding_addAI
    {
        npc_gunship_boarding_add_realAI(Creature* creature) : npc_gunship_boarding_addAI(creature)
        {
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            npc_gunship_boarding_addAI::UpdateAI(diff);
            _events.Update(diff);
            UpdateVictim();
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            if (!anyValid)
            {
                TriggerBurningPitch(me);
                return;
            }
            if (!me->GetVictim())
                return;
            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_boarding_add_realAI>(creature);
    }
};

class npc_gunship_mage : public CreatureScript
{
public:
    npc_gunship_mage() : CreatureScript("npc_gunship_mage") { }

    struct npc_gunship_mageAI : public gunship_npc_AI
    {
        npc_gunship_mageAI(Creature* creature) : gunship_npc_AI(creature)
        {
            me->m_CombatDistance = 70.0f;
        }

        void AttackStart(Unit* target) override
        {
            me->Attack(target, false);
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH && Slot)
            {
                me->SetFacingTo(Slot->TargetPosition.GetOrientation());
                switch (Index)
                {
                    case SLOT_FREEZE_MAGE:
                        if (Player* player = me->SelectNearestPlayer(50.0f))
                        {
                            me->SetInCombatWithZone();
                            me->AddThreat(player, 1.0f);
                        }
                        me->CastSpell((Unit*)nullptr, SPELL_BELOW_ZERO, false);
                        break;
                    case SLOT_MAGE_1:
                    case SLOT_MAGE_2:
                        me->CastSpell((Unit*)nullptr, SPELL_SHADOW_CHANNELING, false);
                        break;
                    default:
                        break;
                }

                me->SetControlled(true, UNIT_STATE_ROOT);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            gunship_npc_AI::UpdateAI(diff);
        }

        bool CanAIAttack(Unit const*  /*target*/) const override
        {
            return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_mageAI>(creature);
    }
};

class npc_gunship_gunner : public CreatureScript
{
public:
    npc_gunship_gunner() : CreatureScript("npc_gunship_gunner") { }

    struct npc_gunship_gunnerAI : public gunship_npc_AI
    {
        npc_gunship_gunnerAI(Creature* creature) : gunship_npc_AI(creature)
        {
            anyValid = true;
            checkTimer = 1000;
            creature->m_CombatDistance = 150.0f;
        }

        void AttackStart(Unit* target) override
        {
            me->Attack(target, false);
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            gunship_npc_AI::MovementInform(type, pointId);
            if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH)
                me->SetControlled(true, UNIT_STATE_ROOT);
        }

        void UpdateAI(uint32 diff) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;
            if (checkTimer <= diff)
            {
                checkTimer = 1000;
                anyValid = false;
                Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                    if (Player* p = itr->GetSource())
                    {
                        if (CanAIAttack(p) && me->IsValidAttackTarget(p))
                        {
                            anyValid = true;
                            me->SetInCombatWith(p);
                            p->SetInCombatWith(me);
                            me->AddThreat(p, 0.0f);
                        }
                        //npcbot: check bots
                        else if (p->HaveBot())
                        {
                            BotMap const* bmap = p->GetBotMgr()->GetBotMap();
                            for (BotMap::const_iterator citr = bmap->begin(); citr != bmap->end(); ++citr)
                            {
                                if (citr->second && CanAIAttack(citr->second) && me->IsValidAttackTarget(citr->second))
                                {
                                    anyValid = true;
                                    me->SetInCombatWith(citr->second);
                                    citr->second->SetInCombatWith(me);
                                    me->AddThreat(citr->second, 0.0f);
                                }
                            }
                        }
                        //end npcbot
                    }
            }
            else
                checkTimer -= diff;
            UpdateVictim();
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
            if (!anyValid)
            {
                TriggerBurningPitch(me);
                return;
            }
            if (!me->GetVictim())
                return;
            DoSpellAttackIfReady(me->GetEntry() == NPC_SKYBREAKER_RIFLEMAN ? SPELL_SHOOT : SPELL_HURL_AXE);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS && target->GetTransport() && target->GetTransport() != me->GetTransport();
        }

    protected:
        bool anyValid;
        uint16 checkTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_gunnerAI>(creature);
    }
};

class npc_gunship_rocketeer : public CreatureScript
{
public:
    npc_gunship_rocketeer() : CreatureScript("npc_gunship_rocketeer") { }

    struct npc_gunship_rocketeerAI : public gunship_npc_AI
    {
        npc_gunship_rocketeerAI(Creature* creature) : gunship_npc_AI(creature)
        {
            creature->m_CombatDistance = 150.0f;
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            gunship_npc_AI::MovementInform(type, pointId);
            if (type == POINT_MOTION_TYPE && pointId == EVENT_CHARGE_PREPATH)
                me->SetControlled(true, UNIT_STATE_ROOT);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != IN_PROGRESS)
                return;
            if (me->GetReactState() == REACT_PASSIVE)
                return;

            UpdateVictim();

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            uint32 spellId = me->GetEntry() == NPC_SKYBREAKER_MORTAR_SOLDIER ? SPELL_ROCKET_ARTILLERY_A : SPELL_ROCKET_ARTILLERY_H;
            if (me->HasSpellCooldown(spellId))
                return;

            me->CastSpell((Unit*)nullptr, spellId, true);
            me->_AddCreatureSpellCooldown(spellId, 0, 9000);
        }

        bool CanAIAttack(Unit const*  /*target*/) const override
        {
            return Instance->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) == IN_PROGRESS;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_gunship_rocketeerAI>(creature);
    }
};

class spell_igb_rocket_pack_aura : public AuraScript
{
    PrepareAuraScript(spell_igb_rocket_pack_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
            {
                SPELL_ROCKET_PACK_DAMAGE,
                SPELL_ROCKET_BURST
            });
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        if (GetTarget()->movespline->Finalized())
            Remove(AURA_REMOVE_BY_EXPIRE);
    }

    void HandleRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        SpellInfo const* damageInfo = sSpellMgr->AssertSpellInfo(SPELL_ROCKET_PACK_DAMAGE);
        GetTarget()->CastCustomSpell(SPELL_ROCKET_PACK_DAMAGE, SPELLVALUE_BASE_POINT0, 2 * (damageInfo->Effects[EFFECT_0].CalcValue() + aurEff->GetTickNumber() * aurEff->GetAmplitude()), nullptr, true);
        GetTarget()->CastSpell((Unit*)nullptr, SPELL_ROCKET_BURST, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_igb_rocket_pack_aura::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectRemove += AuraEffectRemoveFn(spell_igb_rocket_pack_aura::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_igb_rocket_pack_useable_aura : public AuraScript
{
    PrepareAuraScript(spell_igb_rocket_pack_useable_aura);

    bool Load() override
    {
        return GetOwner()->GetInstanceScript();
    }

    bool CheckAreaTarget(Unit* target)
    {
        return target->IsPlayer() && GetOwner()->GetInstanceScript()->GetBossState(DATA_ICECROWN_GUNSHIP_BATTLE) != DONE;
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* owner = GetOwner()->ToCreature())
            if (Player* target = GetTarget()->ToPlayer())
                if (target->HasItemCount(ITEM_GOBLIN_ROCKET_PACK, 1))
                    sCreatureTextMgr->SendChat(owner, SAY_ZAFOD_ROCKET_PACK_ACTIVE, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* owner = GetOwner()->ToCreature())
            if (Player* target = GetTarget()->ToPlayer())
                if (target->HasItemCount(ITEM_GOBLIN_ROCKET_PACK, 1))
                    sCreatureTextMgr->SendChat(owner, SAY_ZAFOD_ROCKET_PACK_DISABLED, target, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_NORMAL, 0, TEAM_NEUTRAL, false, target);
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_igb_rocket_pack_useable_aura::CheckAreaTarget);
        AfterEffectApply += AuraEffectApplyFn(spell_igb_rocket_pack_useable_aura::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_igb_rocket_pack_useable_aura::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_igb_teleport_to_enemy_ship : public SpellScript
{
    PrepareSpellScript(spell_igb_teleport_to_enemy_ship);

    void RelocateTransportOffset(SpellEffIndex /*effIndex*/)
    {
        WorldLocation const* dest = GetHitDest();
        Unit* target = GetHitUnit();
        if (!dest || !target || !target->GetTransport())
            return;

        float x, y, z, o;
        dest->GetPosition(x, y, z, o);
        target->GetTransport()->CalculatePassengerOffset(x, y, z, &o);
        target->m_movementInfo.transport.pos.Relocate(x, y, z, o);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_igb_teleport_to_enemy_ship::RelocateTransportOffset, EFFECT_0, SPELL_EFFECT_TELEPORT_UNITS);
    }
};

class spell_igb_check_for_players : public SpellScript
{
    PrepareSpellScript(spell_igb_check_for_players);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GUNSHIP_FALL_TELEPORT });
    }

    bool Load() override
    {
        _playerCount = 0;
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void CountTargets(std::list<WorldObject*>& targets)
    {
        _playerCount = targets.size();
    }

    void TriggerWipe()
    {
        if (!_playerCount)
            GetCaster()->ToCreature()->AI()->JustDied(nullptr);
    }

    void TeleportPlayer(SpellEffIndex /*effIndex*/)
    {
        if (GetHitUnit()->GetPositionZ() < GetCaster()->GetPositionZ() - 10.0f)
            GetHitUnit()->CastSpell(GetHitUnit(), SPELL_GUNSHIP_FALL_TELEPORT, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_check_for_players::CountTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        AfterCast += SpellCastFn(spell_igb_check_for_players::TriggerWipe);
        OnEffectHitTarget += SpellEffectFn(spell_igb_check_for_players::TeleportPlayer, EFFECT_0, SPELL_EFFECT_DUMMY);
    }

private:
    uint32 _playerCount;
};

class spell_igb_gunship_fall_teleport : public SpellScript
{
    PrepareSpellScript(spell_igb_gunship_fall_teleport);

    bool Load() override
    {
        return GetCaster()->GetInstanceScript();
    }

    void SelectTransport(WorldObject*& target)
    {
        if (InstanceScript* instance = target->GetInstanceScript())
            target = instance->instance->GetTransport(instance->GetGuidData(DATA_ICECROWN_GUNSHIP_BATTLE));
    }

    void RelocateDest(SpellEffIndex /*effIndex*/)
    {
        Position offset = {0.0f, 0.0f, 0.0f, 0.0f};
        offset.m_positionZ = GetCaster()->GetInstanceScript()->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? 36.0f : 21.0f;
        GetHitDest()->RelocateOffset(offset);
    }

    void Register() override
    {
        OnObjectTargetSelect += SpellObjectTargetSelectFn(spell_igb_gunship_fall_teleport::SelectTransport, EFFECT_0, TARGET_DEST_NEARBY_ENTRY);
        OnEffectLaunch += SpellEffectFn(spell_igb_gunship_fall_teleport::RelocateDest, EFFECT_0, SPELL_EFFECT_TELEPORT_UNITS);
    }
};

class spell_igb_explosion_main_aura : public AuraScript
{
    PrepareAuraScript(spell_igb_explosion_main_aura);

    bool Load() override
    {
        _tickNo = urand(0, 3);
        return true;
    }

    void PeriodicTick(AuraEffect const* aurEff)
    {
        if ((aurEff->GetTickNumber() % 4) != _tickNo)
            PreventDefaultAction();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_igb_explosion_main_aura::PeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }

private:
    uint32 _tickNo;
};

class IgbExplosionCheck
{
public:
    IgbExplosionCheck(Unit* source) : _source(source) {}

    bool operator()(WorldObject* unit)
    {
        return unit->GetTransport() != _source->GetTransport();
    }

private:
    Unit* _source;
};

class spell_igb_explosion : public SpellScript
{
    PrepareSpellScript(spell_igb_explosion);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.remove_if(IgbExplosionCheck(GetCaster()));
        Acore::Containers::RandomResize(targets, 1);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_explosion::SelectTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
    }
};

class IgbTeleportOnVictoryCheck
{
public:
    IgbTeleportOnVictoryCheck(InstanceScript* inst) : _inst(inst) {}

    bool operator()(WorldObject* unit)
    {
        return unit->GetTransGUID() != _inst->GetGuidData(DATA_ENEMY_GUNSHIP);
    }

private:
    InstanceScript* _inst;
};

class spell_igb_teleport_players_on_victory : public SpellScript
{
    PrepareSpellScript(spell_igb_teleport_players_on_victory);

    bool Load() override
    {
        return GetCaster()->GetInstanceScript();
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        InstanceScript* instance = GetCaster()->GetInstanceScript();
        targets.remove_if(IgbTeleportOnVictoryCheck(instance));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_teleport_players_on_victory::FilterTargets, EFFECT_1, TARGET_UNIT_DEST_AREA_ENTRY);
    }
};

class spell_igb_periodic_trigger_with_power_cost_aura : public AuraScript
{
    PrepareAuraScript(spell_igb_periodic_trigger_with_power_cost_aura);

    void HandlePeriodicTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), GetSpellInfo()->Effects[EFFECT_0].TriggerSpell, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_POWER_AND_REAGENT_COST));
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_igb_periodic_trigger_with_power_cost_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_igb_overheat_aura : public AuraScript
{
    PrepareAuraScript(spell_igb_overheat_aura);

    bool Load() override
    {
        if (GetAura()->GetType() != UNIT_AURA_TYPE)
            return false;
        return GetUnitOwner()->IsVehicle();
    }

    void SendClientControl(uint8 value)
    {
        if (Vehicle* vehicle = GetUnitOwner()->GetVehicleKit())
        {
            if (Unit* passenger = vehicle->GetPassenger(0))
            {
                if (Player* player = passenger->ToPlayer())
                {
                    WorldPacket data(SMSG_CLIENT_CONTROL_UPDATE, GetUnitOwner()->GetPackGUID().size() + 1);
                    data << GetUnitOwner()->GetPackGUID();
                    data << uint8(value);
                    player->GetSession()->SendPacket(&data);
                }
            }
        }
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        SendClientControl(0);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        SendClientControl(1);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_igb_overheat_aura::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_igb_overheat_aura::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_igb_cannon_blast : public SpellScript
{
    PrepareSpellScript(spell_igb_cannon_blast);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_OVERHEAT });
    }

    bool Load() override
    {
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void CalculatePower()
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        SpellInfo const* spellInfo = GetSpellInfo();
        if (!spellInfo)
            return;

        // Check if the effect is energize
        if (spellInfo->Effects[EFFECT_1].Effect == SPELL_EFFECT_ENERGIZE)
        {
            int32 energizeAmount = spellInfo->Effects[EFFECT_1].CalcValue(caster);

            // Apply the power gain directly to the caster
            caster->ModifyPower(POWER_ENERGY, energizeAmount);
        }

        if (caster->GetPower(POWER_ENERGY) >= 100)
        {
            caster->CastSpell(caster, SPELL_OVERHEAT, true);
            if (Vehicle* vehicle = caster->GetVehicleKit())
                if (Unit* passenger = vehicle->GetPassenger(0))
                    sCreatureTextMgr->SendChat(caster->ToCreature(), SAY_OVERHEAT, passenger);
        }

    }

    void PreventPowerGainOnHit(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_igb_cannon_blast::CalculatePower);
        OnEffectHitTarget += SpellEffectFn(spell_igb_cannon_blast::PreventPowerGainOnHit, EFFECT_1, SPELL_EFFECT_ENERGIZE);

    }
};

class spell_igb_incinerating_blast : public SpellScript
{
    PrepareSpellScript(spell_igb_incinerating_blast);

    void StoreEnergy()
    {
        _energyLeft = GetCaster()->GetPower(POWER_ENERGY) - 10;
    }

    void RemoveEnergy()
    {
        GetCaster()->SetPower(POWER_ENERGY, 0);
    }

    void CalculateDamage(SpellEffIndex /*effIndex*/)
    {
        PreventHitEffect(EFFECT_0);
        SpellInfo const* si = sSpellMgr->GetSpellInfo(GetSpellInfo()->Effects[0].TriggerSpell);
        if (!si)
            return;
        SpellCastTargets targets;
        Position dest = GetExplTargetDest()->GetPosition();
        targets.SetDst(dest);
        CustomSpellValues values;
        int32 damage = si->Effects[0].CalcValue() + _energyLeft * _energyLeft * 8;
        values.AddSpellMod(SPELLVALUE_BASE_POINT0, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT1, damage);
        values.AddSpellMod(SPELLVALUE_BASE_POINT2, damage);
        GetCaster()->CastSpell(targets, si, &values, TRIGGERED_FULL_MASK);
        //SetEffectValue(GetEffectValue() + _energyLeft * _energyLeft * 8);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_igb_incinerating_blast::StoreEnergy);
        AfterCast += SpellCastFn(spell_igb_incinerating_blast::RemoveEnergy);
        OnEffectHit += SpellEffectFn(spell_igb_incinerating_blast::CalculateDamage, EFFECT_0, SPELL_EFFECT_TRIGGER_MISSILE);
    }

private:
    uint32 _energyLeft;
};

class BurningPitchFilterCheck
{
public:
    BurningPitchFilterCheck(uint32 entry) : _entry(entry) {}

    bool operator()(WorldObject* unit)
    {
        if (Transport* transport = unit->GetTransport())
            return transport->GetEntry() != _entry;
        return true;
    }

private:
    uint32 _entry;
};

class spell_igb_burning_pitch_selector : public SpellScript
{
    PrepareSpellScript(spell_igb_burning_pitch_selector);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        TeamId teamId = TEAM_HORDE;
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
            teamId = TeamId(instance->GetData(DATA_TEAMID_IN_INSTANCE));

        targets.remove_if(BurningPitchFilterCheck(teamId == TEAM_HORDE ? GO_ORGRIMS_HAMMER_H : GO_THE_SKYBREAKER_A));
        if (!targets.empty())
        {
            WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
            targets.clear();
            targets.push_back(target);
        }
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->CastSpell(GetHitUnit(), uint32(GetEffectValue()), TRIGGERED_NONE);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_burning_pitch_selector::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_igb_burning_pitch_selector::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_igb_burning_pitch : public SpellScript
{
    PrepareSpellScript(spell_igb_burning_pitch);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ 8000, SPELL_BURNING_PITCH });
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->CastCustomSpell(uint32(GetEffectValue()), SPELLVALUE_BASE_POINT0, 8000, nullptr, TRIGGERED_FULL_MASK);
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_BURNING_PITCH, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_igb_burning_pitch::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class IgbArtilleryCheck
{
public:
    IgbArtilleryCheck(uint32 entry) : _entry(entry) {}

    bool operator()(WorldObject* unit)
    {
        return unit->GetTypeId() != TYPEID_PLAYER || unit->GetPositionZ() > 478.0f || !unit->GetTransport() || unit->GetTransport()->GetEntry() != _entry
        || unit->GetMapHeight(unit->GetPhaseMask(), unit->GetPositionX(), unit->GetPositionY(), unit->GetPositionZ()) < 465.0f;
    }

private:
    uint32 _entry;
};

class spell_igb_rocket_artillery : public SpellScript
{
    PrepareSpellScript(spell_igb_rocket_artillery);

    void SelectRandomTarget(std::list<WorldObject*>& targets)
    {
        TeamId teamId = TEAM_HORDE;
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
            teamId = TeamId(instance->GetData(DATA_TEAMID_IN_INSTANCE));
        targets.remove_if(IgbArtilleryCheck(teamId == TEAM_HORDE ? GO_ORGRIMS_HAMMER_H : GO_THE_SKYBREAKER_A));

        if (!targets.empty())
        {
            WorldObject* target = Acore::Containers::SelectRandomContainerElement(targets);
            targets.clear();
            targets.push_back(target);
        }
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetCaster()->CastSpell(GetHitUnit()->GetPositionX(), GetHitUnit()->GetPositionY(),
            GetHitUnit()->GetMapHeight(GetCaster()->GetPhaseMask(), GetHitUnit()->GetPositionX(), GetHitUnit()->GetPositionY(), GetHitUnit()->GetPositionZ()),
            uint32(GetEffectValue()), TRIGGERED_NONE);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_igb_rocket_artillery::SelectRandomTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_igb_rocket_artillery::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_igb_rocket_artillery_explosion : public SpellScript
{
    PrepareSpellScript(spell_igb_rocket_artillery_explosion);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BURNING_PITCH_DAMAGE_A, SPELL_BURNING_PITCH_DAMAGE_H, 5000 });
    }

    void DamageGunship(SpellEffIndex /*effIndex*/)
    {
        if (InstanceScript* instance = GetCaster()->GetInstanceScript())
            GetCaster()->CastCustomSpell(instance->GetData(DATA_TEAMID_IN_INSTANCE) == TEAM_HORDE ? SPELL_BURNING_PITCH_DAMAGE_A : SPELL_BURNING_PITCH_DAMAGE_H, SPELLVALUE_BASE_POINT0, 5000, nullptr, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_igb_rocket_artillery_explosion::DamageGunship, EFFECT_0, SPELL_EFFECT_TRIGGER_MISSILE);
    }
};

class spell_igb_below_zero : public SpellScript
{
    PrepareSpellScript(spell_igb_below_zero);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_EJECT_ALL_PASSENGERS });
    }

    void RemovePassengers(SpellMissInfo missInfo)
    {
        if (missInfo != SPELL_MISS_NONE)
        {
            return;
        }

        GetHitUnit()->SetPower(POWER_ENERGY, 0);
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_EJECT_ALL_PASSENGERS, TRIGGERED_FULL_MASK);
    }

    void Register() override
    {
        BeforeHit += BeforeSpellHitFn(spell_igb_below_zero::RemovePassengers);
    }
};

class spell_igb_on_gunship_deck_aura : public AuraScript
{
    PrepareAuraScript(spell_igb_on_gunship_deck_aura);

    bool Load() override
    {
        if (InstanceScript* instance = GetOwner()->GetInstanceScript())
            _teamIdInInstance = TeamId(instance->GetData(DATA_TEAMID_IN_INSTANCE));
        else
            _teamIdInInstance = TEAM_ALLIANCE;
        return true;
    }

    bool CheckAreaTarget(Unit* unit)
    {
        return unit->IsPlayer();
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        bool enemy = GetSpellInfo()->Id == uint32(_teamIdInInstance == TEAM_HORDE ? SPELL_ON_SKYBREAKER_DECK : SPELL_ON_ORGRIMS_HAMMER_DECK);
        if (Creature* gunship = GetOwner()->FindNearestCreature(_teamIdInInstance == TEAM_HORDE ? NPC_ORGRIMS_HAMMER : NPC_THE_SKYBREAKER, 200.0f))
            gunship->AI()->SetGUID(GetTarget()->GetGUID(), enemy ? ACTION_SHIP_VISITS_ENEMY : ACTION_SHIP_VISITS_SELF);
    }

    void Register() override
    {
        DoCheckAreaTarget += AuraCheckAreaTargetFn(spell_igb_on_gunship_deck_aura::CheckAreaTarget);
        AfterEffectApply += AuraEffectApplyFn(spell_igb_on_gunship_deck_aura::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    TeamId _teamIdInInstance;
};

class achievement_im_on_a_boat : public AchievementCriteriaScript
{
public:
    achievement_im_on_a_boat() : AchievementCriteriaScript("achievement_im_on_a_boat") { }

    bool OnCheck(Player* /*source*/, Unit* target, uint32 /*criteria_id*/) override
    {
        return target->GetAI() && target->GetAI()->GetData(ACTION_SHIP_VISITS_ENEMY) == 1;
    }
};

// 71201 - Battle Experience - proc should never happen, handled in script
class spell_igb_battle_experience_check : public AuraScript
{
    PrepareAuraScript(spell_igb_battle_experience_check);

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_igb_battle_experience_check::CheckProc);
    }
};

void AddSC_boss_icecrown_gunship_battle()
{
    new npc_gunship();
    new npc_high_overlord_saurfang_igb();
    new npc_muradin_bronzebeard_igb();
    new npc_zafod_boombox();
    new npc_igb_ship_crew();
    new npc_gunship_boarding_leader();
    new npc_gunship_boarding_add();
    new npc_gunship_mage();
    new npc_gunship_gunner();
    new npc_gunship_rocketeer();
    RegisterSpellScript(spell_igb_rocket_pack_aura);
    RegisterSpellScript(spell_igb_rocket_pack_useable_aura);
    RegisterSpellScript(spell_igb_teleport_to_enemy_ship);
    RegisterSpellScript(spell_igb_check_for_players);
    RegisterSpellScript(spell_igb_gunship_fall_teleport);
    RegisterSpellScript(spell_igb_explosion_main_aura);
    RegisterSpellScript(spell_igb_explosion);
    RegisterSpellScript(spell_igb_teleport_players_on_victory);
    RegisterSpellScript(spell_igb_periodic_trigger_with_power_cost_aura);
    RegisterSpellScript(spell_igb_overheat_aura);
    RegisterSpellScript(spell_igb_cannon_blast);
    RegisterSpellScript(spell_igb_incinerating_blast);
    RegisterSpellScript(spell_igb_burning_pitch_selector);
    RegisterSpellScript(spell_igb_burning_pitch);
    RegisterSpellScript(spell_igb_rocket_artillery);
    RegisterSpellScript(spell_igb_rocket_artillery_explosion);
    RegisterSpellScript(spell_igb_below_zero);
    RegisterSpellScript(spell_igb_on_gunship_deck_aura);
    new achievement_im_on_a_boat();
    RegisterSpellScript(spell_igb_battle_experience_check);
}
