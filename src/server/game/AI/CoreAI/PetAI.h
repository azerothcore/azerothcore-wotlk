/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

        void UpdateAI(uint32);
        static int Permissible(const Creature*);

        void KilledUnit(Unit* /*victim*/);
        void AttackStart(Unit* target);
        void MovementInform(uint32 moveType, uint32 data);
        void OwnerAttackedBy(Unit* attacker);
        void OwnerAttacked(Unit* target);
        void AttackedBy(Unit* attacker);
        void ReceiveEmote(Player* player, uint32 textEmote);

        // The following aren't used by the PetAI but need to be defined to override
        //  default CreatureAI functions which interfere with the PetAI
        //
        void MoveInLineOfSight(Unit* /*who*/) {} // CreatureAI interferes with returning pets
        void MoveInLineOfSight_Safe(Unit* /*who*/) {} // CreatureAI interferes with returning pets
        void EnterEvadeMode() {} // For fleeing, pets don't use this type of Evade mechanic
        void SpellHit(Unit* caster, const SpellInfo* spellInfo);

    private:
        bool _isVisible(Unit*) const;
        bool _needToStop(void);
        void _stopAttack(void);
        void _doMeleeAttack();
        bool _canMeleeAttack();

        void UpdateAllies();

        TimeTracker i_tracker;
        std::set<uint64> m_AllySet;
        uint32 m_updateAlliesTimer;
        float combatRange;

        Unit* SelectNextTarget(bool allowAutoSelect) const;
        void HandleReturnMovement();
        void DoAttack(Unit* target, bool chase);
        bool CanAttack(Unit* target, const SpellInfo* spellInfo = nullptr);
        void ClearCharmInfoFlags();
};
#endif
