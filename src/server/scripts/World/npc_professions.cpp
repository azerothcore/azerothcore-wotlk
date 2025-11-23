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

#include "CreatureScript.h"
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

/*###
# to be removed from here (->ncp_text). This is data for database projects.
###*/
#define TALK_MUST_UNLEARN_WEAPON    "You must forget your weapon type specialty before I can help you. Go to Everlook in Winterspring and seek help there."

#define TALK_HAMMER_LEARN           "Ah, a seasoned veteran you once were. I know you are capable, you merely need to ask and I shall teach you the way of the hammersmith."
#define TALK_AXE_LEARN              "Ah, a seasoned veteran you once were. I know you are capable, you merely need to ask and I shall teach you the way of the axesmith."
#define TALK_SWORD_LEARN            "Ah, a seasoned veteran you once were. I know you are capable, you merely need to ask and I shall teach you the way of the swordsmith."

#define TALK_HAMMER_UNLEARN         "Forgetting your Hammersmithing skill is not something to do lightly. If you choose to abandon it you will forget all recipes that require Hammersmithing to create!"
#define TALK_AXE_UNLEARN            "Forgetting your Axesmithing skill is not something to do lightly. If you choose to abandon it you will forget all recipes that require Axesmithing to create!"
#define TALK_SWORD_UNLEARN          "Forgetting your Swordsmithing skill is not something to do lightly. If you choose to abandon it you will forget all recipes that require Swordsmithing to create!"

/*###
# generic defines
###*/

#define GOSSIP_SENDER_LEARN         50
#define GOSSIP_SENDER_UNLEARN       51
#define GOSSIP_SENDER_CHECK         52

/*###
# gossip item and box texts
###*/

#define GOSSIP_LEARN_POTION         "Please teach me how to become a Master of Potions, Lauranna"
#define GOSSIP_UNLEARN_POTION       "I wish to unlearn Potion Mastery"
#define GOSSIP_LEARN_TRANSMUTE      "Please teach me how to become a Master of Transmutations, Zarevhi"
#define GOSSIP_UNLEARN_TRANSMUTE    "I wish to unlearn Transmutation Mastery"
#define GOSSIP_LEARN_ELIXIR         "Please teach me how to become a Master of Elixirs, Lorokeem"
#define GOSSIP_UNLEARN_ELIXIR       "I wish to unlearn Elixir Mastery"

#define BOX_UNLEARN_ALCHEMY_SPEC    "Do you really want to unlearn your alchemy specialty and lose all associated recipes? \n Cost: "

#define GOSSIP_WEAPON_LEARN         "Please teach me how to become a Weaponsmith"
#define GOSSIP_WEAPON_UNLEARN       "I wish to unlearn the art of Weaponsmithing"
#define GOSSIP_ARMOR_LEARN          "Please teach me how to become a Armorsmith"
#define GOSSIP_ARMOR_UNLEARN        "I wish to unlearn the art of Armorsmithing"

#define GOSSIP_UNLEARN_SMITH_SPEC   "I wish to unlearn my blacksmith specialty"
#define BOX_UNLEARN_ARMORORWEAPON   "Do you really want to unlearn your blacksmith specialty and lose all associated recipes? \n Cost: "

#define GOSSIP_LEARN_HAMMER         "Please teach me how to become a Hammersmith, Lilith"
#define GOSSIP_UNLEARN_HAMMER       "I wish to unlearn Hammersmithing"
#define GOSSIP_LEARN_AXE            "Please teach me how to become a Axesmith, Kilram"
#define GOSSIP_UNLEARN_AXE          "I wish to unlearn Axesmithing"
#define GOSSIP_LEARN_SWORD          "Please teach me how to become a Swordsmith, Seril"
#define GOSSIP_UNLEARN_SWORD        "I wish to unlearn Swordsmithing"

#define BOX_UNLEARN_WEAPON_SPEC     "Do you really want to unlearn your weaponsmith specialty and lose all associated recipes? \n Cost: "

#define GOSSIP_LEARN_SPELLFIRE      "Please teach me how to become a Spellcloth tailor"
#define GOSSIP_UNLEARN_SPELLFIRE    "I wish to unlearn Spellfire Tailoring"
#define GOSSIP_LEARN_MOONCLOTH      "Please teach me how to become a Mooncloth tailor"
#define GOSSIP_UNLEARN_MOONCLOTH    "I wish to unlearn Mooncloth Tailoring"
#define GOSSIP_LEARN_SHADOWEAVE     "Please teach me how to become a Shadoweave tailor"
#define GOSSIP_UNLEARN_SHADOWEAVE   "I wish to unlearn Shadoweave Tailoring"

#define BOX_UNLEARN_TAILOR_SPEC     "Do you really want to unlearn your tailoring specialty and lose all associated recipes? \n Cost: "

#define GOSSIP_LEARN_GOBLIN         "I am absolutely certain that i want to learn Goblin engineering"
#define GOSSIP_LEARN_GNOMISH        "I am absolutely certain that i want to learn Gnomish engineering"
#define GOSSIP_UNLEARN_GOBLIN       "I wish to unlearn Goblin engineering"
#define GOSSIP_UNLEARN_GNOMISH      "I wish to unlearn Gnomish engineering"

#define BOX_UNLEARN_ENGIN_SPEC     "Do you really want to unlearn your engineering specialty and lose all associated recipes? \n Cost: "
#define BOX_LEARN_ENGIN_SPEC     "Do you really want to learn this engineering specialty? \n Cost: "

/*###
# spells defines
###*/
enum ProfessionSpells
{
    S_WEAPON                = 9787,
    S_ARMOR                 = 9788,
    S_HAMMER                = 17040,
    S_AXE                   = 17041,
    S_SWORD                 = 17039,

    S_LEARN_WEAPON          = 9789,
    S_LEARN_ARMOR           = 9790,
    S_LEARN_HAMMER          = 39099,
    S_LEARN_AXE             = 39098,
    S_LEARN_SWORD           = 39097,

    S_UNLEARN_WEAPON        = 36436,
    S_UNLEARN_ARMOR         = 36435,
    S_UNLEARN_HAMMER        = 36441,
    S_UNLEARN_AXE           = 36439,
    S_UNLEARN_SWORD         = 36438,

    S_REP_ARMOR             = 17451,
    S_REP_WEAPON            = 17452,

    REP_ARMOR               = 46,
    REP_WEAPON              = 289,
    REP_HAMMER              = 569,
    REP_AXE                 = 570,
    REP_SWORD               = 571,

    S_DRAGON                = 10656,
    S_ELEMENTAL             = 10658,
    S_TRIBAL                = 10660,

    S_LEARN_DRAGON          = 10657,
    S_LEARN_ELEMENTAL       = 10659,
    S_LEARN_TRIBAL          = 10661,

    S_UNLEARN_DRAGON        = 36434,
    S_UNLEARN_ELEMENTAL     = 36328,
    S_UNLEARN_TRIBAL        = 36433,

    S_GOBLIN                = 20222,
    S_GNOMISH               = 20219,

    S_LEARN_GOBLIN          = 20221,
    S_LEARN_GNOMISH         = 20220,

    S_SPELLFIRE             = 26797,
    S_MOONCLOTH             = 26798,
    S_SHADOWEAVE            = 26801,
    S_UNLEARN_GOBLIN        = 68334,
    S_UNLEARN_GNOMISH       = 68333,

