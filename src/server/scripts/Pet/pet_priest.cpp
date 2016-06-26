/*
 * Copyright (C) 
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_pri_".
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "PassiveAI.h"
#include "PetAI.h"
#include "TotemAI.h"

enum PriestSpells
{
    SPELL_PRIEST_GLYPH_OF_SHADOWFIEND       = 58228,
    SPELL_PRIEST_GLYPH_OF_SHADOWFIEND_MANA  = 58227,
    SPELL_PRIEST_SHADOWFIEND_DODGE          = 8273,
    SPELL_PRIEST_LIGHTWELL_CHARGES          = 59907
};

class npc_pet_pri_lightwell : public CreatureScript
{
    public:
        npc_pet_pri_lightwell() : CreatureScript("npc_pet_pri_lightwell") { }

        struct npc_pet_pri_lightwellAI : public TotemAI
        {
            npc_pet_pri_lightwellAI(Creature* creature) : TotemAI(creature) { }

            void InitializeAI()
            {
                if (Unit* owner = me->ToTempSummon()->GetSummoner())
                {
                    uint32 hp = uint32(owner->GetMaxHealth()*0.3f);
                    me->SetMaxHealth(hp);
                    me->SetHealth(hp);
                    me->SetLevel(owner->getLevel());
                }

                me->CastSpell(me, SPELL_PRIEST_LIGHTWELL_CHARGES, false); // Spell for Lightwell Charges
                TotemAI::InitializeAI();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pet_pri_lightwellAI(creature);
        }
};

class npc_pet_pri_shadowfiend : public CreatureScript
{
    public:
        npc_pet_pri_shadowfiend() : CreatureScript("npc_pet_pri_shadowfiend") { }

        struct npc_pet_pri_shadowfiendAI : public PetAI
        {
            npc_pet_pri_shadowfiendAI(Creature* creature) : PetAI(creature) { }

            void Reset()
            {
                PetAI::Reset();
                if (!me->HasAura(SPELL_PRIEST_SHADOWFIEND_DODGE))
                    me->AddAura(SPELL_PRIEST_SHADOWFIEND_DODGE, me);

                if (Unit* target = me->SelectNearestTarget(15.0f))
                    AttackStart(target);
            }

            void JustDied(Unit* /*killer*/)
            {
                if (me->IsSummon())
                    if (Unit* owner = me->ToTempSummon()->GetSummoner())
                        if (owner->HasAura(SPELL_PRIEST_GLYPH_OF_SHADOWFIEND))
                            owner->CastSpell(owner, SPELL_PRIEST_GLYPH_OF_SHADOWFIEND_MANA, true);
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pet_pri_shadowfiendAI(creature);
        }
};

void AddSC_priest_pet_scripts()
{
    new npc_pet_pri_lightwell();
    new npc_pet_pri_shadowfiend();
}
