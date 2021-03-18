/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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
    explicit TempSummon(SummonPropertiesEntry const* properties, uint64 owner, bool isWorldObject);
    ~TempSummon() override = default;
    void Update(uint32 time) override;
    virtual void InitStats(uint32 lifetime);
    virtual void InitSummon();
    virtual void UnSummon(uint32 msTime = 0);
    void RemoveFromWorld() override;
    void SetTempSummonType(TempSummonType type);
    void SaveToDB(uint32 /*mapid*/, uint8 /*spawnMask*/, uint32 /*phaseMask*/) override {}
    [[nodiscard]] Unit* GetSummoner() const;
    uint64 GetSummonerGUID() { return m_summonerGUID; }
    TempSummonType const& GetSummonType() { return m_type; }
    uint32 GetTimer() { return m_timer; }
    void SetTimer(uint32 t) { m_timer = t; }

    const SummonPropertiesEntry* const m_Properties;
private:
    TempSummonType m_type;
    uint32 m_timer;
    uint32 m_lifetime;
    uint64 m_summonerGUID;
};

class Minion : public TempSummon
{
public:
    Minion(SummonPropertiesEntry const* properties, uint64 owner, bool isWorldObject);
    void InitStats(uint32 duration) override;
    void RemoveFromWorld() override;
    [[nodiscard]] Unit* GetOwner() const;
    [[nodiscard]] float GetFollowAngle() const override { return m_followAngle; }
    void SetFollowAngle(float angle) { m_followAngle = angle; }
    [[nodiscard]] bool IsPetGhoul() const {return GetEntry() == 26125 /*normal ghoul*/ || GetEntry() == 30230 /*Raise Ally ghoul*/;} // Ghoul may be guardian or pet
    [[nodiscard]] bool IsGuardianPet() const;
    void setDeathState(DeathState s, bool despawn = false) override;                   // override virtual Unit::setDeathState
protected:
    const uint64 m_owner;
    float m_followAngle;
};

class Guardian : public Minion
{
public:
    Guardian(SummonPropertiesEntry const* properties, uint64 owner, bool isWorldObject);
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
};

class Puppet : public Minion
{
public:
    Puppet(SummonPropertiesEntry const* properties, uint64 owner);
    void InitStats(uint32 duration) override;
    void InitSummon() override;
    void Update(uint32 time) override;
    void RemoveFromWorld() override;
protected:
    [[nodiscard]] Player* GetOwner() const;
    const uint64 m_owner;
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
