/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Spell.h"
#include "Vehicle.h"
#include "Unit.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CreatureTextMgr.h"
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
    return target->GetExactDist2dSq(&CenterPosition) < 90.0f*90.0f && target->GetPositionZ() > 840.0f && target->GetPositionZ() < 875.0f;
}

void SendPacketToPlayers(WorldPacket const* data, Unit* source)
{
    // Send packet to all players in The Frozen Throne
    Map::PlayerList const& players = source->GetMap()->GetPlayers();
    if (!players.isEmpty())
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->GetAreaId() == AREA_THE_FROZEN_THRONE)
                    player->GetSession()->SendPacket(data);
}


struct ShadowTrapLKTargetSelector : public acore::unary_function<Unit*, bool>
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



struct NonTankLKTargetSelector : public acore::unary_function<Unit*, bool>
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


struct DefileTargetSelector : public acore::unary_function<Unit*, bool>
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
                    go->SetDestructibleState(GO_DESTRUCTIBLE_INTACT, NULL, true);
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

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            _owner->SetReactState(REACT_AGGRESSIVE);
            if (!_owner->getThreatManager().isThreatListEmpty())
                if (Unit* target = _owner->SelectVictim())
                    _owner->AI()->AttackStart(target);
            if (!_owner->GetVictim())
                if (Unit* target = _summoner->AI()->SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankLKTargetSelector(_summoner)))
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

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            _owner->SetReactState(REACT_AGGRESSIVE);
            _owner->CastSpell(_owner, SPELL_VILE_SPIRIT_MOVE_SEARCH, true);
            _owner->CastSpell((Unit*)NULL, SPELL_VILE_SPIRIT_DAMAGE_SEARCH, true);
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

        bool Execute(uint64 /*time*/, uint32 /*diff*/)
        {
            _owner->CastCustomSpell(SPELL_TRIGGER_VILE_SPIRIT_HEROIC, SPELLVALUE_MAX_TARGETS, 1, NULL, true);

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

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
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

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/)
    {
        _owner.CastSpell((Unit*)NULL, SPELL_PLAY_MOVIE, false);
        return true;
    }

private:
    Creature& _owner;
};

