/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "ScriptMgr.h"
#include "Player.h"

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

    void OnFirstLogin(Player* player)
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