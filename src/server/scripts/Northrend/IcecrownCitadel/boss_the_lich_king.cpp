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
#include "Cell.h"
#include "CellImpl.h"
#include "CreatureScript.h"
#include "CreatureTextMgr.h"
#include "GameTime.h"
#include "GridNotifiers.h"
#include "ObjectMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "Unit.h"
#include "Vehicle.h"
#include "Weather.h"
#include "icecrown_citadel.h"

enum Texts
{
    // The Lich King
    SAY_LK_INTRO_1                  = 0,
    SAY_LK_INTRO_2                  = 1,
    SAY_LK_INTRO_3                  = 2,
    SAY_LK_REMORSELESS_WINTER       = 4,
    SAY_LK_QUAKE                    = 5,
    SAY_LK_SUMMON_VALKYR            = 6,
    SAY_LK_HARVEST_SOUL             = 7,
    SAY_LK_FROSTMOURNE_ESCAPE       = 8,    // not said on heroic
    SAY_LK_FROSTMOURNE_KILL         = 9,    // not said on heroic
    SAY_LK_KILL                     = 10,
    SAY_LK_BERSERK                  = 11,
    EMOTE_DEFILE_WARNING            = 12,
    EMOTE_NECROTIC_PLAGUE_WARNING   = 13,
    SAY_LK_OUTRO_1                  = 14,
    SAY_LK_OUTRO_2                  = 15,
    SAY_LK_OUTRO_3                  = 16,
    SAY_LK_OUTRO_4                  = 17,
    SAY_LK_OUTRO_5                  = 18,
    SAY_LK_OUTRO_6                  = 19,
    SAY_LK_OUTRO_7                  = 20,
    SAY_LK_OUTRO_8                  = 21,

    // Highlord Tirion Fordring
    SAY_TIRION_INTRO_1              = 0,
    SAY_TIRION_INTRO_2              = 1,
    SAY_TIRION_OUTRO_1              = 2,
    SAY_TIRION_OUTRO_2              = 3,
    SAY_TIRION_OUTRO_3              = 4,

    // Terenas Menethil (outro)
    SAY_TERENAS_OUTRO_1             = 0,
    SAY_TERENAS_OUTRO_2             = 1,

    // Terenas Menethil (Frostmourne)
    SAY_TERENAS_INTRO_1             = 0,
    SAY_TERENAS_INTRO_2             = 1,
    SAY_TERENAS_INTRO_3             = 2,
};

enum Spells
{
    // Basic
    SPELL_PLAGUE_AVOIDANCE              = 72846,
    SPELL_EMOTE_SIT_NO_SHEATH           = 73220,
    SPELL_BOSS_HITTIN_YA                = 73878,
    SPELL_BOSS_HITTIN_YA_AURA           = 73879,
    SPELL_EMOTE_SHOUT_NO_SHEATH         = 73213,
    SPELL_ICE_LOCK                      = 71614,

    // Outro
    SPELL_FURY_OF_FROSTMOURNE           = 72350,
    SPELL_FURY_OF_FROSTMOURNE_NO_REZ    = 72351,
    SPELL_EMOTE_QUESTION_NO_SHEATH      = 73330,
    SPELL_RAISE_DEAD                    = 71769,
    SPELL_LIGHTS_BLESSING               = 71797,
    SPELL_JUMP                          = 71809,
    SPELL_JUMP_TRIGGERED                = 71811,
    SPELL_JUMP_2                        = 72431,
    SPELL_SUMMON_BROKEN_FROSTMOURNE     = 74081,
    SPELL_SUMMON_BROKEN_FROSTMOURNE_2   = 72406,
    SPELL_SUMMON_BROKEN_FROSTMOURNE_3   = 73017,
    SPELL_BROKEN_FROSTMOURNE            = 72398,
    SPELL_BROKEN_FROSTMOURNE_KNOCK      = 72405,
    SPELL_SOUL_BARRAGE                  = 72305,
    SPELL_SUMMON_TERENAS                = 72420,
    SPELL_MASS_RESURRECTION             = 72429,
    SPELL_MASS_RESURRECTION_REAL        = 72423,
    SPELL_PLAY_MOVIE                    = 73159,

    // Phase Transition
    SPELL_REMORSELESS_WINTER_1          = 68981,
    SPELL_REMORSELESS_WINTER_2          = 72259,
    SPELL_QUAKE                         = 72262,
    SPELL_PAIN_AND_SUFFERING            = 72133,
    SPELL_SUMMON_ICE_SPHERE             = 69104,
    SPELL_ICE_SPHERE                    = 69090,
    SPELL_ICE_BURST_TARGET_SEARCH       = 69109,
    SPELL_ICE_PULSE                     = 69091,
    SPELL_ICE_BURST                     = 69108,
    SPELL_RAGING_SPIRIT                 = 69200,
    SPELL_RAGING_SPIRIT_VISUAL          = 69197,
    SPELL_RAGING_SPIRIT_VISUAL_CLONE    = 69198,
    SPELL_SOUL_SHRIEK                   = 69242,

    // Phase 1
    SPELL_RISEN_WITCH_DOCTOR_SPAWN      = 69639,
    SPELL_SUMMON_SHAMBLING_HORROR       = 70372,
    SPELL_SUMMON_DRUDGE_GHOULS          = 70358,
    SPELL_INFEST                        = 70541, //cast time 2 sec
    SPELL_NECROTIC_PLAGUE               = 70337,
    SPELL_NECROTIC_PLAGUE_JUMP          = 70338,
    SPELL_PLAGUE_SIPHON                 = 74074,
    SPELL_SHADOW_TRAP                   = 73539,
    SPELL_SHADOW_TRAP_AURA              = 73525,
    SPELL_SHADOW_TRAP_KNOCKBACK         = 73529,

    // Phase 2
    SPELL_DEFILE                        = 72762, //cast time 2 sec
    SPELL_DEFILE_AURA                   = 72743,
    SPELL_DEFILE_GROW                   = 72756,
    SPELL_SOUL_REAPER                   = 69409, // instant
    SPELL_SOUL_REAPER_BUFF              = 69410,
    SPELL_SUMMON_VALKYR                 = 69037, // instant
    SPELL_SUMMON_VALKYR_PERIODIC        = 74361,
    SPELL_WINGS_OF_THE_DAMNED           = 74352,
    SPELL_VALKYR_TARGET_SEARCH          = 69030,
    SPELL_HARVEST_SOUL_VALKYR           = 68985, // vehicle aura used by Val'kyr Shadowguard and Strangulate Vehicle
    SPELL_CHARGE                        = 74399,
    SPELL_VALKYR_CARRY                  = 74445,
    SPELL_EJECT_ALL_PASSENGERS          = 68576,
    SPELL_LIFE_SIPHON                   = 73488,
    SPELL_LIFE_SIPHON_HEAL              = 73489,

    // Phase 3
    SPELL_VILE_SPIRITS                  = 70498,
    SPELL_VILE_SPIRIT_MOVE_SEARCH       = 70501,
    SPELL_VILE_SPIRIT_DAMAGE_SEARCH     = 70502,
    SPELL_SPIRIT_BURST                  = 70503,
    SPELL_HARVEST_SOUL                  = 68980,
    SPELL_HARVEST_SOUL_VEHICLE          = 68984,
    SPELL_HARVEST_SOUL_VISUAL           = 71372,
    SPELL_HARVEST_SOUL_TELEPORT         = 72546,
    SPELL_HARVEST_SOUL_TELEPORT_BACK    = 72597,
    SPELL_KILL_FROSTMOURNE_PLAYERS      = 75127,
    SPELL_HARVESTED_SOUL_LK_BUFF        = 72679,
    SPELL_HARVEST_SOULS                 = 73654,
    SPELL_HARVEST_SOULS_TELEPORT        = 73655,
    //SPELL_IN_FROSTMOURNE_ROOM           = 74276,

    // Frostmourne
    SPELL_LIGHTS_FAVOR                  = 69382,
    SPELL_RESTORE_SOUL                  = 72595,
    SPELL_RESTORE_SOULS                 = 73650,
    SPELL_TERENAS_LOSES_INSIDE          = 72572,
    SPELL_DESTROY_SOUL                  = 74086,
    SPELL_DARK_HUNGER                   = 69383,    // Passive proc healing
    SPELL_DARK_HUNGER_HEAL              = 69384,
    SPELL_SOUL_RIP                      = 69397,    // Deals increasing damage
    SPELL_SOUL_RIP_DAMAGE               = 69398,
    SPELL_SUMMON_SPIRIT_BOMB_1          = 73581,
    SPELL_SUMMON_SPIRIT_BOMB_2          = 74299,
    SPELL_TRIGGER_VILE_SPIRIT_HEROIC    = 73582,
    SPELL_EXPLOSION                     = 73576,

    // Shambling Horror
    SPELL_SHOCKWAVE                     = 72149,
    SPELL_ENRAGE                        = 72143,
    SPELL_FRENZY                        = 28747,
};

#define NECROTIC_PLAGUE_LK   RAID_MODE<uint32>(70337, 73912, 73913, 73914)
#define NECROTIC_PLAGUE_PLR  RAID_MODE<uint32>(70338, 73785, 73786, 73787)
#define REMORSELESS_WINTER_1 RAID_MODE<uint32>(68981, 74270, 74271, 74272)
#define REMORSELESS_WINTER_2 RAID_MODE<uint32>(72259, 74273, 74274, 74275)
#define SUMMON_VALKYR        RAID_MODE<uint32>(69037, 74361, 69037, 74361)
//#define HARVEST_SOUL         RAID_MODE<uint32>(68980, 74325, 74296, 74297)
#define HARVESTED_SOUL_BUFF  RAID_MODE<uint32>(72679, 74318, 74319, 74320)

enum Events
{
    EVENT_NONE,

    // Intro
    EVENT_INTRO_LK_MOVE,
    EVENT_INTRO_LK_TALK_1,
    EVENT_INTRO_LK_EMOTE_CAST_SHOUT,
    EVENT_INTRO_LK_EMOTE_1,
    EVENT_INTRO_LK_CAST_FREEZE,
    EVENT_INTRO_FORDRING_TALK_1,
    EVENT_INTRO_FORDRING_TALK_2,
    EVENT_INTRO_FORDRING_EMOTE_1,
    EVENT_INTRO_FORDRING_CHARGE,
    EVENT_INTRO_FINISH,

    // Outro
    EVENT_OUTRO_LK_TALK_1,
    EVENT_OUTRO_LK_TALK_2,
    EVENT_OUTRO_LK_EMOTE_TALK,
    EVENT_OUTRO_LK_TALK_3,
    EVENT_OUTRO_LK_EMOTE_CAST_SHOUT,
    EVENT_OUTRO_LK_MOVE_CENTER,
    EVENT_OUTRO_LK_TALK_4,
    EVENT_OUTRO_LK_RAISE_DEAD,
    EVENT_OUTRO_LK_TALK_5,
    EVENT_OUTRO_LK_TALK_6,
    EVENT_OUTRO_LK_TALK_7,
    EVENT_OUTRO_LK_TALK_8,
    EVENT_OUTRO_FORDRING_TALK_1,
    EVENT_OUTRO_FORDRING_BLESS,
    EVENT_OUTRO_FORDRING_REMOVE_ICE,
    EVENT_OUTRO_FORDRING_MOVE_1,
    EVENT_OUTRO_FORDRING_JUMP,
    EVENT_OUTRO_AFTER_SUMMON_BROKEN_FROSTMOURNE,
    EVENT_OUTRO_KNOCK_BACK,
    EVENT_OUTRO_SOUL_BARRAGE,
    EVENT_OUTRO_AFTER_SOUL_BARRAGE,
    EVENT_OUTRO_SUMMON_TERENAS,
    EVENT_OUTRO_TERENAS_TALK_1,
    EVENT_OUTRO_TERENAS_TALK_2,

    // General
    EVENT_BERSERK,
    EVENT_START_ATTACK,
    EVENT_QUAKE,
    EVENT_QUAKE_2,

    // Combat
    EVENT_SUMMON_SHAMBLING_HORROR,
    EVENT_SUMMON_DRUDGE_GHOUL,
    EVENT_INFEST,
    EVENT_NECROTIC_PLAGUE,
    EVENT_SHADOW_TRAP,
    EVENT_PAIN_AND_SUFFERING,
    EVENT_SUMMON_ICE_SPHERE,
    EVENT_SUMMON_RAGING_SPIRIT,
    EVENT_DEFILE,
    EVENT_SOUL_REAPER,
    EVENT_SUMMON_VALKYR,
    EVENT_VILE_SPIRITS,
    EVENT_HARVEST_SOUL,
    EVENT_HARVEST_SOULS,
    EVENT_FROSTMOURNE_HEROIC,

    // Shambling Horror
    EVENT_SHOCKWAVE,
    EVENT_ENRAGE,

    // Raging Spirit
    EVENT_SOUL_SHRIEK,
    EVENT_RAGING_SPIRIT_UNROOT,

    // Val'kyr Shadowguard
    EVENT_GRAB_PLAYER,
    EVENT_MOVE_TO_DROP_POS,
    EVENT_MOVE_TO_SIPHON_POS,
    EVENT_LIFE_SIPHON,

    // Strangulate Vehicle (Harvest Soul)
    EVENT_TELEPORT,
    EVENT_MOVE_TO_LICH_KING,
    EVENT_DESPAWN_SELF,

    // Inside Frostmourne
    EVENT_FROSTMOURNE_TALK_1,
    EVENT_FROSTMOURNE_TALK_2,
    EVENT_FROSTMOURNE_TALK_3,
    EVENT_DESTROY_SOUL,
    EVENT_TELEPORT_BACK,
    EVENT_SOUL_RIP,
};

enum EventGroups
{
    EVENT_GROUP_NONE,
    EVENT_GROUP_ABILITIES,
    EVENT_GROUP_BERSERK,
    EVENT_GROUP_VILE_SPIRITS,
};

enum Phases
{
    PHASE_NONE                  = 0,
    PHASE_INTRO                 = 1,
    PHASE_ONE                   = 2,
    PHASE_TWO                   = 3,
    PHASE_THREE                 = 4,
    PHASE_TRANSITION            = 5,
    PHASE_FROSTMOURNE           = 6, // only set on heroic mode when all players are sent into frostmourne
    PHASE_OUTRO                 = 7,

    PHASE_MASK_NO_CAST_CHECK    = (1 << PHASE_TRANSITION) | (1 << PHASE_FROSTMOURNE) | (1 << PHASE_OUTRO),
    PHASE_MASK_NO_VICTIM        = (1 << PHASE_INTRO) | (1 << PHASE_OUTRO) | (1 << PHASE_FROSTMOURNE),
};