    S_LEARN_SPELLFIRE       = 26796,
    S_LEARN_MOONCLOTH       = 26799,
    S_LEARN_SHADOWEAVE      = 26800,

    S_UNLEARN_SPELLFIRE     = 41299,
    S_UNLEARN_MOONCLOTH     = 41558,
    S_UNLEARN_SHADOWEAVE    = 41559,

    S_TRANSMUTE             = 28672,
    S_ELIXIR                = 28677,
    S_POTION                = 28675,

    S_LEARN_TRANSMUTE       = 28674,
    S_LEARN_ELIXIR          = 28678,
    S_LEARN_POTION          = 28676,

    S_UNLEARN_TRANSMUTE     = 41565,
    S_UNLEARN_ELIXIR        = 41564,
    S_UNLEARN_POTION        = 41563,
};

/*###
# specialization trainers
###*/
enum SpecializationTrainers
{
    /* Alchemy */
    N_TRAINER_TRANSMUTE     = 22427, // Zarevhi
    N_TRAINER_ELIXIR        = 19052, // Lorokeem
    N_TRAINER_POTION        = 17909, // Lauranna Thar'well

    /* Blacksmithing */
    N_TRAINER_SMITHOMNI1    = 11145, // Myolor Sunderfury
    N_TRAINER_SMITHOMNI2    = 11176, // Krathok Moltenfist
    N_TRAINER_WEAPON1       = 11146, // Ironus Coldsteel
    N_TRAINER_WEAPON2       = 11178, // Borgosh Corebender
    N_TRAINER_ARMOR1        = 5164, // Grumnus Steelshaper
    N_TRAINER_ARMOR2        = 11177, // Okothos Ironrager
    N_TRAINER_HAMMER        = 11191, // Lilith the Lithe
    N_TRAINER_AXE           = 11192, // Kilram
    N_TRAINER_SWORD         = 11193, // Seril Scourgebane

    /* Leatherworking */
    N_TRAINER_DRAGON1       = 7866, // Peter Galen
    N_TRAINER_DRAGON2       = 7867, // Thorkaf Dragoneye
    N_TRAINER_ELEMENTAL1    = 7868, // Sarah Tanner
    N_TRAINER_ELEMENTAL2    = 7869, // Brumn Winterhoof
    N_TRAINER_TRIBAL1       = 7870, // Caryssia Moonhunter
    N_TRAINER_TRIBAL2       = 7871, // Se'Jib

    /* Tailoring */
    N_TRAINER_SPELLFIRE     = 22213, // Gidge Spellweaver
    N_TRAINER_MOONCLOTH     = 22208, // Nasmara Moonsong
    N_TRAINER_SHADOWEAVE    = 22212, // Andrion Darkspinner
};

/*###
# specialization quests
###*/
enum SpecializationQuests
{
    /* Alchemy */
    Q_MASTER_TRANSMUTE      = 10899,
    Q_MASTER_ELIXIR         = 10902,
    Q_MASTER_POTION         = 10897,
};

// All referred to gossips (menu, menu_opt, actions)
enum Gossips
{
    // Leatherworking
    GOSSIP_MENU_PETER_GALEN           = 3067,
    GOSSIP_MENU_THORKAF_DRAGONEYE     = 3068,
    GOSSIP_MENU_BRUMN_WINTERHOOF      = 3069,
    GOSSIP_MENU_SARAH_TANNER          = 3070,
    GOSSIP_MENU_CARYSSIA_MOONHUNTER   = 3072,
    GOSSIP_MENU_SEJIB                 = 3073,

    GOSSIP_MENU_UNLEARN_CONFIRM_DRAGONSCALE   = 3075,
    GOSSIP_MENU_UNLEARN_CONFIRM_ELEMENTAL     = 3076,
    GOSSIP_MENU_UNLEARN_CONFIRM_TRIBAL        = 3077,

    GOSSIP_MENU_OPTION_TRAIN                       = 0,
    GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_DRAGONSCALE = 1,
    GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_ELEMENTAL   = 1,
    GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_TRIBAL      = 1,

    GOSSIP_TEXT_UNLEARN_CONFIRM_DRAGONSCALE = 10304,
    GOSSIP_TEXT_UNLEARN_CONFIRM_ELEMENTAL   = 10302,
    GOSSIP_TEXT_UNLEARN_CONFIRM_TRIBAL      = 10303,

    GOSSIP_MENU_GO_SOOTHSAYING_FOR_DUMMIES = 7058,
    GOSSIP_MENU_OPTION_GO_LEARN_DRAGONSCALE = 4,
    GOSSIP_MENU_OPTION_GO_LEARN_ELEMENTAL   = 5,
    GOSSIP_MENU_OPTION_GO_LEARN_TRIBAL      = 6,

};

/*###
# formulas to calculate unlearning cost
###*/

int32 DoLearnCost(Player* /*player*/)                      //tailor, alchemy
{
    return 200000;
}

int32 DoHighUnlearnCost(Player* /*player*/)                //tailor, alchemy
{
    return 1500000;
}

int32 DoMedUnlearnCost(Player* player)                     //blacksmith, leatherwork
{
    uint8 level = player->GetLevel();
    if (level < 51)
        return 250000;
    else if (level < 66)
        return 500000;
    else
        return 1000000;
}

int32 DoLowUnlearnCost(Player* player)                     //blacksmith
{
    uint8 level = player->GetLevel();
    if (level < 66)
        return 50000;
    else
        return 100000;
}

bool EquippedOk(Player* player, uint32 spellId)
{
    SpellInfo const* spell = sSpellMgr->GetSpellInfo(spellId);
    if (!spell)
        return false;

    for (uint8 i = 0; i < 3; ++i)
    {
        uint32 reqSpell = spell->Effects[i].TriggerSpell;
        if (!reqSpell)
            continue;

        Item* item = nullptr;
        for (uint8 j = EQUIPMENT_SLOT_START; j < EQUIPMENT_SLOT_END; ++j)
        {
            item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, j);
            if (item && item->GetTemplate()->RequiredSpell == reqSpell)
            {
                //player has item equipped that require specialty. Not allow to unlearn, player has to unequip first
                LOG_DEBUG("scripts.ai", "Player attempt to unlearn spell {}, but item {} is equipped.", reqSpell, item->GetEntry());
                return false;
            }
        }
    }
    return true;
}

/*###
# unlearning related profession spells
###*/

