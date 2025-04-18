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

#include "GameObjectScript.h"
#include "Player.h"

class go_noblegarden_colored_egg : public GameObjectScript
{
public:
    go_noblegarden_colored_egg() : GameObjectScript("go_noblegarden_colored_egg") { }

    bool OnGossipHello(Player* player, GameObject* /*go*/) override
    {
        if (roll_chance_i(5))
            player->CastSpell(player, 61734, true); // SPELL NOBLEGARDEN BUNNY
        return false;
    }
};

void AddSC_event_noblegarden_scripts()
{
    new go_noblegarden_colored_egg();
}