Position const CenterPosition     = {503.6282f, -2124.655f, 840.8569f, 0.0f};
Position const TirionSpawn        = { 505.2118f, -2124.353f, 840.9403f, 3.141593f };
Position const TirionIntro        = {488.2970f, -2124.840f, 840.8569f, 0.0f};
Position const TirionCharge       = {472.8500f, -2124.350f, 840.8570f, 0.0f};
Position const LichKingIntro[3]   = { {432.0851f, -2123.673f, 864.6582f, 0.0f}, {457.8351f, -2123.423f, 841.1582f, 0.0f}, {465.0730f, -2123.470f, 840.8569f, 0.0f} };
Position const OutroPosition1     = {488.6100f, -2124.620f, 840.8569f, 0.0f};
Position const OutroFlying        = {509.6897f, -2124.561f, 845.3565f, 0.0f};
Position const TerenasSpawn       = {495.5542f, -2517.012f, 1050.000f, 4.6993f};
Position const TerenasSpawnHeroic = {495.7080f, -2523.760f, 1050.000f, 0.0f};
Position const SpiritWardenSpawn  = {495.3406f, -2529.983f, 1050.000f, 1.5592f};

enum MovePoints
{
    POINT_NONE,
    POINT_CENTER_1,
    POINT_CENTER_2,
    POINT_TIRION_INTRO,
    POINT_TIRION_OUTRO,
    POINT_DROP_PLAYER,
    POINT_START_SIPHON,
    POINT_GROUND,
};

enum EncounterActions
{
    ACTION_NONE,
    ACTION_START_ATTACK,
    ACTION_OUTRO,
    ACTION_BREAK_FROSTMOURNE,
    ACTION_TELEPORT_BACK,
};

enum MiscData
{
    LIGHT_SNOWSTORM             = 2490,
    LIGHT_SOULSTORM             = 2508,
    EQUIP_ASHBRINGER            = 13262,
    MUSIC_FROZEN_THRONE         = 17457,
    MUSIC_SPECIAL               = 17458, // Summon Shambling Horror, Remorseless Winter, Quake, Summon Val'kyr Periodic, Harvest Soul, Vile Spirits
    MUSIC_FURY_OF_FROSTMOURNE   = 17459,
    MUSIC_FINAL                 = 17460, // Raise Dead, Light's Blessing
    SOUND_PAIN                  = 17360, // separate sound, not attached to any text
    EQUIP_ASHBRINGER_GLOWING    = 50442,
    EQUIP_BROKEN_FROSTMOURNE    = 50840,
    MOVIE_FALL_OF_THE_LICH_KING = 16,
};

#define DATA_PLAGUE_STACK 70337
#define DATA_VILE 45814622

bool IsValidPlatformTarget(Unit const* target)
{
    return target->GetExactDist2dSq(&CenterPosition) < 90.0f * 90.0f && target->GetPositionZ() > 840.0f && target->GetPositionZ() < 875.0f;
}

void SendPacketToPlayers(WorldPacket const* data, Unit* source)
{
    // Send packet to all players in The Frozen Throne
    Map::PlayerList const& players = source->GetMap()->GetPlayers();
    if (!players.IsEmpty())
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->GetAreaId() == AREA_THE_FROZEN_THRONE)
                    player->GetSession()->SendPacket(data);
}

struct ShadowTrapLKTargetSelector
{
public:
    ShadowTrapLKTargetSelector(Creature* source, bool playerOnly = true, bool reqLOS = false, float maxDist = 0.0f) : _source(source), _playerOnly(playerOnly), _reqLOS(reqLOS), _maxDist(maxDist) { }
    bool operator()(Unit const* target) const
    {
        if (!target)
            return false;
        if (!target->IsAlive())
            return false;
        if (_playerOnly && target->GetTypeId() != TYPEID_PLAYER)
            return false;
        if (_maxDist && _source->GetExactDist(target) > _maxDist)
            return false;
        if (_reqLOS && !_source->IsWithinLOSInMap(target))
            return false;
        return true;
    }

private:
    Creature const* _source;
    bool _playerOnly;
    bool _reqLOS;
    float _maxDist;
};

struct NonTankLKTargetSelector
{
public:
    NonTankLKTargetSelector(Creature* source, bool playerOnly = true, bool reqLOS = false, float maxDist = 0.0f, uint32 exclude1 = 0, uint32 exclude2 = 0) : _source(source), _playerOnly(playerOnly), _reqLOS(reqLOS), _maxDist(maxDist), _exclude1(exclude1), _exclude2(exclude2) { }
    bool operator()(Unit const* target) const
    {
        if (!target)
            return false;
        if (!target->IsAlive())
            return false;
        if (_playerOnly && target->GetTypeId() != TYPEID_PLAYER)
            return false;
        if (target == _source->GetVictim())
            return false;
        if (target->HasAura(SPELL_BOSS_HITTIN_YA_AURA))
            return false;
        if (_maxDist && _source->GetExactDist(target) > _maxDist)
            return false;
        if ((_exclude1 && target->HasAura(_exclude1)) || (_exclude2 && target->HasAura(_exclude2)))
            return false;
        if (_reqLOS && !_source->IsWithinLOSInMap(target))
            return false;
        return true;
    }

private:
    Creature const* _source;
    bool _playerOnly;
    bool _reqLOS;
    float _maxDist;
    uint32 _exclude1;
    uint32 _exclude2;
};

struct DefileTargetSelector
{
public:
    DefileTargetSelector(Creature* source) : _source(source) { }
    bool operator()(Unit const* target) const
    {
        if (!target)
            return false;
        if (!target->IsAlive())
            return false;
        if (target->GetTypeId() != TYPEID_PLAYER)
            return false;
        if (_source->GetExactDist(target) > 100.0f)
            return false;
        if (target->HasAura(SPELL_HARVEST_SOUL_VALKYR) || target->HasAura(SPELL_VALKYR_TARGET_SEARCH))
            return false;
        if (!_source->IsWithinLOSInMap(target))
            return false;
        return true;
    }

private:
    Creature const* _source;
};

class FrozenThroneResetWorker
{
public:
    FrozenThroneResetWorker() { }

    bool operator()(GameObject* go)
    {
        switch (go->GetEntry())
        {
            case GO_ARTHAS_PLATFORM:
                go->SetDestructibleState(GO_DESTRUCTIBLE_INTACT, nullptr, true);
                break;
            case GO_DOODAD_ICECROWN_THRONEFROSTYWIND01:
                go->SetGoState(GO_STATE_ACTIVE);
                break;
            case GO_DOODAD_ICECROWN_THRONEFROSTYEDGE01:
                go->SetGoState(GO_STATE_READY);
                break;
            case GO_DOODAD_ICECROWN_SNOWEDGEWARNING01:
                go->SetGoState(GO_STATE_READY);
                break;
            case GO_DOODAD_ICESHARD_STANDING02:
            case GO_DOODAD_ICESHARD_STANDING01:
            case GO_DOODAD_ICESHARD_STANDING03:
            case GO_DOODAD_ICESHARD_STANDING04:
                go->ResetDoorOrButton();
                break;
            default:
                break;
        }

        return false;
    }
};

class StartMovementEvent : public BasicEvent
{
public:
    StartMovementEvent(Creature* summoner, Creature* owner) : _summoner(summoner), _owner(owner) {}

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _owner->SetReactState(REACT_AGGRESSIVE);
        if (!_owner->GetThreatMgr().isThreatListEmpty())
            if (Unit* target = _owner->SelectVictim())
                _owner->AI()->AttackStart(target);
        if (!_owner->GetVictim())
            if (Unit* target = _summoner->AI()->SelectTarget(SelectTargetMethod::Random, 0, NonTankLKTargetSelector(_summoner)))
                _owner->AI()->AttackStart(target);
        _owner->AI()->DoZoneInCombat();
        return true;
    }

private:
    Creature* _summoner;
    Creature* _owner;
};

class VileSpiritActivateEvent : public BasicEvent
{
public:
    explicit VileSpiritActivateEvent(Creature* owner) : _owner(owner) {}

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _owner->SetReactState(REACT_AGGRESSIVE);
        _owner->CastSpell(_owner, SPELL_VILE_SPIRIT_MOVE_SEARCH, true);
        _owner->CastSpell((Unit*)nullptr, SPELL_VILE_SPIRIT_DAMAGE_SEARCH, true);
        return true;
    }

private:
    Creature* _owner;
};

class TriggerWickedSpirit : public BasicEvent
{
public:
    explicit TriggerWickedSpirit(Creature* owner)
        : _owner(owner), _counter(13)
    {
    }

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _owner->CastCustomSpell(SPELL_TRIGGER_VILE_SPIRIT_HEROIC, SPELLVALUE_MAX_TARGETS, 1, nullptr, true);

        if (--_counter)
        {
            _owner->m_Events.AddEvent(this, _owner->m_Events.CalculateTime(3000));
            return false;
        }

        return true;
    }

private:
    Creature* _owner;
    uint32 _counter;
};

class LichKingDeathEvent : public BasicEvent
{
public:
    LichKingDeathEvent(Creature& owner) : _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.RemoveAllAuras();
        Unit::Kill(&_owner, &_owner);
        return true;
    }

private:
    Creature& _owner;
};

class LichKingMovieEvent : public BasicEvent
{
public:
    LichKingMovieEvent(Creature& owner) : _owner(owner) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _owner.CastSpell((Unit*)nullptr, SPELL_PLAY_MOVIE, false);
        return true;
    }

private:
    Creature& _owner;
};

class NecroticPlagueTargetCheck
{
public:
    NecroticPlagueTargetCheck(Unit const* obj, uint32 notAura1, uint32 notAura2) : _sourceObj(obj), _notAura1(notAura1), _notAura2(notAura2) {}

    bool operator()(Unit* unit) const
    {
        if (!unit || unit->GetTypeId() != TYPEID_PLAYER || unit == _sourceObj || _sourceObj->GetVictim() == unit || !unit->isTargetableForAttack())
            return false;
        if (unit->HasAura(SPELL_PLAGUE_AVOIDANCE) || unit->HasAura(SPELL_BOSS_HITTIN_YA_AURA) || unit->HasAura(_notAura1) || unit->HasAura(_notAura2))
            return false;
        if (!_sourceObj->IsWithinLOSInMap(unit))
            return false;
        return true;
    }

private:
    Unit const* _sourceObj;
    uint32 _notAura1;
    uint32 _notAura2;
};

class HeightDifferenceCheck
{
public:
    HeightDifferenceCheck(GameObject* go, float diff, bool reverse) : _baseObject(go), _difference(diff), _reverse(reverse) {}
    bool operator()(WorldObject* unit) const { return (unit->GetPositionZ() - _baseObject->GetPositionZ() > _difference) != _reverse; }
private:
    GameObject* _baseObject;
    float _difference;
    bool _reverse;
};

class boss_the_lich_king : public CreatureScript
{
public:
    boss_the_lich_king() : CreatureScript("boss_the_lich_king") { }

    struct boss_the_lich_kingAI : public BossAI
    {
        boss_the_lich_kingAI(Creature* creature) : BossAI(creature, DATA_THE_LICH_KING)
        {
            me->AddAura(SPELL_EMOTE_SIT_NO_SHEATH, me);
            me->SetImmuneToPC(true);
            me->SetReactState(REACT_PASSIVE);
        }

        uint8 _phase;
        uint32 _necroticPlagueStack;
        uint32 _vileSpiritExplosions;
        uint16 _positionCheckTimer;
        uint32 _lastTalkTimeKill;
        uint32 _lastTalkTimeBuff;
        bool _bFrostmournePhase;
        bool _bFordringMustFallYell;

