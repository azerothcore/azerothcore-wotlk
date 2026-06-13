/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _CHARMINFO_H
#define _CHARMINFO_H

#include "Define.h"
#include "ObjectGuid.h"

#define MAX_SPELL_CHARM         4
#define MAX_SPELL_VEHICLE       6
#define MAX_SPELL_POSSESS       8
#define MAX_SPELL_CONTROL_BAR   10

#define MAX_UNIT_ACTION_BAR_INDEX (ACTION_BAR_INDEX_END-ACTION_BAR_INDEX_START)

#define UNIT_ACTION_BUTTON_ACTION(X) (uint32(X) & 0x00FFFFFF)
#define UNIT_ACTION_BUTTON_TYPE(X)   ((uint32(X) & 0xFF000000) >> 24)
#define MAKE_UNIT_ACTION_BUTTON(A, T) (uint32(A) | (uint32(T) << 24))

class GlobalCooldownMgr;
class SpellInfo;
class Unit;
class WorldPacket;

enum CommandStates : uint8;
enum ReactStates : uint8;

enum CharmType : uint8
{
    CHARM_TYPE_CHARM,
    CHARM_TYPE_POSSESS,
    CHARM_TYPE_VEHICLE,
    CHARM_TYPE_CONVERT,
};

enum ActionBarIndex
{
    ACTION_BAR_INDEX_START = 0,
    ACTION_BAR_INDEX_PET_SPELL_START = 3,
    ACTION_BAR_INDEX_PET_SPELL_END = 7,
    ACTION_BAR_INDEX_END = 10,
};

enum ActiveStates : uint8
{
    ACT_PASSIVE  = 0x01,                                    // 0x01 - passive
    ACT_DISABLED = 0x81,                                    // 0x80 - castable
    ACT_ENABLED  = 0xC1,                                    // 0x40 | 0x80 - auto cast + castable
    ACT_COMMAND  = 0x07,                                    // 0x01 | 0x02 | 0x04
    ACT_REACTION = 0x06,                                    // 0x02 | 0x04
    ACT_DECIDE   = 0x00                                     // custom
};

struct GlobalCooldown
{
    explicit GlobalCooldown(uint32 _dur = 0, uint32 _time = 0) : duration(_dur), cast_time(_time) {}

    uint32 duration;
    uint32 cast_time;
};

typedef std::unordered_map<uint32 /*category*/, GlobalCooldown> GlobalCooldownList;

class GlobalCooldownMgr                                     // Shared by Player and CharmInfo
{
public:
    GlobalCooldownMgr() = default;

public:
    bool HasGlobalCooldown(SpellInfo const* spellInfo) const;
    uint32 GetGlobalCooldown(SpellInfo const* spellInfo) const;
    void AddGlobalCooldown(SpellInfo const* spellInfo, uint32 gcd);
    void CancelGlobalCooldown(SpellInfo const* spellInfo);

private:
    GlobalCooldownList m_GlobalCooldowns;
};

struct UnitActionBarEntry
{
    UnitActionBarEntry() : packedData(uint32(ACT_DISABLED) << 24) {}

    uint32 packedData;

    // helper
    [[nodiscard]] ActiveStates GetType() const { return ActiveStates(UNIT_ACTION_BUTTON_TYPE(packedData)); }
    [[nodiscard]] uint32 GetAction() const { return UNIT_ACTION_BUTTON_ACTION(packedData); }
    [[nodiscard]] bool IsActionBarForSpell() const
    {
        ActiveStates Type = GetType();
        return Type == ACT_DISABLED || Type == ACT_ENABLED || Type == ACT_PASSIVE;
    }

    void SetActionAndType(uint32 action, ActiveStates type)
    {
        packedData = MAKE_UNIT_ACTION_BUTTON(action, type);
    }

    void SetType(ActiveStates type)
    {
        packedData = MAKE_UNIT_ACTION_BUTTON(UNIT_ACTION_BUTTON_ACTION(packedData), type);
    }