class NecroticPlagueTargetCheck : public acore::unary_function<Unit*, bool>
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
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
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

            void Reset()
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
                if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC))
                    me->SetStandState(UNIT_STAND_STATE_SIT);
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
                DoAction(ACTION_RESTORE_LIGHT);
                me->PlayDirectSound(17374);
            }

            void EnterCombat(Unit* target)
            {
                if (!instance->CheckRequiredBosses(DATA_THE_LICH_KING, target->ToPlayer()) || !me->IsVisible())
                {
                    EnterEvadeMode();
                    instance->DoCastSpellOnPlayers(LIGHT_S_HAMMER_TELEPORT);
                    return;
                }

                _phase = PHASE_ONE;
                instance->SetBossState(DATA_THE_LICH_KING, IN_PROGRESS);
                me->setActive(true);
                me->SetInCombatWithZone();
                me->RemoveAurasDueToSpell(SPELL_EMOTE_SIT_NO_SHEATH); // just to be sure

                events.ScheduleEvent(EVENT_BERSERK, 900000, EVENT_GROUP_BERSERK);
                events.ScheduleEvent(EVENT_SUMMON_SHAMBLING_HORROR, 15000, EVENT_GROUP_ABILITIES);
                events.ScheduleEvent(EVENT_SUMMON_DRUDGE_GHOUL, 10000, EVENT_GROUP_ABILITIES);
                events.ScheduleEvent(EVENT_INFEST, 5000, EVENT_GROUP_ABILITIES);
                events.ScheduleEvent(EVENT_NECROTIC_PLAGUE, urand(30000, 31000), EVENT_GROUP_ABILITIES);
                if (IsHeroic())
                    events.ScheduleEvent(EVENT_SHADOW_TRAP, 15500, EVENT_GROUP_ABILITIES);
            }

            void JustReachedHome()
            {
                _JustReachedHome();
                DoAction(ACTION_RESTORE_LIGHT);

                // Reset The Frozen Throne gameobjects
                FrozenThroneResetWorker reset;
                acore::GameObjectWorker<FrozenThroneResetWorker> worker(me, reset);
                me->VisitNearbyGridObject(333.0f, worker);

                me->AddAura(SPELL_EMOTE_SIT_NO_SHEATH, me);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                me->SetReactState(REACT_PASSIVE);
                me->SetStandState(UNIT_STAND_STATE_SIT);

            }

            bool CanAIAttack(Unit const* target) const
            {
                return me->IsVisible() && IsValidPlatformTarget(target) && !target->GetVehicle();
            }

            /*bool CanBeSeen(Player const* p)
            {
                return me->GetExactDistSq(p) < 200.0f*200.0f;
            }*/

            void KilledUnit(Unit* victim)
            {
                if (victim->GetTypeId() == TYPEID_PLAYER && !me->IsInEvadeMode() && _phase != PHASE_OUTRO && _lastTalkTimeKill+5 < time(nullptr))
                {
                    _lastTalkTimeKill = time(nullptr);
                    Talk(SAY_LK_KILL);
                }
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_RESTORE_LIGHT:
                        me->GetMap()->SetZoneOverrideLight(AREA_THE_FROZEN_THRONE, 0, 5000);
                        me->GetMap()->SetZoneWeather(AREA_THE_FROZEN_THRONE, WEATHER_STATE_FINE, 0.5f);
                        break;
                    case ACTION_START_ATTACK:
                        events.ScheduleEvent(EVENT_START_ATTACK, 5250);
                        break;
                    case ACTION_BREAK_FROSTMOURNE:
                        me->CastSpell((Unit*)NULL, SPELL_SUMMON_BROKEN_FROSTMOURNE, true);
                        me->CastSpell((Unit*)NULL, SPELL_SUMMON_BROKEN_FROSTMOURNE_2, false);
                        SetEquipmentSlots(false, EQUIP_BROKEN_FROSTMOURNE);
                        if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_HIGHLORD_TIRION_FORDRING)))
                            tirion->AI()->DoAction(ACTION_BREAK_FROSTMOURNE);
                        break;
                    case ACTION_TELEPORT_BACK:
                        {
                            if (_phase == PHASE_FROSTMOURNE)
                                events.RescheduleEvent(EVENT_START_ATTACK, 1000);
                            EntryCheckPredicate pred(NPC_STRANGULATE_VEHICLE);
                            summons.DoAction(ACTION_TELEPORT_BACK, pred);
                            if (!IsHeroic() && _phase != PHASE_OUTRO && me->IsInCombat() && _lastTalkTimeBuff+5 <= time(nullptr))
                                Talk(SAY_LK_FROSTMOURNE_ESCAPE);
                        }
                        break;
                    default:
                        break;
                }
            }

            void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (!attacker || (_bFrostmournePhase && attacker->GetExactDistSq(495.708f, -2523.76f, 1049.95f) > 40.0f*40.0f)) // frostmourne room, prevent exploiting (tele hack to get back and damage him)
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
                    me->CastSpell((Unit*)NULL, SPELL_FURY_OF_FROSTMOURNE, false);
                    me->SetWalk(true);

                    if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_HIGHLORD_TIRION_FORDRING)))
                        tirion->AI()->DoAction(ACTION_OUTRO);
                    return;
                }

                if (_phase == PHASE_OUTRO)
                {
                    if (!me->HasByteFlag(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_HOVER))
                        damage = me->GetHealth() > 1 ? 1 : 0;
                    else if (damage >= me->GetHealth()) // dying...
                    {
                        damage = me->GetHealth()-1;
                        me->SetDisableGravity(false);
                        me->RemoveByteFlag(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_ALWAYS_STAND | UNIT_BYTE1_FLAG_HOVER);
                        me->SendMonsterMove(me->GetPositionX()+0.25f, me->GetPositionY(), 840.86f, 300, SPLINEFLAG_FALLING);
                        me->m_positionZ = 840.86f;
                        me->SetOrientation(0.0f);
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
                        if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_HIGHLORD_TIRION_FORDRING)))
                        {
                            tirion->MonsterYell("The Lich King must fall!", LANG_UNIVERSAL, 0);
                            tirion->PlayDirectSound(17389);
                        }
                    }
                    
                }
                else if (damage >= me->GetHealth())
                    damage = me->GetHealth()-1;
            }

            void JustSummoned(Creature* summon)
            {
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

            void SummonedCreatureDies(Creature* summon, Unit*)
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

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
            {
                if (spell->Id == HARVESTED_SOUL_BUFF && me->IsInCombat() && !IsHeroic() && _phase != PHASE_OUTRO && _lastTalkTimeBuff+5 <= time(nullptr))
                {
                    _lastTalkTimeBuff = time(nullptr);
                    Talk(SAY_LK_FROSTMOURNE_KILL);
                }
            }

            void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell)
            {
                if (spell->Id == REMORSELESS_WINTER_1 || spell->Id == REMORSELESS_WINTER_2)
                {
                    me->GetMap()->SetZoneOverrideLight(AREA_THE_FROZEN_THRONE, LIGHT_SNOWSTORM, 5000);
                    me->GetMap()->SetZoneWeather(AREA_THE_FROZEN_THRONE, WEATHER_STATE_LIGHT_SNOW, 0.5f);
                    summons.DespawnEntry(NPC_SHADOW_TRAP_TRIGGER);
                }
            }

            void MovementInform(uint32 type, uint32 pointId)
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
                        //events.DelayEvents(62500, EVENT_GROUP_BERSERK); // delay berserk timer, its not ticking during phase transitions, bullshit, 15mins on movies
                        events.ScheduleEvent(EVENT_QUAKE, 62500);
                        events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, 3500, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_SUMMON_ICE_SPHERE, 8000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_SUMMON_RAGING_SPIRIT, 4000, EVENT_GROUP_ABILITIES);
                        break;
                    case POINT_CENTER_2:
                        me->SetFacingTo(0.0f);
                        Talk(SAY_LK_REMORSELESS_WINTER);
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                        me->CastSpell(me, SPELL_REMORSELESS_WINTER_2, false);
                        summons.DespawnEntry(NPC_VALKYR_SHADOWGUARD);
                        //events.DelayEvents(62500, EVENT_GROUP_BERSERK); // delay berserk timer, its not ticking during phase transitions, bullshit, 15 mins on movies
                        events.ScheduleEvent(EVENT_QUAKE_2, 62500);
                        events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, 3500, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_SUMMON_ICE_SPHERE, 8000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_SUMMON_RAGING_SPIRIT, 4000, EVENT_GROUP_ABILITIES);
                        break;
                    default:
                        break;
                }
            }

            void UpdateAI(uint32 diff)
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
                    if (!players.isEmpty())
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
                            events.RescheduleEvent(EVENT_DEFILE, 0, EVENT_GROUP_ABILITIES);
                            events.RescheduleEvent(EVENT_SOUL_REAPER, urand(7000, 12000), EVENT_GROUP_ABILITIES);

                            for (SummonList::iterator i = summons.begin(); i != summons.end(); ++i)
                                if (Creature* summon = ObjectAccessor::GetCreature(*me, *i))
                                    if (summon->GetEntry() == NPC_RAGING_SPIRIT)
                                        summon->SetReactState(REACT_AGGRESSIVE);
                        }
                        break;
                    case EVENT_QUAKE:
                        _phase = PHASE_TWO;
                        events.CancelEventGroup(EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_INFEST, 14000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_SUMMON_VALKYR, 20000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_SOUL_REAPER, 40000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_DEFILE, 38000, EVENT_GROUP_ABILITIES);

                        me->InterruptNonMeleeSpells(false);
                        me->ClearUnitState(UNIT_STATE_CASTING);
                        me->SetFacingTo(0.0f);
                        me->CastSpell((Unit*)NULL, SPELL_QUAKE, false);
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                        Talk(SAY_LK_QUAKE);
                        break;
                    case EVENT_QUAKE_2:
                        _phase = PHASE_THREE;
                        events.CancelEventGroup(EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_SOUL_REAPER, 40000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_DEFILE, 38000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_VILE_SPIRITS, 20000, EVENT_GROUP_VILE_SPIRITS);
                        events.ScheduleEvent(IsHeroic() ? EVENT_HARVEST_SOULS : EVENT_HARVEST_SOUL, 14000, EVENT_GROUP_ABILITIES);

                        me->InterruptNonMeleeSpells(false);
                        me->ClearUnitState(UNIT_STATE_CASTING);
                        me->SetFacingTo(0.0f);
                        me->CastSpell((Unit*)NULL, SPELL_QUAKE, false);
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                        Talk(SAY_LK_QUAKE);
                        break;

                    // ABILITIES:
                    case EVENT_SUMMON_SHAMBLING_HORROR:
                        me->CastSpell(me, SPELL_SUMMON_SHAMBLING_HORROR, false);
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                        events.ScheduleEvent(EVENT_SUMMON_SHAMBLING_HORROR, 60000, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_SUMMON_DRUDGE_GHOUL:
                        me->CastSpell(me, SPELL_SUMMON_DRUDGE_GHOULS, false);
                        events.ScheduleEvent(EVENT_SUMMON_DRUDGE_GHOUL, 30000, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_INFEST:
                        me->CastSpell(me, SPELL_INFEST, false);
                        events.ScheduleEvent(EVENT_INFEST, 22500, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_NECROTIC_PLAGUE:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, NecroticPlagueTargetCheck(me, NECROTIC_PLAGUE_LK, NECROTIC_PLAGUE_PLR)))
                        {
                            Talk(EMOTE_NECROTIC_PLAGUE_WARNING, target);
                            me->CastSpell(target, SPELL_NECROTIC_PLAGUE, false);
                            events.ScheduleEvent(EVENT_NECROTIC_PLAGUE, urand(30000, 31000), EVENT_GROUP_ABILITIES);
                        }
                        else
                            events.ScheduleEvent(EVENT_NECROTIC_PLAGUE, 5000, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_SHADOW_TRAP:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, ShadowTrapLKTargetSelector(me, true, true, 100.0f)))
                            me->CastSpell(target, SPELL_SHADOW_TRAP, false);
                        events.ScheduleEvent(EVENT_SHADOW_TRAP, 15500, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_PAIN_AND_SUFFERING:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        {
                            //events.DelayEventsToMax(500, EVENT_GROUP_ABILITIES);
                            me->SetFacingTo(me->GetAngle(target));
                            me->CastSpell(target, SPELL_PAIN_AND_SUFFERING, false);
                        }
                        events.ScheduleEvent(EVENT_PAIN_AND_SUFFERING, (IsHeroic() ? urand(1250, 1750) : urand(1750, 2250)), EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_SUMMON_ICE_SPHERE:
                        me->CastSpell((Unit*)NULL, SPELL_SUMMON_ICE_SPHERE, false);
                        events.ScheduleEvent(EVENT_SUMMON_ICE_SPHERE, 7500, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_SUMMON_RAGING_SPIRIT:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                            me->CastSpell(target, SPELL_RAGING_SPIRIT, false);
                        events.ScheduleEvent(EVENT_SUMMON_RAGING_SPIRIT, (!HealthAbovePct(40) ? 15000 : 20000), EVENT_GROUP_ABILITIES);
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
                                    events.ScheduleEvent(EVENT_DEFILE, t+(Is25ManRaid() ? 5000 : 4000), EVENT_GROUP_ABILITIES);
                                    break;
                                } 

                                // if valkyr is coming between 1.5 and 3 seconds after defile then we've to
                                // delay valkyr just a bit
                                events.RescheduleEvent(EVENT_SUMMON_VALKYR, 5000, EVENT_GROUP_ABILITIES);
                            }

                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, DefileTargetSelector(me)))
                            {
                                Talk(EMOTE_DEFILE_WARNING);
                                me->CastSpell(target, SPELL_DEFILE, false);
                                // defile has a fixed CD (from dbm) that can be variable only
                                // if no target has been found at the moment (schedule after 1 second)
                                events.ScheduleEvent(EVENT_DEFILE, 32500, EVENT_GROUP_ABILITIES);
                            }
                            else {
                                // be sure it happen trying each seconds if no target
                                events.ScheduleEvent(EVENT_DEFILE, 1000, EVENT_GROUP_ABILITIES);
                            }
                        }
                        break;
                    case EVENT_SOUL_REAPER:
                        if (me->IsWithinMeleeRange(me->GetVictim()))
                        {
                            me->CastSpell(me->GetVictim(), SPELL_SOUL_REAPER, false);
                            events.ScheduleEvent(EVENT_SOUL_REAPER, 30500, EVENT_GROUP_ABILITIES);
                        }
                        else
                            events.ScheduleEvent(EVENT_SOUL_REAPER, 1000, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_SUMMON_VALKYR:
                        {
                            me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                            Talk(SAY_LK_SUMMON_VALKYR);
                            me->CastSpell((Unit*)NULL, SUMMON_VALKYR, false);
                            events.ScheduleEvent(EVENT_SUMMON_VALKYR, 45000, EVENT_GROUP_ABILITIES);

                            // schedule a defile (or reschedule it) if next defile event 
                            // doesn't exist ( now > next defile ) or defile is coming too soon
                            uint32 minTime = (Is25ManRaid() ? 5000 : 4000);
                            if (uint32 evTime = events.GetNextEventTime(EVENT_DEFILE))
                                if (events.GetTimer() > evTime || evTime - events.GetTimer() < minTime) {
                                    events.RescheduleEvent(EVENT_DEFILE, minTime, EVENT_GROUP_ABILITIES);
                                }
                        }
                        break;
                    case EVENT_VILE_SPIRITS:
                        me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_SPECIAL);
                        me->CastSpell((Unit*)NULL, SPELL_VILE_SPIRITS, false);
                        events.ScheduleEvent(EVENT_VILE_SPIRITS, 30000, EVENT_GROUP_VILE_SPIRITS);
                        break;
                    case EVENT_HARVEST_SOUL:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankLKTargetSelector(me, true, true, 55.0f)))
                        {
                            Talk(SAY_LK_HARVEST_SOUL);
                            me->CastSpell(target, SPELL_HARVEST_SOUL, false);
                            events.ScheduleEvent(EVENT_HARVEST_SOUL, 75000, EVENT_GROUP_ABILITIES);
                        }
                        else
                            events.ScheduleEvent(EVENT_HARVEST_SOUL, 10000, EVENT_GROUP_ABILITIES);
                        break;
                    case EVENT_HARVEST_SOULS:
                        Talk(SAY_LK_HARVEST_SOUL);
                        me->CastSpell((Unit*)NULL, SPELL_HARVEST_SOULS, false);
                        _phase = PHASE_FROSTMOURNE;
                        me->SetReactState(REACT_PASSIVE);
                        me->AttackStop();
                        events.ScheduleEvent(EVENT_START_ATTACK, 55000);
                        events.DelayEvents(52500, EVENT_GROUP_VILE_SPIRITS);
                        events.CancelEvent(EVENT_DEFILE);
                        events.CancelEvent(EVENT_SOUL_REAPER);
                        events.ScheduleEvent(EVENT_FROSTMOURNE_HEROIC, 6000, EVENT_GROUP_ABILITIES);
                        events.ScheduleEvent(EVENT_HARVEST_SOULS, urand(100000, 110000), EVENT_GROUP_ABILITIES);

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
                        if (TempSummon* terenas = me->GetMap()->SummonCreature(NPC_TERENAS_MENETHIL_FROSTMOURNE_H, TerenasSpawnHeroic, NULL, 55000))
                        {
                            terenas->AI()->DoAction(ACTION_FROSTMOURNE_INTRO);
                            if (Creature* spawner = terenas->FindNearestCreature(NPC_WORLD_TRIGGER_INFINITE_AOI, 100.0f, true))
                            {
                                spawner->CastSpell(spawner, SPELL_SUMMON_SPIRIT_BOMB_1, true);  // summons bombs randomly
                                spawner->CastSpell(spawner, SPELL_SUMMON_SPIRIT_BOMB_2, true);  // summons bombs on players
                                spawner->m_Events.AddEvent(new TriggerWickedSpirit(spawner), spawner->m_Events.CalculateTime(3000));
                                terenas->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC); // to avoid being healed by player trinket procs. terenas' health doesn't matter on heroic
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

            uint32 GetData(uint32 type) const
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

            void SetData(uint32 type, uint32 value)
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

            void EnterEvadeMode()
            {
                EntryCheckPredicate pred(NPC_STRANGULATE_VEHICLE);
                summons.DoAction(ACTION_TELEPORT_BACK, pred);
                instance->SetBossState(DATA_THE_LICH_KING, FAIL);
                me->CastSpell((Unit*)NULL, SPELL_KILL_FROSTMOURNE_PLAYERS, true);
                BossAI::EnterEvadeMode();
                me->SetReactState(REACT_AGGRESSIVE);

                if (Creature* tirion = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_HIGHLORD_TIRION_FORDRING)))
                    tirion->AI()->EnterEvadeMode();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
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

            void Reset()
            {
                _events.Reset();
                if (_instance->GetBossState(DATA_THE_LICH_KING) == DONE || (me->GetMap()->IsHeroic() && !_instance->GetData(DATA_LK_HC_AVAILABLE)))
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                me->SetReactState(REACT_PASSIVE);
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE)
                    return;

                switch (id)
                {
                    case POINT_TIRION_INTRO:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            if (!theLichKing->IsAlive() || !theLichKing->IsVisible())
                                break;
                            me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY2H);
                            theLichKing->SetStandState(UNIT_STAND_STATE_STAND);
                            theLichKing->SetSheath(SHEATH_STATE_MELEE);
                            theLichKing->RemoveAurasDueToSpell(SPELL_EMOTE_SIT_NO_SHEATH);
                            theLichKing->AI()->Talk(SAY_LK_INTRO_1);
                            me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_FROZEN_THRONE);
                            _events.ScheduleEvent(EVENT_INTRO_LK_MOVE, 3000);
                        }
                        break;
                    case POINT_TIRION_OUTRO:
                        _events.ScheduleEvent(EVENT_OUTRO_FORDRING_JUMP, 1);
                        break;
                }
            }

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_OUTRO:
                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_1, 2600);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_TALK, 6600);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_TALK, 17600);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_2, 30000);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_3, 39000);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_CAST_SHOUT, 50000);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_EMOTE_TALK, 54000);
                        _events.ScheduleEvent(EVENT_OUTRO_LK_MOVE_CENTER, 65000);
                        break;
                    case ACTION_BREAK_FROSTMOURNE:
                        _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_6, 2500);
                        _events.ScheduleEvent(EVENT_OUTRO_SOUL_BARRAGE, 6500);
                        break;
                }
            }

            void SpellHit(Unit* /*caster*/, SpellInfo const* spell)
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
                    SetEquipmentSlots(true);
                }
            }

            void JustReachedHome()
            {
                ScriptedAI::JustReachedHome();
                if (!(_instance->GetBossState(DATA_THE_LICH_KING) == DONE || (me->GetMap()->IsHeroic() && !_instance->GetData(DATA_LK_HC_AVAILABLE))))
                    me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
            }

            void sGossipSelect(Player* /*player*/, uint32 sender, uint32 action)
            {
                Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING));
                if (me->GetCreatureTemplate()->GossipMenuId == sender && !action && me->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP) && theLichKing && !theLichKing->IsInEvadeMode())
                {
                    if (me->GetMap()->IsHeroic() && !_instance->GetData(DATA_LK_HC_AVAILABLE))
                        return;
                    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                    me->SetWalk(true);
                    me->GetMotionMaster()->MovePoint(POINT_TIRION_INTRO, TirionIntro);
                }
            }

            /*bool CanBeSeen(Player const* p)
            {
                return me->GetExactDistSq(p) < 200.0f*200.0f;
            }*/

            void UpdateAI(uint32 diff)
            {
                UpdateVictim();

                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_INTRO_LK_MOVE:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            Movement::PointsArray path;
                            path.push_back(G3D::Vector3(theLichKing->GetPositionX(), theLichKing->GetPositionY(), theLichKing->GetPositionZ()));
                            for (uint8 i=0; i<3; ++i)
                                path.push_back(G3D::Vector3(LichKingIntro[i].GetPositionX(), LichKingIntro[i].GetPositionY(), LichKingIntro[i].GetPositionZ()));
                            theLichKing->SetWalk(true);
                            theLichKing->GetMotionMaster()->MoveSplinePath(&path);
                            _events.ScheduleEvent(EVENT_INTRO_FORDRING_TALK_1, 11000);
                        }
                        break;
                    case EVENT_INTRO_LK_TALK_1:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->AI()->Talk(SAY_LK_INTRO_2);
                            theLichKing->HandleEmoteCommand(EMOTE_ONESHOT_TALK_NO_SHEATHE);
                            _events.ScheduleEvent(EVENT_INTRO_LK_EMOTE_CAST_SHOUT, 7000);
                            _events.ScheduleEvent(EVENT_INTRO_LK_EMOTE_1, 13000);
                            _events.ScheduleEvent(EVENT_INTRO_LK_EMOTE_CAST_SHOUT, 18000);
                            _events.ScheduleEvent(EVENT_INTRO_LK_CAST_FREEZE, 31000);
                        }
                        break;
                    case EVENT_INTRO_LK_EMOTE_CAST_SHOUT:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            theLichKing->CastSpell(theLichKing, SPELL_EMOTE_SHOUT_NO_SHEATH, false);
                        break;
                    case EVENT_INTRO_LK_EMOTE_1:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            theLichKing->HandleEmoteCommand(EMOTE_ONESHOT_POINT_NO_SHEATHE);
                        break;
                    case EVENT_INTRO_LK_CAST_FREEZE:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->AI()->Talk(SAY_LK_INTRO_3);
                            theLichKing->CastSpell((Unit*)NULL, SPELL_ICE_LOCK, false);
                            _events.ScheduleEvent(EVENT_INTRO_FINISH, 1000);
                        }
                        break;
                    case EVENT_INTRO_FORDRING_TALK_1:
                        {
                            Talk(SAY_TIRION_INTRO_1);
                            _events.ScheduleEvent(EVENT_INTRO_LK_TALK_1, 9000);
                            _events.ScheduleEvent(EVENT_INTRO_FORDRING_TALK_2, 34000);
                        }
                        break;
                    case EVENT_INTRO_FORDRING_TALK_2:
                        {
                            Talk(SAY_TIRION_INTRO_2);
                            _events.ScheduleEvent(EVENT_INTRO_FORDRING_EMOTE_1, 2000);
                            _events.ScheduleEvent(EVENT_INTRO_FORDRING_CHARGE, 5000);
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
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->SetWalk(false);
                            theLichKing->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC);
                            theLichKing->SetReactState(REACT_AGGRESSIVE);
                            theLichKing->SetInCombatWithZone();
                            if (!theLichKing->IsInCombat())
                                theLichKing->AI()->EnterEvadeMode();
                        }
                        break;


                    case EVENT_OUTRO_LK_TALK_1:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->AI()->Talk(SAY_LK_OUTRO_1);
                            theLichKing->CastSpell((Unit*)NULL, SPELL_FURY_OF_FROSTMOURNE_NO_REZ, true);
                            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                if (Player* p = itr->GetSource())
                                    if (p->IsAlive())
                                        Unit::Kill(me, p);
                        }
                        break;
                    case EVENT_OUTRO_LK_TALK_2:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->AI()->Talk(SAY_LK_OUTRO_2);
                            theLichKing->CastSpell((Unit*)NULL, SPELL_EMOTE_QUESTION_NO_SHEATH, false);
                        }
                        break;
                    case EVENT_OUTRO_LK_EMOTE_TALK:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            theLichKing->HandleEmoteCommand(EMOTE_ONESHOT_TALK_NO_SHEATHE);
                        break;
                    case EVENT_OUTRO_LK_TALK_3:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->SetFacingToObject(me);
                            theLichKing->AI()->Talk(SAY_LK_OUTRO_3);
                        }
                        break;
                    case EVENT_OUTRO_LK_MOVE_CENTER:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->GetMotionMaster()->MovePoint(0, CenterPosition);
                            uint32 travelTime = 1000*theLichKing->GetExactDist(&CenterPosition)/theLichKing->GetSpeed(MOVE_WALK) + 1000;
                            
                            _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_4, 1+travelTime);
                            _events.ScheduleEvent(EVENT_OUTRO_LK_RAISE_DEAD, 1000+travelTime);
                            _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_5, 29000+travelTime);
                        }
                        break;
                    case EVENT_OUTRO_LK_TALK_4:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->SetFacingTo(0.01745329f);
                            theLichKing->AI()->Talk(SAY_LK_OUTRO_4);
                        }
                        break;
                    case EVENT_OUTRO_LK_RAISE_DEAD:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->CastSpell((Unit*)NULL, SPELL_RAISE_DEAD, false);
                            theLichKing->ClearUnitState(UNIT_STATE_CASTING);
                            me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_FINAL);
                        }
                        break;
                    case EVENT_OUTRO_LK_TALK_5:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->AI()->Talk(SAY_LK_OUTRO_5);
                            _events.ScheduleEvent(EVENT_OUTRO_FORDRING_TALK_1, 7000);
                            _events.ScheduleEvent(EVENT_OUTRO_FORDRING_BLESS, 18000);
                            _events.ScheduleEvent(EVENT_OUTRO_FORDRING_REMOVE_ICE, 23000);
                            _events.ScheduleEvent(EVENT_OUTRO_FORDRING_MOVE_1, 25000);
                        }
                        break;
                    case EVENT_OUTRO_LK_TALK_6:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->AI()->Talk(SAY_LK_OUTRO_6);
                            me->SetFacingToObject(theLichKing);
                            theLichKing->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, EQUIP_UNEQUIP);
                            theLichKing->CastSpell((Unit*)NULL, SPELL_SUMMON_BROKEN_FROSTMOURNE_3, true);
                            me->GetMap()->SetZoneOverrideLight(AREA_THE_FROZEN_THRONE, LIGHT_SOULSTORM, 10000);
                            me->GetMap()->SetZoneWeather(AREA_THE_FROZEN_THRONE, WEATHER_STATE_BLACKSNOW, 0.5f);

                            _events.ScheduleEvent(EVENT_OUTRO_AFTER_SUMMON_BROKEN_FROSTMOURNE, 1000);
                            _events.ScheduleEvent(EVENT_OUTRO_KNOCK_BACK, 3000);
                            break;
                        }
                        break;
                    case EVENT_OUTRO_AFTER_SUMMON_BROKEN_FROSTMOURNE:
                        if (Creature* frostmourne = me->FindNearestCreature(NPC_FROSTMOURNE_TRIGGER, 50.0f))
                            frostmourne->CastSpell((Unit*)NULL, SPELL_BROKEN_FROSTMOURNE, true);
                        break;
                    case EVENT_OUTRO_KNOCK_BACK:
                        if (Creature* frostmourne = me->FindNearestCreature(NPC_FROSTMOURNE_TRIGGER, 50.0f))
                            frostmourne->CastSpell((Unit*)NULL, SPELL_BROKEN_FROSTMOURNE_KNOCK, false);
                        break;
                    case EVENT_OUTRO_SOUL_BARRAGE:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            theLichKing->CastSpell((Unit*)NULL, SPELL_SOUL_BARRAGE, TRIGGERED_IGNORE_CAST_IN_PROGRESS);
                            sCreatureTextMgr->SendSound(theLichKing, SOUND_PAIN, CHAT_MSG_MONSTER_YELL, 0, TEXT_RANGE_NORMAL, TEAM_NEUTRAL, false);
                            theLichKing->SetDisableGravity(true);
                            theLichKing->SetByteFlag(UNIT_FIELD_BYTES_1, 3, UNIT_BYTE1_FLAG_ALWAYS_STAND | UNIT_BYTE1_FLAG_HOVER);
                            theLichKing->GetMotionMaster()->MovePoint(0, OutroFlying);
                            
                            _events.ScheduleEvent(EVENT_OUTRO_AFTER_SOUL_BARRAGE, 3000);
                        }
                        break;
                    case EVENT_OUTRO_AFTER_SOUL_BARRAGE:
                        Talk(SAY_TIRION_OUTRO_2);
                        _events.ScheduleEvent(EVENT_OUTRO_SUMMON_TERENAS, 6000);
                        break;
                    case EVENT_OUTRO_SUMMON_TERENAS:
                        if (Creature* frostmourne = me->FindNearestCreature(NPC_FROSTMOURNE_TRIGGER, 50.0f))
                        {
                            frostmourne->CastSpell((Unit*)NULL, SPELL_SUMMON_TERENAS, false);
                            if (Creature* terenas = me->FindNearestCreature(NPC_TERENAS_MENETHIL_OUTRO, 50.0f))
                                terenas->SetFacingToObject(frostmourne);
                        }
                        _events.ScheduleEvent(EVENT_OUTRO_TERENAS_TALK_1, 2000);
                        _events.ScheduleEvent(EVENT_OUTRO_TERENAS_TALK_2, 14000);
                        break;
                    case EVENT_OUTRO_TERENAS_TALK_1:
                        if (Creature* terenas = me->FindNearestCreature(NPC_TERENAS_MENETHIL_OUTRO, 50.0f))
                            terenas->AI()->Talk(SAY_TERENAS_OUTRO_1);
                        break;
                    case EVENT_OUTRO_TERENAS_TALK_2:
                        if (Creature* terenas = me->FindNearestCreature(NPC_TERENAS_MENETHIL_OUTRO, 50.0f))
                        {
                            terenas->AI()->Talk(SAY_TERENAS_OUTRO_2);
                            terenas->CastSpell((Unit*)NULL, SPELL_MASS_RESURRECTION, false);
                            if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            {
                                lichKing->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC);
                                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                                me->RemoveAllAuras();
                                SetEquipmentSlots(true);
                                me->Attack(lichKing, true);
                                me->GetMotionMaster()->MovePoint(0, 512.16f, -2120.25f, 840.86f);
                            }
                            _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_7, 7000);
                            _events.ScheduleEvent(EVENT_OUTRO_LK_TALK_8, 17000);
                        }
                        break;
                    case EVENT_OUTRO_LK_TALK_7:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            theLichKing->AI()->Talk(SAY_LK_OUTRO_7);
                        break;
                    case EVENT_OUTRO_LK_TALK_8:
                        if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
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
                        if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                        {
                            me->SetFacingToObject(lichKing);
                            me->GetMap()->SetZoneMusic(AREA_THE_FROZEN_THRONE, MUSIC_FINAL);
                        }
                        break;
                    case EVENT_OUTRO_FORDRING_MOVE_1:
                        me->GetMotionMaster()->MovePoint(POINT_TIRION_OUTRO, OutroPosition1);
                        break;
                    case EVENT_OUTRO_FORDRING_JUMP:
                        me->CastSpell((Unit*)NULL, SPELL_JUMP, false);
                        break;


                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

            void EnterEvadeMode()
            {
                if (!me->IsAlive())
                    return;

                if (Creature* theLichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                    if (theLichKing->IsInEvadeMode())
                    {
                        ScriptedAI::EnterEvadeMode();
                        return;
                    }

                me->DeleteThreatList();
                me->CombatStop(false);
            }

            bool CanAIAttack(Unit const* target) const
            {
                return target->GetEntry() == NPC_THE_LICH_KING;
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_tirion_fordringAI>(creature);
        }
};

