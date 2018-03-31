/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef TRINITY_PETAI_H
#define TRINITY_PETAI_H

#include "CreatureAI.h"
#include "Timer.h"

class Creature;
class Spell;

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
        bool _canMeleeAttack() const;

        void UpdateAllies();

        TimeTracker i_tracker;
        std::set<uint64> m_AllySet;
        uint32 m_updateAlliesTimer;

        Unit* SelectNextTarget(bool allowAutoSelect) const;
        void HandleReturnMovement();
        void DoAttack(Unit* target, bool chase);
        bool CanAttack(Unit* target, const SpellInfo* spellInfo = NULL);
        void ClearCharmInfoFlags();
};
#endif