        void Reset() override
        {
            _phase = PHASE_NONE;
            _necroticPlagueStack = 0;
            _vileSpiritExplosions = 0;
            _positionCheckTimer = 5000;
            _lastTalkTimeKill = 0;
            _lastTalkTimeBuff = 0;
            _bFrostmournePhase = false;
            _bFordringMustFallYell = false;

            _Reset();
            DoAction(ACTION_RESTORE_LIGHT);
            SetEquipmentSlots(true);
            if (me->IsImmuneToPC())
                me->SetStandState(UNIT_STAND_STATE_SIT);

            DoAction(ACTION_RESTORE_LIGHT);

            // Reset The Frozen Throne gameobjects
            FrozenThroneResetWorker reset;
            Acore::GameObjectWorker<FrozenThroneResetWorker> worker(me, reset);
            Cell::VisitGridObjects(me, worker, 333.0f);

            me->AddAura(SPELL_EMOTE_SIT_NO_SHEATH, me);
            me->SetImmuneToPC(true);
            me->SetReactState(REACT_PASSIVE);
            me->SetStandState(UNIT_STAND_STATE_SIT);

            if (!ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_HIGHLORD_TIRION_FORDRING)))
                me->SummonCreature(NPC_HIGHLORD_TIRION_FORDRING_LK, TirionSpawn, TEMPSUMMON_MANUAL_DESPAWN);
        }

        void JustDied(Unit* /*killer*/) override
        {
            _JustDied();
            DoAction(ACTION_RESTORE_LIGHT);
            me->PlayDirectSound(17374);
        }

        void JustEngagedWith(Unit* target) override
        {
            if (!instance->CheckRequiredBosses(DATA_THE_LICH_KING, target->ToPlayer()) || !me->IsVisible())
            {
                EnterEvadeMode(EVADE_REASON_OTHER);
                instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                return;
            }

            _phase = PHASE_ONE;
            instance->SetBossState(DATA_THE_LICH_KING, IN_PROGRESS);
            me->setActive(true);
            me->SetInCombatWithZone();
            me->RemoveAurasDueToSpell(SPELL_EMOTE_SIT_NO_SHEATH); // just to be sure

            events.ScheduleEvent(EVENT_BERSERK, 15min, EVENT_GROUP_BERSERK);
            events.ScheduleEvent(EVENT_SUMMON_SHAMBLING_HORROR, 15s, EVENT_GROUP_ABILITIES);
            events.ScheduleEvent(EVENT_SUMMON_DRUDGE_GHOUL, 10s, EVENT_GROUP_ABILITIES);
            events.ScheduleEvent(EVENT_INFEST, 5s, EVENT_GROUP_ABILITIES);
            events.ScheduleEvent(EVENT_NECROTIC_PLAGUE, 30s, 31s, EVENT_GROUP_ABILITIES);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SHADOW_TRAP, 15s + 500ms, EVENT_GROUP_ABILITIES);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return me->IsVisible() && IsValidPlatformTarget(target) && !target->GetVehicle();
        }

        /*bool CanBeSeen(Player const* p)
        {
            return me->GetExactDistSq(p) < 200.0f*200.0f;
        }*/

        void KilledUnit(Unit* victim) override
        {
            if (victim->IsPlayer() && !me->IsInEvadeMode() && _phase != PHASE_OUTRO && _lastTalkTimeKill + 5 < GameTime::GetGameTime().count())
            {
                _lastTalkTimeKill = GameTime::GetGameTime().count();
                Talk(SAY_LK_KILL);
            }
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_RESTORE_LIGHT:
                    me->GetMap()->SetZoneOverrideLight(AREA_THE_FROZEN_THRONE, 0, 5s);
                    me->GetMap()->SetZoneWeather(AREA_THE_FROZEN_THRONE, WEATHER_STATE_FINE, 0.5f);
                    break;
                case ACTION_START_ATTACK:
                    events.ScheduleEvent(EVENT_START_ATTACK, 5250ms);
                    break;
                case ACTION_BREAK_FROSTMOURNE:
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_BROKEN_FROSTMOURNE, true);
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_BROKEN_FROSTMOURNE_2, false);
                    SetEquipmentSlots(false, EQUIP_BROKEN_FROSTMOURNE);
                    if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_HIGHLORD_TIRION_FORDRING)))
                        tirion->AI()->DoAction(ACTION_BREAK_FROSTMOURNE);
                    break;
                case ACTION_TELEPORT_BACK:
                    {
                        if (_phase == PHASE_FROSTMOURNE)
                            events.RescheduleEvent(EVENT_START_ATTACK, 1s);
                        EntryCheckPredicate pred(NPC_STRANGULATE_VEHICLE);
                        summons.DoAction(ACTION_TELEPORT_BACK, pred);
                        if (!IsHeroic() && _phase != PHASE_OUTRO && me->IsInCombat() && _lastTalkTimeBuff + 5 <= GameTime::GetGameTime().count())
                            Talk(SAY_LK_FROSTMOURNE_ESCAPE);
                    }
                    break;
                default:
                    break;
            }
        }

        void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!attacker || (_bFrostmournePhase && attacker->GetExactDistSq(495.708f, -2523.76f, 1049.95f) > 40.0f * 40.0f)) // frostmourne room, prevent exploiting (tele hack to get back and damage him)
            {
                damage = 0;
                return;
            }

            if (_phase == PHASE_ONE && !HealthAbovePct(70) && !me->HasUnitState(UNIT_STATE_CASTING))
            {
                _phase = PHASE_TRANSITION;
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();
                events.CancelEventGroup(EVENT_GROUP_ABILITIES);
                me->InterruptNonMeleeSpells(false);
                me->GetMotionMaster()->MovePoint(POINT_CENTER_1, CenterPosition);
                return;
            }

            if (_phase == PHASE_TWO && !HealthAbovePct(40) && !me->HasUnitState(UNIT_STATE_CASTING))
            {
                _phase = PHASE_TRANSITION;
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();
                events.CancelEventGroup(EVENT_GROUP_ABILITIES);
                me->InterruptNonMeleeSpells(false);
                me->GetMotionMaster()->MovePoint(POINT_CENTER_2, CenterPosition);
                return;
            }

            if (_phase == PHASE_THREE && HealthBelowPct(10) && !me->HasUnitState(UNIT_STATE_CASTING))
            {
                _phase = PHASE_OUTRO;
                EntryCheckPredicate pred(NPC_STRANGULATE_VEHICLE);
                summons.DoAction(ACTION_TELEPORT_BACK, pred);
                events.Reset();
                summons.DespawnAll();
                me->SetReactState(REACT_PASSIVE);
                me->AttackStop();
                me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_FURY_OF_FROSTMOURNE);
                me->InterruptNonMeleeSpells(true);
                me->CastSpell((Unit*)nullptr, SPELL_FURY_OF_FROSTMOURNE, false);
                me->SetWalk(true);

                if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_HIGHLORD_TIRION_FORDRING)))
                    tirion->AI()->DoAction(ACTION_OUTRO);
                return;
            }

            if (_phase == PHASE_OUTRO)
            {
                if (!me->IsLevitating())
                    damage = me->GetHealth() > 1 ? 1 : 0;
                else if (damage >= me->GetHealth()) // dying...
                {
                    damage = me->GetHealth() - 1;
                    me->SetDisableGravity(false);
                    me->GetMotionMaster()->MoveFall();
                    if (Creature* frostmourne = me->FindNearestCreature(NPC_FROSTMOURNE_TRIGGER, 50.0f))
                        frostmourne->DespawnOrUnsummon(1);
                    if (Creature* terenas = me->FindNearestCreature(NPC_TERENAS_MENETHIL_OUTRO, 50.0f))
                        terenas->DespawnOrUnsummon(1);

                    me->m_Events.AddEvent(new LichKingDeathEvent(*me), me->m_Events.CalculateTime(2500)); // die after spinning anim is over, so death anim is visible
                    me->m_Events.AddEvent(new LichKingMovieEvent(*me), me->m_Events.CalculateTime(11500));
                }

                if (!_bFordringMustFallYell && me->GetHealth() < 500000)
                {
                    _bFordringMustFallYell = true;
                    if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_HIGHLORD_TIRION_FORDRING)))
                    {
                        tirion->AI()->Talk(SAY_TIRION_OUTRO_3);
                    }
                }
            }
            else if (damage >= me->GetHealth())
                damage = me->GetHealth() - 1;
        }

        void JustSummoned(Creature* summon) override
        {
            if (summon->GetEntry() == NPC_HIGHLORD_TIRION_FORDRING_LK)
            {
                return;
            }

            switch (summon->GetEntry())
            {
                case NPC_SHAMBLING_HORROR:
                case NPC_DRUDGE_GHOUL:
                    summon->SetHomePosition(CenterPosition);
                    summon->CastSpell(summon, SPELL_RISEN_WITCH_DOCTOR_SPAWN, true);
                    summon->SetReactState(REACT_PASSIVE);
                    summon->HandleEmoteCommand(EMOTE_ONESHOT_EMERGE);
                    summon->m_Events.AddEvent(new StartMovementEvent(me, summon), summon->m_Events.CalculateTime(5000));
                    break;
                case NPC_RAGING_SPIRIT:
                    summon->SetHomePosition(CenterPosition);
                    break;
                case NPC_VILE_SPIRIT:
                    {
                        summon->SetReactState(REACT_PASSIVE);
                        summon->GetMotionMaster()->MoveRandom(10.0f);
                        if (_phase == PHASE_THREE)
                            summon->m_Events.AddEvent(new VileSpiritActivateEvent(summon), summon->m_Events.CalculateTime(15000));
                        break;
                    }
                case NPC_STRANGULATE_VEHICLE:
                    summons.Summon(summon);
                    return;
                case NPC_DEFILE:
                case NPC_SHADOW_TRAP_TRIGGER:
                    summon->m_positionZ = 840.86f;
                    summon->UpdatePosition(summon->GetPositionX(), summon->GetPositionY(), summon->GetPositionZ(), summon->GetOrientation(), true);
                    summon->StopMovingOnCurrentPos();
                    break;
                case NPC_VALKYR_SHADOWGUARD:
                    if (_phase == PHASE_THREE || events.GetNextEventTime(EVENT_QUAKE_2))
                        summon->DespawnOrUnsummon(1);
                    break;
                default:
                    break;
            }

            BossAI::JustSummoned(summon);
        }

        void SummonedCreatureDies(Creature* summon, Unit*) override
        {
            switch (summon->GetEntry())
            {
                case NPC_SHAMBLING_HORROR:
                case NPC_DRUDGE_GHOUL:
                case NPC_ICE_SPHERE:
                case NPC_VALKYR_SHADOWGUARD:
                case NPC_RAGING_SPIRIT:
                case NPC_VILE_SPIRIT:
                    summon->ToTempSummon()->SetTimer(5000);
                    summon->ToTempSummon()->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN);
                    break;
                default:
                    break;
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == HARVESTED_SOUL_BUFF && me->IsInCombat() && !IsHeroic() && _phase != PHASE_OUTRO && _lastTalkTimeBuff + 5 <= GameTime::GetGameTime().count())
            {
                _lastTalkTimeBuff = GameTime::GetGameTime().count();
                Talk(SAY_LK_FROSTMOURNE_KILL);
            }
        }

        void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell) override
        {
            if (spell->Id == REMORSELESS_WINTER_1 || spell->Id == REMORSELESS_WINTER_2)
            {
                me->GetMap()->SetZoneOverrideLight(AREA_THE_FROZEN_THRONE, LIGHT_SNOWSTORM, 5s);
                me->GetMap()->SetZoneWeather(AREA_THE_FROZEN_THRONE, WEATHER_STATE_LIGHT_SNOW, 0.5f);
                summons.DespawnEntry(NPC_SHADOW_TRAP_TRIGGER);
            }
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            switch (pointId)
            {
                case POINT_CENTER_1:
                    me->SetFacingTo(0.0f);
                    Talk(SAY_LK_REMORSELESS_WINTER);
                    me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                    me->CastSpell(me, SPELL_REMORSELESS_WINTER_1, false);
                    //events.DelayEvents(62500, EVENT_GROUP_BERSERK); // delay berserk timer, its not ticking during phase transitions, 15mins on movies
                    events.ScheduleEvent(EVENT_QUAKE, 62s + 500ms);
                    events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, 3500ms, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SUMMON_ICE_SPHERE, 8s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SUMMON_RAGING_SPIRIT, 4s, EVENT_GROUP_ABILITIES);
                    break;
                case POINT_CENTER_2:
                    me->SetFacingTo(0.0f);
                    Talk(SAY_LK_REMORSELESS_WINTER);
                    me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                    me->CastSpell(me, SPELL_REMORSELESS_WINTER_2, false);
                    summons.DespawnEntry(NPC_VALKYR_SHADOWGUARD);
                    //events.DelayEvents(62500, EVENT_GROUP_BERSERK); // delay berserk timer, its not ticking during phase transitions, 15 mins on movies
                    events.ScheduleEvent(EVENT_QUAKE_2, 62s + 500ms);
                    events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, 3500ms, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SUMMON_ICE_SPHERE, 8s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SUMMON_RAGING_SPIRIT, 4s, EVENT_GROUP_ABILITIES);
                    break;
                default:
                    break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (_phase == PHASE_NONE)
                return;

            // check phase first to prevent updating victim and entering evade mode when not wanted
            if (!((1 << _phase) & PHASE_MASK_NO_VICTIM))
                if (!UpdateVictim())
                    return;

            // handle falling players so they don't fall infinitely
            if (_positionCheckTimer <= diff)
            {
                _positionCheckTimer = 5000;
                Map::PlayerList const& players = me->GetMap()->GetPlayers();
                if (!players.IsEmpty())
                    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                        if (Player* player = itr->GetSource())
                            if (player->GetPositionZ() < 700.0f)
                                Unit::Kill(me, player);
            }
            else
                _positionCheckTimer -= diff;

            events.Update(diff);

            // during Remorseless Winter phases The Lich King is channeling a spell, but we must continue casting other spells
            if (me->HasUnitState(UNIT_STATE_CASTING) && !((1 << _phase) & PHASE_MASK_NO_CAST_CHECK))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_BERSERK:
                    Talk(SAY_LK_BERSERK);
                    me->CastSpell(me, SPELL_BERSERK2, true);
                    break;
                case EVENT_START_ATTACK:
                    me->SetReactState(REACT_AGGRESSIVE);
                    if (_phase == PHASE_FROSTMOURNE)
                    {
                        _bFrostmournePhase = false;
                        _phase = PHASE_THREE;
                        events.RescheduleEvent(EVENT_DEFILE, 0ms, EVENT_GROUP_ABILITIES);
                        events.RescheduleEvent(EVENT_SOUL_REAPER, 7s, 12s, EVENT_GROUP_ABILITIES);

                        for (SummonList::iterator i = summons.begin(); i != summons.end(); ++i)
                            if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                                if (summon->GetEntry() == NPC_RAGING_SPIRIT)
                                    summon->SetReactState(REACT_AGGRESSIVE);
                    }
                    break;
                case EVENT_QUAKE:
                    _phase = PHASE_TWO;
                    events.CancelEventGroup(EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_INFEST, 14s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SUMMON_VALKYR, 20s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SOUL_REAPER, 40s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_DEFILE, 38s, EVENT_GROUP_ABILITIES);

                    me->InterruptNonMeleeSpells(false);
                    me->ClearUnitState(UNIT_STATE_CASTING);
                    me->SetFacingTo(0.0f);
                    me->CastSpell((Unit*)nullptr, SPELL_QUAKE, false);
                    me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                    Talk(SAY_LK_QUAKE);
                    break;
                case EVENT_QUAKE_2:
                    _phase = PHASE_THREE;
                    events.CancelEventGroup(EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_SOUL_REAPER, 40s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_DEFILE, 38s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_VILE_SPIRITS, 20s, EVENT_GROUP_VILE_SPIRITS);
                    events.ScheduleEvent(IsHeroic() ? EVENT_HARVEST_SOULS : EVENT_HARVEST_SOUL, 14s, EVENT_GROUP_ABILITIES);

                    me->InterruptNonMeleeSpells(false);
                    me->ClearUnitState(UNIT_STATE_CASTING);
                    me->SetFacingTo(0.0f);
                    me->CastSpell((Unit*)nullptr, SPELL_QUAKE, false);
                    me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                    Talk(SAY_LK_QUAKE);
                    break;

                // ABILITIES:
                case EVENT_SUMMON_SHAMBLING_HORROR:
                    me->CastSpell(me, SPELL_SUMMON_SHAMBLING_HORROR, false);
                    me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                    events.ScheduleEvent(EVENT_SUMMON_SHAMBLING_HORROR, 60s, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_SUMMON_DRUDGE_GHOUL:
                    me->CastSpell(me, SPELL_SUMMON_DRUDGE_GHOULS, false);
                    events.ScheduleEvent(EVENT_SUMMON_DRUDGE_GHOUL, 30s, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_INFEST:
                    me->CastSpell(me, SPELL_INFEST, false);
                    events.ScheduleEvent(EVENT_INFEST, 22s + 500ms, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_NECROTIC_PLAGUE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NecroticPlagueTargetCheck(me, NECROTIC_PLAGUE_LK, NECROTIC_PLAGUE_PLR)))
                    {
                        Talk(EMOTE_NECROTIC_PLAGUE_WARNING, target);
                        me->CastSpell(target, SPELL_NECROTIC_PLAGUE, false);
                        events.ScheduleEvent(EVENT_NECROTIC_PLAGUE, 30s, 31s, EVENT_GROUP_ABILITIES);
                    }
                    else
                        events.ScheduleEvent(EVENT_NECROTIC_PLAGUE, 5s, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_SHADOW_TRAP:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, ShadowTrapLKTargetSelector(me, true, true, 100.0f)))
                        me->CastSpell(target, SPELL_SHADOW_TRAP, false);
                    events.ScheduleEvent(EVENT_SHADOW_TRAP, 15s + 500ms, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_PAIN_AND_SUFFERING:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                    {
                        //events.DelayEventsToMax(500, EVENT_GROUP_ABILITIES);
                        me->SetFacingTo(me->GetAngle(target));
                        me->CastSpell(target, SPELL_PAIN_AND_SUFFERING, false);
                    }
                    events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, (IsHeroic() ? urand(1250, 1750) : urand(1750, 2250)), EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_SUMMON_ICE_SPHERE:
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_ICE_SPHERE, false);
                    events.ScheduleEvent(EVENT_SUMMON_ICE_SPHERE, 7500ms, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_SUMMON_RAGING_SPIRIT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                        me->CastSpell(target, SPELL_RAGING_SPIRIT, false);
                    events.ScheduleEvent(EVENT_SUMMON_RAGING_SPIRIT, (!HealthAbovePct(40) ? 15s : 20s), EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_DEFILE:
                    {
                        uint32 evTime = events.GetNextEventTime(EVENT_SUMMON_VALKYR);
                        // if defile (cast time 2sec) is less than 3 before valkyr appears
                        // we've to decide
                        if (evTime && (events.GetTimer() > evTime || evTime - events.GetTimer() < 5000))
                        {
                            // if valkyr is less than 1.5 secs after defile (cast time 2 sec) then we've a sync issue, so
                            // we need to cancel it (break) and schedule a defile to be casted 5 or 4 seconds after valkyr
                            if (events.GetTimer() > evTime || evTime - events.GetTimer() < 3500)
                            {
                                uint32 t = events.GetTimer() > evTime ? 0 : evTime - events.GetTimer();
                                events.ScheduleEvent(EVENT_DEFILE, t + (Is25ManRaid() ? 5000 : 4000), EVENT_GROUP_ABILITIES);
                                break;
                            }

                            // if valkyr is coming between 1.5 and 3 seconds after defile then we've to
                            // delay valkyr just a bit
                            events.RescheduleEvent(EVENT_SUMMON_VALKYR, 5s, EVENT_GROUP_ABILITIES);
                        }

                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, DefileTargetSelector(me)))
                        {
                            Talk(EMOTE_DEFILE_WARNING);
                            me->CastSpell(target, SPELL_DEFILE, false);
                            // defile has a fixed CD (from dbm) that can be variable only
                            // if no target has been found at the moment (schedule after 1 second)
                            events.ScheduleEvent(EVENT_DEFILE, 32s + 500ms, EVENT_GROUP_ABILITIES);
                        }
                        else
                        {
                            // be sure it happen trying each seconds if no target
                            events.ScheduleEvent(EVENT_DEFILE, 1s, EVENT_GROUP_ABILITIES);
                        }
                    }
                    break;
                case EVENT_SOUL_REAPER:
                    if (me->IsWithinMeleeRange(me->GetVictim()))
                    {
                        me->CastSpell(me->GetVictim(), SPELL_SOUL_REAPER, false);
                        events.ScheduleEvent(EVENT_SOUL_REAPER, 30s + 500ms, EVENT_GROUP_ABILITIES);
                    }
                    else
                        events.ScheduleEvent(EVENT_SOUL_REAPER, 1s, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_SUMMON_VALKYR:
                    {
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                        Talk(SAY_LK_SUMMON_VALKYR);
                        me->CastSpell((Unit*)nullptr, SUMMON_VALKYR, false);
                        events.ScheduleEvent(EVENT_SUMMON_VALKYR, 45s, EVENT_GROUP_ABILITIES);

                        // schedule a defile (or reschedule it) if next defile event
                        // doesn't exist ( now > next defile ) or defile is coming too soon
                        uint32 minTime = (Is25ManRaid() ? 5000 : 4000);
                        if (uint32 evTime = events.GetNextEventTime(EVENT_DEFILE))
                            if (events.GetTimer() > evTime || evTime - events.GetTimer() < minTime)
                            {
                                events.RescheduleEvent(EVENT_DEFILE, minTime, EVENT_GROUP_ABILITIES);
                            }
                    }
                    break;
                case EVENT_VILE_SPIRITS:
                    me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                    me->CastSpell((Unit*)nullptr, SPELL_VILE_SPIRITS, false);
                    events.ScheduleEvent(EVENT_VILE_SPIRITS, 30s, EVENT_GROUP_VILE_SPIRITS);
                    break;
                case EVENT_HARVEST_SOUL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, NonTankLKTargetSelector(me, true, true, 55.0f)))
                    {
                        Talk(SAY_LK_HARVEST_SOUL);
                        me->CastSpell(target, SPELL_HARVEST_SOUL, false);
                        events.ScheduleEvent(EVENT_HARVEST_SOUL, 75s, EVENT_GROUP_ABILITIES);
                    }
                    else
                        events.ScheduleEvent(EVENT_HARVEST_SOUL, 10s, EVENT_GROUP_ABILITIES);
                    break;
                case EVENT_HARVEST_SOULS:
                    Talk(SAY_LK_HARVEST_SOUL);
                    me->CastSpell((Unit*)nullptr, SPELL_HARVEST_SOULS, false);
                    _phase = PHASE_FROSTMOURNE;
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    events.ScheduleEvent(EVENT_START_ATTACK, 55s);
                    events.DelayEvents(52500, EVENT_GROUP_VILE_SPIRITS);
                    events.CancelEvent(EVENT_DEFILE);
                    events.CancelEvent(EVENT_SOUL_REAPER);
                    events.ScheduleEvent(EVENT_FROSTMOURNE_HEROIC, 6s, EVENT_GROUP_ABILITIES);
                    events.ScheduleEvent(EVENT_HARVEST_SOULS, 100s, 110s, EVENT_GROUP_ABILITIES);

                    for (SummonList::iterator i = summons.begin(); i != summons.end(); ++i)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                        {
                            if (summon->GetEntry() == NPC_VILE_SPIRIT)
                            {
                                summon->m_Events.KillAllEvents(true);
                                summon->m_Events.AddEvent(new VileSpiritActivateEvent(summon), summon->m_Events.CalculateTime(55000));
                                summon->GetMotionMaster()->Clear(true);
                                summon->StopMoving();
                                summon->SetReactState(REACT_PASSIVE);
                                summon->AttackStop();
                            }
                            else if (summon->GetEntry() == NPC_RAGING_SPIRIT)
                            {
                                summon->GetMotionMaster()->Clear(true);
                                summon->StopMoving();
                                summon->SetReactState(REACT_PASSIVE);
                                summon->AttackStop();
                            }
                        }
                    break;
                case EVENT_FROSTMOURNE_HEROIC:
                    _bFrostmournePhase = true;
                    if (TempSummon* terenas = me->GetMap()->SummonCreature(NPC_TERENAS_MENETHIL_FROSTMOURNE_H, TerenasSpawnHeroic, nullptr, 55000))
                    {
                        terenas->AI()->DoAction(ACTION_FROSTMOURNE_INTRO);
                        if (Creature* spawner = terenas->FindNearestCreature(NPC_WORLD_TRIGGER_INFINITE_AOI, 100.0f, true))
                        {
                            spawner->CastSpell(spawner, SPELL_SUMMON_SPIRIT_BOMB_1, true);  // summons bombs randomly
                            spawner->CastSpell(spawner, SPELL_SUMMON_SPIRIT_BOMB_2, true);  // summons bombs on players
                            spawner->m_Events.AddEvent(new TriggerWickedSpirit(spawner), spawner->m_Events.CalculateTime(3000));
                            terenas->SetImmuneToAll(true); // to avoid being healed by player trinket procs. terenas' health doesn't matter on heroic
                        }
                    }
                    break;

                default:
                    break;
            }

            if (!me->HasReactState(REACT_PASSIVE) && me->GetVictim() && me->IsWithinMeleeRange(me->GetVictim()) && me->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE && !me->IsWithinLOSInMap(me->GetVictim()))
                me->GetMotionMaster()->MoveCharge(me->GetVictim()->GetPositionX(), me->GetVictim()->GetPositionY(), me->GetVictim()->GetPositionZ(), me->GetSpeed(MOVE_RUN), POINT_NONE);

            DoMeleeAttackIfReady();
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_PLAGUE_STACK:
                    return _necroticPlagueStack;
                case DATA_VILE:
                    return _vileSpiritExplosions;
                default:
                    break;
            }

            return 0;
        }

        void SetData(uint32 type, uint32 value) override
        {
            switch (type)
            {
                case DATA_PLAGUE_STACK:
                    _necroticPlagueStack = std::max(value, _necroticPlagueStack);
                    break;
                case DATA_VILE:
                    _vileSpiritExplosions += value;
                    break;
                default:
                    break;
            }
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            EntryCheckPredicate pred(NPC_STRANGULATE_VEHICLE);
            summons.DoAction(ACTION_TELEPORT_BACK, pred);
            instance->SetBossState(DATA_THE_LICH_KING, FAIL);
            me->CastSpell((Unit*)nullptr, SPELL_KILL_FROSTMOURNE_PLAYERS, true);
            BossAI::EnterEvadeMode(why);
            me->SetReactState(REACT_AGGRESSIVE);

            if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetGuidData(DATA_HIGHLORD_TIRION_FORDRING)))
                tirion->DespawnOrUnsummon();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<boss_the_lich_kingAI>(creature);
    }
};