class spell_the_lich_king_quake : public SpellScriptLoader
{
    public:
        spell_the_lich_king_quake() : SpellScriptLoader("spell_the_lich_king_quake") { }

        class spell_the_lich_king_quake_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_quake_SpellScript);

            bool Load()
            {
                return GetCaster()->GetInstanceScript() != nullptr;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                if (GameObject* platform = ObjectAccessor::GetGameObject(*GetCaster(), GetCaster()->GetInstanceScript()->GetData64(DATA_ARTHAS_PLATFORM)))
                    targets.remove_if(HeightDifferenceCheck(platform, 5.0f, false));
            }

            void HandleSendEvent(SpellEffIndex /*effIndex*/)
            {
                if (GetCaster()->IsAIEnabled)
                    GetCaster()->GetAI()->DoAction(ACTION_START_ATTACK);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_quake_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
                OnEffectHit += SpellEffectFn(spell_the_lich_king_quake_SpellScript::HandleSendEvent, EFFECT_1, SPELL_EFFECT_SEND_EVENT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_quake_SpellScript();
        }
};

class spell_the_lich_king_jump : public SpellScriptLoader
{
    public:
        spell_the_lich_king_jump() : SpellScriptLoader("spell_the_lich_king_jump") { }

        class spell_the_lich_king_jump_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_jump_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetHitUnit()->RemoveAurasDueToSpell(SPELL_RAISE_DEAD);
                GetHitUnit()->InterruptNonMeleeSpells(true);
                GetHitUnit()->CastSpell((Unit*)NULL, SPELL_JUMP_2, true);
                if (Creature* creature = GetHitCreature())
                    creature->AI()->DoAction(ACTION_BREAK_FROSTMOURNE);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_jump_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_jump_SpellScript();
        }
};

