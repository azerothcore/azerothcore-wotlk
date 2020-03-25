/* =============================================================
TO DO:
• Merge human sql template with alliance template
• As Barbz suggested: Rename to character_template the module 
    and all related files (to be less confusing and less generic)
• As Barbz suggested: Scaling system for twink servers
================================================================ */

#include "TemplateNPC.h"
#include "Chat.h"

void sTemplateNPC::ApplyBonus(Player *player, Item *item, EnchantmentSlot slot, uint32 bonusEntry)
{
    if (!item)
        return;

    if (!bonusEntry || bonusEntry == 0)
        return;

    player->ApplyEnchantment(item, slot, false);
    item->SetEnchantment(slot, bonusEntry, 0, 0);
    player->ApplyEnchantment(item, slot, true);
}

void sTemplateNPC::EquipTemplateGear(Player *player)
{
    if (player->getRace() == RACE_HUMAN)
    {
        for (HumanGearContainer::const_iterator itr = m_HumanGearContainer.begin(); itr != m_HumanGearContainer.end(); ++itr)
        {
            if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            {
                player->EquipNewItem((*itr)->pos, (*itr)->itemEntry, true); // Equip the item and apply enchants and gems
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PERM_ENCHANTMENT_SLOT, (*itr)->enchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT, (*itr)->socket1);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_2, (*itr)->socket2);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_3, (*itr)->socket3);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), BONUS_ENCHANTMENT_SLOT, (*itr)->bonusEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PRISMATIC_ENCHANTMENT_SLOT, (*itr)->prismaticEnchant);
            }
        }
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        for (AllianceGearContainer::const_iterator itr = m_AllianceGearContainer.begin(); itr != m_AllianceGearContainer.end(); ++itr)
        {
            if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            {
                player->EquipNewItem((*itr)->pos, (*itr)->itemEntry, true); // Equip the item and apply enchants and gems
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PERM_ENCHANTMENT_SLOT, (*itr)->enchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT, (*itr)->socket1);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_2, (*itr)->socket2);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_3, (*itr)->socket3);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), BONUS_ENCHANTMENT_SLOT, (*itr)->bonusEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PRISMATIC_ENCHANTMENT_SLOT, (*itr)->prismaticEnchant);
            }
        }
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {
        for (HordeGearContainer::const_iterator itr = m_HordeGearContainer.begin(); itr != m_HordeGearContainer.end(); ++itr)
        {
            if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            {
                player->EquipNewItem((*itr)->pos, (*itr)->itemEntry, true); // Equip the item and apply enchants and gems
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PERM_ENCHANTMENT_SLOT, (*itr)->enchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT, (*itr)->socket1);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_2, (*itr)->socket2);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_3, (*itr)->socket3);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), BONUS_ENCHANTMENT_SLOT, (*itr)->bonusEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PRISMATIC_ENCHANTMENT_SLOT, (*itr)->prismaticEnchant);
            }
        }
    }
}

