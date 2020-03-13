/* =============================================================
TO DO:
• Merge human sql template with alliance template
• As Barbz suggested: Rename to character_template the module 
    and all related files (to be less confusing and less generic)
• As Barbz suggested: Scaling system for twink servers
================================================================ */

#include "TemplateNPC.h"

void sTemplateNPC::LearnPlateMailSpells(Player* player)
{
    switch (player->getClass())
    {
    case CLASS_WARRIOR:
    case CLASS_PALADIN:
    case CLASS_DEATH_KNIGHT:
        player->learnSpell(PLATE_MAIL);
        break;
    case CLASS_SHAMAN:
    case CLASS_HUNTER:
        player->learnSpell(MAIL);
        break;
    default:
        break;
    }
}

void sTemplateNPC::ApplyBonus(Player* player, Item* item, EnchantmentSlot slot, uint32 bonusEntry)
{
    if (!item)
        return;

    if (!bonusEntry || bonusEntry == 0)
        return;

    player->ApplyEnchantment(item, slot, false);
    item->SetEnchantment(slot, bonusEntry, 0, 0);
    player->ApplyEnchantment(item, slot, true);
}

void sTemplateNPC::ApplyGlyph(Player* player, uint8 slot, uint32 glyphID)
{
    if (GlyphPropertiesEntry const* gp = sGlyphPropertiesStore.LookupEntry(glyphID))
    {
        if (uint32 oldGlyph = player->GetGlyph(slot))
        {
            player->RemoveAurasDueToSpell(sGlyphPropertiesStore.LookupEntry(oldGlyph)->SpellId);
            player->SetGlyph(slot, 0, true);
        }
        player->CastSpell(player, gp->SpellId, true);
        player->SetGlyph(slot, glyphID, true);
    }
}

void sTemplateNPC::RemoveAllGlyphs(Player* player)
{
    for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
    {
        if (uint32 glyph = player->GetGlyph(i))
        {
            if (GlyphPropertiesEntry const* gp = sGlyphPropertiesStore.LookupEntry(glyph))
            {
                if (GlyphSlotEntry const* gs = sGlyphSlotStore.LookupEntry(player->GetGlyphSlot(i)))
                {
                    player->RemoveAurasDueToSpell(sGlyphPropertiesStore.LookupEntry(glyph)->SpellId);
                    player->SetGlyph(i, 0, true);
                    player->SendTalentsInfoData(false); // this is somewhat an in-game glyph realtime update (apply/remove)
                }
            }
        }
    }
}

void sTemplateNPC::LearnTemplateTalents(Player* player)
{
    for (TalentContainer::const_iterator itr = m_TalentContainer.begin(); itr != m_TalentContainer.end(); ++itr)
    {
        if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
        {
            player->learnSpell((*itr)->talentId);
            player->addTalent((*itr)->talentId, player->GetActiveSpecMask(), true);
        }
    }

    player->SetFreeTalentPoints(0);
    player->SendTalentsInfoData(false);
}

void sTemplateNPC::LearnTemplateGlyphs(Player* player)
{
    for (GlyphContainer::const_iterator itr = m_GlyphContainer.begin(); itr != m_GlyphContainer.end(); ++itr)
    {
        if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            ApplyGlyph(player, (*itr)->slot, (*itr)->glyph);
    }
    player->SendTalentsInfoData(false);
}

void sTemplateNPC::EquipTemplateGear(Player* player)
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