class spell_the_lich_king_jump_remove_aura : public SpellScriptLoader
{
    public:
        spell_the_lich_king_jump_remove_aura() : SpellScriptLoader("spell_the_lich_king_jump_remove_aura") { }

        class spell_the_lich_king_jump_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_jump_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetHitUnit()->RemoveAurasDueToSpell(uint32(GetEffectValue()));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_jump_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_jump_SpellScript();
        }
};

class spell_the_lich_king_play_movie : public SpellScriptLoader
{
    public:
        spell_the_lich_king_play_movie() : SpellScriptLoader("spell_the_lich_king_play_movie") { }

        class spell_the_lich_king_play_movie_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_play_movie_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
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

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_play_movie_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_play_movie_SpellScript();
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

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_SHOCKWAVE, urand(20000, 25000));
                _events.ScheduleEvent(EVENT_ENRAGE, urand(11000, 14000));
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (!_frenzied && IsHeroic() && me->HealthBelowPctDamaged(20, damage))
                {
                    _frenzied = true;
                    me->CastSpell(me, SPELL_FRENZY, true);
                }
            }

            void UpdateAI(uint32 diff)
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
                        _events.ScheduleEvent(EVENT_SHOCKWAVE, urand(20000, 25000));
                        break;
                    case EVENT_ENRAGE:
                        me->CastSpell(me, SPELL_ENRAGE, false);
                        _events.ScheduleEvent(EVENT_ENRAGE, urand(20000, 25000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

            bool CanAIAttack(Unit const* target) const
            {
                return IsValidPlatformTarget(target) && !target->GetVehicle();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_shambling_horror_iccAI>(creature);
        }
};

class spell_the_lich_king_infest : public SpellScriptLoader
{
    public:
        spell_the_lich_king_infest() :  SpellScriptLoader("spell_the_lich_king_infest") { }

        class spell_the_lich_king_infest_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_infest_AuraScript);

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

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_infest_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
                OnEffectUpdatePeriodic += AuraEffectUpdatePeriodicFn(spell_the_lich_king_infest_AuraScript::OnUpdate, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_infest_AuraScript();
        }
};

class spell_the_lich_king_necrotic_plague : public SpellScriptLoader
{
    public:
        spell_the_lich_king_necrotic_plague() :  SpellScriptLoader("spell_the_lich_king_necrotic_plague") { }

        class spell_the_lich_king_necrotic_plague_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_necrotic_plague_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_NECROTIC_PLAGUE_JUMP))
                    return false;
                return true;
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
                GetTarget()->CastCustomSpell(SPELL_NECROTIC_PLAGUE_JUMP, values, NULL, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());

                if (Unit* caster = GetCaster())
                    caster->CastSpell(caster, SPELL_PLAGUE_SIPHON, true);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_necrotic_plague_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_necrotic_plague_AuraScript();
        }
};

class spell_the_lich_king_necrotic_plague_jump : public SpellScriptLoader
{
    public:
        spell_the_lich_king_necrotic_plague_jump() :  SpellScriptLoader("spell_the_lich_king_necrotic_plague_jump") { }

        class spell_the_lich_king_necrotic_plague_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_necrotic_plague_SpellScript);

            bool Load()
            {
                _hadJumpingAura = false;
                _hadInitialAura = false;
                return true;
            }

            void FilterTargets(std::list<WorldObject*>& targets)
            {
                targets.sort(acore::ObjectDistanceOrderPred(GetCaster()));
                if (targets.size() <= 1)
                    return;

                targets.resize(1);
            }

            void CheckAura()
            {
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

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_necrotic_plague_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
                BeforeHit += SpellHitFn(spell_the_lich_king_necrotic_plague_SpellScript::CheckAura);
                OnHit += SpellHitFn(spell_the_lich_king_necrotic_plague_SpellScript::AddMissingStack);
            }

            bool _hadJumpingAura;
            bool _hadInitialAura;
        };

        class spell_the_lich_king_necrotic_plague_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_necrotic_plague_AuraScript);

            bool Load()
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
                GetTarget()->CastCustomSpell(SPELL_NECROTIC_PLAGUE_JUMP, values, NULL, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());
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
                GetTarget()->CastCustomSpell(SPELL_NECROTIC_PLAGUE_JUMP, values, NULL, TRIGGERED_FULL_MASK, nullptr, nullptr, GetCasterGUID());
                if (Unit* caster = GetCaster())
                    caster->CastSpell(caster, SPELL_PLAGUE_SIPHON, true);

                Remove(AURA_REMOVE_BY_ENEMY_SPELL);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_the_lich_king_necrotic_plague_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
                AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_necrotic_plague_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
                AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_necrotic_plague_AuraScript::OnDispel, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAPPLY);
                AfterEffectApply += AuraEffectApplyFn(spell_the_lich_king_necrotic_plague_AuraScript::AfterDispel, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAPPLY);
            }

            int32 _lastAmount;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_necrotic_plague_SpellScript();
        }

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_necrotic_plague_AuraScript();
        }
};

class spell_the_lich_king_shadow_trap_visual : public SpellScriptLoader
{
    public:
        spell_the_lich_king_shadow_trap_visual() : SpellScriptLoader("spell_the_lich_king_shadow_trap_visual") { }