class npc_tirion_fordring_tft : public CreatureScript
{
public:
    npc_tirion_fordring_tft() : CreatureScript("npc_tirion_fordring_tft") { }

    struct npc_tirion_fordringAI : public ScriptedAI
    {
        npc_tirion_fordringAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

        void Reset() override
        {
            _events.Reset();
            if (_instance->GetBossState(DATA_THE_LICH_KING) == DONE || (me->GetMap()->IsHeroic() && !_instance->GetData(DATA_LK_HC_AVAILABLE)))
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetReactState(REACT_PASSIVE);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            switch (id)
            {
                case POINT_TIRION_INTRO:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        if (!theLichKing->IsAlive() || !theLichKing->IsVisible())
                            break;
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                        theLichKing->SetStandState(UNIT_STAND_STATE_STAND);
                        theLichKing->SetSheath(SHEATH_STATE_MELEE);
                        theLichKing->RemoveAurasDueToSpell(SPELL_EMOTE_SIT_NO_SHEATH);
                        theLichKing->AI()->Talk(SAY_LK_INTRO_1);
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_FROZEN_THRONE);
                        _events.ScheduleEvent(EVENT_INTRO_LK_MOVE, 3s);
                    }
                    break;
                case POINT_TIRION_OUTRO:
                    _events.ScheduleEvent(EVENT_OUTRO_FORDRING_JUMP, 1ms);
                    break;
            }
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_OUTRO:
                    _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_1, 2600ms);
                    _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_TALK, 6600ms);
                    _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_TALK, 17s + 600ms);
                    _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_2, 30s);
                    _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_3, 39s);
                    _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_CAST_SHOUT, 50s);
                    _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_TALK, 54s);
                    _events.ScheduleEvent(EVENT_OUTRO_LK_MOVE_CENTER, 65s);
                    break;
                case ACTION_BREAK_FROSTMOURNE:
                    _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_6, 2500ms);
                    _events.ScheduleEvent(EVENT_OUTRO_SOUL_BARRAGE, 6500ms);
                    break;
            }
        }

        void SpellHit(Unit* /*caster*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_ICE_LOCK)
            {
                me->StopMoving();
                me->GetMotionMaster()->Clear(true);
                me->SetFacingTo(3.085098f);
            }
            else if (spell->Id == SPELL_BROKEN_FROSTMOURNE_KNOCK)
            {
                // remove glow on ashbringer and tirion
                me->RemoveAllAuras();
                SetEquipmentSlots(false, EQUIP_ASHBRINGER);
            }
        }

        void JustReachedHome() override
        {
            ScriptedAI::JustReachedHome();
            if (!(_instance->GetBossState(DATA_THE_LICH_KING) == DONE || (me->GetMap()->IsHeroic() && !_instance->GetData(DATA_LK_HC_AVAILABLE))))
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
        }

        void sGossipSelect(Player* /*player*/, uint32 sender, uint32 action) override
        {
            Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING));
            if (me->GetCreatureTemplate()->GossipMenuId == sender && !action && me->HasNpcFlag(UNIT_NPC_FLAG_GOSSIP) && theLichKing && !theLichKing->IsInEvadeMode())
            {
                if (me->GetMap()->IsHeroic() && !_instance->GetData(DATA_LK_HC_AVAILABLE))
                    return;
                me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                me->SetWalk(true);
                me->GetMotionMaster()->MovePoint(POINT_TIRION_INTRO, TirionIntro);
            }
        }

        /*bool CanBeSeen(Player const* p)
        {
            return me->GetExactDistSq(p) < 200.0f*200.0f;
        }*/

        void UpdateAI(uint32 diff) override
        {
            UpdateVictim();

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_INTRO_LK_MOVE:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        Movement::PointsArray path;
                        path.push_back(G3D::Vector3(theLichKing->GetPositionX(), theLichKing->GetPositionY(), theLichKing->GetPositionZ()));
                        for (uint8 i = 0; i < 3; ++i)
                            path.push_back(G3D::Vector3(LichKingIntro[i].GetPositionX(), LichKingIntro[i].GetPositionY(), LichKingIntro[i].GetPositionZ()));
                        theLichKing->SetWalk(true);
                        theLichKing->GetMotionMaster()->MoveSplinePath(&path);
                        _events.ScheduleEvent(EVENT_INTRO_FORDRING_TALK_1, 11s);
                    }
                    break;
                case EVENT_INTRO_LK_TALK_1:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->AI()->Talk(SAY_LK_INTRO_2);
                        theLichKing->HandleEmoteCommand(EMOTE_ONESHOT_TALK_NO_SHEATHE);
                        _events.ScheduleEvent(EVENT_INTRO_LK_EMOTE_CAST_SHOUT, 7s);
                        _events.ScheduleEvent(EVENT_INTRO_LK_EMOTE_1, 13s);
                        _events.ScheduleEvent(EVENT_INTRO_LK_EMOTE_CAST_SHOUT, 18s);
                        _events.ScheduleEvent(EVENT_INTRO_LK_CAST_FREEZE, 31s);
                    }
                    break;
                case EVENT_INTRO_LK_EMOTE_CAST_SHOUT:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        theLichKing->CastSpell(theLichKing, SPELL_EMOTE_SHOUT_NO_SHEATH, false);
                    break;
                case EVENT_INTRO_LK_EMOTE_1:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        theLichKing->HandleEmoteCommand(EMOTE_ONESHOT_POINT_NO_SHEATHE);
                    break;
                case EVENT_INTRO_LK_CAST_FREEZE:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->AI()->Talk(SAY_LK_INTRO_3);
                        theLichKing->CastSpell((Unit*)nullptr, SPELL_ICE_LOCK, false);
                        _events.ScheduleEvent(EVENT_INTRO_FINISH, 1s);
                    }
                    break;
                case EVENT_INTRO_FORDRING_TALK_1:
                    {
                        Talk(SAY_TIRION_INTRO_1);
                        _events.ScheduleEvent(EVENT_INTRO_LK_TALK_1, 9s);
                        _events.ScheduleEvent(EVENT_INTRO_FORDRING_TALK_2, 34s);
                    }
                    break;
                case EVENT_INTRO_FORDRING_TALK_2:
                    {
                        Talk(SAY_TIRION_INTRO_2);
                        _events.ScheduleEvent(EVENT_INTRO_FORDRING_EMOTE_1, 2s);
                        _events.ScheduleEvent(EVENT_INTRO_FORDRING_CHARGE, 5s);
                    }
                    break;
                case EVENT_INTRO_FORDRING_EMOTE_1:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_POINT_NO_SHEATHE);
                    break;
                case EVENT_INTRO_FORDRING_CHARGE:
                    me->SetWalk(false);
                    me->GetMotionMaster()->MovePoint(0, TirionCharge);
                    break;
                case EVENT_INTRO_FINISH:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->SetWalk(false);
                        theLichKing->SetImmuneToPC(false);
                        theLichKing->SetReactState(REACT_AGGRESSIVE);
                        theLichKing->SetInCombatWithZone();
                        if (!theLichKing->IsInCombat())
                            theLichKing->AI()->EnterEvadeMode();
                    }
                    break;

                case EVENT_OUTRO_LK_TALK_1:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_1);
                        theLichKing->CastSpell((Unit*)nullptr, SPELL_FURY_OF_FROSTMOURNE_NO_REZ, true);
                        Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                            if (Player* p = itr->GetSource())
                                if (p->IsAlive())
                                    Unit::Kill(me, p);
                    }
                    break;
                case EVENT_OUTRO_LK_TALK_2:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_2);
                        theLichKing->CastSpell((Unit*)nullptr, SPELL_EMOTE_QUESTION_NO_SHEATH, false);
                    }
                    break;
                case EVENT_OUTRO_LK_EMOTE_TALK:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        theLichKing->HandleEmoteCommand(EMOTE_ONESHOT_TALK_NO_SHEATHE);
                    break;
                case EVENT_OUTRO_LK_TALK_3:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->SetFacingToObject(me);
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_3);
                    }
                    break;
                case EVENT_OUTRO_LK_MOVE_CENTER:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->GetMotionMaster()->MovePoint(0, CenterPosition);
                        uint32 travelTime = 1000 * theLichKing->GetExactDist(&CenterPosition) / theLichKing->GetSpeed(MOVE_WALK) + 1000;

                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_4, 1 + travelTime);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_RAISE_DEAD, 1000 + travelTime);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_5, 29000 + travelTime);
                    }
                    break;
                case EVENT_OUTRO_LK_TALK_4:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->SetFacingTo(0.01745329f);
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_4);
                    }
                    break;
                case EVENT_OUTRO_LK_RAISE_DEAD:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->CastSpell((Unit*)nullptr, SPELL_RAISE_DEAD, false);
                        theLichKing->ClearUnitState(UNIT_STATE_CASTING);
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_FINAL);
                    }
                    break;
                case EVENT_OUTRO_LK_TALK_5:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_5);
                        _events.ScheduleEvent(EVENT_OUTRO_FORDRING_TALK_1, 7s);
                        _events.ScheduleEvent(EVENT_OUTRO_FORDRING_BLESS, 18s);
                        _events.ScheduleEvent(EVENT_OUTRO_FORDRING_REMOVE_ICE, 23s);
                        _events.ScheduleEvent(EVENT_OUTRO_FORDRING_MOVE_1, 25s);
                    }
                    break;
                case EVENT_OUTRO_LK_TALK_6:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_6);
                        me->SetFacingToObject(theLichKing);
                        theLichKing->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, EQUIP_UNEQUIP);
                        theLichKing->CastSpell((Unit*)nullptr, SPELL_SUMMON_BROKEN_FROSTMOURNE_3, true);
                        me->GetMap()->SetZoneOverrideLight(AREA_THE_FROZEN_THRONE, LIGHT_SOULSTORM, 10s);
                        me->GetMap()->SetZoneWeather(AREA_THE_FROZEN_THRONE, WEATHER_STATE_BLACKSNOW, 0.5f);

                        _events.ScheduleEvent(EVENT_OUTRO_AFTER_SUMMON_BROKEN_FROSTMOURNE, 1s);
                        _events.ScheduleEvent(EVENT_OUTRO_KNOCK_BACK, 3s);
                        break;
                    }
                    break;
                case EVENT_OUTRO_AFTER_SUMMON_BROKEN_FROSTMOURNE:
                    if (Creature* frostmourne = me->FindNearestCreature(NPC_FROSTMOURNE_TRIGGER, 50.0f))
                        frostmourne->CastSpell((Unit*)nullptr, SPELL_BROKEN_FROSTMOURNE, true);
                    break;
                case EVENT_OUTRO_KNOCK_BACK:
                    if (Creature* frostmourne = me->FindNearestCreature(NPC_FROSTMOURNE_TRIGGER, 50.0f))
                        frostmourne->CastSpell((Unit*)nullptr, SPELL_BROKEN_FROSTMOURNE_KNOCK, false);
                    break;
                case EVENT_OUTRO_SOUL_BARRAGE:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        theLichKing->CastSpell((Unit*)nullptr, SPELL_SOUL_BARRAGE, TRIGGERED_IGNORE_CAST_IN_PROGRESS);
                        sCreatureTextMgr->SendSound(theLichKing, SOUND_PAIN, CHAT_MSG_MONSTER_YELL, 0, TEXT_RANGE_NORMAL, TEAM_NEUTRAL, false);
                        theLichKing->SetDisableGravity(true);
                        theLichKing->GetMotionMaster()->MovePoint(0, OutroFlying);

                        _events.ScheduleEvent(EVENT_OUTRO_AFTER_SOUL_BARRAGE, 3s);
                    }
                    break;
                case EVENT_OUTRO_AFTER_SOUL_BARRAGE:
                    Talk(SAY_TIRION_OUTRO_2);
                    _events.ScheduleEvent(EVENT_OUTRO_SUMMON_TERENAS, 6s);
                    break;
                case EVENT_OUTRO_SUMMON_TERENAS:
                    if (Creature* frostmourne = me->FindNearestCreature(NPC_FROSTMOURNE_TRIGGER, 50.0f))
                    {
                        frostmourne->CastSpell((Unit*)nullptr, SPELL_SUMMON_TERENAS, false);
                        if (Creature* terenas = me->FindNearestCreature(NPC_TERENAS_MENETHIL_OUTRO, 50.0f))
                            terenas->SetFacingToObject(frostmourne);
                    }
                    _events.ScheduleEvent(EVENT_OUTRO_TERENAS_TALK_1, 2s);
                    _events.ScheduleEvent(EVENT_OUTRO_TERENAS_TALK_2, 14s);
                    break;
                case EVENT_OUTRO_TERENAS_TALK_1:
                    if (Creature* terenas = me->FindNearestCreature(NPC_TERENAS_MENETHIL_OUTRO, 50.0f))
                        terenas->AI()->Talk(SAY_TERENAS_OUTRO_1);
                    break;
                case EVENT_OUTRO_TERENAS_TALK_2:
                    if (Creature* terenas = me->FindNearestCreature(NPC_TERENAS_MENETHIL_OUTRO, 50.0f))
                    {
                        terenas->AI()->Talk(SAY_TERENAS_OUTRO_2);
                        terenas->CastSpell((Unit*)nullptr, SPELL_MASS_RESURRECTION, false);
                        if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        {
                            lichKing->SetImmuneToNPC(false);
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                            me->RemoveAllAuras();
                            SetEquipmentSlots(false, EQUIP_ASHBRINGER);
                            me->Attack(lichKing, true);
                            me->GetMotionMaster()->MovePoint(0, 512.16f, -2120.25f, 840.86f);
                        }
                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_7, 7s);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_8, 17s);
                    }
                    break;
                case EVENT_OUTRO_LK_TALK_7:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_7);
                    break;
                case EVENT_OUTRO_LK_TALK_8:
                    if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        theLichKing->AI()->Talk(SAY_LK_OUTRO_8);
                    break;
                case EVENT_OUTRO_FORDRING_TALK_1:
                    Talk(SAY_TIRION_OUTRO_1);
                    break;
                case EVENT_OUTRO_FORDRING_BLESS:
                    me->CastSpell(me, SPELL_LIGHTS_BLESSING, false);
                    break;
                case EVENT_OUTRO_FORDRING_REMOVE_ICE:
                    me->RemoveAurasDueToSpell(SPELL_ICE_LOCK);
                    SetEquipmentSlots(false, EQUIP_ASHBRINGER_GLOWING);
                    if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                    {
                        me->SetFacingToObject(lichKing);
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_FINAL);
                    }
                    break;
                case EVENT_OUTRO_FORDRING_MOVE_1:
                    me->GetMotionMaster()->MovePoint(POINT_TIRION_OUTRO, OutroPosition1);
                    break;
                case EVENT_OUTRO_FORDRING_JUMP:
                    me->CastSpell((Unit*)nullptr, SPELL_JUMP, false);
                    break;

                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!me->IsAlive())
                return;

            if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                if (theLichKing->IsInEvadeMode())
                {
                    ScriptedAI::EnterEvadeMode(why);
                    return;
                }

            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(false);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetEntry() == NPC_THE_LICH_KING;
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_tirion_fordringAI>(creature);
    }
};