void sTemplateNPC::LoadTalentsContainer()
{
    for (TalentContainer::const_iterator itr = m_TalentContainer.begin(); itr != m_TalentContainer.end(); ++itr)
        delete *itr;

    m_TalentContainer.clear();

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec, talentId FROM template_npc_talents;");

    if (!result)
    {
        sLog->outString(">>TEMPLATE NPC: Loaded 0 talent templates. DB table `template_npc_talents` is empty!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        TalentTemplate* pTalent = new TalentTemplate;

        pTalent->playerClass = fields[0].GetString();
        pTalent->playerSpec = fields[1].GetString();
        pTalent->talentId = fields[2].GetUInt32();

        m_TalentContainer.push_back(pTalent);
        ++count;
    } while (result->NextRow());
    sLog->outString(">>TEMPLATE NPC: Loaded %u talent templates in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sTemplateNPC::LoadGlyphsContainer()
{
    for (GlyphContainer::const_iterator itr = m_GlyphContainer.begin(); itr != m_GlyphContainer.end(); ++itr)
        delete *itr;

    m_GlyphContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec, slot, glyph FROM template_npc_glyphs;");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        sLog->outString(">>TEMPLATE NPC: Loaded 0 glyph templates. DB table `template_npc_glyphs` is empty!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        GlyphTemplate* pGlyph = new GlyphTemplate;

        pGlyph->playerClass = fields[0].GetString();
        pGlyph->playerSpec = fields[1].GetString();
        pGlyph->slot = fields[2].GetUInt8();
        pGlyph->glyph = fields[3].GetUInt32();

        m_GlyphContainer.push_back(pGlyph);
        ++count;
    } while (result->NextRow());


    sLog->outString(">>TEMPLATE NPC: Loaded %u glyph templates in %u ms.", count, GetMSTimeDiffToNow(oldMSTime));
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
        Field* fields = result->Fetch();

        HumanGearTemplate* pItem = new HumanGearTemplate;

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
        Field* fields = result->Fetch();

        AllianceGearTemplate* pItem = new AllianceGearTemplate;

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
        Field* fields = result->Fetch();

        HordeGearTemplate* pItem = new HordeGearTemplate;

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

std::string sTemplateNPC::GetClassString(Player* player)
{
    switch (player->getClass())
    {
    case CLASS_PRIEST:       return "Priest";      break;
    case CLASS_PALADIN:      return "Paladin";     break;
    case CLASS_WARRIOR:      return "Warrior";     break;
    case CLASS_MAGE:         return "Mage";        break;
    case CLASS_WARLOCK:      return "Warlock";     break;
    case CLASS_SHAMAN:       return "Shaman";      break;
    case CLASS_DRUID:        return "Druid";       break;
    case CLASS_HUNTER:       return "Hunter";      break;
    case CLASS_ROGUE:        return "Rogue";       break;
    case CLASS_DEATH_KNIGHT: return "DeathKnight"; break;
    default:
        break;
    }
    return "Unknown"; // Fix warning, this should never happen
}

bool sTemplateNPC::OverwriteTemplate(Player* player, std::string& playerSpecStr)
{
    // Delete old talent and glyph templates before extracting new ones
    CharacterDatabase.PExecute("DELETE FROM template_npc_talents WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());
    CharacterDatabase.PExecute("DELETE FROM template_npc_glyphs WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());

    // Delete old gear templates before extracting new ones
    if (player->getRace() == RACE_HUMAN)
    {
        CharacterDatabase.PExecute("DELETE FROM template_npc_human WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        CharacterDatabase.PExecute("DELETE FROM template_npc_alliance WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {                                                                                                        // ????????????? sTemplateNpcMgr here??
        CharacterDatabase.PExecute("DELETE FROM template_npc_horde WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    return true;
}

void sTemplateNPC::ExtractGearTemplateToDB(Player* player, std::string& playerSpecStr)
{
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        Item* equippedItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);

        if (equippedItem)
        {
            if (player->getRace() == RACE_HUMAN)
            {
                CharacterDatabase.PExecute("INSERT INTO template_npc_human (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('%s', '%s', '%u', '%u', '%u', '%u', '%u', '%u', '%u', '%u');"
                    , GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                    equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                    equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
            {
                CharacterDatabase.PExecute("INSERT INTO template_npc_alliance (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('%s', '%s', '%u', '%u', '%u', '%u', '%u', '%u', '%u', '%u');"
                    , GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                    equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                    equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (player->GetTeamId() == TEAM_HORDE)
            {
                CharacterDatabase.PExecute("INSERT INTO template_npc_horde (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('%s', '%s', '%u', '%u', '%u', '%u', '%u', '%u', '%u', '%u');"
                    , GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                    equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                    equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
        }
    }
}

void sTemplateNPC::ExtractTalentTemplateToDB(Player* player, std::string& playerSpecStr)
{
    QueryResult result = CharacterDatabase.PQuery("SELECT spell FROM character_talent WHERE guid = '%u' "
        "AND talentGroup = '%u';", player->GetGUID(), player->GetActiveSpec());

    if (!result)
    {
        return;
    }
    else if (player->GetFreeTalentPoints() > 0)
    {
        player->GetSession()->SendAreaTriggerMessage("You have unspend talent points. Please spend all your talent points and re-extract the template.");
        return;
    }
    else
    {
        do
        {
            Field* fields = result->Fetch();
            uint32 spell = fields[0].GetUInt32();

            CharacterDatabase.PExecute("INSERT INTO template_npc_talents (playerClass, playerSpec, talentId) "
                "VALUES ('%s', '%s', '%u');", GetClassString(player).c_str(), playerSpecStr.c_str(), spell);
        } while (result->NextRow());
    }
}

void sTemplateNPC::ExtractGlyphsTemplateToDB(Player* player, std::string& playerSpecStr)
{
    QueryResult result = CharacterDatabase.PQuery("SELECT glyph1, glyph2, glyph3, glyph4, glyph5, glyph6 "
        "FROM character_glyphs WHERE guid = '%u' AND talentGroup = '%u';", player->GetGUID(), player->GetActiveSpec());

    for (uint8 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
    {
        if (!result)
        {
            player->GetSession()->SendAreaTriggerMessage("Get glyphs and re-extract the template!");
            continue;
        }

        Field* fields = result->Fetch();
        uint32 glyph1 = fields[0].GetUInt32();
        uint32 glyph2 = fields[1].GetUInt32();
        uint32 glyph3 = fields[2].GetUInt32();
        uint32 glyph4 = fields[3].GetUInt32();
        uint32 glyph5 = fields[4].GetUInt32();
        uint32 glyph6 = fields[5].GetUInt32();

        uint32 storedGlyph;

        switch (slot)
        {
        case 0:
            storedGlyph = glyph1;
            break;
        case 1:
            storedGlyph = glyph2;
            break;
        case 2:
            storedGlyph = glyph3;
            break;
        case 3:
            storedGlyph = glyph4;
            break;
        case 4:
            storedGlyph = glyph5;
            break;
        case 5:
            storedGlyph = glyph6;
            break;
        default:
            break;
        }

        CharacterDatabase.PExecute("INSERT INTO template_npc_glyphs (playerClass, playerSpec, slot, glyph) "
            "VALUES ('%s', '%s', '%u', '%u');", GetClassString(player).c_str(), playerSpecStr.c_str(), slot, storedGlyph);
    }
}

bool sTemplateNPC::CanEquipTemplate(Player* player, std::string& playerSpecStr)
{
    if (player->getRace() == RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT playerClass, playerSpec FROM template_npc_human "
            "WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT playerClass, playerSpec FROM template_npc_alliance "
            "WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT playerClass, playerSpec FROM template_npc_horde "
            "WHERE playerClass = '%s' AND playerSpec = '%s';", GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    return true;
}

class TemplateNPC : public CreatureScript
{
public:
    TemplateNPC() : CreatureScript("TemplateNPC") { }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            switch (player->getClass())
            {
            case CLASS_PRIEST:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_wordfortitude:30|t|r Use Discipline Spec", GOSSIP_SENDER_MAIN, 0);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r Use Holy Spec", GOSSIP_SENDER_MAIN, 1);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_shadowwordpain:30|t|r Use Shadow Spec", GOSSIP_SENDER_MAIN, 2);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_wordfortitude:30|t|r Use Discipline Spec (Talents Only)", GOSSIP_SENDER_MAIN, 100);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r Use Holy spec (Talents only)", GOSSIP_SENDER_MAIN, 101);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_shadowwordpain:30|t|r Use Shadow spec (Talents only)", GOSSIP_SENDER_MAIN, 102);
                break;
            case CLASS_PALADIN:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r Use Holy Spec", GOSSIP_SENDER_MAIN, 3);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_devotionaura:30|t|r Use Protection Spec", GOSSIP_SENDER_MAIN, 4);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_auraoflight:30|t|r Use Retribution Spec", GOSSIP_SENDER_MAIN, 5);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r Use Holy Spec (Talents Only)", GOSSIP_SENDER_MAIN, 103);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_devotionaura:30|t|r Use Protection Spec (Talents Only)", GOSSIP_SENDER_MAIN, 104);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_auraoflight:30|t|r Use Retribution Spec (Talents Only)", GOSSIP_SENDER_MAIN, 105);
                break;
            case CLASS_WARRIOR:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_innerrage:30|t|r Use Fury Spec", GOSSIP_SENDER_MAIN, 6);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Arms Spec", GOSSIP_SENDER_MAIN, 7);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_defensivestance:30|t|r Use Protection Spec", GOSSIP_SENDER_MAIN, 8);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_innerrage:30|t|r Use Fury Spec (Talents Only)", GOSSIP_SENDER_MAIN, 106);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Arms Spec (Talents Only)", GOSSIP_SENDER_MAIN, 107);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_defensivestance:30|t|r Use Protection Spec (Talents Only)", GOSSIP_SENDER_MAIN, 108);
                break;
            case CLASS_MAGE:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_magicalsentry:30|t|r Use Arcane Spec", GOSSIP_SENDER_MAIN, 9);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_fire_flamebolt:30|t|r Use Fire Spec", GOSSIP_SENDER_MAIN, 10);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_frost_frostbolt02:30|t|r Use Frost Spec", GOSSIP_SENDER_MAIN, 11);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_magicalsentry:30|t|r Use Arcane Spec (Talents Only)", GOSSIP_SENDER_MAIN, 109);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_fire_flamebolt:30|t|r Use Fire Spec (Talents Only)", GOSSIP_SENDER_MAIN, 110);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_frost_frostbolt02:30|t|r Use Frost Spec (Talents Only)", GOSSIP_SENDER_MAIN, 111);
                break;
            case CLASS_WARLOCK:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_deathcoil:30|t|r Use Affliction Spec", GOSSIP_SENDER_MAIN, 12);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_metamorphosis:30|t|r Use Demonology Spec", GOSSIP_SENDER_MAIN, 13);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_rainoffire:30|t|r Use Destruction Spec", GOSSIP_SENDER_MAIN, 14);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_deathcoil:30|t|r Use Affliction Spec (Talents Only)", GOSSIP_SENDER_MAIN, 112);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_metamorphosis:30|t|r Use Demonology Spec (Talents Only)", GOSSIP_SENDER_MAIN, 113);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_rainoffire:30|t|r Use Destruction Spec (Talents Only)", GOSSIP_SENDER_MAIN, 114);
                break;
            case CLASS_SHAMAN:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightning:30|t|r Use Elemental Spec", GOSSIP_SENDER_MAIN, 15);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightningshield:30|t|r Use Enhancement Spec", GOSSIP_SENDER_MAIN, 16);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_magicimmunity:30|t|r Use Restoration Spec", GOSSIP_SENDER_MAIN, 17);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightning:30|t|r Use Elemental Spec (Talents Only)", GOSSIP_SENDER_MAIN, 115);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightningshield:30|t|r Use Enhancement Spec (Talents Only)", GOSSIP_SENDER_MAIN, 116);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_magicimmunity:30|t|r Use Restoration Spec (Talents Only)", GOSSIP_SENDER_MAIN, 117);
                break;
            case CLASS_DRUID:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_starfall:30|t|r Use Ballance Spec", GOSSIP_SENDER_MAIN, 18);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_racial_bearform:30|t|r Use Feral Spec", GOSSIP_SENDER_MAIN, 19);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_healingtouch:30|t|r Use Restoration Spec", GOSSIP_SENDER_MAIN, 20);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_starfall:30|t|r Use Ballance Spec (Talents Only)", GOSSIP_SENDER_MAIN, 118);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_racial_bearform:30|t|r Use Feral Spec (Talents Only)", GOSSIP_SENDER_MAIN, 119);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_healingtouch:30|t|r Use Restoration Spec (Talents Only)", GOSSIP_SENDER_MAIN, 120);
                break;
            case CLASS_HUNTER:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_marksmanship:30|t|r Use Marksmanship Spec", GOSSIP_SENDER_MAIN, 21);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_hunter_beasttaming:30|t|r Use Beastmastery Spec", GOSSIP_SENDER_MAIN, 22);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_Hunter_swiftstrike:30|t|r Use Survival Spec", GOSSIP_SENDER_MAIN, 23);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_marksmanship:30|t|r Use Marksmanship Spec (Talents Only)", GOSSIP_SENDER_MAIN, 121);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_hunter_beasttaming:30|t|r Use Beastmastery Spec (Talents Only)", GOSSIP_SENDER_MAIN, 122);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_Hunter_swiftstrike:30|t|r Use Survival Spec (Talents Only)", GOSSIP_SENDER_MAIN, 123);
                break;
            case CLASS_ROGUE:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Assasination Spec", GOSSIP_SENDER_MAIN, 24);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_backstab:30|t|r Use Combat Spec", GOSSIP_SENDER_MAIN, 25);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_stealth:30|t|r Use Subtlety Spec", GOSSIP_SENDER_MAIN, 26);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Assasination Spec (Talents Only)", GOSSIP_SENDER_MAIN, 124);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_backstab:30|t|r Use Combat Spec (Talents Only)", GOSSIP_SENDER_MAIN, 125);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_stealth:30|t|r Use Subtlety Spec (Talents Only)", GOSSIP_SENDER_MAIN, 126);
                break;
            case CLASS_DEATH_KNIGHT:
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_bloodpresence:30|t|r Use Blood Spec", GOSSIP_SENDER_MAIN, 27);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_frostpresence:30|t|r Use Frost Spec", GOSSIP_SENDER_MAIN, 28);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_unholypresence:30|t|r Use Unholy Spec", GOSSIP_SENDER_MAIN, 29);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_bloodpresence:30|t|r Use Blood Spec (Talents Only)", GOSSIP_SENDER_MAIN, 127);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_frostpresence:30|t|r Use Frost Spec (Talents Only)", GOSSIP_SENDER_MAIN, 128);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_unholypresence:30|t|r Use Unholy Spec (Talents Only)", GOSSIP_SENDER_MAIN, 129);
                break;
            }

            /*player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Spell_ChargeNegative:30|t|r Remove all glyphs", GOSSIP_SENDER_MAIN, 30);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Spell_ChargeNegative:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Spell_ChargeNegative:30|t|r Destroy my equipped gear", GOSSIP_SENDER_MAIN, 32);*/
			player->SEND_GOSSIP_MENU(55002, creature->GetGUID());
            return true;
        }

        static void EquipFullTemplateGear(Player* player, std::string& playerSpecStr) // Merge
        {
            if (sTemplateNpcMgr->CanEquipTemplate(player, playerSpecStr) == false)
            {
                player->GetSession()->SendAreaTriggerMessage("There's no templates for %s specialization yet.", playerSpecStr.c_str());
                return;
            }

            // Don't let players to use Template feature while wearing some gear
            for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
            {
                if (Item* haveItemEquipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
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

            sTemplateNpcMgr->LearnTemplateTalents(player);
            sTemplateNpcMgr->LearnTemplateGlyphs(player);
            sTemplateNpcMgr->EquipTemplateGear(player);
            sTemplateNpcMgr->LearnPlateMailSpells(player);

            LearnWeaponSkills(player);

            player->GetSession()->SendAreaTriggerMessage("Successfuly equipped %s %s template!", playerSpecStr.c_str(), sTemplateNpcMgr->GetClassString(player).c_str());

            if (player->getPowerType() == POWER_MANA)
                player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));

            player->SetHealth(player->GetMaxHealth());

            // Learn Riding/Flying
            if (player->HasSpell(SPELL_Artisan_Riding) ||
                player->HasSpell(SPELL_Cold_Weather_Flying) ||
                player->HasSpell(SPELL_Amani_War_Bear) ||
                player->HasSpell(SPELL_Teach_Learn_Talent_Specialization_Switches)
                || player->HasSpell(SPELL_Learn_a_Second_Talent_Specialization)
                )
                return;

            // Cast spells that teach dual spec
            // Both are also ImplicitTarget self and must be cast by player
            player->CastSpell(player, SPELL_Teach_Learn_Talent_Specialization_Switches, player->GetGUID());
            player->CastSpell(player, SPELL_Learn_a_Second_Talent_Specialization, player->GetGUID());

            player->learnSpell(SPELL_Artisan_Riding);
            player->learnSpell(SPELL_Cold_Weather_Flying);
            player->learnSpell(SPELL_Amani_War_Bear);

        }

        static void LearnOnlyTalentsAndGlyphs(Player* player, std::string& playerSpecStr) // Merge
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

            sTemplateNpcMgr->LearnTemplateTalents(player);
            sTemplateNpcMgr->LearnTemplateGlyphs(player);
            //sTemplateNpcMgr->EquipTemplateGear(player);
            sTemplateNpcMgr->LearnPlateMailSpells(player);

            LearnWeaponSkills(player);

            player->GetSession()->SendAreaTriggerMessage("Successfuly learned talent spec %s!", playerSpecStr.c_str());

            // Learn Riding/Flying
            if (player->HasSpell(SPELL_Artisan_Riding) ||
                player->HasSpell(SPELL_Cold_Weather_Flying) ||
                player->HasSpell(SPELL_Amani_War_Bear) ||
                player->HasSpell(SPELL_Teach_Learn_Talent_Specialization_Switches)
               || player->HasSpell(SPELL_Learn_a_Second_Talent_Specialization)
                )
                return;

            // Cast spells that teach dual spec
            // Both are also ImplicitTarget self and must be cast by player
            player->CastSpell(player, SPELL_Teach_Learn_Talent_Specialization_Switches, player->GetGUID());
            player->CastSpell(player, SPELL_Learn_a_Second_Talent_Specialization, player->GetGUID());

            player->learnSpell(SPELL_Artisan_Riding);
            player->learnSpell(SPELL_Cold_Weather_Flying);
            player->learnSpell(SPELL_Amani_War_Bear);
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction)
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
                sTemplateNpcMgr->RemoveAllGlyphs(player);
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

            case 32:
                for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
                {
                    if (Item* haveItemEquipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
                    {
                        if (haveItemEquipped)
                        {
                            player->DestroyItemCount(haveItemEquipped->GetEntry(), 1, true, true);

                            if (haveItemEquipped->IsInWorld())
                            {
                                haveItemEquipped->RemoveFromWorld();
                                haveItemEquipped->DestroyForPlayer(player);
                            }

                            haveItemEquipped->SetUInt64Value(ITEM_FIELD_CONTAINED, 0);
                            haveItemEquipped->SetSlot(NULL_SLOT);
                            haveItemEquipped->SetState(ITEM_REMOVED, player);
                        }
                    }
                }
                player->GetSession()->SendAreaTriggerMessage("Your equipped gear has been destroyed.");
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
            player->UpdateSkillsForLevel();

            return true;
        }
};

class TemplateNPC_command : public CommandScript
{
public:
    TemplateNPC_command() : CommandScript("TemplateNPC_command") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> TemplateNPCTable =
        {
            { "reload",      SEC_ADMINISTRATOR, true , &HandleReloadTemplateNPCCommand, "" }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "templatenpc", SEC_ADMINISTRATOR, true, nullptr                         , "", TemplateNPCTable }
        };
        return commandTable;
    }


    static bool HandleReloadTemplateNPCCommand(ChatHandler* handler, const char* /*args*/)
    {
        sLog->outString("Reloading templates for Template NPC table...");
        sTemplateNpcMgr->LoadTalentsContainer();
        sTemplateNpcMgr->LoadGlyphsContainer();
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
    TemplateNPC_World() : WorldScript("TemplateNPC_World") { }

    void OnStartup() override
    {
        // Load templates for Template NPC #1
        sLog->outString("== TEMPLATE NPC ===========================================================================");
        sLog->outString("Loading Template Talents...");
        sTemplateNpcMgr->LoadTalentsContainer();

        // Load templates for Template NPC #2
        sLog->outString("Loading Template Glyphs...");
        sTemplateNpcMgr->LoadGlyphsContainer();

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