        class spell_the_lich_king_shadow_trap_visual_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_shadow_trap_visual_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
                    GetTarget()->CastSpell(GetTarget(), SPELL_SHADOW_TRAP_AURA, TRIGGERED_NONE);
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_shadow_trap_visual_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_shadow_trap_visual_AuraScript();
        }
};

class spell_the_lich_king_shadow_trap_periodic : public SpellScriptLoader
{
    public:
        spell_the_lich_king_shadow_trap_periodic() : SpellScriptLoader("spell_the_lich_king_shadow_trap_periodic") { }

        class spell_the_lich_king_shadow_trap_periodic_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_shadow_trap_periodic_SpellScript);

            void CheckTargetCount(std::list<WorldObject*>& targets)
            {
                if (targets.empty())
                    return;

                GetCaster()->CastSpell((Unit*)NULL, SPELL_SHADOW_TRAP_KNOCKBACK, true);
                if (Aura* a = GetCaster()->GetAura(SPELL_SHADOW_TRAP_AURA))
                    a->SetDuration(0);
                if (GetCaster()->GetTypeId() == TYPEID_UNIT)
                    GetCaster()->ToCreature()->DespawnOrUnsummon(3000);

            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_shadow_trap_periodic_SpellScript::CheckTargetCount, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_shadow_trap_periodic_SpellScript();
        }
};

class spell_the_lich_king_ice_burst_target_search : public SpellScriptLoader
{
    public:
        spell_the_lich_king_ice_burst_target_search() : SpellScriptLoader("spell_the_lich_king_ice_burst_target_search") { }

        class spell_the_lich_king_ice_burst_target_search_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_ice_burst_target_search_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_ICE_BURST))
                    return false;
                return true;
            }

            void CheckTargetCount(std::list<WorldObject*>& unitList)
            {
                if (unitList.empty())
                    return;

                if (GetCaster()->GetTypeId() == TYPEID_UNIT)
                    GetCaster()->ToCreature()->AI()->DoAction(-1);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_ice_burst_target_search_SpellScript::CheckTargetCount, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_ice_burst_target_search_SpellScript();
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
                targetGUID = 0;
                timer = 250;
                me->SetReactState(REACT_PASSIVE);
            }

            uint64 targetGUID;
            uint16 timer;

            void DoAction(int32 a)
            {
                if (a == -1)
                {
                    me->RemoveAllAuras();
                    me->CastSpell(me, SPELL_ICE_BURST, true);
                    me->DespawnOrUnsummon(1000);
                    targetGUID = 0;
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
                targetGUID = 0;
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

            void UpdateAI(uint32 diff)
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
                    if (me->GetVictim()->GetGUID() != targetGUID || !target || !me->IsValidAttackTarget(target) || target->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || target->GetExactDist2dSq(&CenterPosition) > 75.0f*75.0f || target->GetPositionZ() < 830.0f || target->GetPositionZ() > 855.0f)
                        SelectNewTarget();
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_icc_ice_sphereAI>(creature);
        }
};

class spell_the_lich_king_raging_spirit : public SpellScriptLoader
{
    public:
        spell_the_lich_king_raging_spirit() : SpellScriptLoader("spell_the_lich_king_raging_spirit") { }

        class spell_the_lich_king_raging_spirit_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_raging_spirit_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (Unit* target = GetHitUnit())
                    target->CastSpell(target, uint32(GetEffectValue()), true, 0, 0, target->GetGUID());
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_raging_spirit_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_raging_spirit_SpellScript();
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

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_RAGING_SPIRIT_UNROOT, 3000);
                _events.ScheduleEvent(EVENT_SOUL_SHRIEK, urand(12000, 15000));

                bool valid = false;
                me->CastSpell(me, SPELL_RAGING_SPIRIT_VISUAL, true);
                if (TempSummon* summon = me->ToTempSummon())
                    if (Unit* summoner = summon->GetSummoner())
                        if (summoner->GetTypeId() == TYPEID_PLAYER && summoner->IsAlive() && !summoner->ToPlayer()->IsBeingTeleported() && summoner->FindMap() == me->GetMap())
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

            void IsSummonedBy(Unit* /*summoner*/)
            {
                // player is the spellcaster so register summon manually
                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                    lichKing->AI()->JustSummoned(me);
            }

            void JustDied(Unit* /*killer*/)
            {
                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                    lichKing->AI()->SummonedCreatureDespawn(me);
                if (TempSummon* summon = me->ToTempSummon())
                {
                    summon->SetTimer(5000);
                    summon->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN);
                }
            }

            void AttackStart(Unit* who)
            {
                if (!me->HasUnitState(UNIT_STATE_ROOT))
                    ScriptedAI::AttackStart(who);
            }

            void UpdateAI(uint32 diff)
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

                            if (!me->getThreatManager().isThreatListEmpty())
                                if (Unit* target = me->SelectVictim())
                                    AttackStart(target);
                            if (!me->GetVictim())
                            {
                                bool valid = false;
                                if (TempSummon* summon = me->ToTempSummon())
                                    if (Unit* summoner = summon->GetSummoner())
                                        if (summoner->GetTypeId() == TYPEID_PLAYER && summoner->IsAlive() && !summoner->ToPlayer()->IsBeingTeleported() && summoner->FindMap() == me->GetMap())
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
                        _events.ScheduleEvent(EVENT_SOUL_SHRIEK, urand(12000, 15000));
                        break;
                    default:
                        break;
                }

                if (!me->HasUnitState(UNIT_STATE_ROOT))
                    DoMeleeAttackIfReady();
            }

            bool CanAIAttack(Unit const* target) const
            {
                return IsValidPlatformTarget(target) && !target->GetVehicle();
            }

        private:
            EventMap _events;
            InstanceScript* _instance;
        };

        CreatureAI* GetAI(Creature* creature) const
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

class spell_the_lich_king_defile : public SpellScriptLoader
{
    public:
        spell_the_lich_king_defile() : SpellScriptLoader("spell_the_lich_king_defile") { }

        class spell_the_lich_king_defile_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_defile_SpellScript);

            void CorrectRange(std::list<WorldObject*>& targets)
            {
                targets.remove_if(VehicleCheck());
                targets.remove_if(acore::AllWorldObjectsInExactRange(GetCaster(), 10.0f * GetCaster()->GetFloatValue(OBJECT_FIELD_SCALE_X), true));
                uint32 strangulatedAura[4] = {68980, 74325, 74296, 74297};
                targets.remove_if(acore::UnitAuraCheck(true, strangulatedAura[GetCaster()->GetMap()->GetDifficulty()]));
            }

            void ChangeDamageAndGrow()
            {
                SetHitDamage(int32(GetHitDamage() * GetCaster()->GetFloatValue(OBJECT_FIELD_SCALE_X)));
                // HACK: target player should cast this spell on defile
                // however with current aura handling auras cast by different units
                // cannot stack on the same aura object increasing the stack count
                GetCaster()->CastSpell(GetCaster(), SPELL_DEFILE_GROW, true);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_defile_SpellScript::CorrectRange, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_defile_SpellScript::CorrectRange, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
                OnHit += SpellHitFn(spell_the_lich_king_defile_SpellScript::ChangeDamageAndGrow);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_defile_SpellScript();
        }
};

class spell_the_lich_king_soul_reaper : public SpellScriptLoader
{
    public:
        spell_the_lich_king_soul_reaper() :  SpellScriptLoader("spell_the_lich_king_soul_reaper") { }

        class spell_the_lich_king_soul_reaper_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_soul_reaper_AuraScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_SOUL_REAPER_BUFF))
                    return false;
                return true;
            }

            void OnPeriodic(AuraEffect const* /*aurEff*/)
            {
                if (Unit* caster = GetCaster())
                    GetTarget()->CastSpell(caster, SPELL_SOUL_REAPER_BUFF, true);
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_soul_reaper_AuraScript::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_soul_reaper_AuraScript();
        }
};

class npc_valkyr_shadowguard : public CreatureScript
{
    public:
        npc_valkyr_shadowguard() : CreatureScript("npc_valkyr_shadowguard") { }

        struct npc_valkyr_shadowguardAI : public NullCreatureAI
        {
            npc_valkyr_shadowguardAI(Creature* creature) : NullCreatureAI(creature), _grabbedPlayer(0), didbelow50pct(false), dropped(false), _instance(creature->GetInstanceScript())
            {
                me->SetReactState(REACT_PASSIVE);
                me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
                me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, true);
                _events.Reset();
                _events.ScheduleEvent(EVENT_GRAB_PLAYER, 2500);
                me->SetWalk(false);
            }

            EventMap _events;
            Position _destPoint;
            uint64 _grabbedPlayer;
            bool didbelow50pct;
            bool dropped;
            InstanceScript* _instance;

            bool IsHeroic() { return me->GetMap()->IsHeroic(); }

            void GoSiphon()
            {
                didbelow50pct = true;
                me->CastSpell((Unit*)NULL, SPELL_EJECT_ALL_PASSENGERS, false);
                float dist = rand_norm()*10.0f + 5.0f;
                float angle = CenterPosition.GetAngle(me);
                _destPoint.Relocate(CenterPosition.GetPositionX()+dist*cos(angle), CenterPosition.GetPositionY()+dist*sin(angle), 855.0f+frand(0.0f, 4.0f), 0.0f);
                me->SetHomePosition(_destPoint);
                _events.Reset();
                _events.ScheduleEvent(EVENT_MOVE_TO_SIPHON_POS, 0);
            }

            void OnCharmed(bool  /*apply*/) {}

