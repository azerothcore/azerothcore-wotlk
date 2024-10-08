/* =============================================================
TO DO:
• Merge human sql template with alliance template
• As Barbz suggested: Rename to character_template the module
    and all related files (to be less confusing and less generic)
• As Barbz suggested: Scaling system for twink servers
================================================================ */

#include "TemplateNPC.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "Translate.h"
#include "Chat.h"

void sTemplateNPC::LearnPlateMailSpells(Player *player)
{
    switch (player->getClass())
    {
    case CLASS_WARRIOR:
    case CLASS_PALADIN:
    case CLASS_DEATH_KNIGHT:
        if (!player->HasSpell(PLATE_MAIL))
			player->learnSpell(PLATE_MAIL);
        break;
    case CLASS_SHAMAN:
    case CLASS_HUNTER:
        if (!player->HasSpell(MAIL))
			player->learnSpell(MAIL);
        break;
    default:
        break;
    }
}

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

void sTemplateNPC::ApplyGlyph(Player *player, uint8 slot, uint32 glyphID)
{
    if (GlyphPropertiesEntry const *gp = sGlyphPropertiesStore.LookupEntry(glyphID))
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

void sTemplateNPC::RemoveAllGlyphs(Player *player)
{
    for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
    {
        if (uint32 glyph = player->GetGlyph(i))
        {
            if (GlyphPropertiesEntry const *gp = sGlyphPropertiesStore.LookupEntry(glyph))
            {
                if (GlyphSlotEntry const *gs = sGlyphSlotStore.LookupEntry(player->GetGlyphSlot(i)))
                {
                    player->RemoveAurasDueToSpell(sGlyphPropertiesStore.LookupEntry(glyph)->SpellId);
                    player->SetGlyph(i, 0, true);
                    player->SendTalentsInfoData(false); // this is somewhat an in-game glyph realtime update (apply/remove)
                }
            }
        }
    }
}


void sTemplateNPC::LearnTemplateGlyphs(Player* player, std::string sTalentsSpec)
{
    for (GlyphContainer::const_iterator itr = m_GlyphContainer.begin(); itr != m_GlyphContainer.end(); ++itr)
    {
        if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            sTemplateNpcMgr->ApplyGlyph(player, (*itr)->slot, (*itr)->glyph);
    }
    player->SendTalentsInfoData(false);
}

void sTemplateNPC::LearnWeaponSkills(Player* player) {
	using ClassToWeapons = std::unordered_map<uint8, std::vector<WeaponProficiencies>>;
	static ClassToWeapons classToWeaponLookup = {
		{ CLASS_WARRIOR,
	        {
	           THROW_WAR,
	           TWO_H_SWORDS,
	           TWO_H_MACES,
	           TWO_H_AXES,
	           STAVES,
	           POLEARMS,
	           ONE_H_SWORDS,
	           ONE_H_MACES,
	           ONE_H_AXES,
	           GUNS,
	           FIST_WEAPONS,
	           DAGGERS,
	           CROSSBOWS,
	           BOWS,
	           BLOCK,
	    	}
		},
		{ CLASS_PRIEST,
			{
				WANDS,
				STAVES,
				SHOOT,
				ONE_H_MACES,
				DAGGERS,
			}
		},
		{ CLASS_PALADIN,
			{
				TWO_H_SWORDS,
				TWO_H_MACES,
				TWO_H_AXES,
				POLEARMS,
				ONE_H_SWORDS,
				ONE_H_MACES,
				ONE_H_AXES,
				BLOCK,
			}
		},
		{ CLASS_ROGUE,
			{
				ONE_H_SWORDS,
				ONE_H_MACES,
				ONE_H_AXES,
				GUNS,
				FIST_WEAPONS,
				DAGGERS,
				CROSSBOWS,
				BOWS,
			}
		},
		{ CLASS_DEATH_KNIGHT,
			{
				TWO_H_SWORDS,
				TWO_H_MACES,
				TWO_H_AXES,
				POLEARMS,
				ONE_H_SWORDS,
				ONE_H_MACES,
				ONE_H_AXES,
			}
		},
		{ CLASS_MAGE,
			{
				WANDS,
				STAVES,
				SHOOT,
				ONE_H_SWORDS,
				DAGGERS,
			}
		},
		{ CLASS_SHAMAN,
			{
				TWO_H_MACES,
				TWO_H_AXES,
				STAVES,
				ONE_H_MACES,
				ONE_H_AXES,
				FIST_WEAPONS,
				DAGGERS,
				BLOCK,
			}
		},
		{ CLASS_HUNTER,
			{
				THROW_WAR,
				TWO_H_SWORDS,
				TWO_H_AXES,
				STAVES,
				POLEARMS,
				ONE_H_SWORDS,
				ONE_H_AXES,
				GUNS,
				FIST_WEAPONS,
				DAGGERS,
				CROSSBOWS,
				BOWS,
			}
		},
		{ CLASS_DRUID,
			{
				TWO_H_MACES,
				STAVES,
				POLEARMS,
				ONE_H_MACES,
				FIST_WEAPONS,
				DAGGERS,
			}
		},
		{ CLASS_WARLOCK,
			{
				WANDS,
				STAVES,
				SHOOT,
				ONE_H_SWORDS,
				DAGGERS,
			}
		}
	};

	auto playerClassWepSkills = classToWeaponLookup.find(player->getClass())->second;
	for (auto playerClassWepSkill : playerClassWepSkills)
	{
		if (player->HasSpell(playerClassWepSkill))
			continue;
		player->learnSpell(playerClassWepSkill);
	}

	player->UpdateSkillsToMaxSkillsForLevel();
}

void sTemplateNPC::EquipTemplateGear(Player* player, std::string sTalentsSpec)
{
    sTemplateNpcMgr->LearnWeaponSkills(player);
    sTemplateNpcMgr->LearnPlateMailSpells(player);
    if (player->getRace() == RACE_HUMAN)
    {
        // reverse sort so we equip items from trinket to helm so we avoid issue with meta gems
        std::sort(m_HumanGearContainer.begin(), m_HumanGearContainer.end(), std::greater<HumanGearTemplate *>());

        for (HumanGearContainer::const_iterator itr = m_HumanGearContainer.begin(); itr != m_HumanGearContainer.end(); ++itr)
        {
            if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            {
                player->EquipNewItem((*itr)->pos, (*itr)->itemEntry, true); // Equip the item and apply enchants and gems
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PERM_ENCHANTMENT_SLOT, (*itr)->enchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), BONUS_ENCHANTMENT_SLOT, (*itr)->bonusEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PRISMATIC_ENCHANTMENT_SLOT, (*itr)->prismaticEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_2, (*itr)->socket2);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_3, (*itr)->socket3);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT, (*itr)->socket1);
            }
        }
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        // reverse sort so we equip items from trinket to helm so we avoid issue with meta gems
        std::sort(m_AllianceGearContainer.begin(), m_AllianceGearContainer.end(), std::greater<AllianceGearTemplate *>());

        for (AllianceGearContainer::const_iterator itr = m_AllianceGearContainer.begin(); itr != m_AllianceGearContainer.end(); ++itr)
        {
            if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            {
                player->EquipNewItem((*itr)->pos, (*itr)->itemEntry, true); // Equip the item and apply enchants and gems
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PERM_ENCHANTMENT_SLOT, (*itr)->enchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), BONUS_ENCHANTMENT_SLOT, (*itr)->bonusEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PRISMATIC_ENCHANTMENT_SLOT, (*itr)->prismaticEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_2, (*itr)->socket2);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_3, (*itr)->socket3);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT, (*itr)->socket1);
            }
        }
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {
        // reverse sort so we equip items from trinket to helm so we avoid issue with meta gems
        std::sort(m_HordeGearContainer.begin(), m_HordeGearContainer.end(), std::greater<HordeGearTemplate *>());

        for (HordeGearContainer::const_iterator itr = m_HordeGearContainer.begin(); itr != m_HordeGearContainer.end(); ++itr)
        {
            if ((*itr)->playerClass == GetClassString(player).c_str() && (*itr)->playerSpec == sTalentsSpec)
            {
                player->EquipNewItem((*itr)->pos, (*itr)->itemEntry, true); // Equip the item and apply enchants and gems
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PERM_ENCHANTMENT_SLOT, (*itr)->enchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), BONUS_ENCHANTMENT_SLOT, (*itr)->bonusEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), PRISMATIC_ENCHANTMENT_SLOT, (*itr)->prismaticEnchant);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_2, (*itr)->socket2);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT_3, (*itr)->socket3);
                ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, (*itr)->pos), SOCK_ENCHANTMENT_SLOT, (*itr)->socket1);
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
        LOG_WARN("sql.sql", ">>TEMPLATE NPC: Loaded 0 talent templates. DB table `template_npc_talents` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        TalentTemplate *pTalent = new TalentTemplate;

        pTalent->playerClass = fields[0].Get<std::string>();
        pTalent->playerSpec = fields[1].Get<std::string>();
        pTalent->talentId = fields[2].Get<uint32>();

        m_TalentContainer.push_back(pTalent);
        ++count;
    } while (result->NextRow());
    LOG_INFO("module", ">>TEMPLATE NPC: Loaded {} talent templates in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
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
        LOG_WARN("sql.sql", ">>TEMPLATE NPC: Loaded 0 glyph templates. DB table `template_npc_glyphs` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        GlyphTemplate *pGlyph = new GlyphTemplate;

        pGlyph->playerClass = fields[0].Get<std::string>();
        pGlyph->playerSpec = fields[1].Get<std::string>();
        pGlyph->slot = fields[2].Get<uint8>();
        pGlyph->glyph = fields[3].Get<uint32>();

        m_GlyphContainer.push_back(pGlyph);
        ++count;
    } while (result->NextRow());

    LOG_INFO("module", ">>TEMPLATE NPC: Loaded {} glyph templates in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
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
        LOG_INFO("module", ">>TEMPLATE NPC: Loaded 0 'gear templates. DB table `template_npc_human` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        HumanGearTemplate *pItem = new HumanGearTemplate;

        pItem->playerClass = fields[0].Get<std::string>();
        pItem->playerSpec = fields[1].Get<std::string>();
        pItem->pos = fields[2].Get<uint8>();
        pItem->itemEntry = fields[3].Get<uint32>();
        pItem->enchant = fields[4].Get<uint32>();
        pItem->socket1 = fields[5].Get<uint32>();
        pItem->socket2 = fields[6].Get<uint32>();
        pItem->socket3 = fields[7].Get<uint32>();
        pItem->bonusEnchant = fields[8].Get<uint32>();
        pItem->prismaticEnchant = fields[9].Get<uint32>();

        m_HumanGearContainer.push_back(pItem);
        ++count;
    } while (result->NextRow());
    LOG_INFO("module", ">>TEMPLATE NPC: Loaded {} gear templates for Humans in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
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
        LOG_INFO("module", ">>TEMPLATE NPC: Loaded 0 'gear templates. DB table `template_npc_alliance` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        AllianceGearTemplate *pItem = new AllianceGearTemplate;

        pItem->playerClass = fields[0].Get<std::string>();
        pItem->playerSpec = fields[1].Get<std::string>();
        pItem->pos = fields[2].Get<uint8>();
        pItem->itemEntry = fields[3].Get<uint32>();
        pItem->enchant = fields[4].Get<uint32>();
        pItem->socket1 = fields[5].Get<uint32>();
        pItem->socket2 = fields[6].Get<uint32>();
        pItem->socket3 = fields[7].Get<uint32>();
        pItem->bonusEnchant = fields[8].Get<uint32>();
        pItem->prismaticEnchant = fields[9].Get<uint32>();

        m_AllianceGearContainer.push_back(pItem);
        ++count;
    } while (result->NextRow());
    LOG_INFO("module", ">>TEMPLATE NPC: Loaded {} gear templates for Alliances in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
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
        LOG_INFO("module", ">>TEMPLATE NPC: Loaded 0 'gear templates. DB table `template_npc_horde` is empty!");
        return;
    }

    do
    {
        Field *fields = result->Fetch();

        HordeGearTemplate *pItem = new HordeGearTemplate;

        pItem->playerClass = fields[0].Get<std::string>();
        pItem->playerSpec = fields[1].Get<std::string>();
        pItem->pos = fields[2].Get<uint8>();
        pItem->itemEntry = fields[3].Get<uint32>();
        pItem->enchant = fields[4].Get<uint32>();
        pItem->socket1 = fields[5].Get<uint32>();
        pItem->socket2 = fields[6].Get<uint32>();
        pItem->socket3 = fields[7].Get<uint32>();
        pItem->bonusEnchant = fields[8].Get<uint32>();
        pItem->prismaticEnchant = fields[9].Get<uint32>();

        m_HordeGearContainer.push_back(pItem);
        ++count;
    } while (result->NextRow());
    LOG_INFO("module", ">>TEMPLATE NPC: Loaded {} gear templates for Hordes in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
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

bool sTemplateNPC::OverwriteTemplate(Player *player, std::string &playerSpecStr)
{
    // Delete old talent and glyph templates before extracting new ones
    CharacterDatabase.Execute("DELETE FROM template_npc_talents WHERE playerClass = '{}' AND playerSpec = '{}';", GetClassString(player).c_str(), playerSpecStr.c_str());
    CharacterDatabase.Execute("DELETE FROM template_npc_glyphs WHERE playerClass = '{}' AND playerSpec = '{}';", GetClassString(player).c_str(), playerSpecStr.c_str());

    // Delete old gear templates before extracting new ones
    if (player->getRace() == RACE_HUMAN)
    {
        CharacterDatabase.Execute("DELETE FROM template_npc_human WHERE playerClass = '{}' AND playerSpec = '{}';", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        CharacterDatabase.Execute("DELETE FROM template_npc_alliance WHERE playerClass = '{}' AND playerSpec = '{}';", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    { // ????????????? sTemplateNpcMgr here??
        CharacterDatabase.Execute("DELETE FROM template_npc_horde WHERE playerClass = '{}' AND playerSpec = '{}';", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    return true;
}

void sTemplateNPC::ExtractGearTemplateToDB(Player *player, std::string &playerSpecStr)
{
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        Item *equippedItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);

        if (equippedItem)
        {
            if (player->getRace() == RACE_HUMAN)
            {
                CharacterDatabase.Execute("INSERT INTO template_npc_human (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}');", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                                          equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                                          equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
            {
                CharacterDatabase.Execute("INSERT INTO template_npc_alliance (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}');", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                                          equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                                          equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (player->GetTeamId() == TEAM_HORDE)
            {
                CharacterDatabase.Execute("INSERT INTO template_npc_horde (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}', '{}');", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT),
                                          equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3),
                                          equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
        }
    }
}

void sTemplateNPC::ExtractTalentTemplateToDB(Player *player, std::string &playerSpecStr)
{
    QueryResult result = CharacterDatabase.Query("SELECT spell FROM character_talent WHERE guid = '{}' "
                                                 "AND talentGroup = '{}';",
                                                 (player->GetGUID()).GetCounter(), player->GetActiveSpecMask());

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
            Field *fields = result->Fetch();
            uint32 spell = fields[0].Get<uint32>();

            CharacterDatabase.Execute("INSERT INTO template_npc_talents (playerClass, playerSpec, talentId) "
                                      "VALUES ('{}', '{}', '{}');",
                                      GetClassString(player).c_str(), playerSpecStr.c_str(), spell);
        } while (result->NextRow());
    }
}

void sTemplateNPC::ExtractGlyphsTemplateToDB(Player *player, std::string &playerSpecStr)
{
    QueryResult result = CharacterDatabase.Query("SELECT glyph1, glyph2, glyph3, glyph4, glyph5, glyph6 "
                                                 "FROM character_glyphs WHERE guid = '{}' AND talentGroup = '{}';",
                                                 player->GetGUID().GetCounter(), player->GetActiveSpec());

    for (uint8 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
    {
        if (!result)
        {
            player->GetSession()->SendAreaTriggerMessage("Get glyphs and re-extract the template!");
            continue;
        }

        Field *fields = result->Fetch();
        uint32 glyph1 = fields[0].Get<uint32>();
        uint32 glyph2 = fields[1].Get<uint32>();
        uint32 glyph3 = fields[2].Get<uint32>();
        uint32 glyph4 = fields[3].Get<uint32>();
        uint32 glyph5 = fields[4].Get<uint32>();
        uint32 glyph6 = fields[5].Get<uint32>();

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

        CharacterDatabase.Execute("INSERT INTO template_npc_glyphs (playerClass, playerSpec, slot, glyph) "
                                  "VALUES ('{}', '{}', '{}', '{}');",
                                  GetClassString(player).c_str(), playerSpecStr.c_str(), slot, storedGlyph);
    }
}

void sTemplateNPC::GetSpecAction(Player* player, int action)
{
    switch(action)
    {
        case 30: // Use Discipline Priest Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Discipline");
            break;

        case 1: // Use Holy Priest Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Holy");
            break;

        case 2: // Use Shadow Priest Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Shadow");
            break;

        case 3: // Use Holy Paladin Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Holy");
            break;

        case 4: // Use Protection Paladin Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Protection");
            break;

        case 5: // Use Retribution Paladin Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Retribution");
            break;

        case 6: // Use Fury Warrior Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Fury");
            break;

        case 7: // Use Arms Warrior Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Arms");
            break;

        case 8: // Use Protection Warrior Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Protection");
            break;

        case 9: // Use Arcane Mage Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Arcane");
            break;

        case 10: // Use Fire Mage Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Fire");
            break;

        case 11: // Use Frost Mage Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Frost");
            break;

        case 12: // Use Affliction Warlock Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Affliction");
            break;

        case 13: // Use Demonology Warlock Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Demonology");
            break;

        case 14: // Use Destruction Warlock Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Destruction");
            break;

        case 15: // Use Elemental Shaman Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Elemental");
            break;

        case 16: // Use Enhancement Shaman Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Enhancement");
            player->AddItem(50737, 1);
            break;

        case 17: // Use Restoration Shaman Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Restoration");
            break;

        case 18: // Use Ballance Druid Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Ballance");
            break;

        case 19: // Use Feral Druid Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Feral");
            break;

        case 20: // Use Restoration Druid Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Restoration");
            break;

        case 21: // Use Marksmanship Hunter Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Marksmanship");
            break;

        case 22: // Use Beastmastery Hunter Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Beastmastery");
            break;

        case 23: // Use Survival Hunter Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Survival");
            break;

        case 24: // Use Assassination Rogue Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Assassination");
            break;

        case 25: // Use Combat Rogue Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Combat");
            break;

        case 26: // Use Subtlety Rogue Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Subtlety");
            break;

        case 27: // Use Blood DK Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Blood");
            break;

        case 28: // Use Frost DK Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Frost");
            break;

        case 29: // Use Unholy DK Spec
            sTemplateNpcMgr->EquipFullTemplateGear(player, "Unholy");
            break;
    }

    CloseGossipMenuFor(player);
    player->UpdateSkillsForLevel();
    player->SaveToDB(false, false);
}

bool sTemplateNPC::CanEquipTemplate(Player *player, std::string &playerSpecStr)
{
    if (player->getRace() == RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec FROM template_npc_human "
                                                     "WHERE playerClass = '{}' AND playerSpec = '{}';",
                                                     GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec FROM template_npc_alliance "
                                                     "WHERE playerClass = '{}' AND playerSpec = '{}';",
                                                     GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {
        QueryResult result = CharacterDatabase.Query("SELECT playerClass, playerSpec FROM template_npc_horde "
                                                     "WHERE playerClass = '{}' AND playerSpec = '{}';",
                                                     GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    return true;
}

void sTemplateNPC::EquipFullTemplateGear(Player* player, std::string playerSpecStr)
{
    if (sTemplateNpcMgr->TemplateExistsCheck(player, playerSpecStr) &&
        sTemplateNpcMgr->CheckPlayerIsNaked(player) &&
        sTemplateNpcMgr->CheckSpendTalents(player) &&
        sTemplateNpcMgr->ApplyTalentsAndGlyphs(player, playerSpecStr) &&
        sTemplateNpcMgr->ApplyGear(player, playerSpecStr))
        player->GetSession()->SendAreaTriggerMessage(GetCustomText(player, RU_template_34, EN_template_34), playerSpecStr.c_str());
}

bool sTemplateNPC::TemplateExistsCheck(Player* player, std::string playerSpecStr)
{
    if (sTemplateNpcMgr->CanEquipTemplate(player, playerSpecStr) == false)
    {
        player->GetSession()->SendAreaTriggerMessage(GetCustomText(player, RU_template_36, EN_template_36), playerSpecStr.c_str());
        return false;
    }
    return true;
}

bool sTemplateNPC::CheckPlayerIsNaked(Player* player)
{
    // Don't let players to use Template feature while wearing some gear
    for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        if (Item* haveItemEquipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
        {
            if (haveItemEquipped)
            {
                ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_template_32, EN_template_32));
                CloseGossipMenuFor(player);
                return false;
            }
        }
    }
    return true;
}

bool sTemplateNPC::CheckSpendTalents(Player* player)
{
    // Don't let players to use Template feature after spending some talent points
    if (player->GetFreeTalentPoints() < 71)
    {
        player->GetSession()->SendAreaTriggerMessage(GetCustomText(player, RU_template_33, EN_template_33));
        CloseGossipMenuFor(player);
        return false;
    }
    return true;
}    

bool sTemplateNPC::ApplyTalentsAndGlyphs(Player* player, std::string playerSpecStr)
{
    if (!player->HasSpell(SPELL_Artisan_Riding))
    {
        // Cast spells that teach dual spec
        // Both are also ImplicitTarget self and must be cast by player
        player->CastSpell(player, SPELL_Teach_Learn_Talent_Specialization_Switches, player->GetGUID());
        player->CastSpell(player, SPELL_Learn_a_Second_Talent_Specialization, player->GetGUID());

        // Learn Riding/Flying
        player->learnSpell(SPELL_Artisan_Riding);
        player->learnSpell(SPELL_Cold_Weather_Flying);
    }

    sTemplateNpcMgr->LearnTemplateGlyphs(player, playerSpecStr);

    // update warr talent
    player->UpdateTitansGrip();

    if (player->getPowerType() == POWER_MANA)
        player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
    player->SetHealth(player->GetMaxHealth());
    return true;
}

bool sTemplateNPC::ApplyGear(Player* player, std::string playerSpecStr)
{
    sTemplateNpcMgr->EquipTemplateGear(player, playerSpecStr);
    return true;
}

class TemplateNPC : public CreatureScript
{
public:
    TemplateNPC() : CreatureScript("TemplateNPC") {}

    bool OnGossipHello(Player* player, Creature* creature)
    {
        GetMainMenu(player, creature);
        return true;
    }

    void GetMainMenu(Player* player, Creature* creature)
    {
        ClearGossipMenuFor(player);
        switch (player->getClass())
        {
            case CLASS_PRIEST:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_2,EN_template_2), GOSSIP_SENDER_MAIN, 30);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_3,EN_template_3), GOSSIP_SENDER_MAIN, 1);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_4,EN_template_4), GOSSIP_SENDER_MAIN, 2);
                break;
            case CLASS_PALADIN:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_5,EN_template_5), GOSSIP_SENDER_MAIN, 3);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_6,EN_template_6), GOSSIP_SENDER_MAIN, 4);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_7,EN_template_7), GOSSIP_SENDER_MAIN, 5);
                break;
            case CLASS_WARRIOR:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_9,EN_template_9), GOSSIP_SENDER_MAIN, 7);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_8,EN_template_8), GOSSIP_SENDER_MAIN, 6);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_10,EN_template_10), GOSSIP_SENDER_MAIN, 8);
                break;
            case CLASS_MAGE:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_11,EN_template_11), GOSSIP_SENDER_MAIN, 9);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_12,EN_template_12), GOSSIP_SENDER_MAIN, 10);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_13,EN_template_13), GOSSIP_SENDER_MAIN, 11);
                break;
            case CLASS_WARLOCK:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_14,EN_template_14), GOSSIP_SENDER_MAIN, 12);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_15,EN_template_15), GOSSIP_SENDER_MAIN, 13);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_16,EN_template_16), GOSSIP_SENDER_MAIN, 14);
                break;
            case CLASS_SHAMAN:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_17,EN_template_17), GOSSIP_SENDER_MAIN, 15);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_18,EN_template_18), GOSSIP_SENDER_MAIN, 16);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_19,EN_template_19), GOSSIP_SENDER_MAIN, 17);
                break;
            case CLASS_DRUID:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_20,EN_template_20), GOSSIP_SENDER_MAIN, 18);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_21,EN_template_21), GOSSIP_SENDER_MAIN, 19);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_22,EN_template_22), GOSSIP_SENDER_MAIN, 20);
                break;
            case CLASS_HUNTER:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_24,EN_template_24), GOSSIP_SENDER_MAIN, 22);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_23,EN_template_23), GOSSIP_SENDER_MAIN, 21);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_25,EN_template_25), GOSSIP_SENDER_MAIN, 23);
                break;
            case CLASS_ROGUE:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_26,EN_template_26), GOSSIP_SENDER_MAIN, 24);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_27,EN_template_27), GOSSIP_SENDER_MAIN, 25);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_28,EN_template_28), GOSSIP_SENDER_MAIN, 26);
                break;
            case CLASS_DEATH_KNIGHT:
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_29,EN_template_29), GOSSIP_SENDER_MAIN, 27);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_30,EN_template_30), GOSSIP_SENDER_MAIN, 28);
                AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, GetCustomText(player, RU_template_31,EN_template_31), GOSSIP_SENDER_MAIN, 29);
                break;
        }
        TemplateNpcWelcome(player, creature);
    }

    void TemplateNpcWelcome(Player* player, Creature* creature)
    {
        std::string name = player->GetName();
        std::ostringstream femb;

        if (player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
        {
            femb << "Приветствую, " << name << "\n\n";
            femb << "Здесь вы можете выбрать спек персонажа, в котором будет:\n\n";
            femb << "* Экипировка\n* Сокеты\n* Чарки\n* Символы\n\n";
            femb << "Выберите свою спецификацию:\n";
        }
        else
        {
            femb << "Greetings, " << name << "\n\n";
            femb << "Here you can choose the character spec, which will be:\n\n";
            femb << "* Equipment\n* Sockets\n* Enchantment\n* Glyph\n\n";
            femb << "Choose your specification:\n";
        }
        player->PlayerTalkClass->SendGossipMenu(femb.str().c_str(), creature->GetGUID());
        return;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        if (!player || !creature)
            return false;

        player->PlayerTalkClass->ClearMenus();
        if (sender == GOSSIP_SENDER_MAIN) {
            sTemplateNpcMgr->GetSpecAction(player, action);  
        } 
        return true;
    }
};