void sTemplateNPC::LoadHumanGearContainer()
{
    for (HumanGearContainer::const_iterator itr = m_HumanGearContainer.begin(); itr != m_HumanGearContainer.end(); ++itr)
        delete *itr;

    m_HumanGearContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec, pos, itemEntry, enchant, socket1, socket2, socket3, bonusEnchant, prismaticEnchant FROM template_npc_human;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        sLog->outString(">>TEMPLATE NPC: Loaded 0 'gear templates. DB table `template_npc_human` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        HumanGearTemplate *pItem = new HumanGearTemplate;

        pItem->playerClass = fields[0].GetString();
        pItem->playerSpec = fields[1].GetString();
        pItem->pos = fields[2].GetUInt8();
        pItem->itemEntry = fields[3].GetUInt32();
        pItem->enchant = fields[4].GetUInt32();
        pItem->socket1 = fields[5].GetUInt32();
        pItem->socket2 = fields[6].GetUInt32();
        pItem->socket3 = fields[7].GetUInt32();
        pItem->bonusEnchant = fields[8].GetUInt32();
        pItem->prismaticEnchant = fields[9].GetUInt32();

        m_HumanGearContainer.push_back(pItem);
        ++count;
    } while (result->NextRow());
    sLog->outString(">>TEMPLATE NPC: Loaded %u gear templates for Humans in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sTemplateNPC::LoadAllianceGearContainer()
{
    for (AllianceGearContainer::const_iterator itr = m_AllianceGearContainer.begin(); itr != m_AllianceGearContainer.end(); ++itr)
        delete *itr;

    m_AllianceGearContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec, pos, itemEntry, enchant, socket1, socket2, socket3, bonusEnchant, prismaticEnchant FROM template_npc_alliance;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        sLog->outString(">>TEMPLATE NPC: Loaded 0 'gear templates. DB table `template_npc_alliance` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        AllianceGearTemplate *pItem = new AllianceGearTemplate;

        pItem->playerClass = fields[0].GetString();
        pItem->playerSpec = fields[1].GetString();
        pItem->pos = fields[2].GetUInt8();
        pItem->itemEntry = fields[3].GetUInt32();
        pItem->enchant = fields[4].GetUInt32();
        pItem->socket1 = fields[5].GetUInt32();
        pItem->socket2 = fields[6].GetUInt32();
        pItem->socket3 = fields[7].GetUInt32();
        pItem->bonusEnchant = fields[8].GetUInt32();
        pItem->prismaticEnchant = fields[9].GetUInt32();

        m_AllianceGearContainer.push_back(pItem);
        ++count;
    } while (result->NextRow());
    sLog->outString(">>TEMPLATE NPC: Loaded %u gear templates for Alliances in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sTemplateNPC::LoadHordeGearContainer()
{
    for (HordeGearContainer::const_iterator itr = m_HordeGearContainer.begin(); itr != m_HordeGearContainer.end(); ++itr)
        delete *itr;

    m_HordeGearContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec, pos, itemEntry, enchant, socket1, socket2, socket3, bonusEnchant, prismaticEnchant FROM template_npc_horde;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        sLog->outString(">>TEMPLATE NPC: Loaded 0 'gear templates. DB table `template_npc_horde` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        HordeGearTemplate *pItem = new HordeGearTemplate;

        pItem->playerClass = fields[0].GetString();
        pItem->playerSpec = fields[1].GetString();
        pItem->pos = fields[2].GetUInt8();
        pItem->itemEntry = fields[3].GetUInt32();
        pItem->enchant = fields[4].GetUInt32();
        pItem->socket1 = fields[5].GetUInt32();
        pItem->socket2 = fields[6].GetUInt32();
        pItem->socket3 = fields[7].GetUInt32();
        pItem->bonusEnchant = fields[8].GetUInt32();
        pItem->prismaticEnchant = fields[9].GetUInt32();

        m_HordeGearContainer.push_back(pItem);
        ++count;
    } while (result->NextRow());
    sLog->outString(">>TEMPLATE NPC: Loaded %u gear templates for Hordes in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

std::string sTemplateNPC::GetClassString(Player *player)
{
    switch (player->getClass())
    {
    case CLASS_PRIEST:
        return "Priest";
        break;
    case CLASS_PALADIN:
        return "Paladin";
        break;
    case CLASS_WARRIOR:
        return "Warrior";
        break;
    case CLASS_MAGE:
        return "Mage";
        break;
    case CLASS_WARLOCK:
        return "Warlock";
        break;
    case CLASS_SHAMAN:
        return "Shaman";
        break;
    case CLASS_DRUID:
        return "Druid";
        break;
    case CLASS_HUNTER:
        return "Hunter";
        break;
    case CLASS_ROGUE:
        return "Rogue";
        break;
    case CLASS_DEATH_KNIGHT:
        return "DeathKnight";
        break;
    default:
        break;
    }
    return "Unknown"; // Fix warning, this should never happen
}

void sTemplateNPC::PurgeTemplate(Player *player, std::string &playerSpecStr, TemplateType type)
{
    switch (type)
    {
    case TYPE_HUMAN:
        CharacterDatabase.PQuery("DELETE FROM template_npc_human WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());
        break;
    case TYPE_ALLIANCE:
        CharacterDatabase.PQuery("DELETE FROM template_npc_alliance WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());
        break;
    case TYPE_HORDE:
        CharacterDatabase.PQuery("DELETE FROM template_npc_horde WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());
        break;
    }
}

void sTemplateNPC::CopyGear(Player *target, Player *src)
{
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        Item *equippedItem = src->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (!equippedItem)
            continue;

        target->EquipNewItem(i, equippedItem->GetEntry(), true);

        ApplyBonus(target, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i), PERM_ENCHANTMENT_SLOT, equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT));
        ApplyBonus(target, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i), SOCK_ENCHANTMENT_SLOT, equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT));
        ApplyBonus(target, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i), SOCK_ENCHANTMENT_SLOT_2, equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2));
        ApplyBonus(target, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i), SOCK_ENCHANTMENT_SLOT_3, equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3));
        ApplyBonus(target, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i), BONUS_ENCHANTMENT_SLOT, equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT));
        ApplyBonus(target, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i), PRISMATIC_ENCHANTMENT_SLOT, equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
    
    }
}