            void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply)
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

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (IsHeroic() && !didbelow50pct && !dropped && me->HealthBelowPctDamaged(50, damage))
                    GoSiphon();
            }

            void MovementInform(uint32 type, uint32 id)
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
                                if (GameObject* platform = ObjectAccessor::GetGameObject(*me, _instance->GetData64(DATA_ARTHAS_PLATFORM)))
                                {
                                    std::list<Creature*> triggers;
                                    GetCreatureListWithEntryInGrid(triggers, me, NPC_WORLD_TRIGGER, 150.0f);
                                    triggers.remove_if(HeightDifferenceCheck(platform, 5.0f, true));
                                    if (!triggers.empty())
                                    {
                                        valid = true;
                                        triggers.sort(acore::ObjectDistanceOrderPred(me));

                                        target->GetMotionMaster()->Clear();
                                        target->UpdatePosition(*me, true);
                                        target->StopMovingOnCurrentPos();

                                        me->CastSpell(target, SPELL_VALKYR_CARRY, false);
                                        _destPoint.Relocate(triggers.front());
                                        _events.Reset();
                                        _events.ScheduleEvent(EVENT_MOVE_TO_DROP_POS, 1000);
                                    }
                                }
                        if (!valid)
                        {
                            _events.Reset();
                            _events.ScheduleEvent(EVENT_GRAB_PLAYER, 500);
                            _grabbedPlayer = 0;
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
                                _events.ScheduleEvent(EVENT_MOVE_TO_DROP_POS, 0);
                                break;
                            }
                            dropped = true;
                            _events.Reset();
                            /*Player* p = nullptr;
                            if (Vehicle* v = me->GetVehicleKit())
                                if (Unit* passenger = v->GetPassenger(0))
                                    p = passenger->ToPlayer();*/
                            me->CastSpell((Unit*)NULL, SPELL_EJECT_ALL_PASSENGERS, false);

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
                            _events.ScheduleEvent(EVENT_MOVE_TO_SIPHON_POS, 0);
                            break;
                        }
                        me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, false);
                        me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_ATTACK_ME, false);
                        _events.ScheduleEvent(EVENT_LIFE_SIPHON, 2000);
                        break;
                }
            }

            void SetGUID(uint64 guid, int32 /* = 0*/)
            {
                _grabbedPlayer = guid;
            }

            void UpdateAI(uint32 diff)
            {
                _events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_STUNNED))
                    return;

                switch (_events.ExecuteEvent())
                {
                    case EVENT_GRAB_PLAYER:
                        if (!_grabbedPlayer)
                        {
                            me->CastSpell((Unit*)NULL, SPELL_VALKYR_TARGET_SEARCH, false);
                            _events.ScheduleEvent(EVENT_GRAB_PLAYER, 2000);
                        }
                        break;
                    case EVENT_MOVE_TO_DROP_POS:
                        me->AddUnitState(UNIT_STATE_NO_ENVIRONMENT_UPD);
                        me->SetDisableGravity(false);
                        me->SetHover(false);
                        me->SetCanFly(false);
                        me->GetMotionMaster()->MovePoint(POINT_DROP_PLAYER, _destPoint, false);
                        me->SetDisableGravity(true, true);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        break;
                    case EVENT_MOVE_TO_SIPHON_POS:
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE); // just in case if passenger disappears so quickly that EVENT_MOVE_TO_DROP_POS is never executed
                        { int32 bp0 = 80; me->CastCustomSpell(me, 1557, &bp0, nullptr, nullptr, true); }
                        me->SetDisableGravity(true);
                        me->SetHover(true);
                        me->SetCanFly(true);
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
                                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                                    target = lichKing->AI()->SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankLKTargetSelector(lichKing, true, false, 100.0f));
                            if (target)
                                me->CastSpell(target, SPELL_LIFE_SIPHON, false);
                            _events.ScheduleEvent(EVENT_LIFE_SIPHON, 2500);
                        }
                        break;
                    default:
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_valkyr_shadowguardAI>(creature);
        }
};

class spell_the_lich_king_summon_into_air : public SpellScriptLoader
{
    public:
        spell_the_lich_king_summon_into_air() : SpellScriptLoader("spell_the_lich_king_summon_into_air") { }

        class spell_the_lich_king_summon_into_air_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_summon_into_air_SpellScript);

            void ModDestHeight(SpellEffIndex effIndex)
            {
                float addZ;
                switch (GetSpellInfo()->Effects[effIndex].MiscValue)
                {
                    case NPC_SPIRIT_BOMB: addZ = 30.0f; break;
                    case NPC_VILE_SPIRIT: addZ = 13.0f; break;
                    default: addZ = 15.0f; break;
                }
                Position const offset = {0.0f, 0.0f, addZ, 0.0f};
                WorldLocation* dest = const_cast<WorldLocation*>(GetExplTargetDest());
                dest->RelocateOffset(offset);
                GetHitDest()->RelocateOffset(offset);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_the_lich_king_summon_into_air_SpellScript::ModDestHeight, EFFECT_0, SPELL_EFFECT_SUMMON);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_summon_into_air_SpellScript();
        }
};

class spell_the_lich_king_teleport_to_frostmourne_hc : public SpellScriptLoader
{
    public:
        spell_the_lich_king_teleport_to_frostmourne_hc() : SpellScriptLoader("spell_the_lich_king_teleport_to_frostmourne_hc") { }

        class spell_the_lich_king_teleport_to_frostmourne_hc_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_teleport_to_frostmourne_hc_SpellScript);

            void ModDest(SpellEffIndex  /*effIndex*/)
            {
                float dist = 2.0f + rand_norm()*18.0f;
                float angle = rand_norm()*2*M_PI;
                Position const offset = {dist*cos(angle), dist*sin(angle), 0.0f, 0.0f};
                WorldLocation* dest = const_cast<WorldLocation*>(GetExplTargetDest());
                dest->RelocateOffset(offset);
                GetHitDest()->RelocateOffset(offset);
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_the_lich_king_teleport_to_frostmourne_hc_SpellScript::ModDest, EFFECT_1, SPELL_EFFECT_TELEPORT_UNITS);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_teleport_to_frostmourne_hc_SpellScript();
        }
};

class spell_the_lich_king_valkyr_target_search : public SpellScriptLoader
{
    public:
        spell_the_lich_king_valkyr_target_search() : SpellScriptLoader("spell_the_lich_king_valkyr_target_search") { }

        class spell_the_lich_king_valkyr_target_search_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_valkyr_target_search_SpellScript);

            WorldObject* _target;

            bool Load()
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
                targets.remove_if(acore::UnitAuraCheck(true, GetSpellInfo()->Id));
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_BOSS_HITTIN_YA_AURA)); // done in dbc, but just to be sure xd
                targets.remove_if(acore::UnitAuraCheck(true, SPELL_HARVEST_SOUL_VALKYR));
                if (InstanceScript* _instance = caster->GetInstanceScript())
                    if (Creature* lichKing = ObjectAccessor::GetCreature(*caster, _instance->GetData64(DATA_THE_LICH_KING)))
                        if (Spell* s = lichKing->GetCurrentSpell(CURRENT_GENERIC_SPELL))
                            if (s->GetSpellInfo()->Id == SPELL_DEFILE && s->m_targets.GetUnitTarget())
                                targets.remove(s->m_targets.GetUnitTarget());

                if (targets.empty())
                    return;

                _target = acore::Containers::SelectRandomContainerElement(targets);
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
                    GetCaster()->GetMotionMaster()->MoveCharge(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ()+4.0f, 42.0f, EVENT_CHARGE);
                    GetCaster()->SetDisableGravity(true, true);
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_valkyr_target_search_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_valkyr_target_search_SpellScript::ReplaceTarget, EFFECT_1, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_valkyr_target_search_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_valkyr_target_search_SpellScript();
        }
};

class spell_the_lich_king_cast_back_to_caster : public SpellScriptLoader
{
    public:
        spell_the_lich_king_cast_back_to_caster() :  SpellScriptLoader("spell_the_lich_king_cast_back_to_caster") { }

        class spell_the_lich_king_cast_back_to_caster_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_cast_back_to_caster_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                GetHitUnit()->CastSpell(GetCaster(), uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_cast_back_to_caster_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_cast_back_to_caster_SpellScript();
        }
};

class spell_the_lich_king_life_siphon : public SpellScriptLoader
{
    public:
        spell_the_lich_king_life_siphon() : SpellScriptLoader("spell_the_lich_king_life_siphon") { }

        class spell_the_lich_king_life_siphon_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_life_siphon_SpellScript);

            bool Validate(SpellInfo const* /*spell*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_LIFE_SIPHON_HEAL))
                    return false;
                return true;
            }

            void TriggerHeal()
            {
                GetHitUnit()->CastCustomSpell(SPELL_LIFE_SIPHON_HEAL, SPELLVALUE_BASE_POINT0, GetHitDamage() * 10, GetCaster(), true);
            }

            void Register()
            {
                AfterHit += SpellHitFn(spell_the_lich_king_life_siphon_SpellScript::TriggerHeal);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_life_siphon_SpellScript();
        }
};

class spell_the_lich_king_vile_spirits : public SpellScriptLoader
{
    public:
        spell_the_lich_king_vile_spirits() : SpellScriptLoader("spell_the_lich_king_vile_spirits") { }

        class spell_the_lich_king_vile_spirits_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_vile_spirits_AuraScript);

            bool Load()
            {
                _is25Man = GetUnitOwner()->GetMap()->Is25ManRaid();
                return true;
            }

            void OnPeriodic(AuraEffect const* aurEff)
            {
                if (_is25Man || ((aurEff->GetTickNumber() - 1) % 5))
                    GetTarget()->CastSpell((Unit*)NULL, GetSpellInfo()->Effects[aurEff->GetEffIndex()].TriggerSpell, true, NULL, aurEff, GetCasterGUID());
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_vile_spirits_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }

            bool _is25Man;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_vile_spirits_AuraScript();
        }
};

class spell_the_lich_king_vile_spirits_visual : public SpellScriptLoader
{
    public:
        spell_the_lich_king_vile_spirits_visual() : SpellScriptLoader("spell_the_lich_king_vile_spirits_visual") { }

        class spell_the_lich_king_vile_spirits_visual_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_vile_spirits_visual_SpellScript);

            void ModDestHeight(SpellEffIndex /*effIndex*/)
            {
                Position offset = {0.0f, 0.0f, 15.0f, 0.0f};
                const_cast<WorldLocation*>(GetExplTargetDest())->RelocateOffset(offset);
            }

            void Register()
            {
                OnEffectLaunch += SpellEffectFn(spell_the_lich_king_vile_spirits_visual_SpellScript::ModDestHeight, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_vile_spirits_visual_SpellScript();
        }
};

class spell_the_lich_king_vile_spirit_move_target_search : public SpellScriptLoader
{
    public:
        spell_the_lich_king_vile_spirit_move_target_search() : SpellScriptLoader("spell_the_lich_king_vile_spirit_move_target_search") { }

        class spell_the_lich_king_vile_spirit_move_target_search_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_vile_spirit_move_target_search_SpellScript);

            bool Load()
            {
                _target = nullptr;
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void SelectTarget(std::list<WorldObject*>& targets)
            {
                if (targets.empty())
                    return;

                _target = acore::Containers::SelectRandomContainerElement(targets);
            }

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                if (GetHitUnit() != _target)
                    return;

                GetCaster()->ToCreature()->SetInCombatWithZone();
                GetCaster()->ToCreature()->AI()->AttackStart(GetHitUnit());
                GetCaster()->AddThreat(GetHitUnit(), GetCaster()->GetMaxHealth()*0.2f);
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_vile_spirit_move_target_search_SpellScript::SelectTarget, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_vile_spirit_move_target_search_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }

            WorldObject* _target;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_vile_spirit_move_target_search_SpellScript();
        }
};

