#include "TemplateNPC.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "Chat.h"

void sTemplateNPC::LearnPlateMailSpells(Player *player)
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
            switch (player->getClass())
            {
            case CLASS_WARRIOR:
                if ((*itr)->playerSpec == "Arms")
                {
                    //player->learnSpellHighRank(12328); // sweeping strikes
                    //player->learnSpellHighRank(12294); // mortal strike
                    //player->learnSpellHighRank(46924); // bladestorm
                    //player->learnSpellHighRank(12323); // piercing howl
                }
                if ((*itr)->playerSpec == "Protection")
                {
                    //player->learnSpellHighRank(20243); // devastate
                    //player->learnSpellHighRank(46968); // shockwave
                    //player->learnSpellHighRank(12809); // concussion blow
                    //player->learnSpellHighRank(12975); // last stand
                }
                break;
            case CLASS_PALADIN:
                if ((*itr)->playerSpec == "Holy")
                {
                    //player->learnSpellHighRank(20473); // holy shock
                    //player->learnSpellHighRank(53563); // beacon of light
                    //player->learnSpellHighRank(64205); // divine sacrifice
                    //player->learnSpellHighRank(31842); // divine illumination
                    //player->learnSpellHighRank(20216); // divine favor
                    //player->learnSpellHighRank(31821); // aura mastery
                }
                if ((*itr)->playerSpec == "Protection")
                {
                    //player->learnSpellHighRank(20911); // blessing of sanctuary
                    //player->learnSpellHighRank(64205); // divine sacrifice
                    //player->learnSpellHighRank(20925); // holy shield
                    //player->learnSpellHighRank(31935); // avenger's shield
                    //player->learnSpellHighRank(53595); // hammer of the righteous
                }
                if ((*itr)->playerSpec == "Retribution")
                {
                    //player->learnSpellHighRank(20066); // repentance
                    //player->learnSpellHighRank(35395); // crusader strike
                    //player->learnSpellHighRank(64205); // divine sacrifice
                    //player->learnSpellHighRank(53385); // divine storm
                }
                break;
            case CLASS_HUNTER:
                if ((*itr)->playerSpec == "Beastmastery")
                {
                    //player->learnSpellHighRank(19577); // intimidation
                    //player->learnSpellHighRank(19574); // bestial wrath
                    //player->learnSpellHighRank(19434); // aimed shot
                    //player->learnSpellHighRank(23989); // readiness
                }
                if ((*itr)->playerSpec == "Marksmanship")
                {
                    //player->learnSpellHighRank(19434); // aimed shot
                    //player->learnSpellHighRank(23989); // readiness
                    //player->learnSpellHighRank(19506); // trueshot aura
                    //player->learnSpellHighRank(34490); // silencing shot
                    //player->learnSpellHighRank(53209); // chimera shot
                    //player->learnSpellHighRank(19503); // scatter shot
                }
                break;
            case CLASS_ROGUE:
                if ((*itr)->playerSpec == "Subtlety")
                {
                    //player->learnSpellHighRank(16511); // hemorrhage
                    //player->learnSpellHighRank(14185); // preparation
                    //player->learnSpellHighRank(14183); // premeditation
                    //player->learnSpellHighRank(36554); // shadowstep
                    //player->learnSpellHighRank(51713); // shadow dance
                }
                if ((*itr)->playerSpec == "Combat")
                {
                    //player->learnSpellHighRank(13750); // adrenaline rush
                    //player->learnSpellHighRank(51690); // killing spree
                }
                if ((*itr)->playerSpec == "Assassination")
                {
                    //player->learnSpellHighRank(14177); // cold blood
                    //player->learnSpellHighRank(1329);  // mutilate
                    //player->learnSpellHighRank(14185); // preparation
                }
                break;
            case CLASS_PRIEST:
                if ((*itr)->playerSpec == "Discipline")
                {
                    //player->learnSpellHighRank(14751); // inner focus
                   // player->learnSpellHighRank(10060); // power infusion
                   // player->learnSpellHighRank(33206); // pain suppression
                    //player->learnSpellHighRank(47540); // penance
                    //player->learnSpellHighRank(19236); // desperate prayer
                }
                if ((*itr)->playerSpec == "Holy")
                {
                    //player->learnSpellHighRank(14751); // inner focus
                    //player->learnSpellHighRank(19236); // desperate prayer
                    //player->learnSpellHighRank(724);   // lightwell
                    //player->learnSpellHighRank(34861); // circle of healing
                    //player->learnSpellHighRank(47788); // Guardian Spirit
                }
                if ((*itr)->playerSpec == "Shadow")
                {
                    //player->learnSpellHighRank(15407); // mind fly
                    //player->learnSpellHighRank(15487); // silence
                   // player->learnSpellHighRank(15286); // vampiric embrace
                    //player->learnSpellHighRank(15473); // shadowform
                    //player->learnSpellHighRank(64044); // psychic horror
                    //player->learnSpellHighRank(34914); // vampiric touch
                    //player->learnSpellHighRank(47585); // dispersion
                    //player->learnSpellHighRank(14751); // inner focus
                }
                break;
            case CLASS_DEATH_KNIGHT:
                if ((*itr)->playerSpec == "Unholy")
                {
                    //player->learnSpellHighRank(49158); // corpse explosion
                   // player->learnSpellHighRank(51052); // anti-magic zone
                    //player->learnSpellHighRank(49222); // bone shield
                    //player->learnSpellHighRank(49206); // summon gargoyle
                    //player->learnSpellHighRank(49039); // lichborne
                    //player->learnSpellHighRank(55090); // scourge strike
                }
                if ((*itr)->playerSpec == "Frost")
                {
                    //player->learnSpellHighRank(49039); // lichborne
                    //player->learnSpellHighRank(49796); // deathchill
                    //player->learnSpellHighRank(49203); // hungering cold
                    //player->learnSpellHighRank(51271); // unbreakable armor
                    //player->learnSpellHighRank(49143); // frost strike
                }
                if ((*itr)->playerSpec == "Blood")
                {
                    //player->learnSpellHighRank(48982); // rune tap
                    //player->learnSpellHighRank(49016); // hysteria
                    //player->learnSpellHighRank(55233); // vampiric blood
                    //player->learnSpellHighRank(55050); // hearth strike
                    //player->learnSpellHighRank(49028); // dancing rune weapon
                    //player->learnSpellHighRank(49039); // lichborne
                }
                break;
            case CLASS_SHAMAN:
                if ((*itr)->playerSpec == "Enhancement")
                {
                    //player->learnSpellHighRank(17364); // stormstrike
                    //player->learnSpellHighRank(60103); // lava lash
                    //player->learnSpellHighRank(30823); // shamanistic rage
                    //player->learnSpellHighRank(51533); // feral spirit
                }
                if ((*itr)->playerSpec == "Restoration")
                {
                    //player->learnSpellHighRank(16188); // nature's swiftness
                    //player->learnSpellHighRank(16190); // mana tide totem
                    //player->learnSpellHighRank(51886); // cleanse spirit
                    //player->learnSpellHighRank(974);   // earth shield
                    //player->learnSpellHighRank(61295); // riptide
                    //player->learnSpellHighRank(55198); // tidal force
                }
                if ((*itr)->playerSpec == "Elemental")
                {
                    //player->learnSpellHighRank(16166); // elemental mastery
                    //player->learnSpellHighRank(51490); // thunderstorm
                    //player->learnSpellHighRank(30706); // totem of wrath
                }
                break;
            case CLASS_MAGE:
                if ((*itr)->playerSpec == "Fire")
                {
                    //player->learnSpellHighRank(11366); // pyroblast
                    //player->learnSpellHighRank(11113); // blast wave
                    //player->learnSpellHighRank(11129); // combustion
                    //player->learnSpellHighRank(31661); // dragon's breath
                    //player->learnSpellHighRank(44457); // living bomb
                    //player->learnSpellHighRank(54646); // focus magic
                }
                if ((*itr)->playerSpec == "Frost")
                {
                    //player->learnSpellHighRank(12472); // icy veins
                    //player->learnSpellHighRank(11958); // cold snap
                    //player->learnSpellHighRank(11426); // ice barrier
                    //player->learnSpellHighRank(31687); // summon water elemental
                    //player->learnSpellHighRank(44572); // deep freeze
                    //player->learnSpellHighRank(54646); // focus magic
                }
                if ((*itr)->playerSpec == "Arcane")
                {
                    //player->learnSpellHighRank(12043); // presence of mind
                    //player->learnSpellHighRank(12042); // arcane power
                    //player->learnSpellHighRank(31589); // slow
                    //player->learnSpellHighRank(44425); // arcane barrage
                    //player->learnSpellHighRank(12472); // icy veins
                }
                break;
            case CLASS_WARLOCK:
                if ((*itr)->playerSpec == "Affliction")
                {
                    //player->learnSpellHighRank(18223); // curse of exhaustion
                    //player->learnSpellHighRank(30108); // unstable affliction
                    //player->learnSpellHighRank(48181); // haunt
                    //player->learnSpellHighRank(18708); // fel domination
                    //player->learnSpellHighRank(19028); // soul link
                }
                if ((*itr)->playerSpec == "Destruction")
                {
                    //player->learnSpellHighRank(17877); // shadowburn
                    //player->learnSpellHighRank(17962); // conflagrate
                    //player->learnSpellHighRank(30283); // shadowfury
                    //player->learnSpellHighRank(50796); // chaos bolt
                    //player->learnSpellHighRank(18708); // fel domination
                    //player->learnSpellHighRank(19028); // soul link
                }
                break;
            case CLASS_DRUID:
                if ((*itr)->playerSpec == "Restoration")
                {
                    //player->learnSpellHighRank(17116); // nature's swiftness
                    //player->learnSpellHighRank(18562); // swiftmend
                    //player->learnSpellHighRank(48438); // wild growth
                }
                if ((*itr)->playerSpec == "Feral")
                {
                    //player->learnSpellHighRank(61336); // survival instincts
                    //player->learnSpellHighRank(49377); // feral charge
                    //player->learnSpellHighRank(33876); // mangle cat
                    //player->learnSpellHighRank(33878); // mangle bear
                    //player->learnSpellHighRank(50334); // berserk
                }
                if ((*itr)->playerSpec == "Ballance")
                {
                    //player->learnSpellHighRank(33831); // force of nature
                    //player->learnSpellHighRank(50516); // typhoon
                    //player->learnSpellHighRank(48505); // starfall
                    //player->learnSpellHighRank(24858); // moonkin form
                    //player->learnSpellHighRank(5570);  // insect swarm
                }
                break;
            }
            player->addTalent((*itr)->talentId, player->GetActiveSpecMask(), 0);
        }
    }
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
        // reverse sort so we equip items from trinket to helm so we avoid issue with meta gems
        std::sort(m_HumanGearContainer.begin(), m_HumanGearContainer.end(), std::greater<HumanGearTemplate*>());

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
        delete* itr;

    m_TalentContainer.clear();

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec`, `talentId` FROM `template_npc_talents`");

    if (!result)
    {
        LOG_WARN("sql.sql", ">> TEMPLATE NPC: Loaded 0 talent templates. DB table `template_npc_talents` is empty!");
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
    LOG_INFO("module", ">> TEMPLATE NPC: Loaded {} talent templates in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sTemplateNPC::LoadGlyphsContainer()
{
    for (GlyphContainer::const_iterator itr = m_GlyphContainer.begin(); itr != m_GlyphContainer.end(); ++itr)
        delete* itr;

    m_GlyphContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec`, `slot`, `glyph` FROM `template_npc_glyphs`");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_WARN("sql.sql", ">> TEMPLATE NPC: Loaded 0 glyph templates. DB table `template_npc_glyphs` is empty!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        GlyphTemplate* pGlyph = new GlyphTemplate;

        pGlyph->playerClass = fields[0].Get<std::string>();
        pGlyph->playerSpec = fields[1].Get<std::string>();
        pGlyph->slot = fields[2].Get<uint8>();
        pGlyph->glyph = fields[3].Get<uint32>();

        m_GlyphContainer.push_back(pGlyph);
        ++count;
    } while (result->NextRow());

    LOG_INFO("module", ">> TEMPLATE NPC: Loaded {} glyph templates in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sTemplateNPC::LoadHumanGearContainer()
{
    for (HumanGearContainer::const_iterator itr = m_HumanGearContainer.begin(); itr != m_HumanGearContainer.end(); ++itr)
        delete* itr;

    m_HumanGearContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant` FROM `template_npc_human`");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("module", ">> TEMPLATE NPC: Loaded 0 gear templates. DB table `template_npc_human` is empty!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        HumanGearTemplate* pItem = new HumanGearTemplate;

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
    LOG_INFO("module", ">> TEMPLATE NPC: Loaded {} gear templates for Humans in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sTemplateNPC::LoadAllianceGearContainer()
{
    for (AllianceGearContainer::const_iterator itr = m_AllianceGearContainer.begin(); itr != m_AllianceGearContainer.end(); ++itr)
        delete* itr;

    m_AllianceGearContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant` FROM `template_npc_alliance`");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("module", ">> TEMPLATE NPC: Loaded 0 gear templates. DB table `template_npc_alliance` is empty!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

        AllianceGearTemplate* pItem = new AllianceGearTemplate;

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
    LOG_INFO("module", ">> TEMPLATE NPC: Loaded {} gear templates for Alliances in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

void sTemplateNPC::LoadHordeGearContainer()
{
    for (HordeGearContainer::const_iterator itr = m_HordeGearContainer.begin(); itr != m_HordeGearContainer.end(); ++itr)
        delete* itr;

    m_HordeGearContainer.clear();

    QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant` FROM `template_npc_horde`");

    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    if (!result)
    {
        LOG_INFO("module", ">> TEMPLATE NPC: Loaded 0 gear templates. DB table `template_npc_horde` is empty!");
        return;
    }

    do
    {
        Field* fields = result->Fetch();

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
    LOG_INFO("module", ">> TEMPLATE NPC: Loaded {} gear templates for Hordes in {} ms.", count, GetMSTimeDiffToNow(oldMSTime));
}

std::string sTemplateNPC::GetClassString(Player* player)
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

bool sTemplateNPC::OverwriteTemplate(Player* player, std::string& playerSpecStr)
{
    // Delete old talent and glyph templates before extracting new ones
    CharacterDatabase.Execute("DELETE FROM `template_npc_talents` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());
    CharacterDatabase.Execute("DELETE FROM `template_npc_glyphs` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());

    // Delete old gear templates before extracting new ones
    if (player->getRace() == RACE_HUMAN)
    {
        CharacterDatabase.Execute("DELETE FROM `template_npc_human` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        CharacterDatabase.Execute("DELETE FROM `template_npc_alliance` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());
        player->GetSession()->SendAreaTriggerMessage("Template successfuly created!");
        return false;
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {
        CharacterDatabase.Execute("DELETE FROM `template_npc_horde` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());
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
                CharacterDatabase.Execute("INSERT INTO `template_npc_human` (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('{}', '{}', {}, {}, {}, {}, {}, {}, {}, {});", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3), equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
            {
                CharacterDatabase.Execute("INSERT INTO `template_npc_alliance` (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('{}', '{}', {}, {}, {}, {}, {}, {}, {}, {});", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3), equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
            else if (player->GetTeamId() == TEAM_HORDE)
            {
                CharacterDatabase.Execute("INSERT INTO `template_npc_horde` (`playerClass`, `playerSpec`, `pos`, `itemEntry`, `enchant`, `socket1`, `socket2`, `socket3`, `bonusEnchant`, `prismaticEnchant`) VALUES ('{}', '{}', {}, {}, {}, {}, {}, {}, {}, {});", GetClassString(player).c_str(), playerSpecStr.c_str(), equippedItem->GetSlot(), equippedItem->GetEntry(), equippedItem->GetEnchantmentId(PERM_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2), equippedItem->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3), equippedItem->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT), equippedItem->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
            }
        }
    }
}

void sTemplateNPC::ExtractTalentTemplateToDB(Player* player, std::string& playerSpecStr)
{
    QueryResult result = CharacterDatabase.Query("SELECT `spell` FROM `character_talent` WHERE `guid`={} AND `talentGroup`={}", player->GetGUID().GetCounter(), player->GetActiveSpecMask());

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
            uint32 spell = fields[0].Get<uint32>();

            CharacterDatabase.Execute("INSERT INTO `template_npc_talents` (`playerClass`, `playerSpec`, `talentId`) VALUES ('{}', '{}', {})", GetClassString(player).c_str(), playerSpecStr.c_str(), spell);
        } while (result->NextRow());
    }
}

void sTemplateNPC::ExtractGlyphsTemplateToDB(Player* player, std::string& playerSpecStr)
{
    QueryResult result = CharacterDatabase.Query("SELECT `glyph1`, `glyph2`, `glyph3`, `glyph4`, `glyph5`, `glyph6` FROM `character_glyphs` WHERE `guid`={} AND `talentGroup`={}", player->GetGUID().GetCounter(), player->GetActiveSpec());

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

        CharacterDatabase.Execute("INSERT INTO `template_npc_glyphs` (`playerClass`, `playerSpec`, `slot`, `glyph`) VALUES ('{}', '{}', {}, {});", GetClassString(player).c_str(), playerSpecStr.c_str(), slot, storedGlyph);
    }
}

bool sTemplateNPC::CanEquipTemplate(Player* player, std::string& playerSpecStr)
{
    if (player->getRace() == RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec` FROM `template_npc_human` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_ALLIANCE && player->getRace() != RACE_HUMAN)
    {
        QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec` FROM `template_npc_alliance` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    else if (player->GetTeamId() == TEAM_HORDE)
    {
        QueryResult result = CharacterDatabase.Query("SELECT `playerClass`, `playerSpec` FROM `template_npc_horde` WHERE `playerClass`='{}' AND `playerSpec`='{}'", GetClassString(player).c_str(), playerSpecStr.c_str());

        if (!result)
            return false;
    }
    return true;
}

class TemplateNPC : public CreatureScript
{
public:
    TemplateNPC() : CreatureScript("TemplateNPC") {}

    bool OnGossipHello(Player* player, Creature* creature)
    {
        switch (player->getClass())
        {
        case CLASS_PRIEST:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_wordfortitude:30|t|r  Discipline ", GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_shadowwordpain:30|t|r  Shadow ", GOSSIP_SENDER_MAIN, 2);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r  Holy ", GOSSIP_SENDER_MAIN, 1);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_wordfortitude:30|t|r Use Discipline Spec (Talents Only)", GOSSIP_SENDER_MAIN, 100);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r Use Holy spec (Talents only)", GOSSIP_SENDER_MAIN, 101);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_shadowwordpain:30|t|r Use Shadow spec (Talents only)", GOSSIP_SENDER_MAIN, 102);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_PALADIN:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_auraoflight:30|t|r  Retribution ", GOSSIP_SENDER_MAIN, 5);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r  Holy ", GOSSIP_SENDER_MAIN, 3);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_devotionaura:30|t|r  Protection ", GOSSIP_SENDER_MAIN, 4);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_holybolt:30|t|r Use Holy Spec (Talents Only)", GOSSIP_SENDER_MAIN, 103);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_devotionaura:30|t|r Use Protection Spec (Talents Only)", GOSSIP_SENDER_MAIN, 104);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_auraoflight:30|t|r Use Retribution Spec (Talents Only)", GOSSIP_SENDER_MAIN, 105);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_WARRIOR:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r  Arms ", GOSSIP_SENDER_MAIN, 7);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_defensivestance:30|t|r Protection ", GOSSIP_SENDER_MAIN, 8);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_innerrage:30|t|r  Fury ", GOSSIP_SENDER_MAIN, 6);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_innerrage:30|t|r Use Fury Spec (Talents Only)", GOSSIP_SENDER_MAIN, 106);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Arms Spec (Talents Only)", GOSSIP_SENDER_MAIN, 107);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_warrior_defensivestance:30|t|r Use Protection Spec (Talents Only)", GOSSIP_SENDER_MAIN, 108);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_MAGE:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_fire_flamebolt:30|t|r  Fire ", GOSSIP_SENDER_MAIN, 10);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_frost_frostbolt02:30|t|r  Frost ", GOSSIP_SENDER_MAIN, 11);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_magicalsentry:30|t|r  Arcane ", GOSSIP_SENDER_MAIN, 9);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_holy_magicalsentry:30|t|r Use Arcane Spec (Talents Only)", GOSSIP_SENDER_MAIN, 109);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_fire_flamebolt:30|t|r Use Fire Spec (Talents Only)", GOSSIP_SENDER_MAIN, 110);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_frost_frostbolt02:30|t|r Use Frost Spec (Talents Only)", GOSSIP_SENDER_MAIN, 111);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_WARLOCK:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_deathcoil:30|t|r  Affliction ", GOSSIP_SENDER_MAIN, 12);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_rainoffire:30|t|r  Destruction ", GOSSIP_SENDER_MAIN, 14);
           //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_metamorphosis:30|t|r  Demonology ", GOSSIP_SENDER_MAIN, 13);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_deathcoil:30|t|r Use Affliction Spec (Talents Only)", GOSSIP_SENDER_MAIN, 112);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_metamorphosis:30|t|r Use Demonology Spec (Talents Only)", GOSSIP_SENDER_MAIN, 113);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_shadow_rainoffire:30|t|r Use Destruction Spec (Talents Only)", GOSSIP_SENDER_MAIN, 114);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_SHAMAN:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightningshield:30|t|r  Enhancement ", GOSSIP_SENDER_MAIN, 16);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightning:30|t|r  Elemental ", GOSSIP_SENDER_MAIN, 15);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_magicimmunity:30|t|r  Restoration ", GOSSIP_SENDER_MAIN, 17);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightning:30|t|r Use Elemental Spec (Talents Only)", GOSSIP_SENDER_MAIN, 115);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_lightningshield:30|t|r Use Enhancement Spec (Talents Only)", GOSSIP_SENDER_MAIN, 116);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_magicimmunity:30|t|r Use Restoration Spec (Talents Only)", GOSSIP_SENDER_MAIN, 117);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_DRUID:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_healingtouch:30|t|r  Restoration ", GOSSIP_SENDER_MAIN, 20);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_racial_bearform:30|t|r  Feral ", GOSSIP_SENDER_MAIN, 19);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_starfall:30|t|r  Ballance ", GOSSIP_SENDER_MAIN, 18);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_starfall:30|t|r Use Ballance Spec (Talents Only)", GOSSIP_SENDER_MAIN, 118);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_racial_bearform:30|t|r Use Feral Spec (Talents Only)", GOSSIP_SENDER_MAIN, 119);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_nature_healingtouch:30|t|r Use Restoration Spec (Talents Only)", GOSSIP_SENDER_MAIN, 120);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_HUNTER:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_marksmanship:30|t|r  Marksmanship ", GOSSIP_SENDER_MAIN, 21);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_hunter_beasttaming:30|t|r  Beastmastery ", GOSSIP_SENDER_MAIN, 22);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_Hunter_swiftstrike:30|t|r  Survival ", GOSSIP_SENDER_MAIN, 23);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_marksmanship:30|t|r Use Marksmanship Spec (Talents Only)", GOSSIP_SENDER_MAIN, 121);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_hunter_beasttaming:30|t|r Use Beastmastery Spec (Talents Only)", GOSSIP_SENDER_MAIN, 122);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_Hunter_swiftstrike:30|t|r Use Survival Spec (Talents Only)", GOSSIP_SENDER_MAIN, 123);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_ROGUE:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_stealth:30|t|r  Subtlety ", GOSSIP_SENDER_MAIN, 26);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r  Assasination ", GOSSIP_SENDER_MAIN, 24);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_backstab:30|t|r  Combat ", GOSSIP_SENDER_MAIN, 25);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_rogue_eviscerate:30|t|r Use Assasination Spec (Talents Only)", GOSSIP_SENDER_MAIN, 124);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_backstab:30|t|r Use Combat Spec (Talents Only)", GOSSIP_SENDER_MAIN, 125);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\ability_stealth:30|t|r Use Subtlety Spec (Talents Only)", GOSSIP_SENDER_MAIN, 126);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        case CLASS_DEATH_KNIGHT:
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_unholypresence:30|t|r  Unholy ", GOSSIP_SENDER_MAIN, 29);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_frostpresence:30|t|r  Frost ", GOSSIP_SENDER_MAIN, 28);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_bloodpresence:30|t|r  Blood ", GOSSIP_SENDER_MAIN, 27);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_bloodpresence:30|t|r Use Blood Spec (Talents Only)", GOSSIP_SENDER_MAIN, 127);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_frostpresence:30|t|r Use Frost Spec (Talents Only)", GOSSIP_SENDER_MAIN, 128);
            //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\spell_deathknight_unholypresence:30|t|r Use Unholy Spec (Talents Only)", GOSSIP_SENDER_MAIN, 129);
            /*AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "----------------------------------------------", GOSSIP_SENDER_MAIN, 5000);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Trade_Engineering:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);*/
            break;
        }

        //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Spell_ChargeNegative:30|t|r Remove all glyphs", GOSSIP_SENDER_MAIN, 30);
        //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Spell_ChargeNegative:30|t|r Reset Talents", GOSSIP_SENDER_MAIN, 31);
        //AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, "|cff00ff00|TInterface\\icons\\Spell_ChargeNegative:30|t|r Destroy my equipped gear", GOSSIP_SENDER_MAIN, 32);
        SendGossipMenuFor(player, 55002, creature->GetGUID());
        return true;
    }

    static void EquipFullTemplateGear(Player* player, std::string& playerSpecStr) // Merge
    {
        if (sTemplateNpcMgr->CanEquipTemplate(player, playerSpecStr) == false)
        {
            player->GetSession()->SendAreaTriggerMessage("Ainda não há modelos para a especialização %s.", playerSpecStr.c_str());
            return;
        }

        // Don't let players to use Template feature while wearing some gear
        for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
        {
            if (Item* haveItemEquipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
            {
                if (haveItemEquipped)
                {
                    player->GetSession()->SendAreaTriggerMessage("Você precisa remover todos os itens equipados para usar este recurso!");
                    CloseGossipMenuFor(player);
                    return;
                }
            }
        }

        // Don't let players to use Template feature after spending some talent points
        if (player->GetFreeTalentPoints() < 71)
        {
            player->GetSession()->SendAreaTriggerMessage("Você já gastou alguns pontos de talento.Você precisa redefinir seus talentos primeiro!");
            CloseGossipMenuFor(player);
            return;
        }

        player->_RemoveAllItemMods();
        sTemplateNpcMgr->LearnTemplateTalents(player);
        sTemplateNpcMgr->LearnTemplateGlyphs(player);
        sTemplateNpcMgr->EquipTemplateGear(player);
        sTemplateNpcMgr->LearnPlateMailSpells(player);

        // update warr talent
        player->UpdateTitansGrip();

        LearnWeaponSkills(player);

        player->GetSession()->SendAreaTriggerMessage("Successfuly equipped %s %s template!", playerSpecStr.c_str(), sTemplateNpcMgr->GetClassString(player).c_str());

        if (player->getPowerType() == POWER_MANA)
            player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));

        player->SetHealth(player->GetMaxHealth());

        // Learn Riding/Flying
        if (player->HasSpell(SPELL_Artisan_Riding) || player->HasSpell(SPELL_Cold_Weather_Flying) || player->HasSpell(SPELL_Amani_War_Bear) || player->HasSpell(SPELL_Teach_Learn_Talent_Specialization_Switches) || player->HasSpell(SPELL_Learn_a_Second_Talent_Specialization))
            return;

        // Cast spells that teach dual spec
        // Both are also ImplicitTarget self and must be cast by player
       // player->CastSpell(player, SPELL_Teach_Learn_Talent_Specialization_Switches, player->GetGUID());
        //player->CastSpell(player, SPELL_Learn_a_Second_Talent_Specialization, player->GetGUID());

        player->learnSpell(SPELL_Artisan_Riding);
        player->learnSpell(SPELL_Cold_Weather_Flying);
        //player->learnSpell(SPELL_Amani_War_Bear);
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
            CloseGossipMenuFor(player);
            return;
        }

        //sTemplateNpcMgr->LearnTemplateTalents(player);
        sTemplateNpcMgr->LearnTemplateGlyphs(player);
        sTemplateNpcMgr->LearnPlateMailSpells(player);

        LearnWeaponSkills(player);

        player->GetSession()->SendAreaTriggerMessage("Successfuly learned talent spec %s!", playerSpecStr.c_str());

        // Learn Riding/Flying
        if (player->HasSpell(SPELL_Artisan_Riding) ||
            player->HasSpell(SPELL_Cold_Weather_Flying) ||
           // player->HasSpell(SPELL_Amani_War_Bear) ||
            player->HasSpell(SPELL_Teach_Learn_Talent_Specialization_Switches) || player->HasSpell(SPELL_Learn_a_Second_Talent_Specialization))
            return;

        // Cast spells that teach dual spec
        // Both are also ImplicitTarget self and must be cast by player
        //player->CastSpell(player, SPELL_Teach_Learn_Talent_Specialization_Switches, player->GetGUID());
        //player->CastSpell(player, SPELL_Learn_a_Second_Talent_Specialization, player->GetGUID());

        player->learnSpell(SPELL_Artisan_Riding);
        player->learnSpell(SPELL_Cold_Weather_Flying);
        //player->learnSpell(SPELL_Amani_War_Bear);
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
            CloseGossipMenuFor(player);
            break;

        case 1: // Use Holy Priest Spec
            sTemplateNpcMgr->sTalentsSpec = "Holy";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 2: // Use Shadow Priest Spec
            sTemplateNpcMgr->sTalentsSpec = "Shadow";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 3: // Use Holy Paladin Spec
            sTemplateNpcMgr->sTalentsSpec = "Holy";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 4: // Use Protection Paladin Spec
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 5: // Use Retribution Paladin Spec
            sTemplateNpcMgr->sTalentsSpec = "Retribution";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 6: // Use Fury Warrior Spec
            sTemplateNpcMgr->sTalentsSpec = "Fury";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 7: // Use Arms Warrior Spec
            sTemplateNpcMgr->sTalentsSpec = "Arms";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 8: // Use Protection Warrior Spec
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 9: // Use Arcane Mage Spec
            sTemplateNpcMgr->sTalentsSpec = "Arcane";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 10: // Use Fire Mage Spec
            sTemplateNpcMgr->sTalentsSpec = "Fire";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 11: // Use Frost Mage Spec
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 12: // Use Affliction Warlock Spec
            sTemplateNpcMgr->sTalentsSpec = "Affliction";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 13: // Use Demonology Warlock Spec
            sTemplateNpcMgr->sTalentsSpec = "Demonology";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 14: // Use Destruction Warlock Spec
            sTemplateNpcMgr->sTalentsSpec = "Destruction";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 15: // Use Elemental Shaman Spec
            sTemplateNpcMgr->sTalentsSpec = "Elemental";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 16: // Use Enhancement Shaman Spec
            sTemplateNpcMgr->sTalentsSpec = "Enhancement";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 17: // Use Restoration Shaman Spec
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 18: // Use Ballance Druid Spec
            sTemplateNpcMgr->sTalentsSpec = "Ballance";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 19: // Use Feral Druid Spec
            sTemplateNpcMgr->sTalentsSpec = "Feral";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 20: // Use Restoration Druid Spec
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 21: // Use Marksmanship Hunter Spec
            sTemplateNpcMgr->sTalentsSpec = "Marksmanship";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 22: // Use Beastmastery Hunter Spec
            sTemplateNpcMgr->sTalentsSpec = "Beastmastery";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 23: // Use Survival Hunter Spec
            sTemplateNpcMgr->sTalentsSpec = "Survival";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 24: // Use Assassination Rogue Spec
            sTemplateNpcMgr->sTalentsSpec = "Assassination";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 25: // Use Combat Rogue Spec
            sTemplateNpcMgr->sTalentsSpec = "Combat";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 26: // Use Subtlety Rogue Spec
            sTemplateNpcMgr->sTalentsSpec = "Subtlety";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 27: // Use Blood DK Spec
            sTemplateNpcMgr->sTalentsSpec = "Blood";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 28: // Use Frost DK Spec
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 29: // Use Unholy DK Spec
            sTemplateNpcMgr->sTalentsSpec = "Unholy";
            EquipFullTemplateGear(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 30:
            sTemplateNpcMgr->RemoveAllGlyphs(player);
            player->GetSession()->SendAreaTriggerMessage("Your glyphs have been removed.");
            // GossipHello(player);
            CloseGossipMenuFor(player);
            break;

        case 31:
            player->resetTalents(true);
            player->SendTalentsInfoData(false);
            player->GetSession()->SendAreaTriggerMessage("Your talents have been reset.");
            CloseGossipMenuFor(player);
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
            CloseGossipMenuFor(player);
            break;

            // Priest
        case 100:
            sTemplateNpcMgr->sTalentsSpec = "Discipline";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 101:
            sTemplateNpcMgr->sTalentsSpec = "Holy";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 102:
            sTemplateNpcMgr->sTalentsSpec = "Shadow";
           // LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Paladin
        case 103:
            sTemplateNpcMgr->sTalentsSpec = "Holy";
           // LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 104:
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 105:
            sTemplateNpcMgr->sTalentsSpec = "Retribution";
           // LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Warrior
        case 106:
            sTemplateNpcMgr->sTalentsSpec = "Fury";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 107:
            sTemplateNpcMgr->sTalentsSpec = "Arms";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 108:
            sTemplateNpcMgr->sTalentsSpec = "Protection";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Mage
        case 109:
            sTemplateNpcMgr->sTalentsSpec = "Arcane";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 110:
            sTemplateNpcMgr->sTalentsSpec = "Fire";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 111:
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Warlock
        case 112:
            sTemplateNpcMgr->sTalentsSpec = "Affliction";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 113:
            sTemplateNpcMgr->sTalentsSpec = "Demonology";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 114:
            sTemplateNpcMgr->sTalentsSpec = "Destruction";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Shaman
        case 115:
            sTemplateNpcMgr->sTalentsSpec = "Elemental";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 116:
            sTemplateNpcMgr->sTalentsSpec = "Enhancement";
           // LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 117:
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Druid
        case 118:
            sTemplateNpcMgr->sTalentsSpec = "Ballance";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 119:
            sTemplateNpcMgr->sTalentsSpec = "Feral";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 120:
            sTemplateNpcMgr->sTalentsSpec = "Restoration";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Hunter
        case 121:
            sTemplateNpcMgr->sTalentsSpec = "Marksmanship";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 122:
            sTemplateNpcMgr->sTalentsSpec = "Beastmastery";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 123:
            sTemplateNpcMgr->sTalentsSpec = "Survival";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // Rogue
        case 124:
            sTemplateNpcMgr->sTalentsSpec = "Assasination";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 125:
            sTemplateNpcMgr->sTalentsSpec = "Combat";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 126:
            sTemplateNpcMgr->sTalentsSpec = "Subtlety";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

            // DK
        case 127:
            sTemplateNpcMgr->sTalentsSpec = "Blood";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 128:
            sTemplateNpcMgr->sTalentsSpec = "Frost";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
            break;

        case 129:
            sTemplateNpcMgr->sTalentsSpec = "Unholy";
            //LearnOnlyTalentsAndGlyphs(player, sTemplateNpcMgr->sTalentsSpec);
            CloseGossipMenuFor(player);
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
    void TeleportPlayer(Player* player) {
        // Coordenadas de Dalaran
        uint32 mapId = 571;         // DALARAN_MAP_ID
        float x = 5706.664f;        // DALARAN_X
        float y = 580.6445f;        // DALARAN_Y
        float z = 619.4176f;        // DALARAN_Z
        float orientation = 0.98854375f; // DALARAN_O

        // Realiza o teleporte
        player->TeleportTo(mapId, x, y, z, orientation);
    }
    static bool HandleReloadTemplateNPCCommand(ChatHandler *handler)
    {
     LOG_INFO("module", "Reloading templates for Template NPC table...");
     sTemplateNpcMgr->LoadTalentsContainer();
     sTemplateNpcMgr->LoadGlyphsContainer();
     sTemplateNpcMgr->LoadHumanGearContainer();
     sTemplateNpcMgr->LoadAllianceGearContainer();
     sTemplateNpcMgr->LoadHordeGearContainer();
    
    // Teleportar o jogador (exemplo de teleporte, ajuste conforme necessário)
    Player* player = handler->GetSession()->GetPlayer();
    if (player) {
       (player,5706.664, 580.6445, 619.4176, 0.98854375); // Substitua pelas coordenadas reais e ID do mapa
    }
    
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
        LOG_INFO("module", "== TEMPLATE NPC ==");
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
        LOG_INFO("module", "== END TEMPLATE NPC ==");
    }
};

void AddSC_TemplateNPC()
{
    new TemplateNPC();
    new TemplateNPC_command();
    new TemplateNPC_World();
}
