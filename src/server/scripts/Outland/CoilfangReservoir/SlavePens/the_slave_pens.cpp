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

#include "the_slave_pens.h"
#include "AreaTriggerScript.h"
#include "InstanceScript.h"
#include "Player.h"

class at_quagmirran_lair : public AreaTriggerScript
{
public:
    at_quagmirran_lair() : AreaTriggerScript("at_quagmirran_lair") {}

    bool OnTrigger(Player* player, AreaTrigger const* /*trigger*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* quagmirran = instance->GetCreature(DATA_QUAGMIRRAN))
            {
                quagmirran->GetMotionMaster()->MovePath(quagmirran->GetEntry() * 100, true);
            }
        }

        return true;
    }
};

void AddSC_the_slave_pens()
{
    new at_quagmirran_lair();
}

