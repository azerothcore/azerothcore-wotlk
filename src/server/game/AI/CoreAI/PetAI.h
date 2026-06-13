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

#ifndef ACORE_PETAI_H
#define ACORE_PETAI_H

#include "CreatureAI.h"
#include "Timer.h"

class Creature;
class Spell;

enum SpecialPets
{
    ENTRY_IMP                   =   416,
    ENTRY_WATER_ELEMENTAL       =   510,
    ENTRY_WATER_ELEMENTAL_PERM  = 37994,

    IMP_FIREBOLT_RANK_1         =  3110,
    IMP_FIREBOLT_RANK_2         =  7799,
    IMP_FIREBOLT_RANK_3         =  7800,
    IMP_FIREBOLT_RANK_4         =  7801,
    IMP_FIREBOLT_RANK_5         =  7802,
    IMP_FIREBOLT_RANK_6         = 11762,
    IMP_FIREBOLT_RANK_7         = 11763,
    IMP_FIREBOLT_RANK_8         = 27267,
    IMP_FIREBOLT_RANK_9         = 47964,
    WATER_ELEMENTAL_WATERBOLT_1 = 31707,
    WATER_ELEMENTAL_WATERBOLT_2 = 72898
};

class PetAI : public CreatureAI
{
public:
    explicit PetAI(Creature* c);

    void UpdateAI(uint32) override;
    static int32 Permissible(Creature const* creature);

    void KilledUnit(Unit* /*victim*/) override;
    void AttackStart(Unit* target) override;
    void MovementInform(uint32 moveType, uint32 data) override;
    void OwnerAttackedBy(Unit* attacker) override;
    void OwnerAttacked(Unit* target) override;
    void AttackedBy(Unit* attacker) override;
    void ReceiveEmote(Player* player, uint32 textEmote) override;

    // The following aren't used by the PetAI but need to be defined to override
    //  default CreatureAI functions which interfere with the PetAI
    //
    void MoveInLineOfSight(Unit* /*who*/) override {} // CreatureAI interferes with returning pets
    void MoveInLineOfSight_Safe(Unit* /*who*/) {} // CreatureAI interferes with returning pets

    void EnterEvadeMode(EvadeReason /*why*/) override {} // For fleeing, pets don't use this type of Evade mechanic
    void SpellHit(Unit* caster, SpellInfo const* spellInfo) override;

    void PetStopAttack() override;

private:
    bool _isVisible(Unit*) const;
    bool _needToStop(void);
    void _stopAttack(void);
    void _doMeleeAttack();
    bool _canMeleeAttack();

    void UpdateAllies();

    TimeTracker i_tracker;
    GuidSet m_AllySet;
    uint32 m_updateAlliesTimer;
    float combatRange;

    Unit* SelectNextTarget(bool allowAutoSelect) const;
    void HandleReturnMovement();
    void DoAttack(Unit* target, bool chase);
    bool CanAttack(Unit* target, SpellInfo const* spellInfo = nullptr);
    void ClearCharmInfoFlags();
};
#endif