    void SetAction(uint32 action)
    {
        packedData = (packedData & 0xFF000000) | UNIT_ACTION_BUTTON_ACTION(action);
    }
};
typedef UnitActionBarEntry CharmSpellInfo;

struct CharmInfo
{
public:
    explicit CharmInfo(Unit* unit);
    ~CharmInfo();
    void RestoreState();
    [[nodiscard]] uint32 GetPetNumber() const { return _petnumber; }
    void SetPetNumber(uint32 petnumber, bool statwindow);

    void SetCommandState(CommandStates st) { _CommandState = st; }
    [[nodiscard]] CommandStates GetCommandState() const { return _CommandState; }
    [[nodiscard]] bool HasCommandState(CommandStates state) const { return (_CommandState == state); }

    void InitPossessCreateSpells();
    void InitCharmCreateSpells();
    void InitPetActionBar();
    void InitEmptyActionBar(bool withAttack = true);

    //return true if successful
    bool AddSpellToActionBar(SpellInfo const* spellInfo, ActiveStates newstate = ACT_DECIDE, uint32 index = MAX_UNIT_ACTION_BAR_INDEX + 1);
    bool RemoveSpellFromActionBar(uint32 spell_id);
    void LoadPetActionBar(const std::string& data);
    void BuildActionBar(WorldPacket* data);
    void SetSpellAutocast(SpellInfo const* spellInfo, bool state);
    void SetActionBar(uint8 index, uint32 spellOrAction, ActiveStates type)
    {
        PetActionBar[index].SetActionAndType(spellOrAction, type);
    }
    [[nodiscard]] UnitActionBarEntry const* GetActionBarEntry(uint8 index) const { return &(PetActionBar[index]); }

    void ToggleCreatureAutocast(SpellInfo const* spellInfo, bool apply);

    CharmSpellInfo* GetCharmSpell(uint8 index) { return &(_charmspells[index]); }

    GlobalCooldownMgr& GetGlobalCooldownMgr() { return _GlobalCooldownMgr; }

    void SetIsCommandAttack(bool val);
    bool IsCommandAttack();
    void SetIsCommandFollow(bool val);
    bool IsCommandFollow();
    void SetIsAtStay(bool val);
    bool IsAtStay();
    void SetIsFollowing(bool val);
    bool IsFollowing();
    void SetIsReturning(bool val);
    bool IsReturning();
    void SaveStayPosition(bool atCurrentPos);
    void GetStayPosition(float& x, float& y, float& z);
    void RemoveStayPosition();
    bool HasStayPosition();

    void SetForcedSpell(uint32 id) { _forcedSpellId = id; }
    int32 GetForcedSpell() { return _forcedSpellId; }
    void SetForcedTargetGUID(ObjectGuid guid = ObjectGuid::Empty) { _forcedTargetGUID = guid; }
    ObjectGuid GetForcedTarget() { return _forcedTargetGUID; }

    // Player react states
    void SetPlayerReactState(ReactStates s) { _oldReactState = s; }
    [[nodiscard]] ReactStates GetPlayerReactState() const { return _oldReactState; }

private:
    Unit* _unit;
    UnitActionBarEntry PetActionBar[MAX_UNIT_ACTION_BAR_INDEX];
    CharmSpellInfo _charmspells[4];
    CommandStates _CommandState;
    uint32 _petnumber;

    //for restoration after charmed
    ReactStates     _oldReactState;

    bool _isCommandAttack;
    bool _isCommandFollow;
    bool _isAtStay;
    bool _isFollowing;
    bool _isReturning;
    int32 _forcedSpellId;
    ObjectGuid _forcedTargetGUID;
    float _stayX;
    float _stayY;
    float _stayZ;

    GlobalCooldownMgr _GlobalCooldownMgr;
};

#endif // _CHARMINFO_H
