/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_warlock_".
 */

#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum WarlockSpells
{
    SPELL_WARLOCK_PHASE_SHIFT = 4511, // Imp spell
};

class npc_pet_warlock_imp : public CreatureScript
{
public:
    npc_pet_warlock_imp() : CreatureScript("npc_pet_warlock_imp") { }

    struct npc_pet_warlock_impAI : public ScriptedAI
    {
        npc_pet_warlock_impAI(Creature* creature) : ScriptedAI(creature) { }

        void EnterCombat(Unit* /*who*/) override
        {
            me->RemoveAurasDueToSpell(SPELL_WARLOCK_PHASE_SHIFT);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pet_warlock_impAI(creature);
    }
};

void AddSC_warlock_pet_scripts()
{
    new npc_pet_warlock_imp();
}
