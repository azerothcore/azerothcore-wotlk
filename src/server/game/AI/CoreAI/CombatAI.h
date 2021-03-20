/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_COMBATAI_H
#define ACORE_COMBATAI_H

#include "ConditionMgr.h"
#include "CreatureAI.h"
#include "CreatureAIImpl.h"

class Creature;

class AggressorAI : public CreatureAI
{
public:
    explicit AggressorAI(Creature* c) : CreatureAI(c) {}

    void UpdateAI(uint32) override;
    static int Permissible(const Creature*);
};

typedef std::vector<uint32> SpellVct;

class CombatAI : public CreatureAI
{
public:
    explicit CombatAI(Creature* c) : CreatureAI(c) {}

    void InitializeAI() override;
    void Reset() override;
    void EnterCombat(Unit* who) override;
    void JustDied(Unit* killer) override;
    void UpdateAI(uint32 diff) override;

    static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

protected:
    EventMap events;
    SpellVct spells;
};

class CasterAI : public CombatAI
{
public:
    explicit CasterAI(Creature* c) : CombatAI(c) { m_attackDist = MELEE_RANGE; }
    void InitializeAI() override;
    void AttackStart(Unit* victim) override { AttackStartCaster(victim, m_attackDist); }
    void UpdateAI(uint32 diff) override;
    void EnterCombat(Unit* /*who*/) override;
private:
    float m_attackDist;
};

struct ArcherAI : public CreatureAI
{
public:
    explicit ArcherAI(Creature* c);
    void AttackStart(Unit* who) override;
    void UpdateAI(uint32 diff) override;

    static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

protected:
    float m_minRange;
};

struct TurretAI : public CreatureAI
{
public:
    explicit TurretAI(Creature* c);
    bool CanAIAttack(const Unit* who) const override;
    void AttackStart(Unit* who) override;
    void UpdateAI(uint32 diff) override;

    static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

protected:
    float m_minRange;
};

#define VEHICLE_CONDITION_CHECK_TIME 1000
#define VEHICLE_DISMISS_TIME 5000
struct VehicleAI : public CreatureAI
{
public:
    explicit VehicleAI(Creature* creature);

    void UpdateAI(uint32 diff) override;
    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}
    void OnCharmed(bool apply) override;

    static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

private:
    void LoadConditions();
    void CheckConditions(uint32 diff);
    ConditionList conditions;
    uint32 m_ConditionsTimer;
    bool m_DoDismiss;
    uint32 m_DismissTimer;
};

#endif