void ProfessionUnlearnSpells(Player* player, uint32 type)
{
    switch (type)
    {
        case S_UNLEARN_WEAPON:                              // S_UNLEARN_WEAPON
            player->removeSpell(36125, SPEC_MASK_ALL, false);                     // Light Earthforged Blade
            player->removeSpell(36128, SPEC_MASK_ALL, false);                     // Light Emberforged Hammer
            player->removeSpell(36126, SPEC_MASK_ALL, false);                     // Light Skyforged Axe
            break;
        case S_UNLEARN_ARMOR:                               // S_UNLEARN_ARMOR
            player->removeSpell(36122, SPEC_MASK_ALL, false);                     // Earthforged Leggings
            player->removeSpell(36129, SPEC_MASK_ALL, false);                     // Heavy Earthforged Breastplate
            player->removeSpell(36130, SPEC_MASK_ALL, false);                     // Stormforged Hauberk
            player->removeSpell(34533, SPEC_MASK_ALL, false);                     // Breastplate of Kings
            player->removeSpell(34529, SPEC_MASK_ALL, false);                     // Nether Chain Shirt
            player->removeSpell(34534, SPEC_MASK_ALL, false);                     // Bulwark of Kings
            player->removeSpell(36257, SPEC_MASK_ALL, false);                     // Bulwark of the Ancient Kings
            player->removeSpell(36256, SPEC_MASK_ALL, false);                     // Embrace of the Twisting Nether
            player->removeSpell(34530, SPEC_MASK_ALL, false);                     // Twisting Nether Chain Shirt
            player->removeSpell(36124, SPEC_MASK_ALL, false);                     // Windforged Leggings
            break;
        case S_UNLEARN_HAMMER:                              // S_UNLEARN_HAMMER
            player->removeSpell(36262, SPEC_MASK_ALL, false);                     // Dragonstrike
            player->removeSpell(34546, SPEC_MASK_ALL, false);                     // Dragonmaw
            player->removeSpell(34545, SPEC_MASK_ALL, false);                     // Drakefist Hammer
            player->removeSpell(36136, SPEC_MASK_ALL, false);                     // Lavaforged Warhammer
            player->removeSpell(34547, SPEC_MASK_ALL, false);                     // Thunder
            player->removeSpell(34567, SPEC_MASK_ALL, false);                     // Deep Thunder
            player->removeSpell(36263, SPEC_MASK_ALL, false);                     // Stormherald
            player->removeSpell(36137, SPEC_MASK_ALL, false);                     // Great Earthforged Hammer
            break;
        case S_UNLEARN_AXE:                                 // S_UNLEARN_AXE
            player->removeSpell(36260, SPEC_MASK_ALL, false);                     // Wicked Edge of the Planes
            player->removeSpell(34562, SPEC_MASK_ALL, false);                     // Black Planar Edge
            player->removeSpell(34541, SPEC_MASK_ALL, false);                     // The Planar Edge
            player->removeSpell(36134, SPEC_MASK_ALL, false);                     // Stormforged Axe
            player->removeSpell(36135, SPEC_MASK_ALL, false);                     // Skyforged Great Axe
            player->removeSpell(36261, SPEC_MASK_ALL, false);                     // Bloodmoon
            player->removeSpell(34543, SPEC_MASK_ALL, false);                     // Lunar Crescent
            player->removeSpell(34544, SPEC_MASK_ALL, false);                     // Mooncleaver
            break;
        case S_UNLEARN_SWORD:                               // S_UNLEARN_SWORD
            player->removeSpell(36258, SPEC_MASK_ALL, false);                     // Blazefury
            player->removeSpell(34537, SPEC_MASK_ALL, false);                     // Blazeguard
            player->removeSpell(34535, SPEC_MASK_ALL, false);                     // Fireguard
            player->removeSpell(36131, SPEC_MASK_ALL, false);                     // Windforged Rapier
            player->removeSpell(36133, SPEC_MASK_ALL, false);                     // Stoneforged Claymore
            player->removeSpell(34538, SPEC_MASK_ALL, false);                     // Lionheart Blade
            player->removeSpell(34540, SPEC_MASK_ALL, false);                     // Lionheart Champion
            player->removeSpell(36259, SPEC_MASK_ALL, false);                     // Lionheart Executioner
            break;
        case S_UNLEARN_DRAGON:                              // S_UNLEARN_DRAGON
            player->removeSpell(10619, SPEC_MASK_ALL, false);                     // Dragonscale Guantlets
            player->removeSpell(10650, SPEC_MASK_ALL, false);                     // Dragonscale Breastplate
            player->removeSpell(36076, SPEC_MASK_ALL, false);                     // Dragonstrike Leggings
            player->removeSpell(24655, SPEC_MASK_ALL, false);                     // Green Dragonscale Gauntlets
            player->removeSpell(24654, SPEC_MASK_ALL, false);                     // Blue Dragonscale Leggings
            player->removeSpell(36079, SPEC_MASK_ALL, false);                     // Golden Dragonstrike Breastplate
            player->removeSpell(35576, SPEC_MASK_ALL, false);                     // Ebon Netherscale Belt
            player->removeSpell(35577, SPEC_MASK_ALL, false);                     // Ebon Netherscale Bracers
            player->removeSpell(35575, SPEC_MASK_ALL, false);                     // Ebon Netherscale Breastplate
            player->removeSpell(35582, SPEC_MASK_ALL, false);                     // Netherstrike Belt
            player->removeSpell(35584, SPEC_MASK_ALL, false);                     // Netherstrike Bracers
            player->removeSpell(35580, SPEC_MASK_ALL, false);                     // Netherstrike Breastplate
            break;
        case S_UNLEARN_ELEMENTAL:                           // S_UNLEARN_ELEMENTAL
            player->removeSpell(36074, SPEC_MASK_ALL, false);                     // Blackstorm Leggings
            player->removeSpell(36077, SPEC_MASK_ALL, false);                     // Primalstorm Breastplate
            player->removeSpell(35590, SPEC_MASK_ALL, false);                     // Primalstrike Belt
            player->removeSpell(35591, SPEC_MASK_ALL, false);                     // Primalstrike Bracers
            player->removeSpell(35589, SPEC_MASK_ALL, false);                     // Primalstrike Vest
            player->removeSpell(10630, SPEC_MASK_ALL, false);                     // Gauntlets of the Sea
            player->removeSpell(10632, SPEC_MASK_ALL, false);                     // Helm of Fire
            break;
        case S_UNLEARN_TRIBAL:                              // S_UNLEARN_TRIBAL
            player->removeSpell(35585, SPEC_MASK_ALL, false);                     // Windhawk Hauberk
            player->removeSpell(35587, SPEC_MASK_ALL, false);                     // Windhawk Belt
            player->removeSpell(35588, SPEC_MASK_ALL, false);                     // Windhawk Bracers
            player->removeSpell(36075, SPEC_MASK_ALL, false);                     // Wildfeather Leggings
            player->removeSpell(36078, SPEC_MASK_ALL, false);                     // Living Crystal Breastplate
            player->removeSpell(10621, SPEC_MASK_ALL, false);                     // Wolfshead Helm
            player->removeSpell(10647, SPEC_MASK_ALL, false);                     // Feathered Breastplate
            break;
        case S_UNLEARN_SPELLFIRE:                           // S_UNLEARN_SPELLFIRE
            player->removeSpell(26752, SPEC_MASK_ALL, false);                     // Spellfire Belt
            player->removeSpell(26753, SPEC_MASK_ALL, false);                     // Spellfire Gloves
            player->removeSpell(26754, SPEC_MASK_ALL, false);                     // Spellfire Robe
            break;
        case S_UNLEARN_MOONCLOTH:                           // S_UNLEARN_MOONCLOTH
            player->removeSpell(26760, SPEC_MASK_ALL, false);                     // Primal Mooncloth Belt
            player->removeSpell(26761, SPEC_MASK_ALL, false);                     // Primal Mooncloth Shoulders
            player->removeSpell(26762, SPEC_MASK_ALL, false);                     // Primal Mooncloth Robe
            break;
        case S_UNLEARN_SHADOWEAVE:                          // S_UNLEARN_SHADOWEAVE
            player->removeSpell(26756, SPEC_MASK_ALL, false);                     // Frozen Shadoweave Shoulders
            player->removeSpell(26757, SPEC_MASK_ALL, false);                     // Frozen Shadoweave Boots
            player->removeSpell(26758, SPEC_MASK_ALL, false);                     // Frozen Shadoweave Robe
            break;
    }
}

