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

#include "Player.h"
#include "ScriptMgr.h"

enum Creationabilities
{
    WARRIOR_CREATION_BATTLE_STANCE = 2457,  // Battle Stance
    DEATH_KNIGHT_CREATION_BLOOD_PRESENCE = 48266, // Blood Presence
};

// Instead of adding a hacky way into Player::Create, we use existing hooks to cast these spells on first character login
class CharacterCreationProcedures : public PlayerScript
{
public:
    CharacterCreationProcedures() : PlayerScript("CharacterCreationProcedures")
    {
    }

    void OnFirstLogin(Player* player) override
    {
        switch (player->getClass())
        {
            // Only two classes posses an aura on creation;
            case CLASS_WARRIOR:
                player->CastSpell(player, WARRIOR_CREATION_BATTLE_STANCE, true);
                return;
            case CLASS_DEATH_KNIGHT:
                player->CastSpell(player, DEATH_KNIGHT_CREATION_BLOOD_PRESENCE, true);
                return;
            // We include, but do not change the other classes
            case CLASS_NONE:
            case CLASS_PALADIN:
            case CLASS_HUNTER:
            case CLASS_ROGUE:
            case CLASS_PRIEST:
            case CLASS_SHAMAN:
            case CLASS_MAGE:
            case CLASS_WARLOCK:
            // case CLASS_UNK: // Does not exist!
            case CLASS_DRUID:
            default:
                // Can be modified based on personal needs;
                return;
        }
    }
};

void AddSC_character_creation()
{
    new CharacterCreationProcedures();
}