class spell_the_lich_king_vile_spirit_damage_target_search : public SpellScriptLoader
{
    public:
        spell_the_lich_king_vile_spirit_damage_target_search() : SpellScriptLoader("spell_the_lich_king_vile_spirit_damage_target_search") { }

        class spell_the_lich_king_vile_spirit_damage_target_search_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_vile_spirit_damage_target_search_SpellScript);

            void CheckTargetCount(std::list<WorldObject*>& targets)
            {
                if (targets.empty())
                    return;

                if (TempSummon* summon = GetCaster()->ToTempSummon())
                    if (Unit* summoner = summon->GetSummoner())
                        summoner->GetAI()->SetData(DATA_VILE, 1);

                if (Creature* c = GetCaster()->ToCreature())
                {
                    c->RemoveAurasDueToSpell(SPELL_VILE_SPIRIT_DAMAGE_SEARCH);
                    c->GetMotionMaster()->Clear(true);
                    c->StopMoving();
                    c->CastSpell((Unit*)NULL, SPELL_SPIRIT_BURST, true);
                    c->DespawnOrUnsummon(3000);
                    c->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                }
            }

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_vile_spirit_damage_target_search_SpellScript::CheckTargetCount, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_vile_spirit_damage_target_search_SpellScript();
        }
};

class spell_the_lich_king_harvest_soul : public SpellScriptLoader
{
    public:
        spell_the_lich_king_harvest_soul() : SpellScriptLoader("spell_the_lich_king_harvest_soul") { }

        class spell_the_lich_king_harvest_soul_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_harvest_soul_AuraScript);

            bool Load()
            {
                return GetOwner()->GetInstanceScript() != nullptr;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                // m_originalCaster to allow stacking from different casters, meh
                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
                    GetTarget()->CastSpell((Unit*)NULL, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, GetTarget()->GetInstanceScript()->GetData64(DATA_THE_LICH_KING));
            }

            void Register()
            {
                AfterEffectRemove += AuraEffectRemoveFn(spell_the_lich_king_harvest_soul_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_harvest_soul_AuraScript();
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

            void IsSummonedBy(Unit* summoner)
            {
                if (!summoner)
                    return;

                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                {
                    me->SetWalk(false);
                    Movement::PointsArray path;
                    path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                    path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), 843.0f));
                    me->GetMotionMaster()->MoveSplinePath(&path);

                    uint64 petGUID = summoner->GetPetGUID();
                    summoner->SetPetGUID(0);
                    summoner->StopMoving();
                    me->CastSpell(summoner, SPELL_HARVEST_SOUL_VEHICLE, true);
                    //summoner->ClearUnitState(UNIT_STATE_ONVEHICLE);
                    summoner->SendMovementFlagUpdate(true);
                    summoner->SetPetGUID(petGUID);
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_MOVE_TO_LICH_KING, 1000);
                    _events.ScheduleEvent(EVENT_TELEPORT, 6250);
                    _events.ScheduleEvent(EVENT_DESPAWN_SELF, 6000+70000);

                    // this will let us easily access all creatures of this entry on heroic mode when its time to teleport back
                    lichKing->AI()->JustSummoned(me);
                }
            }

            bool IsHeroic() { return me->GetMap()->IsHeroic(); }
            void OnCharmed(bool  /*apply*/) {}
            void PassengerBoarded(Unit* pass, int8  /*seat*/, bool apply)
            {
                if (!apply)
                    pass->RemoveAurasDueToSpell(VEHICLE_SPELL_PARACHUTE);
            }

            void DoAction(int32 action)
            {
                if (action != ACTION_TELEPORT_BACK)
                    return;

                if (TempSummon* summ = me->ToTempSummon())
                {
                    if (Unit* summoner = summ->GetSummoner())
                    {
                        bool buff = _instance->GetBossState(DATA_THE_LICH_KING) == IN_PROGRESS && summoner->GetTypeId() == TYPEID_PLAYER && (!summoner->IsAlive() || summoner->ToPlayer()->IsBeingTeleported() || summoner->FindMap() != me->GetMap());
                        if (summoner->GetTypeId() == TYPEID_PLAYER && !summoner->ToPlayer()->IsBeingTeleported() && summoner->FindMap() == me->GetMap())
                        {
                            if (buff)
                                summoner->CastSpell((Unit*)NULL, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, _instance->GetData64(DATA_THE_LICH_KING));

                            me->CastSpell(summoner, SPELL_HARVEST_SOUL_TELEPORT_BACK, false);
                        }
                        else if (buff)
                            me->CastSpell((Unit*)NULL, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, _instance->GetData64(DATA_THE_LICH_KING));

                        summoner->RemoveAurasDueToSpell(IsHeroic() ? SPELL_HARVEST_SOULS_TELEPORT : SPELL_HARVEST_SOUL_TELEPORT);
                    }
                    else
                        me->CastSpell((Unit*)NULL, SPELL_HARVESTED_SOUL_LK_BUFF, true, nullptr, nullptr, _instance->GetData64(DATA_THE_LICH_KING));
                }

                _events.Reset();
                me->RemoveAllAuras();
                me->DespawnOrUnsummon(500);

                if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                    lichKing->AI()->SummonedCreatureDespawn(me);
            }

            void UpdateAI(uint32 diff)
            {
                _events.Update(diff);

                switch (_events.ExecuteEvent())
                {
                    case EVENT_TELEPORT:
                        me->GetMotionMaster()->Clear(false);
                        me->GetMotionMaster()->MoveIdle();
                        if (TempSummon* summ = me->ToTempSummon())
                            if (Unit* summoner = summ->GetSummoner())
                            {
                                if (summoner->IsAlive() && summoner->GetTypeId() == TYPEID_PLAYER)
                                {
                                    summoner->CastSpell((Unit*)NULL, SPELL_HARVEST_SOUL_VISUAL, true);
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
                                    _events.RescheduleEvent(EVENT_DESPAWN_SELF, 0);
                                }
                            }
                        break;
                    case EVENT_MOVE_TO_LICH_KING:
                        if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            if (me->GetExactDist(lichKing) > 8.0f)
                            {
                                float dist = float(rand_norm()) * 5.0f + 8.0f;
                                float angle = lichKing->GetAngle(me);
                                Movement::PointsArray path;
                                path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
                                path.push_back(G3D::Vector3(lichKing->GetPositionX()+dist*cos(angle), lichKing->GetPositionY()+dist*sin(angle), 843.0f));
                                me->GetMotionMaster()->MoveSplinePath(&path);
                            }
                        break;
                    case EVENT_DESPAWN_SELF:
                        if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            lichKing->AI()->SummonedCreatureDespawn(me);
                        me->DespawnOrUnsummon(1);
                        break;
                    default:
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
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

            void DoAction(int32 action)
            {
                switch (action)
                {
                    case ACTION_FROSTMOURNE_INTRO:
                        me->SetControlled(true, UNIT_STATE_ROOT);
                        me->setActive(true);
                        _events.Reset();
                        _events.ScheduleEvent(EVENT_FROSTMOURNE_TALK_1, 2000);
                        _events.ScheduleEvent(EVENT_FROSTMOURNE_TALK_2, 11000);
                        if (!IsHeroic())
                        {
                            me->SetHealth(me->GetMaxHealth() / 2);
                            _events.ScheduleEvent(EVENT_DESTROY_SOUL, 60000);
                            _events.ScheduleEvent(EVENT_FROSTMOURNE_TALK_3, 25000);
                        }
                        break;
                    case ACTION_TELEPORT_BACK:
                        if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                        {
                            _events.Reset();
                            me->CastSpell((Unit*)NULL, SPELL_RESTORE_SOUL, false);
                            me->DespawnOrUnsummon(3000);
                        }
                        break;
                }
            }

            void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
            {
                if (damage >= me->GetHealth())
                {
                    damage = me->GetHealth() - 1;
                    if (IsHeroic())
                        return;
                    if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
                    {
                        _events.Reset();
                        _events.ScheduleEvent(EVENT_TELEPORT_BACK, 1000);
                        if (Creature* warden = me->FindNearestCreature(NPC_SPIRIT_WARDEN, 20.0f))
                        {
                            warden->CastSpell((Unit*)NULL, SPELL_DESTROY_SOUL, false);
                            warden->DespawnOrUnsummon(2000);
                        }
                        me->CastSpell(me, SPELL_TERENAS_LOSES_INSIDE, false);
                        me->SetDisplayId(16946);
                        me->SetReactState(REACT_PASSIVE);
                        me->AttackStop();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        me->DespawnOrUnsummon(2000);
                    }
                }
            }

            void UpdateAI(uint32 diff)
            {
                UpdateVictim();

                _events.Update(diff);

                switch (_events.ExecuteEvent())
                {
                    case EVENT_FROSTMOURNE_TALK_1:
                        me->SetControlled(false, UNIT_STATE_ROOT);
                        Talk(SAY_TERENAS_INTRO_1);
                        if (IsHeroic())
                            me->CastSpell((Unit*)NULL, SPELL_RESTORE_SOULS, false);
                        break;
                    case EVENT_FROSTMOURNE_TALK_2:
                        Talk(SAY_TERENAS_INTRO_2);
                        break;
                    case EVENT_FROSTMOURNE_TALK_3:
                        Talk(SAY_TERENAS_INTRO_3);
                        break;
                    case EVENT_DESTROY_SOUL:
                        if (Creature* warden = me->FindNearestCreature(NPC_SPIRIT_WARDEN, 20.0f))
                            warden->CastSpell((Unit*)NULL, SPELL_DESTROY_SOUL, false);
                        me->CastSpell(me, SPELL_TERENAS_LOSES_INSIDE, false);
                        me->SetDisplayId(16946);
                        me->SetReactState(REACT_PASSIVE);
                        me->AttackStop();
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        _events.Reset();
                        _events.ScheduleEvent(EVENT_TELEPORT_BACK, 1000);
                        break;
                    case EVENT_TELEPORT_BACK:
                        if (Creature* lichKing = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_THE_LICH_KING)))
                            lichKing->AI()->DoAction(ACTION_TELEPORT_BACK);
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

            bool CanAIAttack(Unit const* target) const
            {
                return target->GetEntry() != NPC_THE_LICH_KING;
            }

            void EnterEvadeMode()
            {
                if (!me->IsAlive())
                    return;

                me->DeleteThreatList();
                me->CombatStop(false);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_terenas_menethilAI>(creature);
        }
};

class spell_the_lich_king_lights_favor : public SpellScriptLoader
{
    public:
        spell_the_lich_king_lights_favor() : SpellScriptLoader("spell_the_lich_king_lights_favor") { }

        class spell_the_lich_king_lights_favor_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_lights_favor_AuraScript);

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

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_lights_favor_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_HEAL);
                DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_the_lich_king_lights_favor_AuraScript::CalculateBonus, EFFECT_1, SPELL_AURA_MOD_DAMAGE_PERCENT_DONE);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_lights_favor_AuraScript();
        }
};