class spell_the_lich_king_quake : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_quake);

    bool Load() override
    {
        return GetCaster()->GetInstanceScript() != nullptr;
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (GameObject* platform = ObjectAccessor::GetGameObject(*GetCaster(), GetCaster()->GetInstanceScript()->GetGuidData(DATA_ARTHAS_PLATFORM)))
            targets.remove_if(HeightDifferenceCheck(platform, 5.0f, false));
    }

    void HandleSendEvent(SpellEffIndex /*effIndex*/)
    {
        if (GetCaster()->IsAIEnabled)
            GetCaster()->GetAI()->DoAction(ACTION_START_ATTACK);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_quake::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHit += SpellEffectFn(spell_the_lich_king_quake::HandleSendEvent, EFFECT_1, SPELL_EFFECT_SEND_EVENT);
    }
};

class spell_the_lich_king_jump : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_jump);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_RAISE_DEAD, SPELL_JUMP_2 });
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetHitUnit()->RemoveAurasDueToSpell(SPELL_RAISE_DEAD);
        GetHitUnit()->InterruptNonMeleeSpells(true);
        GetHitUnit()->CastSpell((Unit*)nullptr, SPELL_JUMP_2, true);
        if (Creature* creature = GetHitCreature())
            creature->AI()->DoAction(ACTION_BREAK_FROSTMOURNE);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_jump::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_the_lich_king_jump_remove_aura : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_jump_remove_aura);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetHitUnit()->RemoveAurasDueToSpell(uint32(GetEffectValue()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_jump_remove_aura::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_the_lich_king_play_movie : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_play_movie);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        if (!sMovieStore.LookupEntry(MOVIE_FALL_OF_THE_LICH_KING))
            return false;
        return true;
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Player* player = GetHitPlayer())
            player->SendMovieStart(MOVIE_FALL_OF_THE_LICH_KING);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_play_movie::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*** FIGHT STUFF BELOW ***/

class npc_shambling_horror_icc : public CreatureScript
{
public:
    npc_shambling_horror_icc() :  CreatureScript("npc_shambling_horror_icc") { }

    struct npc_shambling_horror_iccAI : public ScriptedAI
    {
        npc_shambling_horror_iccAI(Creature* creature) : ScriptedAI(creature)
        {
            _frenzied = false;
        }

        EventMap _events;
        bool _frenzied;

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_SHOCKWAVE, 20s, 25s);
            _events.ScheduleEvent(EVENT_ENRAGE, 11s, 14s);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!_frenzied && IsHeroic() && me->HealthBelowPctDamaged(20, damage))
            {
                _frenzied = true;
                me->CastSpell(me, SPELL_FRENZY, true);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_SHOCKWAVE:
                    me->CastSpell(me->GetVictim(), SPELL_SHOCKWAVE, false);
                    _events.ScheduleEvent(EVENT_SHOCKWAVE, 20s, 25s);
                    break;
                case EVENT_ENRAGE:
                    me->CastSpell(me, SPELL_ENRAGE, false);
                    _events.ScheduleEvent(EVENT_ENRAGE, 20s, 25s);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return IsValidPlatformTarget(target) && !target->GetVehicle();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_shambling_horror_iccAI>(creature);
    }
};

class spell_the_lich_king_infest_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_infest_aura);

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (GetUnitOwner()->HealthAbovePct(90))
        {
            PreventDefaultAction();
            Remove(AURA_REMOVE_BY_ENEMY_SPELL);
        }
    }

    void OnUpdate(AuraEffect* aurEff)
    {
        // multiply, starting from 2nd tick
        if (aurEff->GetTickNumber() == 1)
            return;

        aurEff->SetAmount(int32(aurEff->GetAmount() * 1.15f));
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_infest_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_the_lich_king_infest_aura::OnUpdate, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_the_lich_king_necrotic_plague_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_necrotic_plague_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_NECROTIC_PLAGUE_JUMP });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        bool dispel = false;
        switch (GetTargetApplication()->GetRemoveMode())
        {
            case AURA_REMOVE_BY_ENEMY_SPELL:
                dispel = true;
            case AURA_REMOVE_BY_EXPIRE:
            case AURA_REMOVE_BY_DEATH:
                break;
            default:
                return;
        }

        CustomSpellValues values;
        if (dispel)
            values.AddSpellMod(SPELLVALUE_BASE_POINT1, AURA_REMOVE_BY_ENEMY_SPELL); // add as marker (spell has no effect 1)
        GetTarget()->CastCustomSpell(SPELL_NECROTIC_PLAGUE_JUMP, values, nullptr, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());

        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, SPELL_PLAGUE_SIPHON, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_necrotic_plague_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_the_lich_king_necrotic_plague_jump : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_necrotic_plague_jump);

    bool Load() override
    {
        _hadJumpingAura = false;
        _hadInitialAura = false;
        return true;
    }

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.sort(Acore::ObjectDistanceOrderPred(GetCaster()));
        if (targets.size() <= 1)
            return;

        targets.resize(1);
    }

    void CheckAura(SpellMissInfo missInfo)
    {
        if (missInfo != SPELL_MISS_NONE)
        {
            return;
        }

        if (GetHitUnit()->HasAura(GetSpellInfo()->Id))
            _hadJumpingAura = true;
        else if (uint32 spellId = sSpellMgr->GetSpellIdForDifficulty(SPELL_NECROTIC_PLAGUE, GetHitUnit()))
            if (GetHitUnit()->HasAura(spellId))
                _hadInitialAura = true;
    }

    void AddMissingStack()
    {
        if (GetHitAura() && !_hadJumpingAura)
        {
            uint32 spellId = sSpellMgr->GetSpellIdForDifficulty(SPELL_NECROTIC_PLAGUE, GetHitUnit());
            if (GetSpellValue()->EffectBasePoints[EFFECT_1] != AURA_REMOVE_BY_ENEMY_SPELL || _hadInitialAura)
                GetHitAura()->ModStackAmount(1);
            if (_hadInitialAura)
                if (Aura* a = GetHitUnit()->GetAura(spellId))
                    a->Remove(AURA_REMOVE_BY_DEFAULT);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_necrotic_plague_jump::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        BeforeHit += BeforeSpellHitFn(spell_the_lich_king_necrotic_plague_jump::CheckAura);
        OnHit += SpellHitFn(spell_the_lich_king_necrotic_plague_jump::AddMissingStack);
    }

private:
    bool _hadJumpingAura;
    bool _hadInitialAura;
};