void ProcessCastaction(Player* player, Creature* creature, uint32 spellId, uint32 triggeredSpellId, int32 cost)
{
    if ((!spellId || !player->HasSpell(spellId)) && player->HasEnoughMoney(cost))
    {
        player->CastSpell(player, triggeredSpellId, true);
        player->ModifyMoney(-cost);

        // xinef: save spells!
        player->SaveToDB(false, false);
    }
    else
        player->SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, creature, 0, 0);
    CloseGossipMenuFor(player);
}

void ProcessUnlearnAction(Player* player, Creature* creature, uint32 spellId, uint32 alternativeSpellId, int32 cost)
{
    if (EquippedOk(player, spellId))
    {
        if (player->HasEnoughMoney(cost))
        {
            player->CastSpell(player, spellId, true);
            ProfessionUnlearnSpells(player, spellId);
            player->ModifyMoney(-cost);
            if (alternativeSpellId)
                creature->CastSpell(player, alternativeSpellId, true);

            // xinef: save spells!
            player->SaveToDB(false, false);
        }
        else
            player->SendBuyError(BUY_ERR_NOT_ENOUGHT_MONEY, creature, 0, 0);
    }
    else
        player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, nullptr, nullptr);
    CloseGossipMenuFor(player);
}

/*###
# start menues alchemy
###*/

class npc_prof_alchemy : public CreatureScript
{
public:
    npc_prof_alchemy() : CreatureScript("npc_prof_alchemy") { }

    inline bool HasAlchemySpell(Player* player)
    {
        return (player->HasSpell(S_TRANSMUTE) || player->HasSpell(S_ELIXIR) || player->HasSpell(S_POTION));
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->IsVendor())
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        if (creature->IsTrainer())
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

        if (player->HasSkill(SKILL_ALCHEMY) && player->GetBaseSkillValue(SKILL_ALCHEMY) >= 325 && player->GetLevel() > 67)
        {
            if (player->GetQuestRewardStatus(Q_MASTER_TRANSMUTE) || player->GetQuestRewardStatus(Q_MASTER_ELIXIR) || player->GetQuestRewardStatus(Q_MASTER_POTION))
            {
                switch (creature->GetEntry())
                {
                    case N_TRAINER_TRANSMUTE:                                 //Zarevhi
                        if (!HasAlchemySpell(player))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_TRANSMUTE,    GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 1);
                        if (player->HasSpell(S_TRANSMUTE))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_TRANSMUTE,  GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 4);
                        break;
                    case N_TRAINER_ELIXIR:                                 //Lorokeem
                        if (!HasAlchemySpell(player))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_ELIXIR,       GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 2);
                        if (player->HasSpell(S_ELIXIR))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_ELIXIR,     GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 5);
                        break;
                    case N_TRAINER_POTION:                                 //Lauranna Thar'well
                        if (!HasAlchemySpell(player))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_POTION,       GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 3);
                        if (player->HasSpell(S_POTION))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_POTION,     GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 6);
                        break;
                }
            }
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    void SendActionMenu(Player* player, Creature* creature, uint32 action)
    {
        switch (action)
        {
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
            case GOSSIP_ACTION_TRAIN:
                player->GetSession()->SendTrainerList(creature);
                break;
            //Learn Alchemy
            case GOSSIP_ACTION_INFO_DEF + 1:
                ProcessCastaction(player, creature, S_TRANSMUTE, S_LEARN_TRANSMUTE, DoLearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                ProcessCastaction(player, creature, S_ELIXIR, S_LEARN_ELIXIR, DoLearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                ProcessCastaction(player, creature, S_POTION, S_LEARN_POTION, DoLearnCost(player));
                break;
            //Unlearn Alchemy
            case GOSSIP_ACTION_INFO_DEF + 4:
                ProcessUnlearnAction(player, creature, S_UNLEARN_TRANSMUTE, 0, DoHighUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                ProcessUnlearnAction(player, creature, S_UNLEARN_ELIXIR, 0, DoHighUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                ProcessUnlearnAction(player, creature, S_UNLEARN_POTION, 0, DoHighUnlearnCost(player));
                break;
        }
    }

    void SendConfirmLearn(Player* player, Creature* creature, uint32 action)
    {
        if (action)
        {
            switch (creature->GetEntry())
            {
                case N_TRAINER_TRANSMUTE:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_TRANSMUTE, GOSSIP_SENDER_CHECK, action);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_ELIXIR:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_ELIXIR,    GOSSIP_SENDER_CHECK, action);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_POTION:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_POTION,    GOSSIP_SENDER_CHECK, action);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
            }
        }
    }

    void SendConfirmUnlearn(Player* player, Creature* creature, uint32 action)
    {
        if (action)
        {
            switch (creature->GetEntry())
            {
                case N_TRAINER_TRANSMUTE:                                     //Zarevhi
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_TRANSMUTE, GOSSIP_SENDER_CHECK, action, BOX_UNLEARN_ALCHEMY_SPEC, DoHighUnlearnCost(player), false);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_ELIXIR:                                     //Lorokeem
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_ELIXIR, GOSSIP_SENDER_CHECK, action,    BOX_UNLEARN_ALCHEMY_SPEC, DoHighUnlearnCost(player), false);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_POTION:                                     //Lauranna Thar'well
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_POTION, GOSSIP_SENDER_CHECK, action,    BOX_UNLEARN_ALCHEMY_SPEC, DoHighUnlearnCost(player), false);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
            }
        }
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN:
                SendActionMenu(player, creature, action);
                break;

            case GOSSIP_SENDER_LEARN:
                SendConfirmLearn(player, creature, action);
                break;

            case GOSSIP_SENDER_UNLEARN:
                SendConfirmUnlearn(player, creature, action);
                break;

            case GOSSIP_SENDER_CHECK:
                SendActionMenu(player, creature, action);
                break;
        }
        return true;
    }
};

/*###
# start menues blacksmith
###*/

class npc_prof_blacksmith : public CreatureScript
{
public:
    npc_prof_blacksmith() : CreatureScript("npc_prof_blacksmith") { }

