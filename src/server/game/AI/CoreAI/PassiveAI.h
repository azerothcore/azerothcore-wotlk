/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef ACORE_PASSIVEAI_H
#define ACORE_PASSIVEAI_H

#include "CreatureAI.h"
//#include "CreatureAIImpl.h"

class PassiveAI : public CreatureAI
{
public:
    explicit PassiveAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}
    void UpdateAI(uint32) override;

    static int Permissible(const Creature*) { return PERMIT_BASE_IDLE;  }
};

class PossessedAI : public CreatureAI
{
public:
    explicit PossessedAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit* target) override;
    void UpdateAI(uint32) override;
    void EnterEvadeMode() override {}

    void JustDied(Unit*) override;
    void KilledUnit(Unit* victim) override;

    static int Permissible(const Creature*) { return PERMIT_BASE_IDLE;  }
};

class NullCreatureAI : public CreatureAI
{
public:
    explicit NullCreatureAI(Creature* c);

    void MoveInLineOfSight(Unit*) override {}
    void AttackStart(Unit*) override {}
    void UpdateAI(uint32) override {}
    void EnterEvadeMode() override {}
    void OnCharmed(bool /*apply*/) override {}

    static int Permissible(const Creature*) { return PERMIT_BASE_IDLE;  }
};

class CritterAI : public PassiveAI
{
public:
    explicit CritterAI(Creature* c) : PassiveAI(c) { _combatTimer = 0; }

    void DamageTaken(Unit* /*done_by*/, uint32& /*damage*/, DamageEffectType damagetype, SpellSchoolMask damageSchoolMask) override;
    void EnterEvadeMode() override;
    void UpdateAI(uint32) override;

    // Xinef: Added
private:
    uint32 _combatTimer;
};

class TriggerAI : public NullCreatureAI
{
public:
    explicit TriggerAI(Creature* c) : NullCreatureAI(c) {}
    void IsSummonedBy(Unit* summoner) override;
};

#endif