using namespace Acore::ChatCommands;
class TemplateNPC_command : public CommandScript
{
public:
    TemplateNPC_command() : CommandScript("TemplateNPC_command") {}

    ChatCommandTable GetCommands() const override
    {

        static ChatCommandTable commandTable =
        {
            {"templatenpc reload", HandleReloadTemplateNPCCommand, SEC_ADMINISTRATOR, Console::No},
        };
        return commandTable;
    }

    static bool HandleReloadTemplateNPCCommand(ChatHandler *handler)
    {
        LOG_INFO("module", "Reloading templates for Template NPC table...");
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
    TemplateNPC_World() : WorldScript("TemplateNPC_World") {}

    void OnStartup() override
    {
        // Load templates for Template NPC #1
        LOG_INFO("module", "== TEMPLATE NPC ===========================================================================");
        LOG_INFO("module", "Loading Template Talents...");
        sTemplateNpcMgr->LoadTalentsContainer();

        // Load templates for Template NPC #2
        LOG_INFO("module", "Loading Template Glyphs...");
        sTemplateNpcMgr->LoadGlyphsContainer();

        // Load templates for Template NPC #3
        LOG_INFO("module", "Loading Template Gear for Humans...");
        sTemplateNpcMgr->LoadHumanGearContainer();

        // Load templates for Template NPC #4
        LOG_INFO("module", "Loading Template Gear for Alliances...");
        sTemplateNpcMgr->LoadAllianceGearContainer();

        // Load templates for Template NPC #5
        LOG_INFO("module", "Loading Template Gear for Hordes...");
        sTemplateNpcMgr->LoadHordeGearContainer();
        LOG_INFO("module", "== END TEMPLATE NPC ===========================================================================");
    }
};

void AddSC_TemplateNPC()
{
    new TemplateNPC();
    new TemplateNPC_command();
    new TemplateNPC_World();
}