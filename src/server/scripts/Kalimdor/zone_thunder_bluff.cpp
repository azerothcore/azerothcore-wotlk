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

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"

/*#####
# Support for Quest 925: Cairne's Hoofprint
######*/

// NPC 3057: Cairne Bloodhoof <High Chieftain>
enum CairneBloodhoof
{
    SPELL_BERSERKER_CHARGE  = 16636,
    SPELL_CLEAVE            = 16044,
    SPELL_MORTAL_STRIKE     = 16856,
    SPELL_THUNDERCLAP       = 23931,
    SPELL_UPPERCUT          = 22916,
    SPELL_CAIRNES_HOOFPRINT = 23123
};

// @todo verify abilities/timers
class npc_cairne_bloodhoof : public CreatureScript
{
public:
    npc_cairne_bloodhoof() : CreatureScript("npc_cairne_bloodhoof") { }

    struct npc_cairne_bloodhoofAI : public ScriptedAI
    {
        npc_cairne_bloodhoofAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            _berserkerChargeTimer = 30000;
            _cleaveTimer          = 5000;
            _mortalStrikeTimer    = 10000;
            _thunderclapTimer     = 15000;
            _uppercutTimer        = 10000;
        }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 action) override
        {
            if (action == 0)
            {
                player->CastSpell(player, SPELL_CAIRNES_HOOFPRINT, false);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (_berserkerChargeTimer <= diff)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                {
                    DoCast(target, SPELL_BERSERKER_CHARGE);
                }
                _berserkerChargeTimer = 25000;
            }
            else
            {
                _berserkerChargeTimer -= diff;
            }

            if (_uppercutTimer <= diff)
            {
                DoCastVictim(SPELL_UPPERCUT);
                _uppercutTimer = 20000;
            }
            else
            {
                _uppercutTimer -= diff;
            }

            if (_thunderclapTimer <= diff)
            {
                DoCastVictim(SPELL_THUNDERCLAP);
                _thunderclapTimer = 15000;
            }
            else
            {
                _thunderclapTimer -= diff;
            }

            if (_mortalStrikeTimer <= diff)
            {
                DoCastVictim(SPELL_MORTAL_STRIKE);
                _mortalStrikeTimer = 15000;
            }
            else
            {
                _mortalStrikeTimer -= diff;
            }

            if (_cleaveTimer <= diff)
            {
                DoCastVictim(SPELL_CLEAVE);
                _cleaveTimer = 7000;
            }
            else
            {
                _cleaveTimer -= diff;
            }

            DoMeleeAttackIfReady();
        }
    private:
        uint32 _berserkerChargeTimer;
        uint32 _cleaveTimer;
        uint32 _mortalStrikeTimer;
        uint32 _thunderclapTimer;
        uint32 _uppercutTimer;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_cairne_bloodhoofAI(creature);
    }
};

void AddSC_thunder_bluff()
{
    new npc_cairne_bloodhoof();
}