class spell_the_lich_king_necrotic_plague_jump_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_necrotic_plague_jump_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_NECROTIC_PLAGUE_JUMP, SPELL_PLAGUE_SIPHON });
    }

    bool Load() override
    {
        _lastAmount = 0;
        return true;
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            if (caster->GetAI())
                caster->GetAI()->SetData(DATA_PLAGUE_STACK, GetStackAmount());
    }

    void OnRemove(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        _lastAmount = aurEff->GetAmount();
        switch (GetTargetApplication()->GetRemoveMode())
        {
            case AURA_REMOVE_BY_EXPIRE:
            case AURA_REMOVE_BY_DEATH:
                break;
            default:
                return;
        }

        CustomSpellValues values;
        values.AddSpellMod(SPELLVALUE_AURA_STACK, GetStackAmount());
        GetTarget()->CastCustomSpell(SPELL_NECROTIC_PLAGUE_JUMP, values, nullptr, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, SPELL_PLAGUE_SIPHON, true);
    }

    void OnDispel(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        _lastAmount = aurEff->GetAmount();
    }

    void AfterDispel(AuraEffect const* aurEff, AuraEffectHandleModes /*mode*/)
    {
        // this means the stack increased so don't process as if dispelled
        if (aurEff->GetAmount() > _lastAmount)
            return;

        CustomSpellValues values;
        values.AddSpellMod(SPELLVALUE_AURA_STACK, GetStackAmount());
        values.AddSpellMod(SPELLVALUE_BASE_POINT1, AURA_REMOVE_BY_ENEMY_SPELL); // add as marker (spell has no effect 1)
        GetTarget()->CastCustomSpell(SPELL_NECROTIC_PLAGUE_JUMP, values, nullptr, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, SPELL_PLAGUE_SIPHON, true);

        Remove(AURA_REMOVE_BY_ENEMY_SPELL);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_the_lich_king_necrotic_plague_jump_aura::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
        AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_necrotic_plague_jump_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_necrotic_plague_jump_aura::OnDispel, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAPPLY);
        AfterEffectApply += AuraEffectApplyFn(spell_the_lich_king_necrotic_plague_jump_aura::AfterDispel, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAPPLY);
    }

private:
    int32 _lastAmount;
};

class spell_the_lich_king_shadow_trap_visual_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_shadow_trap_visual_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOW_TRAP_AURA });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
            GetTarget()->CastSpell(GetTarget(), SPELL_SHADOW_TRAP_AURA, TRIGGERED_NONE);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_shadow_trap_visual_aura::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_the_lich_king_shadow_trap_periodic : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_shadow_trap_periodic);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOW_TRAP_KNOCKBACK });
    }

    void CheckTargetCount(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        GetCaster()->CastSpell((Unit*)nullptr, SPELL_SHADOW_TRAP_KNOCKBACK, true);
        if (Aura* a = GetCaster()->GetAura(SPELL_SHADOW_TRAP_AURA))
            a->SetDuration(0);
        if (GetCaster()->GetTypeId() == TYPEID_UNIT)
            GetCaster()->ToCreature()->DespawnOrUnsummon(3000);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_shadow_trap_periodic::CheckTargetCount, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_the_lich_king_ice_burst_target_search : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_ice_burst_target_search);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_ICE_BURST });
    }

    void CheckTargetCount(std::list<WorldObject*>& unitList)
    {
        if (unitList.empty())
            return;

        if (GetCaster()->GetTypeId() == TYPEID_UNIT)
            GetCaster()->ToCreature()->AI()->DoAction(-1);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_ice_burst_target_search::CheckTargetCount, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class npc_icc_ice_sphere : public CreatureScript
{
public:
    npc_icc_ice_sphere() : CreatureScript("npc_icc_ice_sphere") { }

    struct npc_icc_ice_sphereAI : public ScriptedAI
    {
        npc_icc_ice_sphereAI(Creature* creature) : ScriptedAI(creature)
        {
            targetGUID.Clear();
            timer = 250;
            me->SetReactState(REACT_PASSIVE);
        }

        ObjectGuid targetGUID;
        uint16 timer;

        void DoAction(int32 a) override
        {
            if (a == -1)
            {
                me->RemoveAllAuras();
                me->CastSpell(me, SPELL_ICE_BURST, true);
                me->DespawnOrUnsummon(1000);
                targetGUID.Clear();
                timer = 9999;
                me->InterruptNonMeleeSpells(true);
                me->AttackStop();
                me->GetMotionMaster()->Clear();
                me->StopMoving();
            }
        }

        void SelectNewTarget()
        {
            if (!me->HasAura(SPELL_ICE_SPHERE))
                me->CastSpell(me, SPELL_ICE_SPHERE, true);
            targetGUID.Clear();
            me->InterruptNonMeleeSpells(true);
            me->AttackStop();
            me->GetMotionMaster()->Clear();
            me->StopMoving();
            if (Player* p = ScriptedAI::SelectTargetFromPlayerList(120.0f, SPELL_ICE_PULSE, false))
            {
                targetGUID = p->GetGUID();
                me->CastSpell(p, SPELL_ICE_PULSE, false);
                me->ClearUnitState(UNIT_STATE_CASTING);
                me->Attack(p, true);
                me->GetMotionMaster()->MoveFollow(p, 0.01f, 0.0f);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (timer > diff)
            {
                timer -= diff;
                return;
            }
            timer = 1000;

            if (!targetGUID || !me->GetVictim() || !me->IsNonMeleeSpellCast(false, false, true, false, true))
                SelectNewTarget();
            else
            {
                Unit* target = ObjectAccessor::GetUnit(*me, targetGUID);
                if (me->GetVictim()->GetGUID() != targetGUID || !target || !me->IsValidAttackTarget(target) || target->HasUnitFlag2(UNIT_FLAG2_FEIGN_DEATH) || target->GetExactDist2dSq(&CenterPosition) > 75.0f * 75.0f || target->GetPositionZ() < 830.0f || target->GetPositionZ() > 855.0f)
                    SelectNewTarget();
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_icc_ice_sphereAI>(creature);
    }
};

class spell_the_lich_king_raging_spirit : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_raging_spirit);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, uint32(GetEffectValue()), true, 0, 0, target->GetGUID());
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_raging_spirit::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class npc_raging_spirit : public CreatureScript
{
public:
    npc_raging_spirit() : CreatureScript("npc_raging_spirit") { }

    struct npc_raging_spiritAI : public ScriptedAI
    {
        npc_raging_spiritAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript())
        {
            me->SetControlled(true, UNIT_STATE_ROOT);
        }

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_RAGING_SPIRIT_UNROOT, 3s);
            _events.ScheduleEvent(EVENT_SOUL_SHRIEK, 12s, 15s);

            bool valid = false;
            me->CastSpell(me, SPELL_RAGING_SPIRIT_VISUAL, true);
            if (TempSummon* summon = me->ToTempSummon())
                if (Unit* summoner = summon->GetSummonerUnit())
                    if (summoner->IsPlayer() && summoner->IsAlive() && !summoner->ToPlayer()->IsBeingTeleported() && summoner->FindMap() == me->GetMap())
                    {
                        valid = true;
                        summoner->CastSpell(me, SPELL_RAGING_SPIRIT_VISUAL_CLONE, true);
                    }
            if (!valid)
            {
                if (Player* plr = ScriptedAI::SelectTargetFromPlayerList(100.0f, 0, true))
                    plr->CastSpell(me, SPELL_RAGING_SPIRIT_VISUAL_CLONE, true);
                else
                    me->DespawnOrUnsummon(1);
            }
        }

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            // player is the spellcaster so register summon manually
            if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                lichKing->AI()->JustSummoned(me);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                lichKing->AI()->SummonedCreatureDespawn(me);
            if (TempSummon* summon = me->ToTempSummon())
            {
                summon->SetTimer(5000);
                summon->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN);
            }
        }

        void AttackStart(Unit* who) override
        {
            if (!me->HasUnitState(UNIT_STATE_ROOT))
                ScriptedAI::AttackStart(who);
        }

        void UpdateAI(uint32 diff) override
        {
            UpdateVictim();

            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_RAGING_SPIRIT_UNROOT:
                    {
                        me->SetControlled(false, UNIT_STATE_ROOT);

                        if (!me->GetThreatMgr().isThreatListEmpty())
                            if (Unit* target = me->SelectVictim())
                                AttackStart(target);
                        if (!me->GetVictim())
                        {
                            bool valid = false;
                            if (TempSummon* summon = me->ToTempSummon())
                                if (Unit* summoner = summon->GetSummonerUnit())
                                    if (summoner->IsPlayer() && summoner->IsAlive() && !summoner->ToPlayer()->IsBeingTeleported() && summoner->FindMap() == me->GetMap())
                                    {
                                        valid = true;
                                        AttackStart(summoner);
                                    }
                            if (!valid)
                                if (Player* plr = ScriptedAI::SelectTargetFromPlayerList(100.0f, 0, true))
                                    AttackStart(plr);
                        }
                        DoZoneInCombat(nullptr, 150.0f);
                    }
                    break;
                case EVENT_SOUL_SHRIEK:
                    if (!me->HasReactState(REACT_PASSIVE))
                        me->CastSpell(me->GetVictim(), SPELL_SOUL_SHRIEK, false);
                    _events.ScheduleEvent(EVENT_SOUL_SHRIEK, 12s, 15s);
                    break;
                default:
                    break;
            }

            if (!me->HasUnitState(UNIT_STATE_ROOT))
                DoMeleeAttackIfReady();
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return IsValidPlatformTarget(target) && !target->GetVehicle();
        }

    private:
        EventMap _events;
        InstanceScript* _instance;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_raging_spiritAI>(creature);
    }
};

class VehicleCheck
{
public:
    bool operator()(WorldObject* unit)
    {
        return (unit->GetTypeId() != TYPEID_UNIT && unit->GetTypeId() != TYPEID_PLAYER) || unit->ToUnit()->GetVehicle();
    }
};

class spell_the_lich_king_defile : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_defile);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DEFILE_GROW });
    }

    void CorrectRange(std::list<WorldObject*>& targets)
    {
        targets.remove_if(VehicleCheck());
        targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 10.0f * GetCaster()->GetFloatValue(OBJECT_FIELD_SCALE_X), true));
        uint32 strangulatedAura[4] = {68980, 74325, 74296, 74297};
        targets.remove_if(Acore::UnitAuraCheck(true, strangulatedAura[GetCaster()->GetMap()->GetDifficulty()]));
    }

    void ChangeDamageAndGrow()
    {
        SetHitDamage(int32(GetHitDamage() * GetCaster()->GetFloatValue(OBJECT_FIELD_SCALE_X)));
        // HACK: target player should cast this spell on defile
        // however with current aura handling auras cast by different units
        // cannot stack on the same aura object increasing the stack count
        GetCaster()->CastSpell(GetCaster(), SPELL_DEFILE_GROW, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_defile::CorrectRange, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_defile::CorrectRange, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        OnHit += SpellHitFn(spell_the_lich_king_defile::ChangeDamageAndGrow);
    }
};

class spell_the_lich_king_soul_reaper_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_soul_reaper_aura);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_SOUL_REAPER_BUFF });
    }

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
            GetTarget()->CastSpell(caster, SPELL_SOUL_REAPER_BUFF, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_soul_reaper_aura::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class npc_valkyr_shadowguard : public CreatureScript
{
public:
    npc_valkyr_shadowguard() : CreatureScript("npc_valkyr_shadowguard") { }

    struct npc_valkyr_shadowguardAI : public NullCreatureAI
    {
        npc_valkyr_shadowguardAI(Creature* creature) : NullCreatureAI(creature), didbelow50pct(false), dropped(false), _instance(creature->GetInstanceScript())
        {
            me->SetReactState(REACT_PASSIVE);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
            _events.Reset();
            _events.ScheduleEvent(EVENT_GRAB_PLAYER, 2500ms);
            me->SetWalk(false);
        }

        EventMap _events;
        Position _destPoint;
        ObjectGuid _grabbedPlayer;
        bool didbelow50pct;
        bool dropped;
        InstanceScript* _instance;

        bool IsHeroic() { return me->GetMap()->IsHeroic(); }

        void GoSiphon()
        {
            didbelow50pct = true;
            me->CastSpell((Unit*)nullptr, SPELL_EJECT_ALL_PASSENGERS, false);
            float dist = rand_norm() * 10.0f + 5.0f;
            float angle = CenterPosition.GetAngle(me);
            _destPoint.Relocate(CenterPosition.GetPositionX() + dist * cos(angle), CenterPosition.GetPositionY() + dist * std::sin(angle), 855.0f + frand(0.0f, 4.0f), 0.0f);
            me->SetHomePosition(_destPoint);
            _events.Reset();
            _events.ScheduleEvent(EVENT_MOVE_TO_SIPHON_POS, 0ms);
        }

        void OnCharmed(bool  /*apply*/) override {}

        void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply) override
        {
            if (apply)
            {
                //pass->ClearUnitState(UNIT_STATE_ONVEHICLE);
                return;
            }
            pass->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE);
            if (didbelow50pct || dropped)
                return;
            if (IsHeroic())
                GoSiphon();
            else
                me->DespawnOrUnsummon(1000);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (IsHeroic() && !didbelow50pct && !dropped && me->HealthBelowPctDamaged(50, damage))
                GoSiphon();
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            switch (id)
            {
                case EVENT_CHARGE:
                    {
                        bool valid = false;
                        if (Player* target = ObjectAccessor::GetPlayer(*me, _grabbedPlayer))
                            if (target->FindMap() == me->GetMap() && target->GetExactDist(me) < 15.0f && !target->GetVehicle())
                                if (GameObject* platform = ObjectAccessor::GetGameObject(*me, _instance->GetGuidData(DATA_ARTHAS_PLATFORM)))
                                {
                                    std::list<Creature*> triggers;
                                    GetCreatureListWithEntryInGrid(triggers, me, NPC_WORLD_TRIGGER, 150.0f);
                                    triggers.remove_if(HeightDifferenceCheck(platform, 5.0f, true));
                                    if (!triggers.empty())
                                    {
                                        valid = true;
                                        triggers.sort(Acore::ObjectDistanceOrderPred(me));

                                        target->GetMotionMaster()->Clear();
                                        target->UpdatePosition(*me, true);
                                        target->StopMovingOnCurrentPos();

                                        me->CastSpell(target, SPELL_VALKYR_CARRY, false);
                                        _destPoint.Relocate(triggers.front());
                                        _events.Reset();
                                        _events.ScheduleEvent(EVENT_MOVE_TO_DROP_POS, 1s);
                                    }
                                }
                        if (!valid)
                        {
                            _events.Reset();
                            _events.ScheduleEvent(EVENT_GRAB_PLAYER, 500ms);
                            _grabbedPlayer.Clear();
                        }
                    }
                    break;
                case POINT_DROP_PLAYER:
                    {
                        if (didbelow50pct || dropped)
                            break;
                        if (me->GetExactDist(&_destPoint) > 1.5f) // movement was interrupted (probably by a stun, start again)
                        {
                            _events.Reset();
                            _events.ScheduleEvent(EVENT_MOVE_TO_DROP_POS, 0ms);
                            break;
                        }
                        dropped = true;
                        _events.Reset();
                        /*Player* p = nullptr;
                        if (Vehicle* v = me->GetVehicleKit())
                            if (Unit* passenger = v->GetPassenger(0))
                                p = passenger->ToPlayer();*/
                        me->CastSpell((Unit*)nullptr, SPELL_EJECT_ALL_PASSENGERS, false);

                        if (IsHeroic())
                            GoSiphon();
                        else
                            me->DespawnOrUnsummon(1000);
                    }
                    break;
                case POINT_START_SIPHON:
                    if (me->GetExactDist(&_destPoint) > 1.5f) // movement was interrupted (probably by a stun, start again)
                    {
                        _events.Reset();
                        _events.ScheduleEvent(EVENT_MOVE_TO_SIPHON_POS, 0ms);
                        break;
                    }
                    me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, false);
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, false);
                    _events.ScheduleEvent(EVENT_LIFE_SIPHON, 2s);
                    break;
            }
        }

        void SetGUID(ObjectGuid guid, int32 /* = 0*/) override
        {
            _grabbedPlayer = guid;
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
                return;

            switch (_events.ExecuteEvent())
            {
                case EVENT_GRAB_PLAYER:
                    if (!_grabbedPlayer)
                    {
                        me->CastSpell((Unit*)nullptr, SPELL_VALKYR_TARGET_SEARCH, false);
                        _events.ScheduleEvent(EVENT_GRAB_PLAYER, 2s);
                    }
                    break;
                case EVENT_MOVE_TO_DROP_POS:
                    me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                    me->SetCanFly(false);
                    me->SetDisableGravity(false);
                    me->GetMotionMaster()->MovePoint(POINT_DROP_PLAYER, _destPoint, false);
                    me->SetDisableGravity(true, true);
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    break;
                case EVENT_MOVE_TO_SIPHON_POS:
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE); // just in case if passenger disappears so quickly that EVENT_MOVE_TO_DROP_POS is never executed
                    { int32 bp0 = 80; me->CastCustomSpell(me, 1557, &bp0, nullptr, nullptr, true); }
                    me->SetCanFly(true);
                    me->SetDisableGravity(true);
                    me->SendMovementFlagUpdate();
                    me->GetMotionMaster()->MovePoint(POINT_START_SIPHON, _destPoint);
                    break;
                case EVENT_LIFE_SIPHON:
                    {
                        Unit* target = nullptr;
                        Unit::AuraEffectList const& tauntAuras = me->GetAuraEffectsByType(SPELL_AURA_MOD_TAUNT);
                        if (!tauntAuras.empty())
                            for (Unit::AuraEffectList::const_reverse_iterator itr = tauntAuras.rbegin(); itr != tauntAuras.rend(); ++itr)
                                if (Unit* caster = (*itr)->GetCaster())
                                    if (me->IsValidAttackTarget(caster))
                                    {
                                        target = caster;
                                        break;
                                    }
                        if (!target)
                            if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                                target = lichKing->AI()->SelectTarget(SelectTargetMethod::Random, 0, NonTankLKTargetSelector(lichKing, true, false, 100.0f));
                        if (target)
                            me->CastSpell(target, SPELL_LIFE_SIPHON, false);
                        _events.ScheduleEvent(EVENT_LIFE_SIPHON, 2500ms);
                    }
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_valkyr_shadowguardAI>(creature);
    }
};