    inline bool HasWeaponSub(Player* player)
    {
        return (player->HasSpell(S_HAMMER) || player->HasSpell(S_AXE) || player->HasSpell(S_SWORD));
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->IsVendor())
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        if (creature->IsTrainer())
        {
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);
        }

        uint32 creatureId = creature->GetEntry();
        //WEAPONSMITH & ARMORSMITH
        if (player->GetBaseSkillValue(SKILL_BLACKSMITHING) >= 225)
        {
            if (player->GetQuestRewardStatus(5284) || player->GetQuestRewardStatus(5302) || player->GetQuestRewardStatus(5283) || player->GetQuestStatus(5301))
            {
                switch (creatureId)
                {
                    case N_TRAINER_SMITHOMNI1:                                     //Myolor Sunderfury
                    case N_TRAINER_SMITHOMNI2:                                     //Krathok Moltenfist
                        if (!player->HasSpell(S_ARMOR) && !player->HasSpell(S_WEAPON))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ARMOR_LEARN,   GOSSIP_SENDER_MAIN,          GOSSIP_ACTION_INFO_DEF + 1);
                        if (!player->HasSpell(S_WEAPON) && !player->HasSpell(S_ARMOR))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_WEAPON_LEARN,  GOSSIP_SENDER_MAIN,          GOSSIP_ACTION_INFO_DEF + 2);
                        break;
                    case N_TRAINER_WEAPON1:                                     //Ironus Coldsteel
                    case N_TRAINER_WEAPON2:                                     //Borgosh Corebender
                        if (player->HasSpell(S_WEAPON))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_WEAPON_UNLEARN,    GOSSIP_SENDER_UNLEARN,   GOSSIP_ACTION_INFO_DEF + 3);
                        break;
                    case N_TRAINER_ARMOR1:                                      //Grumnus Steelshaper
                    case N_TRAINER_ARMOR2:                                     //Okothos Ironrager
                        if (player->HasSpell(S_ARMOR))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_ARMOR_UNLEARN,     GOSSIP_SENDER_UNLEARN,   GOSSIP_ACTION_INFO_DEF + 4);
                        break;
                }
            }
        }
        //WEAPONSMITH SPEC
        if (player->HasSpell(S_WEAPON) && player->GetLevel() > 49 && player->GetBaseSkillValue(SKILL_BLACKSMITHING) >= 250)
        {
            switch (creatureId)
            {
                case N_TRAINER_HAMMER:                                     //Lilith the Lithe
                    if (!HasWeaponSub(player))
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_HAMMER,       GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 5);
                    if (player->HasSpell(S_HAMMER))
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_HAMMER,     GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 8);
                    break;
                case N_TRAINER_AXE:                                     //Kilram
                    if (!HasWeaponSub(player))
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_AXE,          GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 6);
                    if (player->HasSpell(S_AXE))
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_AXE,        GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 9);
                    break;
                case N_TRAINER_SWORD:                                     //Seril Scourgebane
                    if (!HasWeaponSub(player))
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_SWORD,        GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 7);
                    if (player->HasSpell(S_SWORD))
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_SWORD,      GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 10);
                    break;
            }
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    void SendActionMenu(Player* player, Creature* creature, uint32 action)
    {
        switch (action)
        {
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
            case GOSSIP_ACTION_TRAIN:
                player->GetSession()->SendTrainerList(creature);
                break;
            //Learn Armor/Weapon
            case GOSSIP_ACTION_INFO_DEF + 1:
                ProcessCastaction(player, creature, S_ARMOR, S_LEARN_ARMOR, 0);
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                ProcessCastaction(player, creature, S_WEAPON, S_LEARN_WEAPON, 0);
                break;
            //Unlearn Armor/Weapon
            case GOSSIP_ACTION_INFO_DEF + 3:
                if (HasWeaponSub(player))
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                else
                    ProcessUnlearnAction(player, creature, S_UNLEARN_WEAPON, S_REP_ARMOR, DoLowUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                ProcessUnlearnAction(player, creature, S_UNLEARN_ARMOR, S_REP_WEAPON, DoLowUnlearnCost(player));
                break;
            //Learn Hammer/Axe/Sword
            case GOSSIP_ACTION_INFO_DEF + 5:
                ProcessCastaction(player, creature, S_HAMMER, S_LEARN_HAMMER, 0);
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                ProcessCastaction(player, creature, S_AXE, S_LEARN_AXE, 0);
                break;
            case GOSSIP_ACTION_INFO_DEF + 7:
                ProcessCastaction(player, creature, S_SWORD, S_LEARN_SWORD, 0);
                break;
            //Unlearn Hammer/Axe/Sword
            case GOSSIP_ACTION_INFO_DEF + 8:
                ProcessUnlearnAction(player, creature, S_UNLEARN_HAMMER, 0, DoMedUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 9:
                ProcessUnlearnAction(player, creature, S_UNLEARN_AXE, 0, DoMedUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 10:
                ProcessUnlearnAction(player, creature, S_UNLEARN_SWORD, 0, DoMedUnlearnCost(player));
                break;
        }
    }

    void SendConfirmLearn(Player* player, Creature* creature, uint32 action)
    {
        if (action)
        {
            switch (creature->GetEntry())
            {
                case N_TRAINER_HAMMER:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_HAMMER, GOSSIP_SENDER_CHECK, action);
                    //unknown textID (TALK_HAMMER_LEARN)
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_AXE:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_AXE,    GOSSIP_SENDER_CHECK, action);
                    //unknown textID (TALK_AXE_LEARN)
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_SWORD:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_SWORD,  GOSSIP_SENDER_CHECK, action);
                    //unknown textID (TALK_SWORD_LEARN)
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
            }
        }
    }

    void SendConfirmUnlearn(Player* player, Creature* creature, uint32 action)
    {
        if (action)
        {
            switch (creature->GetEntry())
            {
                case N_TRAINER_WEAPON1:                                     //Ironus Coldsteel
                case N_TRAINER_WEAPON2:                                     //Borgosh Corebender
                case N_TRAINER_ARMOR1:                                      //Grumnus Steelshaper
                case N_TRAINER_ARMOR2:                                     //Okothos Ironrager
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_SMITH_SPEC, GOSSIP_SENDER_CHECK, action, BOX_UNLEARN_ARMORORWEAPON, DoLowUnlearnCost(player), false);
                    //unknown textID (TALK_UNLEARN_AXEORWEAPON)
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;

                case N_TRAINER_HAMMER:
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_HAMMER, GOSSIP_SENDER_CHECK, action,    BOX_UNLEARN_WEAPON_SPEC, DoMedUnlearnCost(player), false);
                    //unknown textID (TALK_HAMMER_UNLEARN)
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_AXE:
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_AXE, GOSSIP_SENDER_CHECK, action,       BOX_UNLEARN_WEAPON_SPEC, DoMedUnlearnCost(player), false);
                    //unknown textID (TALK_AXE_UNLEARN)
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_SWORD:
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_SWORD, GOSSIP_SENDER_CHECK, action,     BOX_UNLEARN_WEAPON_SPEC, DoMedUnlearnCost(player), false);
                    //unknown textID (TALK_SWORD_UNLEARN)
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
            }
        }
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN:
                SendActionMenu(player, creature, action);
                break;

            case GOSSIP_SENDER_LEARN:
                SendConfirmLearn(player, creature, action);
                break;

            case GOSSIP_SENDER_UNLEARN:
                SendConfirmUnlearn(player, creature, action);
                break;

            case GOSSIP_SENDER_CHECK:
                SendActionMenu(player, creature, action);
                break;
        }
        return true;
    }
};

/*###
# engineering trinkets
###*/

enum EngineeringTrinkets
{
    NPC_ZAP                     = 14742,
    NPC_JHORDY                  = 14743,
    NPC_KABLAM                  = 21493,
    NPC_SMILES                  = 21494,

    SPELL_LEARN_TO_EVERLOOK     = 23490,
    SPELL_LEARN_TO_GADGET       = 23491,
    SPELL_LEARN_TO_AREA52       = 36956,
    SPELL_LEARN_TO_TOSHLEY      = 36957,

    SPELL_TO_EVERLOOK           = 23486,
    SPELL_TO_GADGET             = 23489,
    SPELL_TO_AREA52             = 36954,
    SPELL_TO_TOSHLEY            = 36955,
};