class spell_the_lich_king_restore_soul : public SpellScriptLoader
{
    public:
        spell_the_lich_king_restore_soul() : SpellScriptLoader("spell_the_lich_king_restore_soul") { }

        class spell_the_lich_king_restore_soul_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_restore_soul_SpellScript);

            bool Load()
            {
                _instance = GetCaster()->GetInstanceScript();
                return _instance != nullptr;
            }

            void FilterTargets(std::list<WorldObject*>& unitList)
            {
                for (std::list<WorldObject*>::const_iterator itr = unitList.begin(); itr != unitList.end(); ++itr)
                    if (Unit* target = (*itr)->ToUnit())
                        target->RemoveAurasDueToSpell(target->GetMap()->IsHeroic() ? SPELL_HARVEST_SOULS_TELEPORT : SPELL_HARVEST_SOUL_TELEPORT);
                if (Creature* lichKing = ObjectAccessor::GetCreature(*GetCaster(), _instance->GetData64(DATA_THE_LICH_KING)))
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

            void Register()
            {
                OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_the_lich_king_restore_soul_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            }

            InstanceScript* _instance;
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_restore_soul_SpellScript();
        }
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

            void Reset()
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_SOUL_RIP, urand(12000, 15000));
            }

            void JustDied(Unit* /*killer*/)
            {
                if (Creature* terenas = ObjectAccessor::GetCreature(*me, _instance->GetData64(DATA_TERENAS_MENETHIL)))
                    terenas->AI()->DoAction(ACTION_TELEPORT_BACK);
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (_events.ExecuteEvent() == EVENT_SOUL_RIP)
                {
                    me->CastSpell(me->GetVictim(), SPELL_SOUL_RIP, false);
                    _events.ScheduleEvent(EVENT_SOUL_RIP, urand(23000, 27000));
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_spirit_wardenAI>(creature);
        }
};

class spell_the_lich_king_dark_hunger : public SpellScriptLoader
{
    public:
        spell_the_lich_king_dark_hunger() : SpellScriptLoader("spell_the_lich_king_dark_hunger") { }

        class spell_the_lich_king_dark_hunger_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_dark_hunger_AuraScript);

            bool Validate(SpellInfo const* /*spellInfo*/)
            {
                if (!sSpellMgr->GetSpellInfo(SPELL_DARK_HUNGER_HEAL))
                    return false;
                return true;
            }

            void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
            {
                PreventDefaultAction();
                int32 heal = int32(eventInfo.GetDamageInfo()->GetDamage() / 2);
                GetTarget()->CastCustomSpell(SPELL_DARK_HUNGER_HEAL, SPELLVALUE_BASE_POINT0, heal, GetTarget(), true, NULL, aurEff);
            }

            void Register()
            {
                OnEffectProc += AuraEffectProcFn(spell_the_lich_king_dark_hunger_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_dark_hunger_AuraScript();
        }
};

class spell_the_lich_king_soul_rip : public SpellScriptLoader
{
    public:
        spell_the_lich_king_soul_rip() : SpellScriptLoader("spell_the_lich_king_soul_rip") { }

        class spell_the_lich_king_soul_rip_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_the_lich_king_soul_rip_AuraScript);

            void OnPeriodic(AuraEffect const* aurEff)
            {
                PreventDefaultAction();
                // shouldn't be needed, this is channeled
                if (Unit* caster = GetCaster())
                    caster->CastCustomSpell(SPELL_SOUL_RIP_DAMAGE, SPELLVALUE_BASE_POINT0, 5000 * aurEff->GetTickNumber(), GetTarget(), true, NULL, aurEff, GetCasterGUID());
            }

            void Register()
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_the_lich_king_soul_rip_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_the_lich_king_soul_rip_AuraScript();
        }
};

class npc_icc_lk_checktarget : public CreatureScript
{
    public:
        npc_icc_lk_checktarget() : CreatureScript("npc_icc_lk_checktarget") { }

        struct npc_icc_lk_checktargetAI : public ScriptedAI
        {
            npc_icc_lk_checktargetAI(Creature* creature) : ScriptedAI(creature) {}

            bool CanAIAttack(Unit const* target) const
            {
                return IsValidPlatformTarget(target) && !target->GetVehicle();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_icc_lk_checktargetAI>(creature);
        }
};

class spell_the_lich_king_summon_spirit_bomb : public SpellScriptLoader
{
    public:
        spell_the_lich_king_summon_spirit_bomb() : SpellScriptLoader("spell_the_lich_king_summon_spirit_bomb") { }

        class spell_the_lich_king_summon_spirit_bomb_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_summon_spirit_bomb_SpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                GetHitUnit()->CastSpell((Unit*)NULL, uint32(GetEffectValue()), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_the_lich_king_summon_spirit_bomb_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_summon_spirit_bomb_SpellScript();
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

            void IsSummonedBy(Unit* /*summoner*/)
            {
                float destX, destY, destZ;
                me->GetPosition(destX, destY);
                destZ = 1055.0f;    // approximation, gets more precise later
                me->UpdateGroundPositionZ(destX, destY, destZ);
                me->SetWalk(false);
                me->GetMotionMaster()->MovePoint(POINT_GROUND, destX, destY, destZ);
            }

            void MovementInform(uint32 type, uint32 point)
            {
                if (type != POINT_MOTION_TYPE || point != POINT_GROUND)
                    return;

                timer = 1000;
            }

            void UpdateAI(uint32 diff)
            {
                if (timer)
                {
                    if (timer <= diff)
                    {
                        timer = 0;
                        me->RemoveAllAuras();
                        me->CastSpell((Unit*)NULL, SPELL_EXPLOSION, false);
                        me->DespawnOrUnsummon(1000);
                    }
                    else
                        timer -= diff;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_lk_spirit_bombAI>(creature);
        }
};

class spell_the_lich_king_trigger_vile_spirit : public SpellScriptLoader
{
    public:
        spell_the_lich_king_trigger_vile_spirit() : SpellScriptLoader("spell_the_lich_king_trigger_vile_spirit") { }

        class spell_the_lich_king_trigger_vile_spirit_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_the_lich_king_trigger_vile_spirit_SpellScript);

            void ActivateSpirit()
            {
                Creature* target = GetHitCreature();
                if (!target)
                    return;

                target->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE | UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_ATTACKABLE_1 | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                target->ForceValuesUpdateAtIndex(UNIT_FIELD_FLAGS);
                VileSpiritActivateEvent(target).Execute(0, 0);
            }

            void Register()
            {
                OnHit += SpellHitFn(spell_the_lich_king_trigger_vile_spirit_SpellScript::ActivateSpirit);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_the_lich_king_trigger_vile_spirit_SpellScript();
        }
};

class npc_lk_wicked_spirit : public CreatureScript
{
    public:
        npc_lk_wicked_spirit() : CreatureScript("npc_lk_wicked_spirit") { }

        struct npc_lk_wicked_spiritAI : public ScriptedAI
        {
            npc_lk_wicked_spiritAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset()
            {
                me->SetCorpseDelay(0);
                me->SetReactState(REACT_PASSIVE);
            }

            void JustDied(Unit* /*killer*/)
            {
                me->SetReactState(REACT_PASSIVE);
            }

            void JustRespawned()
            {
                me->SetReactState(REACT_PASSIVE);
            }

            bool CanAIAttack(Unit const* target) const
            {
                return me->GetReactState() == REACT_AGGRESSIVE && target->GetTypeId() == TYPEID_PLAYER && target->GetExactDistSq(495.708f, -2523.76f, 1049.95f) < 40.0f*40.0f;
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return GetIcecrownCitadelAI<npc_lk_wicked_spiritAI>(creature);
        }
};

class achievement_been_waiting_long_time : public AchievementCriteriaScript
{
    public:
        achievement_been_waiting_long_time() : AchievementCriteriaScript("achievement_been_waiting_long_time") { }

        bool OnCheck(Player* /*source*/, Unit* target)
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

        bool OnCheck(Player* /*source*/, Unit* target)
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
    new spell_the_lich_king_quake();
    new spell_the_lich_king_jump();
    new spell_the_lich_king_jump_remove_aura();
    new spell_trigger_spell_from_caster("spell_the_lich_king_mass_resurrection", SPELL_MASS_RESURRECTION_REAL);
    new spell_the_lich_king_play_movie();

    // fight stuff below
    new npc_shambling_horror_icc();
    new spell_the_lich_king_infest();
    new spell_the_lich_king_necrotic_plague();
    new spell_the_lich_king_necrotic_plague_jump();
    new spell_the_lich_king_shadow_trap_visual();
    new spell_the_lich_king_shadow_trap_periodic();
    new spell_the_lich_king_ice_burst_target_search();
    new npc_icc_ice_sphere();
    new spell_the_lich_king_raging_spirit();
    new npc_raging_spirit();
    new spell_the_lich_king_defile();
    new spell_the_lich_king_soul_reaper();
    new npc_valkyr_shadowguard();
    new spell_the_lich_king_summon_into_air();
    new spell_the_lich_king_teleport_to_frostmourne_hc();
    new spell_the_lich_king_valkyr_target_search();
    new spell_the_lich_king_cast_back_to_caster();
    new spell_the_lich_king_life_siphon();
    new spell_the_lich_king_vile_spirits();
    new spell_the_lich_king_vile_spirits_visual();
    new spell_the_lich_king_vile_spirit_move_target_search();
    new spell_the_lich_king_vile_spirit_damage_target_search();
    new spell_the_lich_king_harvest_soul();
    new npc_strangulate_vehicle();
    new npc_terenas_menethil();
    new spell_the_lich_king_lights_favor();
    new spell_the_lich_king_restore_soul();
    new npc_spirit_warden();
    new spell_the_lich_king_dark_hunger();
    new spell_the_lich_king_soul_rip();
    new npc_icc_lk_checktarget();
    new spell_the_lich_king_summon_spirit_bomb();
    new npc_lk_spirit_bomb();
    new spell_the_lich_king_trigger_vile_spirit();
    new npc_lk_wicked_spirit();
    new achievement_been_waiting_long_time();
    new achievement_neck_deep_in_vile();
}