void sTemplateNPC::ExtractGearTemplateToDB(Player *player, std::string &playerSpecStr, TemplateType type)
{
    PurgeTemplate(player, playerSpecStr, type);

    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        Item *equippedItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);

        if (equippedItem)
        {
            if (type == TYPE_HUMAN)
            {
                CharacterDatabase.PExecute("INSERT INTO template_npc_human (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('%s', '%s', '%u', '%u', '%u', '%u', '%u', '%u', '%u', '%u');", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(),
                                           equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                                           equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT),
                                           equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2),
                                           equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                                           equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT),
                                           equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (type == TYPE_ALLIANCE)
            {
                CharacterDatabase.PExecute("INSERT INTO template_npc_alliance (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('%s', '%s', '%u', '%u', '%u', '%u', '%u', '%u', '%u', '%u');", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                                           equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                                           equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (type == TYPE_HORDE)
            {
                CharacterDatabase.PExecute("INSERT INTO template_npc_horde (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('%s', '%s', '%u', '%u', '%u', '%u', '%u', '%u', '%u', '%u');", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                                           equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                                           equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
        }
    }
}

bool sTemplateNPC::CanEquipTemplate(Player *player, std::string &playerSpecStr)
{
    if (player->getRace() == RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT playerClass, playerSpec FROM template_npc_human "
                                                      "WHERE playerClass = '%s' AND playerSpec = '%s';",
                                                      GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT playerClass, playerSpec FROM template_npc_alliance "
                                                      "WHERE playerClass = '%s' AND playerSpec = '%s';",
                                                      GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT playerClass, playerSpec FROM template_npc_horde "
                                                      "WHERE playerClass = '%s' AND playerSpec = '%s';",
                                                      GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    return true;
}

class TemplateNPC : public CreatureScript
{
public:
    TemplateNPC() : CreatureScript("TemplateNPC") {}

    bool OnGossipHello(Player *player, Creature *creature)
    {
        switch (player->getClass())
        {
        case CLASS_PRIEST:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_wordfortitude:30|t|r Use Discipline Gear", GOSSIP_SENDER_MAIN, 0);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_shadowwordpain:30|t|r Use Shadow Gear", GOSSIP_SENDER_MAIN, 2);
            break;
        case CLASS_PALADIN:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r Use Holy Gear", GOSSIP_SENDER_MAIN, 3);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_devotionaura:30|t|r Use Protection Gear", GOSSIP_SENDER_MAIN, 4);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_auraoflight:30|t|r Use Retribution Gear", GOSSIP_SENDER_MAIN, 5);

            break;
        case CLASS_WARRIOR:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Arms Gear", GOSSIP_SENDER_MAIN, 7);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_defensivestance:30|t|r Use Protection Gear", GOSSIP_SENDER_MAIN, 8);

            break;
        case CLASS_MAGE:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_magicalsentry:30|t|r Use Arcane Gear", GOSSIP_SENDER_MAIN, 9);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_fire_flamebolt:30|t|r Use Fire Gear", GOSSIP_SENDER_MAIN, 10);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_frost_frostbolt02:30|t|r Use Frost Gear", GOSSIP_SENDER_MAIN, 11);

            break;
        case CLASS_WARLOCK:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_deathcoil:30|t|r Use Affliction Gear", GOSSIP_SENDER_MAIN, 12);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_rainoffire:30|t|r Use Destruction Gear", GOSSIP_SENDER_MAIN, 14);

            break;
        case CLASS_SHAMAN:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightning:30|t|r Use Elemental Gear", GOSSIP_SENDER_MAIN, 15);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightningshield:30|t|r Use Enhancement Gear", GOSSIP_SENDER_MAIN, 16);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_magicimmunity:30|t|r Use Restoration Gear", GOSSIP_SENDER_MAIN, 17);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);

            break;
        case CLASS_DRUID:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_starfall:30|t|r Use Ballance Gear", GOSSIP_SENDER_MAIN, 18);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_racial_bearform:30|t|r Use Feral Gear", GOSSIP_SENDER_MAIN, 19);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_healingtouch:30|t|r Use Restoration Gear", GOSSIP_SENDER_MAIN, 20);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);

            break;
        case CLASS_HUNTER:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_marksmanship:30|t|r Use Marksmanship Gear", GOSSIP_SENDER_MAIN, 21);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_hunter_beasttaming:30|t|r Use Beastmastery Gear", GOSSIP_SENDER_MAIN, 22);

            break;
        case CLASS_ROGUE:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Assasination Gear", GOSSIP_SENDER_MAIN, 24);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_stealth:30|t|r Use Subtlety Gear", GOSSIP_SENDER_MAIN, 26);

            break;
        case CLASS_DEATH_KNIGHT:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_frostpresence:30|t|r Use Frost Gear", GOSSIP_SENDER_MAIN, 28);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_unholypresence:30|t|r Use Unholy Gear", GOSSIP_SENDER_MAIN, 29);
            break;
        }

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Spell_ChargeNegative:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);
        player->SEND_GOSSIP_MENU(55002, creature->GetGUID());

        return true;
    }

    static void EquipFullTemplateGear(Player *player, std::string &playerSpecStr) // Merge
    {
        if (sTemplateNpcMgr->CanEquipTemplate(player, playerSpecStr) == false)
        {
            player->GetSession()->SendAreaTriggerMessage("There's no templates for %s specialization yet.", playerSpecStr.c_str());
            return;
        }

        // Don't let players to use Template feature while wearing some gear
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
            if (Item *haveItemEquipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                if (haveItemEquipped)
                {
                    player->GetSession()->SendAreaTriggerMessage("You need to remove all your equipped items in order to use this feature!");
                    player->CLOSE_GOSSIP_MENU();
                    return;
                }
            }
        }

        // Don't let players to use Template feature after spending some talent points
        if (player->GetFreeTalentPoints() < 71)
        {
            player->GetSession()->SendAreaTriggerMessage("You have already spent some talent points. You need to reset your talents first!");
            player->CLOSE_GOSSIP_MENU();
            return;
        }
        sTemplateNpcMgr->EquipTemplateGear(player);

        player->GetSession()->SendAreaTriggerMessage("Successfuly equipped %s %s template!", playerSpecStr.c_str(), sTemplateNpcMgr->GetClassString(player).c_str());

        if (player->getPowerType() == POWER_MANA)
            player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));

        player->SetHealth(player->GetMaxHealth());
    }

    static void LearnOnlyTalentsAndGlyphs(Player *player, std::string &playerSpecStr) // Merge
    {
        if (sTemplateNpcMgr->CanEquipTemplate(player, playerSpecStr) == false)
        {
            player->GetSession()->SendAreaTriggerMessage("There's no templates for %s specialization yet.", playerSpecStr.c_str());
            return;
        }

        // Don't let players to use Template feature after spending some talent points
        if (player->GetFreeTalentPoints() < 71)
        {
            player->GetSession()->SendAreaTriggerMessage("You have already spent some talent points. You need to reset your talents first!");
            player->CLOSE_GOSSIP_MENU();
            return;
        }

        player->GetSession()->SendAreaTriggerMessage("Successfuly learned talent spec %s!", playerSpecStr.c_str());
    }

    bool OnGossipSelect(Player *player, Creature *creature, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();

        if (!player || !creature)
            return false;

        switch (uiAction)
        {
        case 0: // Use Discipline Priest Spec
            sTemplateNpcMgr->sTalentsSpec = "Discipline";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 1: // Use Holy Priest Spec
            sTemplateNpcMgr->sTalentsSpec = "Holy";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 2: // Use Shadow Priest Spec
            sTemplateNpcMgr->sTalentsSpec = "Shadow";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 3: // Use Holy Paladin Spec
            sTemplateNpcMgr->sTalentsSpec = "Holy";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 4: // Use Protection Paladin Spec
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 5: // Use Retribution Paladin Spec
            sTemplateNpcMgr->sTalentsSpec = "Retribution";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 6: // Use Fury Warrior Spec
            sTemplateNpcMgr->sTalentsSpec = "Fury";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 7: // Use Arms Warrior Spec
            sTemplateNpcMgr->sTalentsSpec = "Arms";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 8: // Use Protection Warrior Spec
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 9: // Use Arcane Mage Spec
            sTemplateNpcMgr->sTalentsSpec = "Arcane";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 10: // Use Fire Mage Spec
            sTemplateNpcMgr->sTalentsSpec = "Fire";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 11: // Use Frost Mage Spec
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 12: // Use Affliction Warlock Spec
            sTemplateNpcMgr->sTalentsSpec = "Affliction";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 13: // Use Demonology Warlock Spec
            sTemplateNpcMgr->sTalentsSpec = "Demonology";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 14: // Use Destruction Warlock Spec
            sTemplateNpcMgr->sTalentsSpec = "Destruction";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 15: // Use Elemental Shaman Spec
            sTemplateNpcMgr->sTalentsSpec = "Elemental";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 16: // Use Enhancement Shaman Spec
            sTemplateNpcMgr->sTalentsSpec = "Enhancement";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 17: // Use Restoration Shaman Spec
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 18: // Use Ballance Druid Spec
            sTemplateNpcMgr->sTalentsSpec = "Ballance";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 19: // Use Feral Druid Spec
            sTemplateNpcMgr->sTalentsSpec = "Feral";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 20: // Use Restoration Druid Spec
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 21: // Use Marksmanship Hunter Spec
            sTemplateNpcMgr->sTalentsSpec = "Marksmanship";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 22: // Use Beastmastery Hunter Spec
            sTemplateNpcMgr->sTalentsSpec = "Beastmastery";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 23: // Use Survival Hunter Spec
            sTemplateNpcMgr->sTalentsSpec = "Survival";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 24: // Use Assassination Rogue Spec
            sTemplateNpcMgr->sTalentsSpec = "Assassination";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 25: // Use Combat Rogue Spec
            sTemplateNpcMgr->sTalentsSpec = "Combat";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 26: // Use Subtlety Rogue Spec
            sTemplateNpcMgr->sTalentsSpec = "Subtlety";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 27: // Use Blood DK Spec
            sTemplateNpcMgr->sTalentsSpec = "Blood";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 28: // Use Frost DK Spec
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 29: // Use Unholy DK Spec
            sTemplateNpcMgr->sTalentsSpec = "Unholy";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 30:
            player->GetSession()->SendAreaTriggerMessage("Your glyphs have been removed.");
            //GossipHello(player);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 31:
            player->resetTalents(true);
            player->SendTalentsInfoData(false);
            player->GetSession()->SendAreaTriggerMessage("Your talents have been reset.");
            player->CLOSE_GOSSIP_MENU();
            break;
            //Priest
        case 100:
            sTemplateNpcMgr->sTalentsSpec = "Discipline";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 101:
            sTemplateNpcMgr->sTalentsSpec = "Holy";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 102:
            sTemplateNpcMgr->sTalentsSpec = "Shadow";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Paladin
        case 103:
            sTemplateNpcMgr->sTalentsSpec = "Holy";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 104:
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 105:
            sTemplateNpcMgr->sTalentsSpec = "Retribution";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Warrior
        case 106:
            sTemplateNpcMgr->sTalentsSpec = "Fury";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 107:
            sTemplateNpcMgr->sTalentsSpec = "Arms";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 108:
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Mage
        case 109:
            sTemplateNpcMgr->sTalentsSpec = "Arcane";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 110:
            sTemplateNpcMgr->sTalentsSpec = "Fire";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 111:
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Warlock
        case 112:
            sTemplateNpcMgr->sTalentsSpec = "Affliction";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 113:
            sTemplateNpcMgr->sTalentsSpec = "Demonology";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 114:
            sTemplateNpcMgr->sTalentsSpec = "Destruction";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Shaman
        case 115:
            sTemplateNpcMgr->sTalentsSpec = "Elemental";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 116:
            sTemplateNpcMgr->sTalentsSpec = "Enhancement";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 117:
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Druid
        case 118:
            sTemplateNpcMgr->sTalentsSpec = "Ballance";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 119:
            sTemplateNpcMgr->sTalentsSpec = "Feral";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 120:
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Hunter
        case 121:
            sTemplateNpcMgr->sTalentsSpec = "Marksmanship";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 122:
            sTemplateNpcMgr->sTalentsSpec = "Beastmastery";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 123:
            sTemplateNpcMgr->sTalentsSpec = "Survival";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //Rogue
        case 124:
            sTemplateNpcMgr->sTalentsSpec = "Assasination";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 125:
            sTemplateNpcMgr->sTalentsSpec = "Combat";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 126:
            sTemplateNpcMgr->sTalentsSpec = "Subtlety";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

            //DK
        case 127:
            sTemplateNpcMgr->sTalentsSpec = "Blood";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 128:
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 129:
            sTemplateNpcMgr->sTalentsSpec = "Unholy";
            LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            player->CLOSE_GOSSIP_MENU();
            break;

        case 5000:
            // return to OnGossipHello menu, otherwise it will freeze every menu
            OnGossipHello(player, creature);
            break;

        default: // Just in case
            player->GetSession()->SendAreaTriggerMessage("Something went wrong in the code. Please contact the administrator.");
            break;
        }

        return true;
    }
};