#define GOSSIP_ITEM_ZAP         "This Dimensional Imploder sounds dangerous! How can I make one?"
#define GOSSIP_ITEM_JHORDY      "I must build a beacon for this marvelous device!"
#define GOSSIP_ITEM_KABLAM      "[PH] Unknown"

class npc_engineering_tele_trinket : public CreatureScript
{
public:
    npc_engineering_tele_trinket() : CreatureScript("npc_engineering_tele_trinket") { }

    bool CanLearn(Player* player, uint32 textId, uint32 altTextId, uint32 skillValue, uint32 reqSpellId, uint32 spellId, uint32& npcTextId)
    {
        bool res = false;
        npcTextId = textId;
        if (player->GetBaseSkillValue(SKILL_ENGINEERING) >= skillValue && player->HasSpell(reqSpellId))
        {
            if (!player->HasSpell(spellId))
                res = true;
            else
                npcTextId = altTextId;
        }
        return res;
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        uint32 npcTextId = 0;
        std::string gossipItem;
        bool canLearn = false;

        if (player->HasSkill(SKILL_ENGINEERING))
        {
            switch (creature->GetEntry())
            {
                case NPC_ZAP:
                    canLearn = CanLearn(player, 6092, 0, 260, S_GOBLIN, SPELL_TO_EVERLOOK, npcTextId);
                    if (canLearn)
                        gossipItem = GOSSIP_ITEM_ZAP;
                    break;
                case NPC_JHORDY:
                    canLearn = CanLearn(player, 7251, 7252, 260, S_GNOMISH, SPELL_TO_GADGET, npcTextId);
                    if (canLearn)
                        gossipItem = GOSSIP_ITEM_JHORDY;
                    break;
                case NPC_KABLAM:
                    canLearn = CanLearn(player, 10365, 0, 350, S_GOBLIN, SPELL_TO_AREA52, npcTextId);
                    if (canLearn)
                        gossipItem = GOSSIP_ITEM_KABLAM;
                    break;
                case NPC_SMILES:
                    canLearn = CanLearn(player, 10363, 0, 350, S_GNOMISH, SPELL_TO_TOSHLEY, npcTextId);
                    if (canLearn)
                        gossipItem = GOSSIP_ITEM_KABLAM;
                    break;
            }
        }

        if (canLearn)
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, gossipItem, creature->GetEntry(), GOSSIP_ACTION_INFO_DEF + 1);

        SendGossipMenuFor(player, npcTextId ? npcTextId : player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        ClearGossipMenuFor(player);
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
            CloseGossipMenuFor(player);

        if (sender != creature->GetEntry())
            return true;

        switch (sender)
        {
            case NPC_ZAP:
                player->CastSpell(player, SPELL_LEARN_TO_EVERLOOK, false);
                break;
            case NPC_JHORDY:
                player->CastSpell(player, SPELL_LEARN_TO_GADGET, false);
                break;
            case NPC_KABLAM:
                player->CastSpell(player, SPELL_LEARN_TO_AREA52, false);
                break;
            case NPC_SMILES:
                player->CastSpell(player, SPELL_LEARN_TO_TOSHLEY, false);
                break;
        }

        return true;
    }
};

/*###
# start menues leatherworking
###*/

class npc_prof_leather : public CreatureScript
{
public:
    npc_prof_leather() : CreatureScript("npc_prof_leather") { }

