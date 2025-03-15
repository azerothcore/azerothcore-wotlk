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

#ifndef AZEROTHCORE_TEMPSUMMON_H
#define AZEROTHCORE_TEMPSUMMON_H

#include "Creature.h"

enum SummonerType
{
    SUMMONER_TYPE_CREATURE      = 0,
    SUMMONER_TYPE_GAMEOBJECT    = 1,
    SUMMONER_TYPE_MAP           = 2
};

/// Stores data for temp summons
struct TempSummonData
{
    uint32 entry;        ///< Entry of summoned creature
    Position pos;        ///< Position, where should be creature spawned
    TempSummonType type; ///< Summon type, see TempSummonType for available types
    uint32 time;         ///< Despawn time, usable only with certain temp summon types
};

class TempSummon : public Creature
{
public:
    explicit TempSummon(SummonPropertiesEntry const* properties, ObjectGuid owner, bool isWorldObject);
    ~TempSummon() override = default;
    void Update(uint32 time) override;
    virtual void InitStats(uint32 lifetime);
    virtual void InitSummon();
    virtual void UnSummon(uint32 msTime = 0);
    void UpdateObjectVisibilityOnCreate() override;
    void RemoveFromWorld() override;
    void SetTempSummonType(TempSummonType type);
    void SaveToDB(uint32 /*mapid*/, uint8 /*spawnMask*/, uint32 /*phaseMask*/) override {}
    [[nodiscard]] WorldObject* GetSummoner() const;
    [[nodiscard]] Unit* GetSummonerUnit() const;
    [[nodiscard]] Creature* GetSummonerCreatureBase() const;
    [[nodiscard]] GameObject* GetSummonerGameObject() const;
    ObjectGuid GetSummonerGUID() const { return m_summonerGUID; }
    TempSummonType GetSummonType() const { return m_type; }
    uint32 GetTimer() { return m_timer; }
    void SetTimer(uint32 t) { m_timer = t; }

    void SetVisibleBySummonerOnly(bool visibleBySummonerOnly) { _visibleBySummonerOnly = visibleBySummonerOnly; }
    [[nodiscard]] bool IsVisibleBySummonerOnly() const { return _visibleBySummonerOnly; }

    const SummonPropertiesEntry* const m_Properties;

    std::string GetDebugInfo() const override;

private:
    TempSummonType m_type;
    uint32 m_timer;
    uint32 m_lifetime;
    ObjectGuid m_summonerGUID;
    bool _visibleBySummonerOnly;
};

class Minion : public TempSummon
{
public:
    Minion(SummonPropertiesEntry const* properties, ObjectGuid owner, bool isWorldObject);
    void InitStats(uint32 duration) override;
    void RemoveFromWorld() override;
    [[nodiscard]] Unit* GetOwner() const;
    [[nodiscard]] float GetFollowAngle() const override { return m_followAngle; }
    void SetFollowAngle(float angle) { m_followAngle = angle; }
    [[nodiscard]] bool IsPetGhoul() const {return GetEntry() == 26125 /*normal ghoul*/ || GetEntry() == 30230 /*Raise Ally ghoul*/;} // Ghoul may be guardian or pet
    [[nodiscard]] bool IsGuardianPet() const;
    void setDeathState(DeathState s, bool despawn = false) override;                   // override virtual Unit::setDeathState

    std::string GetDebugInfo() const override;
protected:
    const ObjectGuid m_owner;
    float m_followAngle;
};

class Guardian : public Minion
{
public:
    Guardian(SummonPropertiesEntry const* properties, ObjectGuid owner, bool isWorldObject);
    void InitStats(uint32 duration) override;
    bool InitStatsForLevel(uint8 level);
    void InitSummon() override;

    bool UpdateStats(Stats stat) override;
    bool UpdateAllStats() override;
    void UpdateArmor() override;
    void UpdateMaxHealth() override;
    void UpdateMaxPower(Powers power) override;
    void UpdateAttackPowerAndDamage(bool ranged = false) override;
    void UpdateDamagePhysical(WeaponAttackType attType) override;

    std::string GetDebugInfo() const override;
};

class Puppet : public Minion
{
public:
    Puppet(SummonPropertiesEntry const* properties, ObjectGuid owner);
    void InitStats(uint32 duration) override;
    void InitSummon() override;
    void Update(uint32 time) override;
    void RemoveFromWorld() override;
protected:
    [[nodiscard]] Player* GetOwner() const;
    const ObjectGuid m_owner;
};

class ForcedUnsummonDelayEvent : public BasicEvent
{
public:
    ForcedUnsummonDelayEvent(TempSummon& owner) : BasicEvent(), m_owner(owner) { }
    bool Execute(uint64 e_time, uint32 p_time) override;

private:
    TempSummon& m_owner;
};
#endif