class TemplateNPC_command : public CommandScript
{
public:
    TemplateNPC_command() : CommandScript("TemplateNPC_command") {}

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> saveTable = {
            {"horde", SEC_ADMINISTRATOR, true, &HandleSaveGearHorde, "<spec>"},
            {"ally", SEC_ADMINISTRATOR, true, &HandleSaveGearAlly, "<spec>"},
            {"human", SEC_ADMINISTRATOR, true, &HandleSaveGearHuman, "<spec>"},
        };

        static std::vector<ChatCommand> TemplateNPCTable = {
            {"copy", SEC_ADMINISTRATOR, true, &HandleCopyCommand, ""},
            {"save", SEC_ADMINISTRATOR, true, nullptr, "", saveTable},
            {"reload", SEC_ADMINISTRATOR, true, &HandleReloadTemplateNPCCommand, ""},
        };

        static std::vector<ChatCommand> commandTable = {
            {"templatenpc", SEC_ADMINISTRATOR, true, nullptr, "", TemplateNPCTable},
        };

        return commandTable;
    }

    static bool HandleCopyCommand(ChatHandler *handler, const char *_args)
    {
        Player *caller = handler->GetSession()->GetPlayer();
        if (!caller)
        {
            handler->SendGlobalGMSysMessage("Wtf?");
            return false;
        }
        uint64 selected = handler->GetSession()->GetPlayer()->GetTarget();
        if (!selected)
        {
            handler->SendGlobalGMSysMessage("Need to select a player");
            return false;
        }
        Player *target = ObjectAccessor::FindPlayerInOrOutOfWorld(selected);

        if (!target)
        {
            handler->SendGlobalGMSysMessage("Need to select a player");
            return false;
        }

        if (caller == target)
        {
            handler->SendGlobalGMSysMessage("You are trying to copy your own gear, which is pointless.");
            return false;
        }

        sTemplateNpcMgr->CopyGear(caller, target);

        handler->SendGlobalGMSysMessage("Gear coppied.");
        return true;
    }

    static bool HandleSaveGearHorde(ChatHandler *handler, const char *_args)
    {
        return HandleSaveGearCommon(handler, _args, TYPE_HORDE);
    }

    static bool HandleSaveGearAlly(ChatHandler *handler, const char *_args)
    {
        return HandleSaveGearCommon(handler, _args, TYPE_ALLIANCE);
    }

    static bool HandleSaveGearHuman(ChatHandler *handler, const char *_args)
    {
        return HandleSaveGearCommon(handler, _args, TYPE_HUMAN);
    }

    static bool HandleSaveGearCommon(ChatHandler *handler, const char *_args, TemplateType type)
    {
        if (!*_args)
            return false;

        auto spec = std::string(_args);

        Player *p = handler->getSelectedPlayerOrSelf();
        if (p == nullptr)
            return false;

        sTemplateNpcMgr->ExtractGearTemplateToDB(p, spec, type);
        return true;
    }

    static bool HandleReloadTemplateNPCCommand(ChatHandler *handler, const char * /*args*/)
    {
        sLog->outString("Reloading templates for Template NPC table...");
        sTemplateNpcMgr->LoadHumanGearContainer();
        sTemplateNpcMgr->LoadAllianceGearContainer();
        sTemplateNpcMgr->LoadHordeGearContainer();
        handler->SendGlobalGMSysMessage("Template NPC templates reloaded.");
        return true;
    }
};

class TemplateNPC_World : public WorldScript
{
public:
    TemplateNPC_World() : WorldScript("TemplateNPC_World") {}

    void OnStartup() override
    {
        // Load templates for Template NPC #1
        sLog->outString("== TEMPLATE NPC ===========================================================================");
        sLog->outString("Loading Template Talents...");

        // Load templates for Template NPC #2
        sLog->outString("Loading Template Glyphs...");

        // Load templates for Template NPC #3
        sLog->outString("Loading Template Gear for Humans...");
        sTemplateNpcMgr->LoadHumanGearContainer();

        // Load templates for Template NPC #4
        sLog->outString("Loading Template Gear for Alliances...");
        sTemplateNpcMgr->LoadAllianceGearContainer();

        // Load templates for Template NPC #5
        sLog->outString("Loading Template Gear for Hordes...");
        sTemplateNpcMgr->LoadHordeGearContainer();
        sLog->outString("== END TEMPLATE NPC ===========================================================================");
    }
};

void AddSC_TemplateNPC()
{
    new TemplateNPC();
    new TemplateNPC_command();
    new TemplateNPC_World();
}