    inline bool HasLeatherSpecialty(Player* player)
    {
        return (player->HasSpell(S_DRAGON) || player->HasSpell(S_ELEMENTAL) || player->HasSpell(S_TRIBAL));
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ClearGossipMenuFor(player);

        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        switch (creature->GetEntry())
        {
            case N_TRAINER_DRAGON1:             //Peter Galen
            case N_TRAINER_DRAGON2:             //Thorkaf Dragoneye
                AddGossipItemFor(player, creature->GetEntry() == N_TRAINER_DRAGON1 ? GOSSIP_MENU_PETER_GALEN : GOSSIP_MENU_THORKAF_DRAGONEYE, GOSSIP_MENU_OPTION_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);
                break;
            case N_TRAINER_ELEMENTAL1:          //Sarah Tanner
            case N_TRAINER_ELEMENTAL2:          //Brumn Winterhoof
                AddGossipItemFor(player, creature->GetEntry() == N_TRAINER_ELEMENTAL1 ? GOSSIP_MENU_SARAH_TANNER : GOSSIP_MENU_BRUMN_WINTERHOOF, GOSSIP_MENU_OPTION_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);
                break;
            case N_TRAINER_TRIBAL1:             //Caryssia Moonhunter
            case N_TRAINER_TRIBAL2:             //Se'Jib
                AddGossipItemFor(player, creature->GetEntry() == N_TRAINER_TRIBAL1 ? GOSSIP_MENU_CARYSSIA_MOONHUNTER : GOSSIP_MENU_SEJIB, GOSSIP_MENU_OPTION_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);
                break;
        }

        if (player->HasSkill(SKILL_LEATHERWORKING) && player->GetBaseSkillValue(SKILL_LEATHERWORKING) >= 225 && player->GetLevel() > 40)
        {
            switch (creature->GetEntry())
            {
                case N_TRAINER_DRAGON1:             //Peter Galen
                case N_TRAINER_DRAGON2:             //Thorkaf Dragoneye
                    if (player->HasSpell(S_DRAGON))
                        AddGossipItemFor(player, creature->GetEntry() == N_TRAINER_DRAGON1 ? GOSSIP_MENU_PETER_GALEN : GOSSIP_MENU_THORKAF_DRAGONEYE, GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_DRAGONSCALE, GOSSIP_SENDER_MAIN, GOSSIP_MENU_UNLEARN_CONFIRM_DRAGONSCALE);
                    break;
                case N_TRAINER_ELEMENTAL1:          //Sarah Tanner
                case N_TRAINER_ELEMENTAL2:          //Brumn Winterhoof
                    if (player->HasSpell(S_ELEMENTAL))
                        AddGossipItemFor(player, creature->GetEntry() == N_TRAINER_ELEMENTAL1 ? GOSSIP_MENU_SARAH_TANNER : GOSSIP_MENU_BRUMN_WINTERHOOF, GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_ELEMENTAL, GOSSIP_SENDER_MAIN, GOSSIP_MENU_UNLEARN_CONFIRM_ELEMENTAL);
                    break;
                case N_TRAINER_TRIBAL1:             //Caryssia Moonhunter
                case N_TRAINER_TRIBAL2:             //Se'Jib
                    if (player->HasSpell(S_TRIBAL))
                        AddGossipItemFor(player, creature->GetEntry() == N_TRAINER_TRIBAL1 ? GOSSIP_MENU_CARYSSIA_MOONHUNTER : GOSSIP_MENU_SEJIB, GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_TRIBAL, GOSSIP_SENDER_MAIN, GOSSIP_MENU_UNLEARN_CONFIRM_TRIBAL);
                    break;
            }
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_TRAIN:
                player->GetSession()->SendTrainerList(creature);
                break;
            case GOSSIP_MENU_UNLEARN_CONFIRM_DRAGONSCALE:
                AddGossipItemFor(player, GOSSIP_MENU_UNLEARN_CONFIRM_DRAGONSCALE, GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_DRAGONSCALE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1, DoMedUnlearnCost(player));
                SendGossipMenuFor(player, GOSSIP_TEXT_UNLEARN_CONFIRM_DRAGONSCALE, creature);
                break;
            case GOSSIP_MENU_UNLEARN_CONFIRM_ELEMENTAL:
                AddGossipItemFor(player, GOSSIP_MENU_UNLEARN_CONFIRM_ELEMENTAL, GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_ELEMENTAL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2, DoMedUnlearnCost(player));
                SendGossipMenuFor(player, GOSSIP_TEXT_UNLEARN_CONFIRM_ELEMENTAL, creature);
                break;
            case GOSSIP_MENU_UNLEARN_CONFIRM_TRIBAL:
                AddGossipItemFor(player, GOSSIP_MENU_UNLEARN_CONFIRM_TRIBAL, GOSSIP_MENU_OPTION_CONFIRM_UNLEARN_TRIBAL, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3, DoMedUnlearnCost(player));
                SendGossipMenuFor(player, GOSSIP_TEXT_UNLEARN_CONFIRM_TRIBAL, creature);
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                ProcessUnlearnAction(player, creature, S_UNLEARN_DRAGON, 0, DoMedUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                ProcessUnlearnAction(player, creature, S_UNLEARN_ELEMENTAL, 0, DoMedUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                ProcessUnlearnAction(player, creature, S_UNLEARN_TRIBAL, 0, DoMedUnlearnCost(player));
                break;
        }
        return true;
    }
};

/*###
# start menues tailoring
###*/

class npc_prof_tailor : public CreatureScript
{
public:
    npc_prof_tailor() : CreatureScript("npc_prof_tailor") { }

    inline bool HasTailorSpell(Player* player)
    {
        return (player->HasSpell(S_MOONCLOTH) || player->HasSpell(S_SHADOWEAVE) || player->HasSpell(S_SPELLFIRE));
    }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (creature->IsVendor())
            AddGossipItemFor(player, GOSSIP_ICON_VENDOR, GOSSIP_TEXT_BROWSE_GOODS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRADE);

        if (creature->IsTrainer())
        {
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);
        }

        //TAILORING SPEC
        if (player->HasSkill(SKILL_TAILORING) && player->GetBaseSkillValue(SKILL_TAILORING) >= 350 && player->GetLevel() > 59)
        {
            if (player->GetQuestRewardStatus(10831) || player->GetQuestRewardStatus(10832) || player->GetQuestRewardStatus(10833))
            {
                switch (creature->GetEntry())
                {
                    case N_TRAINER_SPELLFIRE:                                 //Gidge Spellweaver
                        if (!HasTailorSpell(player))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_SPELLFIRE,    GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 1);
                        if (player->HasSpell(S_SPELLFIRE))
                        {
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_SPELLFIRE,  GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 4);
                        }
                        break;
                    case N_TRAINER_MOONCLOTH:                                 //Nasmara Moonsong
                        if (!HasTailorSpell(player))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_MOONCLOTH,    GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 2);
                        if (player->HasSpell(S_MOONCLOTH))
                        {
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_MOONCLOTH,  GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 5);
                        }
                        break;
                    case N_TRAINER_SHADOWEAVE:                                 //Andrion Darkspinner
                        if (!HasTailorSpell(player))
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_SHADOWEAVE,   GOSSIP_SENDER_LEARN,    GOSSIP_ACTION_INFO_DEF + 3);
                        if (player->HasSpell(S_SHADOWEAVE))
                        {
                            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_UNLEARN_SHADOWEAVE, GOSSIP_SENDER_UNLEARN,  GOSSIP_ACTION_INFO_DEF + 6);
                        }
                        break;
                }
            }
        }

        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    void SendActionMenu(Player* player, Creature* creature, uint32 action)
    {
        switch (action)
        {
            case GOSSIP_ACTION_TRADE:
                player->GetSession()->SendListInventory(creature->GetGUID());
                break;
            case GOSSIP_ACTION_TRAIN:
                player->GetSession()->SendTrainerList(creature);
                break;
            //Learn Tailor
            case GOSSIP_ACTION_INFO_DEF + 1:
                ProcessCastaction(player, creature, S_SPELLFIRE, S_LEARN_SPELLFIRE, DoLearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                ProcessCastaction(player, creature, S_MOONCLOTH, S_LEARN_MOONCLOTH, DoLearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                ProcessCastaction(player, creature, S_SHADOWEAVE, S_LEARN_SHADOWEAVE, DoLearnCost(player));
                break;
            //Unlearn Tailor
            case GOSSIP_ACTION_INFO_DEF + 4:
                ProcessUnlearnAction(player, creature, S_UNLEARN_SPELLFIRE, 0, DoHighUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                ProcessUnlearnAction(player, creature, S_UNLEARN_MOONCLOTH, 0, DoHighUnlearnCost(player));
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                ProcessUnlearnAction(player, creature, S_UNLEARN_SHADOWEAVE, 0, DoHighUnlearnCost(player));
                break;
        }
    }

    void SendConfirmLearn(Player* player, Creature* creature, uint32 action)
    {
        if (action)
        {
            switch (creature->GetEntry())
            {
                case N_TRAINER_SPELLFIRE:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_SPELLFIRE, GOSSIP_SENDER_CHECK, action);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_MOONCLOTH:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_MOONCLOTH,    GOSSIP_SENDER_CHECK, action);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_SHADOWEAVE:
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_SHADOWEAVE,  GOSSIP_SENDER_CHECK, action);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
            }
        }
    }

    void SendConfirmUnlearn(Player* player, Creature* creature, uint32 action)
    {
        if (action)
        {
            switch (creature->GetEntry())
            {
                case N_TRAINER_SPELLFIRE:                                     //Gidge Spellweaver
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_SPELLFIRE, GOSSIP_SENDER_CHECK, action, BOX_UNLEARN_TAILOR_SPEC, DoHighUnlearnCost(player), false);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_MOONCLOTH:                                     //Nasmara Moonsong
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_MOONCLOTH, GOSSIP_SENDER_CHECK, action, BOX_UNLEARN_TAILOR_SPEC, DoHighUnlearnCost(player), false);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
                case N_TRAINER_SHADOWEAVE:                                     //Andrion Darkspinner
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_SHADOWEAVE, GOSSIP_SENDER_CHECK, action, BOX_UNLEARN_TAILOR_SPEC, DoHighUnlearnCost(player), false);
                    //unknown textID ()
                    SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
                    break;
            }
        }
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        ClearGossipMenuFor(player);
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN:
                SendActionMenu(player, creature, action);
                break;

            case GOSSIP_SENDER_LEARN:
                SendConfirmLearn(player, creature, action);
                break;

            case GOSSIP_SENDER_UNLEARN:
                SendConfirmUnlearn(player, creature, action);
                break;

            case GOSSIP_SENDER_CHECK:
                SendActionMenu(player, creature, action);
                break;
        }
        return true;
    }
};

class go_evil_book_for_dummies : public GameObjectScript
{
public:
    go_evil_book_for_dummies() : GameObjectScript("go_evil_book_for_dummies") { }

    inline bool HasLeatherSpecialty(Player* player)
    {
        return (player->HasSpell(S_DRAGON) || player->HasSpell(S_ELEMENTAL) || player->HasSpell(S_TRIBAL));
    }