class spell_the_lich_king_summon_into_air : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_summon_into_air);

    void ModDestHeight(SpellEffIndex effIndex)
    {
        float addZ;
        switch (GetSpellInfo()->Effects[effIndex].MiscValue)
        {
            case NPC_SPIRIT_BOMB:
                addZ = 30.0f;
                break;
            case NPC_VILE_SPIRIT:
                addZ = 13.0f;
                break;
            default:
                addZ = 15.0f;
                break;
        }
        Position const offset = {0.0f, 0.0f, addZ, 0.0f};
        WorldLocation* dest = const_cast<WorldLocation*>(GetExplTargetDest());
        dest->RelocateOffset(offset);
        GetHitDest()->RelocateOffset(offset);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_the_lich_king_summon_into_air::ModDestHeight, EFFECT_0, SPELL_EFFECT_SUMMON);
    }
};

class spell_the_lich_king_teleport_to_frostmourne_hc : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_teleport_to_frostmourne_hc);

    void ModDest(SpellEffIndex  /*effIndex*/)
    {
        float dist = 2.0f + rand_norm() * 18.0f;
        float angle = rand_norm() * 2 * M_PI;
        Position const offset = {dist * cos(angle), dist * std::sin(angle), 0.0f, 0.0f};
        WorldLocation* dest = const_cast<WorldLocation*>(GetExplTargetDest());
        dest->RelocateOffset(offset);
        GetHitDest()->RelocateOffset(offset);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_the_lich_king_teleport_to_frostmourne_hc::ModDest, EFFECT_1, SPELL_EFFECT_TELEPORT_UNITS);
    }
};

class spell_the_lich_king_valkyr_target_search : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_valkyr_target_search);

    WorldObject* _target;

    bool Load() override
    {
        _target = nullptr;
        return true;
    }

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;
        Creature* caster = GetCaster()->ToCreature();
        if (!caster)
        {
            targets.clear();
            return;
        }
            //npcbot
            targets.remove_if(Acore::ObjectTypeIdCheck(TYPEID_PLAYER, false));
            //end npcbot
        targets.remove_if(Acore::UnitAuraCheck(true, GetSpellInfo()->Id));
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_BOSS_HITTIN_YA_AURA)); // done in dbc, but just to be sure xd
        targets.remove_if(Acore::UnitAuraCheck(true, SPELL_HARVEST_SOUL_VALKYR));
        if (InstanceScript* _instance = caster->GetInstanceScript())
            if (Creature* lichKing = ObjectAccessor::GetCreature(*caster, _instance->GetGuidData(DATA_THE_LICH_KING)))
                if (Spell* s = lichKing->GetCurrentSpell(CURRENT_GENERIC_SPELL))
                    if (s->GetSpellInfo()->Id == SPELL_DEFILE && s->m_targets.GetUnitTarget())
                        targets.remove(s->m_targets.GetUnitTarget());

        if (targets.empty())
            return;

        _target = Acore::Containers::SelectRandomContainerElement(targets);
        targets.clear();
        targets.push_back(_target);
        if (Creature* caster = GetCaster()->ToCreature())
            caster->AI()->SetGUID(_target->GetGUID());
    }

    void ReplaceTarget(std::list<WorldObject*>& targets)
    {
        targets.clear();
        if (_target)
            targets.push_back(_target);
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
        {
            GetCaster()->GetMotionMaster()->MoveCharge(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ() + 4.0f, 42.0f, EVENT_CHARGE);
            GetCaster()->SetDisableGravity(true, true);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_valkyr_target_search::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_valkyr_target_search::ReplaceTarget, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_valkyr_target_search::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_the_lich_king_cast_back_to_caster : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_cast_back_to_caster);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_cast_back_to_caster::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_the_lich_king_life_siphon : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_life_siphon);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo({ SPELL_LIFE_SIPHON_HEAL });
    }

    void TriggerHeal()
    {
        GetHitUnit()->CastCustomSpell(SPELL_LIFE_SIPHON_HEAL, SPELLVALUE_BASE_POINT0, GetHitDamage() * 10, GetCaster(), true);
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_the_lich_king_life_siphon::TriggerHeal);
    }
};

class spell_the_lich_king_vile_spirits_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_vile_spirits_aura);

    bool Load() override
    {
        _is25Man = GetUnitOwner()->GetMap()->Is25ManRaid();
        return true;
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        if (_is25Man || ((aurEff->GetTickNumber() - 1) % 5))
            GetTarget()->CastSpell((Unit*)nullptr, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true, nullptr, aurEff, GetCasterGUID());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_vile_spirits_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }

private:
    bool _is25Man;
};

class spell_the_lich_king_vile_spirits_visual : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_vile_spirits_visual);

    void ModDestHeight(SpellEffIndex /*effIndex*/)
    {
        Position offset = {0.0f, 0.0f, 15.0f, 0.0f};
        const_cast<WorldLocation*>(GetExplTargetDest())->RelocateOffset(offset);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_the_lich_king_vile_spirits_visual::ModDestHeight, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

class spell_the_lich_king_vile_spirit_move_target_search : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_vile_spirit_move_target_search);

    bool Load() override
    {
        _target = nullptr;
        return GetCaster()->GetTypeId() == TYPEID_UNIT;
    }

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        _target = Acore::Containers::SelectRandomContainerElement(targets);
    }

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (GetHitUnit() != _target)
            return;

        GetCaster()->ToCreature()->SetInCombatWithZone();
        GetCaster()->ToCreature()->AI()->AttackStart(GetHitUnit());
        GetCaster()->AddThreat(GetHitUnit(), GetCaster()->GetMaxHealth() * 0.2f);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_vile_spirit_move_target_search::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_vile_spirit_move_target_search::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }

private:
    WorldObject* _target;
};

class spell_the_lich_king_vile_spirit_damage_target_search : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_vile_spirit_damage_target_search);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_VILE_SPIRIT_DAMAGE_SEARCH, SPELL_SPIRIT_BURST });
    }

    void CheckTargetCount(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            return;

        if (TempSummon* summon = GetCaster()->ToTempSummon())
            if (Unit* summoner = summon->GetSummonerUnit())
                summoner->GetAI()->SetData(DATA_VILE, 1);

        if (Creature* c = GetCaster()->ToCreature())
        {
            c->RemoveAurasDueToSpell(SPELL_VILE_SPIRIT_DAMAGE_SEARCH);
            c->GetMotionMaster()->Clear(true);
            c->StopMoving();
            c->CastSpell((Unit*)nullptr, SPELL_SPIRIT_BURST, true);
            c->DespawnOrUnsummon(3000);
            c->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_vile_spirit_damage_target_search::CheckTargetCount, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

class spell_the_lich_king_harvest_soul_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_harvest_soul_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HARVESTED_SOUL_LK_BUFF });
    }

    bool Load() override
    {
        return GetOwner()->GetInstanceScript() != nullptr;
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // m_originalCaster to allow stacking from different casters, meh
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
            GetTarget()->CastSpell((Unit*)nullptr, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, GetTarget()->GetInstanceScript()->GetGuidData(DATA_THE_LICH_KING));
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_harvest_soul_aura::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class npc_strangulate_vehicle : public CreatureScript
{
public:
    npc_strangulate_vehicle() : CreatureScript("npc_strangulate_vehicle") { }

    struct npc_strangulate_vehicleAI : public NullCreatureAI
    {
        npc_strangulate_vehicleAI(Creature* creature) : NullCreatureAI(creature), _instance(creature->GetInstanceScript()) {}

        EventMap _events;
        InstanceScript* _instance;

        void IsSummonedBy(WorldObject* summoner) override
        {
            if (!summoner)
                return;

            if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
            {
                me->SetWalk(false);
                Movement::PointsArray path;
                path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), 843.0f));
                me->GetMotionMaster()->MoveSplinePath(&path);

                ObjectGuid petGUID = summoner->ToUnit()->GetPetGUID();
                summoner->ToUnit()->SetPetGUID(ObjectGuid::Empty);
                summoner->ToUnit()->StopMoving();
                me->CastSpell(summoner->ToUnit(), SPELL_HARVEST_SOUL_VEHICLE, true);
                //summoner->ClearUnitState(UNIT_STATE_ONVEHICLE);
                summoner->ToUnit()->SendMovementFlagUpdate(true);
                summoner->ToUnit()->SetPetGUID(petGUID);
                _events.Reset();
                _events.ScheduleEvent(EVENT_MOVE_TO_LICH_KING, 1s);
                _events.ScheduleEvent(EVENT_TELEPORT, 6250ms);
                _events.ScheduleEvent(EVENT_DESPAWN_SELF, 76s);

                // this will let us easily access all creatures of this entry on heroic mode when its time to teleport back
                lichKing->AI()->JustSummoned(me);
            }
        }

        bool IsHeroic() { return me->GetMap()->IsHeroic(); }
        void OnCharmed(bool  /*apply*/) override {}
        void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply) override
        {
            if (!apply)
                pass->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE);
        }

        void DoAction(int32 action) override
        {
            if (action != ACTION_TELEPORT_BACK)
                return;

            if (TempSummon* summ = me->ToTempSummon())
            {
                if (Unit* summoner = summ->GetSummonerUnit())
                {
                    bool buff = _instance->GetBossState(DATA_THE_LICH_KING) == IN_PROGRESS && summoner->IsPlayer() && (!summoner->IsAlive() || summoner->ToPlayer()->IsBeingTeleported() || summoner->FindMap() != me->GetMap());
                    if (summoner->IsPlayer() && !summoner->ToPlayer()->IsBeingTeleported() && summoner->FindMap() == me->GetMap())
                    {
                        if (buff)
                            summoner->CastSpell((Unit*)nullptr, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, _instance->GetGuidData(DATA_THE_LICH_KING));

                        me->CastSpell(summoner, SPELL_HARVEST_SOUL_TELEPORT_BACK, false);
                    }
                    else if (buff)
                        me->CastSpell((Unit*)nullptr, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, _instance->GetGuidData(DATA_THE_LICH_KING));

                    summoner->RemoveAurasDueToSpell(IsHeroic() ? SPELL_HARVEST_SOULS_TELEPORT : SPELL_HARVEST_SOUL_TELEPORT);
                }
                else
                    me->CastSpell((Unit*)nullptr, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, _instance->GetGuidData(DATA_THE_LICH_KING));
            }

            _events.Reset();
            me->RemoveAllAuras();
            me->DespawnOrUnsummon(500);

            if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                lichKing->AI()->SummonedCreatureDespawn(me);
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_TELEPORT:
                    me->GetMotionMaster()->Clear(false);
                    me->GetMotionMaster()->MoveIdle();
                    if (TempSummon* summ = me->ToTempSummon())
                        if (Unit* summoner = summ->GetSummonerUnit())
                        {
                            if (summoner->IsAlive() && summoner->IsPlayer())
                            {
                                summoner->CastSpell((Unit*)nullptr, SPELL_HARVEST_SOUL_VISUAL, true);
                                summoner->ExitVehicle(summoner);
                                me->UpdatePosition(me->GetPositionX(), me->GetPositionY(), 840.87f, me->GetOrientation(), true);
                                me->StopMovingOnCurrentPos();
                                if (!IsHeroic())
                                    summoner->CastSpell(summoner, SPELL_HARVEST_SOUL_TELEPORT, true);
                                else
                                    summoner->CastSpell(summoner, SPELL_HARVEST_SOULS_TELEPORT, true);
                            }
                            else
                            {
                                summoner->ExitVehicle(summoner);
                                _events.RescheduleEvent(EVENT_DESPAWN_SELF, 0ms);
                            }
                        }
                    break;
                case EVENT_MOVE_TO_LICH_KING:
                    if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        if (me->GetExactDist(lichKing) > 8.0f)
                        {
                            float dist = float(rand_norm()) * 5.0f + 8.0f;
                            float angle = lichKing->GetAngle(me);
                            Movement::PointsArray path;
                            path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                            path.push_back(G3D::Vector3(lichKing->GetPositionX() + dist * cos(angle), lichKing->GetPositionY() + dist * std::sin(angle), 843.0f));
                            me->GetMotionMaster()->MoveSplinePath(&path);
                        }
                    break;
                case EVENT_DESPAWN_SELF:
                    if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        lichKing->AI()->SummonedCreatureDespawn(me);
                    me->DespawnOrUnsummon(1);
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_strangulate_vehicleAI>(creature);
    }
};

class npc_terenas_menethil : public CreatureScript
{
public:
    npc_terenas_menethil() : CreatureScript("npc_terenas_menethil") { }