    bool OnGossipHello(Player* player, GameObject* gameobject) override
    {
        //ENGINEERING SPEC
        if (player->HasSkill(SKILL_ENGINEERING) && player->GetBaseSkillValue(SKILL_ENGINEERING) >= 225 && player->GetLevel() >= 35)
        {
            if (player->GetQuestRewardStatus(3643) || player->GetQuestRewardStatus(3641) || player->GetQuestRewardStatus(3639))
            {
                if (player->HasSpell(S_GOBLIN)) // Has Goblin specialization
                {
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_GOBLIN, GOSSIP_SENDER_UNLEARN, GOSSIP_ACTION_INFO_DEF + 3, BOX_UNLEARN_ENGIN_SPEC, DoHighUnlearnCost(player), false);
                }
                else if (player->HasSpell(S_GNOMISH)) // Has Gnomish specialization
                {
                    AddGossipItemFor(player, 0, GOSSIP_UNLEARN_GNOMISH, GOSSIP_SENDER_UNLEARN, GOSSIP_ACTION_INFO_DEF + 4, BOX_UNLEARN_ENGIN_SPEC, DoHighUnlearnCost(player), false);
                }
                else // does not have any specialization
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_GOBLIN, GOSSIP_SENDER_LEARN, GOSSIP_ACTION_INFO_DEF + 1, BOX_LEARN_ENGIN_SPEC, DoLearnCost(player), false);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_GNOMISH, GOSSIP_SENDER_LEARN, GOSSIP_ACTION_INFO_DEF + 2, BOX_LEARN_ENGIN_SPEC, DoLearnCost(player), false);
                }
            }
        }

        //LEATHERWORKING SPEC
        if (player->HasSkill(SKILL_LEATHERWORKING) && player->GetBaseSkillValue(SKILL_LEATHERWORKING) >= 225 && player->GetLevel() >= 40)
        {
            if (!HasLeatherSpecialty(player) && (player->GetQuestRewardStatus(5141) || player->GetQuestRewardStatus(5143) || player->GetQuestRewardStatus(5144) || player->GetQuestRewardStatus(5145) || player->GetQuestRewardStatus(5146) || player->GetQuestRewardStatus(5148)))
            {
                AddGossipItemFor(player, GOSSIP_MENU_GO_SOOTHSAYING_FOR_DUMMIES, GOSSIP_MENU_OPTION_GO_LEARN_DRAGONSCALE, GOSSIP_SENDER_LEARN, GOSSIP_ACTION_INFO_DEF + 5);
                AddGossipItemFor(player, GOSSIP_MENU_GO_SOOTHSAYING_FOR_DUMMIES, GOSSIP_MENU_OPTION_GO_LEARN_ELEMENTAL, GOSSIP_SENDER_LEARN, GOSSIP_ACTION_INFO_DEF + 6);
                AddGossipItemFor(player, GOSSIP_MENU_GO_SOOTHSAYING_FOR_DUMMIES, GOSSIP_MENU_OPTION_GO_LEARN_TRIBAL, GOSSIP_SENDER_LEARN, GOSSIP_ACTION_INFO_DEF + 7);
            }
        }

        SendGossipMenuFor(player, player->GetGossipTextId(gameobject), gameobject->GetGUID());
        return true;
    }

    void SendActionMenu(Player* player, GameObject*  /*gameobject*/, uint32 uiAction)
    {
        switch (uiAction)
        {
            // Learn Goblin
            case GOSSIP_ACTION_INFO_DEF + 1:
                ProcessCastaction(player, nullptr, S_GOBLIN, S_LEARN_GOBLIN, DoLearnCost(player));
                break;
            // Learn Gnomish
            case GOSSIP_ACTION_INFO_DEF + 2:
                ProcessCastaction(player, nullptr, S_GNOMISH, S_LEARN_GNOMISH, DoLearnCost(player));
                break;
            //Unlearn Goblin
            case GOSSIP_ACTION_INFO_DEF + 3:
                ProcessUnlearnAction(player, nullptr, S_UNLEARN_GOBLIN, 0, DoHighUnlearnCost(player));
                break;
            //Unlearn Gnomish
            case GOSSIP_ACTION_INFO_DEF + 4:
                ProcessUnlearnAction(player, nullptr, S_UNLEARN_GNOMISH, 0, DoHighUnlearnCost(player));
                break;
            //Learn Dragon
            case GOSSIP_ACTION_INFO_DEF + 5:
                ProcessCastaction(player, nullptr, S_DRAGON, S_LEARN_DRAGON, 0);
                break;
            //Learn Elemental
            case GOSSIP_ACTION_INFO_DEF + 6:
                ProcessCastaction(player, nullptr, S_ELEMENTAL, S_LEARN_ELEMENTAL, 0);
                break;
            //Learn Tribal
            case GOSSIP_ACTION_INFO_DEF + 7:
                ProcessCastaction(player, nullptr, S_TRIBAL, S_LEARN_TRIBAL, 0);
                break;
        }
    }

    void SendConfirmLearn(Player* player, GameObject* gameobject, uint32 uiAction)
    {
        switch (uiAction)
        {
            // Goblin
            case GOSSIP_ACTION_INFO_DEF + 1:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_GOBLIN, GOSSIP_SENDER_CHECK, uiAction);
                SendGossipMenuFor(player, player->GetGossipTextId(gameobject), gameobject->GetGUID());
                break;
            // Gnomish
            case GOSSIP_ACTION_INFO_DEF + 2:
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_LEARN_GNOMISH, GOSSIP_SENDER_CHECK, uiAction);
                SendGossipMenuFor(player, player->GetGossipTextId(gameobject), gameobject->GetGUID());
                break;
        }
    }

    void SendConfirmUnlearn(Player* player, GameObject* gameobject, uint32 uiAction)
    {
        switch (uiAction)
        {
            // Goblin
            case GOSSIP_ACTION_INFO_DEF + 3:
                AddGossipItemFor(player, 0, GOSSIP_UNLEARN_GOBLIN, GOSSIP_SENDER_CHECK, uiAction, BOX_UNLEARN_ENGIN_SPEC, DoHighUnlearnCost(player), false);
                SendGossipMenuFor(player, player->GetGossipTextId(gameobject), gameobject->GetGUID());
                break;
            // Gnomish
            case GOSSIP_ACTION_INFO_DEF + 4:
                AddGossipItemFor(player, 0, GOSSIP_UNLEARN_GNOMISH, GOSSIP_SENDER_CHECK, uiAction, BOX_UNLEARN_ENGIN_SPEC, DoHighUnlearnCost(player), false);
                SendGossipMenuFor(player, player->GetGossipTextId(gameobject), gameobject->GetGUID());
                break;
        }
    }

    bool OnGossipSelect(Player* player, GameObject* gameobject, uint32 uiSender, uint32 uiAction) override
    {
        ClearGossipMenuFor(player);
        switch (uiSender)
        {
            case GOSSIP_SENDER_LEARN:
                SendActionMenu(player, gameobject, uiAction);
                break;
            case GOSSIP_SENDER_UNLEARN:
                SendActionMenu(player, gameobject, uiAction);
                break;
        }
        return true;
    }
};

void AddSC_npc_professions()
{
    new npc_prof_alchemy();
    new npc_prof_blacksmith();
    new npc_engineering_tele_trinket();
    new npc_prof_leather();
    new npc_prof_tailor();
    new go_evil_book_for_dummies();
}