    struct npc_terenas_menethilAI : public ScriptedAI
    {
        npc_terenas_menethilAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

        EventMap _events;
        InstanceScript* _instance;

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_FROSTMOURNE_INTRO:
                    me->SetControlled(true, UNIT_STATE_ROOT);
                    me->setActive(true);
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_FROSTMOURNE_TALK_1, 2s);
                    _events.ScheduleEvent(EVENT_FROSTMOURNE_TALK_2, 11s);
                    if (!IsHeroic())
                    {
                        me->SetHealth(me->GetMaxHealth() / 2);
                        _events.ScheduleEvent(EVENT_DESTROY_SOUL, 1min);
                        _events.ScheduleEvent(EVENT_FROSTMOURNE_TALK_3, 25s);
                    }
                    break;
                case ACTION_TELEPORT_BACK:
                    if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                    {
                        _events.Reset();
                        me->CastSpell((Unit*)nullptr, SPELL_RESTORE_SOUL, false);
                        me->DespawnOrUnsummon(3000);
                    }
                    break;
            }
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (damage >= me->GetHealth())
            {
                damage = me->GetHealth() - 1;
                if (IsHeroic())
                    return;
                if (!me->HasUnitFlag(UNIT_FLAG_NOT_SELECTABLE))
                {
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_TELEPORT_BACK, 1s);
                    if (Creature* warden = me->FindNearestCreature(NPC_SPIRIT_WARDEN, 20.0f))
                    {
                        warden->CastSpell((Unit*)nullptr, SPELL_DESTROY_SOUL, false);
                        warden->DespawnOrUnsummon(2000);
                    }
                    me->CastSpell(me, SPELL_TERENAS_LOSES_INSIDE, false);
                    me->SetDisplayId(16946);
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    me->DespawnOrUnsummon(2000);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            UpdateVictim();

            _events.Update(diff);

            switch (_events.ExecuteEvent())
            {
                case EVENT_FROSTMOURNE_TALK_1:
                    me->SetControlled(false, UNIT_STATE_ROOT);
                    Talk(SAY_TERENAS_INTRO_1);
                    if (IsHeroic())
                        me->CastSpell((Unit*)nullptr, SPELL_RESTORE_SOULS, false);
                    break;
                case EVENT_FROSTMOURNE_TALK_2:
                    Talk(SAY_TERENAS_INTRO_2);
                    break;
                case EVENT_FROSTMOURNE_TALK_3:
                    Talk(SAY_TERENAS_INTRO_3);
                    break;
                case EVENT_DESTROY_SOUL:
                    if (Creature* warden = me->FindNearestCreature(NPC_SPIRIT_WARDEN, 20.0f))
                        warden->CastSpell((Unit*)nullptr, SPELL_DESTROY_SOUL, false);
                    me->CastSpell(me, SPELL_TERENAS_LOSES_INSIDE, false);
                    me->SetDisplayId(16946);
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_TELEPORT_BACK, 1s);
                    break;
                case EVENT_TELEPORT_BACK:
                    if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_THE_LICH_KING)))
                        lichKing->AI()->DoAction(ACTION_TELEPORT_BACK);
                    break;
                default:
                    break;
            }

            DoMeleeAttackIfReady();
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return target->GetEntry() != NPC_THE_LICH_KING;
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            if (!me->IsAlive())
                return;

            me->GetThreatMgr().ClearAllThreat();
            me->CombatStop(false);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_terenas_menethilAI>(creature);
    }
};

class spell_the_lich_king_lights_favor_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_lights_favor_aura);

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (Unit* caster = GetCaster())
            if (AuraEffect* effect = GetAura()->GetEffect(EFFECT_1))
                effect->RecalculateAmount(caster);
    }

    void CalculateBonus(AuraEffect const* /*aurEff*/, int32& amount, bool& canBeRecalculated)
    {
        canBeRecalculated = true;
        amount = 0;
        if (Unit* caster = GetCaster())
            amount = int32(caster->GetHealthPct());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_lights_favor_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_the_lich_king_lights_favor_aura::CalculateBonus, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
    }
};

class spell_the_lich_king_restore_soul : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_restore_soul);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_HARVEST_SOULS_TELEPORT, SPELL_HARVEST_SOUL_TELEPORT });
    }

    bool Load() override
    {
        _instance = GetCaster()->GetInstanceScript();
        return _instance != nullptr;
    }

    void FilterTargets(std::list<WorldObject*>& unitList)
    {
        for (std::list<WorldObject*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
            if (Unit* target = (*itr)->ToUnit())
                target->RemoveAurasDueToSpell(target->GetMap()->IsHeroic() ? SPELL_HARVEST_SOULS_TELEPORT : SPELL_HARVEST_SOUL_TELEPORT);
        if (Creature* lichKing = ObjectAccessor::GetCreature(*GetCaster(), _instance->GetGuidData(DATA_THE_LICH_KING)))
            lichKing->AI()->DoAction(ACTION_TELEPORT_BACK);
        if (Creature* spawner = GetCaster()->FindNearestCreature(NPC_WORLD_TRIGGER_INFINITE_AOI, 50.0f, true))
        {
            spawner->RemoveAllAuras();
            spawner->m_Events.KillAllEvents(true);
        }

        std::list<Creature*> spirits;
        GetCaster()->GetCreatureListWithEntryInGrid(spirits, NPC_WICKED_SPIRIT, 200.0f);
        for (std::list<Creature*>::iterator itr = spirits.begin(); itr != spirits.end(); ++itr)
        {
            (*itr)->m_Events.KillAllEvents(true);
            (*itr)->RemoveAllAuras();
            (*itr)->AI()->EnterEvadeMode();
            (*itr)->SetReactState(REACT_PASSIVE);
        }
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_restore_soul::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
    }

private:
    InstanceScript* _instance;
};

class npc_spirit_warden : public CreatureScript
{
public:
    npc_spirit_warden() : CreatureScript("npc_spirit_warden") { }

    struct npc_spirit_wardenAI : public ScriptedAI
    {
        npc_spirit_wardenAI(Creature* creature) : ScriptedAI(creature), _instance(creature->GetInstanceScript()) {}

        EventMap _events;
        InstanceScript* _instance;

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_SOUL_RIP, 12s, 15s);
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* terenas = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_TERENAS_MENETHIL)))
                terenas->AI()->DoAction(ACTION_TELEPORT_BACK);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            _events.Update(diff);

            if (_events.ExecuteEvent() == EVENT_SOUL_RIP)
            {
                me->CastSpell(me->GetVictim(), SPELL_SOUL_RIP, false);
                _events.ScheduleEvent(EVENT_SOUL_RIP, 23s, 27s);
            }

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_spirit_wardenAI>(creature);
    }
};

class spell_the_lich_king_dark_hunger_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_dark_hunger_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DARK_HUNGER_HEAL });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();

        if (!damageInfo || !damageInfo->GetDamage())
        {
            return;
        }

        int32 heal = static_cast<int32>(damageInfo->GetDamage() / 2);
        GetTarget()->CastCustomSpell(SPELL_DARK_HUNGER_HEAL, SPELLVALUE_BASE_POINT0, heal, GetTarget(), true, nullptr, aurEff);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_the_lich_king_dark_hunger_aura::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_the_lich_king_soul_rip_aura : public AuraScript
{
    PrepareAuraScript(spell_the_lich_king_soul_rip_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SOUL_RIP_DAMAGE, 5000 });
    }

    void OnPeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        // shouldn't be needed, this is channeled
        if (Unit* caster = GetCaster())
            caster->CastCustomSpell(SPELL_SOUL_RIP_DAMAGE, SPELLVALUE_BASE_POINT0, 5000 * aurEff->GetTickNumber(), GetTarget(), true, nullptr, aurEff, GetCasterGUID());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_soul_rip_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class npc_icc_lk_checktarget : public CreatureScript
{
public:
    npc_icc_lk_checktarget() : CreatureScript("npc_icc_lk_checktarget") { }

    struct npc_icc_lk_checktargetAI : public ScriptedAI
    {
        npc_icc_lk_checktargetAI(Creature* creature) : ScriptedAI(creature) {}

        bool CanAIAttack(Unit const* target) const override
        {
            return IsValidPlatformTarget(target) && !target->GetVehicle();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_icc_lk_checktargetAI>(creature);
    }
};

class spell_the_lich_king_summon_spirit_bomb : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_summon_spirit_bomb);

    void HandleScript(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        GetHitUnit()->CastSpell((Unit*)nullptr, uint32(GetEffectValue()), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_summon_spirit_bomb::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class npc_lk_spirit_bomb : public CreatureScript
{
public:
    npc_lk_spirit_bomb() : CreatureScript("npc_lk_spirit_bomb") { }

    struct npc_lk_spirit_bombAI : public NullCreatureAI
    {
        npc_lk_spirit_bombAI(Creature* creature) : NullCreatureAI(creature)
        {
            me->SetReactState(REACT_PASSIVE);
            me->DespawnOrUnsummon(45000); // for safety
            timer = 0;
        }

        uint16 timer;

        void IsSummonedBy(WorldObject* /*summoner*/) override
        {
            float destX, destY, destZ;
            me->GetPosition(destX, destY);
            destZ = 1055.0f;    // approximation, gets more precise later
            me->UpdateGroundPositionZ(destX, destY, destZ);
            me->SetWalk(false);
            me->GetMotionMaster()->MovePoint(POINT_GROUND, destX, destY, destZ);
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            if (type != POINT_MOTION_TYPE || point != POINT_GROUND)
                return;

            timer = 1000;
        }

        void UpdateAI(uint32 diff) override
        {
            if (timer)
            {
                if (timer <= diff)
                {
                    timer = 0;
                    me->RemoveAllAuras();
                    me->CastSpell((Unit*)nullptr, SPELL_EXPLOSION, false);
                    me->DespawnOrUnsummon(1000);
                }
                else
                    timer -= diff;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_lk_spirit_bombAI>(creature);
    }
};

class spell_the_lich_king_trigger_vile_spirit : public SpellScript
{
    PrepareSpellScript(spell_the_lich_king_trigger_vile_spirit);

    void ActivateSpirit()
    {
        Creature* target = GetHitCreature();
        if (!target)
            return;

        target->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1);
        target->SetImmuneToAll(false);
        target->ForceValuesUpdateAtIndex(UNIT_FIELD_FLAGS);
        VileSpiritActivateEvent(target).Execute(0, 0);
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_the_lich_king_trigger_vile_spirit::ActivateSpirit);
    }
};

class npc_lk_wicked_spirit : public CreatureScript
{
public:
    npc_lk_wicked_spirit() : CreatureScript("npc_lk_wicked_spirit") { }

    struct npc_lk_wicked_spiritAI : public ScriptedAI
    {
        npc_lk_wicked_spiritAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            me->SetCorpseDelay(0);
            me->SetReactState(REACT_PASSIVE);
        }

        void JustDied(Unit* /*killer*/) override
        {
            me->SetReactState(REACT_PASSIVE);
        }

        void JustRespawned() override
        {
            me->SetReactState(REACT_PASSIVE);
        }

        bool CanAIAttack(Unit const* target) const override
        {
            return me->GetReactState() == REACT_AGGRESSIVE && target->IsPlayer() && target->GetExactDistSq(495.708f, -2523.76f, 1049.95f) < 40.0f * 40.0f;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetIcecrownCitadelAI<npc_lk_wicked_spiritAI>(creature);
    }
};

class achievement_been_waiting_long_time : public AchievementCriteriaScript
{
public:
    achievement_been_waiting_long_time() : AchievementCriteriaScript("achievement_been_waiting_long_time") { }

    bool OnCheck(Player* /*source*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return target->GetAI()->GetData(DATA_PLAGUE_STACK) >= 30;
    }
};

class achievement_neck_deep_in_vile : public AchievementCriteriaScript
{
public:
    achievement_neck_deep_in_vile() : AchievementCriteriaScript("achievement_neck_deep_in_vile") { }

    bool OnCheck(Player* /*source*/, Unit* target, uint32 /*criteria_id*/) override
    {
        if (!target)
            return false;

        return !target->GetAI()->GetData(DATA_VILE);
    }
};

void AddSC_boss_the_lich_king()
{
    new boss_the_lich_king();
    new npc_tirion_fordring_tft();
    RegisterSpellScript(spell_the_lich_king_quake);
    RegisterSpellScript(spell_the_lich_king_jump);
    RegisterSpellScript(spell_the_lich_king_jump_remove_aura);
    RegisterSpellScriptWithArgs(spell_trigger_spell_from_caster, "spell_the_lich_king_mass_resurrection", SPELL_MASS_RESURRECTION_REAL);
    RegisterSpellScript(spell_the_lich_king_play_movie);

    // fight stuff below
    new npc_shambling_horror_icc();
    RegisterSpellScript(spell_the_lich_king_infest_aura);
    RegisterSpellScript(spell_the_lich_king_necrotic_plague_aura);
    RegisterSpellAndAuraScriptPair(spell_the_lich_king_necrotic_plague_jump, spell_the_lich_king_necrotic_plague_jump_aura);
    RegisterSpellScript(spell_the_lich_king_shadow_trap_visual_aura);
    RegisterSpellScript(spell_the_lich_king_shadow_trap_periodic);
    RegisterSpellScript(spell_the_lich_king_ice_burst_target_search);
    new npc_icc_ice_sphere();
    RegisterSpellScript(spell_the_lich_king_raging_spirit);
    new npc_raging_spirit();
    RegisterSpellScript(spell_the_lich_king_defile);
    RegisterSpellScript(spell_the_lich_king_soul_reaper_aura);
    new npc_valkyr_shadowguard();
    RegisterSpellScript(spell_the_lich_king_summon_into_air);
    RegisterSpellScript(spell_the_lich_king_teleport_to_frostmourne_hc);
    RegisterSpellScript(spell_the_lich_king_valkyr_target_search);
    RegisterSpellScript(spell_the_lich_king_cast_back_to_caster);
    RegisterSpellScript(spell_the_lich_king_life_siphon);
    RegisterSpellScript(spell_the_lich_king_vile_spirits_aura);
    RegisterSpellScript(spell_the_lich_king_vile_spirits_visual);
    RegisterSpellScript(spell_the_lich_king_vile_spirit_move_target_search);
    RegisterSpellScript(spell_the_lich_king_vile_spirit_damage_target_search);
    RegisterSpellScript(spell_the_lich_king_harvest_soul_aura);
    new npc_strangulate_vehicle();
    new npc_terenas_menethil();
    RegisterSpellScript(spell_the_lich_king_lights_favor_aura);
    RegisterSpellScript(spell_the_lich_king_restore_soul);
    new npc_spirit_warden();
    RegisterSpellScript(spell_the_lich_king_dark_hunger_aura);
    RegisterSpellScript(spell_the_lich_king_soul_rip_aura);
    new npc_icc_lk_checktarget();
    RegisterSpellScript(spell_the_lich_king_summon_spirit_bomb);
    new npc_lk_spirit_bomb();
    RegisterSpellScript(spell_the_lich_king_trigger_vile_spirit);
    new npc_lk_wicked_spirit();
    new achievement_been_waiting_long_time();
    new achievement_neck_deep_in_vile();
}
