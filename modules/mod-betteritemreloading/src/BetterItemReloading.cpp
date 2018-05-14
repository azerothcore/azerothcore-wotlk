#include "ScriptMgr.h"
#include "Language.h"
#include "DisableMgr.h"

class BetterItemReloading : public CommandScript
{
public:
    BetterItemReloading() : CommandScript("BetterItemReloading") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> breloadCommandTable =
        {
            { "item", SEC_ADMINISTRATOR, true, &HandleBetterReloadItemsCommand, ""}
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "breload", SEC_ADMINISTRATOR, true, nullptr, "", breloadCommandTable}
        };

        return commandTable;
    }

    static bool HandleBetterReloadItemsCommand(ChatHandler* handler, const char* args)
    {
        if (!*args)
            return false;

        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        std::vector<Item*> pItems;
        std::vector<uint8> slots;
        std::vector<uint8> bagSlots;

        Tokenizer entries(std::string(args), ' ');

        for (Tokenizer::const_iterator itr = entries.begin(); itr != entries.end(); ++itr)
        {
            uint32 entry = uint32(atoi(*itr));

            // Deequip the item and cache it
            for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
            {
                Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
                if (pItem && pItem->GetEntry() == entry)
                {
                    uint8 slot = pItem->GetSlot();
                    pItems.push_back(pItem);
                    slots.push_back(slot);
                    player->DestroyItem(pItem->GetBagSlot() , slot, true);
                }
            }

            QueryResult result = WorldDatabase.PQuery("SELECT entry, class, subclass, SoundOverrideSubclass, name, displayid, Quality, Flags, FlagsExtra, BuyCount, BuyPrice, SellPrice, InventoryType, "
                "AllowableClass, AllowableRace, ItemLevel, RequiredLevel, RequiredSkill, RequiredSkillRank, requiredspell, requiredhonorrank, "
                "RequiredCityRank, RequiredReputationFaction, RequiredReputationRank, maxcount, stackable, ContainerSlots, StatsCount, stat_type1, "
                "stat_value1, stat_type2, stat_value2, stat_type3, stat_value3, stat_type4, stat_value4, stat_type5, stat_value5, stat_type6, "
                "stat_value6, stat_type7, stat_value7, stat_type8, stat_value8, stat_type9, stat_value9, stat_type10, stat_value10, "
                "ScalingStatDistribution, ScalingStatValue, dmg_min1, dmg_max1, dmg_type1, dmg_min2, dmg_max2, dmg_type2, armor, holy_res, fire_res, "
                "nature_res, frost_res, shadow_res, arcane_res, delay, ammo_type, RangedModRange, spellid_1, spelltrigger_1, spellcharges_1, "
                "spellppmRate_1, spellcooldown_1, spellcategory_1, spellcategorycooldown_1, spellid_2, spelltrigger_2, spellcharges_2, "
                "spellppmRate_2, spellcooldown_2, spellcategory_2, spellcategorycooldown_2, spellid_3, spelltrigger_3, spellcharges_3, "
                "spellppmRate_3, spellcooldown_3, spellcategory_3, spellcategorycooldown_3, spellid_4, spelltrigger_4, spellcharges_4, "
                "spellppmRate_4, spellcooldown_4, spellcategory_4, spellcategorycooldown_4, spellid_5, spelltrigger_5, spellcharges_5, "
                "spellppmRate_5, spellcooldown_5, spellcategory_5, spellcategorycooldown_5, bonding, description, PageText, LanguageID, PageMaterial, "
                "startquest, lockid, Material, sheath, RandomProperty, RandomSuffix, block, itemset, MaxDurability, area, Map, BagFamily, "
                "TotemCategory, socketColor_1, socketContent_1, socketColor_2, socketContent_2, socketColor_3, socketContent_3, socketBonus, "
                "GemProperties, RequiredDisenchantSkill, ArmorDamageModifier, duration, ItemLimitCategory, HolidayId, ScriptName, DisenchantID, "
                "FoodType, minMoneyLoot, maxMoneyLoot, flagsCustom FROM item_template WHERE entry = %u", entry);

            if (!result)
            {
                handler->PSendSysMessage("Couldn't reload item_template entry %u", entry);
                continue;
            }

            Field* fields = result->Fetch();

            ItemTemplate* itemTemplate;
            std::unordered_map<uint32, ItemTemplate>::const_iterator hasItem = sObjectMgr->GetItemTemplateStore()->find(entry);

            if (hasItem == sObjectMgr->GetItemTemplateStore()->end())
            {
                auto itStore = const_cast<ItemTemplateContainer*>(sObjectMgr->GetItemTemplateStore());
                itStore->insert(std::make_pair(entry, ItemTemplate()));
                auto itStoreFast = const_cast<std::vector<ItemTemplate*>*>(sObjectMgr->GetItemTemplateStoreFast());

                // Sadly, we have to reinsert all items here
                uint32 max = 0;
                for (ItemTemplateContainer::const_iterator itr = itStore->begin(); itr != itStore->end(); ++itr)
                    if (itr->first > max)
                        max = itr->first;
                if (max)
                {
                    itStoreFast->clear();
                    itStoreFast->resize(max + 1, NULL);
                    for (ItemTemplateContainer::iterator itr = itStore->begin(); itr != itStore->end(); ++itr)
                        (*itStoreFast)[itr->first] = &(itr->second);
                }
            }

            itemTemplate = const_cast<ItemTemplate*>(&sObjectMgr->GetItemTemplateStore()->at(entry));

            itemTemplate->ItemId = entry;
            itemTemplate->Class = uint32(fields[1].GetUInt8());
            itemTemplate->SubClass = uint32(fields[2].GetUInt8());
            itemTemplate->SoundOverrideSubclass = int32(fields[3].GetInt8());
            itemTemplate->Name1 = fields[4].GetString();
            itemTemplate->DisplayInfoID = fields[5].GetUInt32();
            itemTemplate->Quality = uint32(fields[6].GetUInt8());
            itemTemplate->Flags = fields[7].GetUInt32();
            itemTemplate->Flags2 = fields[8].GetUInt32();
            itemTemplate->BuyCount = uint32(fields[9].GetUInt8());
            itemTemplate->BuyPrice = int32(fields[10].GetInt64());
            itemTemplate->SellPrice = fields[11].GetUInt32();
            itemTemplate->InventoryType = uint32(fields[12].GetUInt8());
            itemTemplate->AllowableClass = fields[13].GetInt32();
            itemTemplate->AllowableRace = fields[14].GetInt32();
            itemTemplate->ItemLevel = uint32(fields[15].GetUInt16());
            itemTemplate->RequiredLevel = uint32(fields[16].GetUInt8());
            itemTemplate->RequiredSkill = uint32(fields[17].GetUInt16());
            itemTemplate->RequiredSkillRank = uint32(fields[18].GetUInt16());
            itemTemplate->RequiredSpell = fields[19].GetUInt32();
            itemTemplate->RequiredHonorRank = fields[20].GetUInt32();
            itemTemplate->RequiredCityRank = fields[21].GetUInt32();
            itemTemplate->RequiredReputationFaction = uint32(fields[22].GetUInt16());
            itemTemplate->RequiredReputationRank = uint32(fields[23].GetUInt16());
            itemTemplate->MaxCount = fields[24].GetInt32();
            itemTemplate->Stackable = fields[25].GetInt32();
            itemTemplate->ContainerSlots = uint32(fields[26].GetUInt8());
            itemTemplate->StatsCount = uint32(fields[27].GetUInt8());

            for (uint8 i = 0; i < itemTemplate->StatsCount; ++i)
            {
                itemTemplate->ItemStat[i].ItemStatType = uint32(fields[28 + i * 2].GetUInt8());
                itemTemplate->ItemStat[i].ItemStatValue = int32(fields[29 + i * 2].GetInt16());
            }

            itemTemplate->ScalingStatDistribution = uint32(fields[48].GetUInt16());
            itemTemplate->ScalingStatValue = fields[49].GetInt32();

            for (uint8 i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
            {
                itemTemplate->Damage[i].DamageMin = fields[50 + i * 3].GetFloat();
                itemTemplate->Damage[i].DamageMax = fields[51 + i * 3].GetFloat();
                itemTemplate->Damage[i].DamageType = uint32(fields[52 + i * 3].GetUInt8());
            }

            itemTemplate->Armor = uint32(fields[56].GetUInt16());
            itemTemplate->HolyRes = uint32(fields[57].GetUInt8());
            itemTemplate->FireRes = uint32(fields[58].GetUInt8());
            itemTemplate->NatureRes = uint32(fields[59].GetUInt8());
            itemTemplate->FrostRes = uint32(fields[60].GetUInt8());
            itemTemplate->ShadowRes = uint32(fields[61].GetUInt8());
            itemTemplate->ArcaneRes = uint32(fields[62].GetUInt8());
            itemTemplate->Delay = uint32(fields[63].GetUInt16());
            itemTemplate->AmmoType = uint32(fields[64].GetUInt8());
            itemTemplate->RangedModRange = fields[65].GetFloat();

            for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
            {
                itemTemplate->Spells[i].SpellId = fields[66 + i * 7].GetInt32();
                itemTemplate->Spells[i].SpellTrigger = uint32(fields[67 + i * 7].GetUInt8());
                itemTemplate->Spells[i].SpellCharges = int32(fields[68 + i * 7].GetInt16());
                itemTemplate->Spells[i].SpellPPMRate = fields[69 + i * 7].GetFloat();
                itemTemplate->Spells[i].SpellCooldown = fields[70 + i * 7].GetInt32();
                itemTemplate->Spells[i].SpellCategory = uint32(fields[71 + i * 7].GetUInt16());
                itemTemplate->Spells[i].SpellCategoryCooldown = fields[72 + i * 7].GetInt32();
            }

            itemTemplate->Bonding = uint32(fields[101].GetUInt8());
            itemTemplate->Description = fields[102].GetString();
            itemTemplate->PageText = fields[103].GetUInt32();
            itemTemplate->LanguageID = uint32(fields[104].GetUInt8());
            itemTemplate->PageMaterial = uint32(fields[105].GetUInt8());
            itemTemplate->StartQuest = fields[106].GetUInt32();
            itemTemplate->LockID = fields[107].GetUInt32();
            itemTemplate->Material = int32(fields[108].GetInt8());
            itemTemplate->Sheath = uint32(fields[109].GetUInt8());
            itemTemplate->RandomProperty = fields[110].GetUInt32();
            itemTemplate->RandomSuffix = fields[111].GetInt32();
            itemTemplate->Block = fields[112].GetUInt32();
            itemTemplate->ItemSet = fields[113].GetUInt32();
            itemTemplate->MaxDurability = uint32(fields[114].GetUInt16());
            itemTemplate->Area = fields[115].GetUInt32();
            itemTemplate->Map = uint32(fields[116].GetUInt16());
            itemTemplate->BagFamily = fields[117].GetUInt32();
            itemTemplate->TotemCategory = fields[118].GetUInt32();

            for (uint8 i = 0; i < MAX_ITEM_PROTO_SOCKETS; ++i)
            {
                itemTemplate->Socket[i].Color = uint32(fields[119 + i * 2].GetUInt8());
                itemTemplate->Socket[i].Content = fields[120 + i * 2].GetUInt32();
            }

            itemTemplate->socketBonus = fields[125].GetUInt32();
            itemTemplate->GemProperties = fields[126].GetUInt32();
            itemTemplate->RequiredDisenchantSkill = uint32(fields[127].GetInt16());
            itemTemplate->ArmorDamageModifier = fields[128].GetFloat();
            itemTemplate->Duration = fields[129].GetUInt32();
            itemTemplate->ItemLimitCategory = uint32(fields[130].GetInt16());
            itemTemplate->HolidayId = fields[131].GetUInt32();
            itemTemplate->ScriptId = sObjectMgr->GetScriptId(fields[132].GetCString());
            itemTemplate->DisenchantID = fields[133].GetUInt32();
            itemTemplate->FoodType = uint32(fields[134].GetUInt8());
            itemTemplate->MinMoneyLoot = fields[135].GetUInt32();
            itemTemplate->MaxMoneyLoot = fields[136].GetUInt32();
            itemTemplate->FlagsCu = fields[137].GetUInt32();

            if (itemTemplate->Class >= MAX_ITEM_CLASS)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong Class value (%u)", entry, itemTemplate->Class);
                itemTemplate->Class = ITEM_CLASS_MISC;
            }

            if (itemTemplate->SubClass >= MaxItemSubclassValues[itemTemplate->Class])
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong Subclass value (%u) for class %u", entry, itemTemplate->SubClass, itemTemplate->Class);
                itemTemplate->SubClass = 0;// exist for all item classes
            }

            if (itemTemplate->Quality >= MAX_ITEM_QUALITY)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong Quality value (%u)", entry, itemTemplate->Quality);
                itemTemplate->Quality = ITEM_QUALITY_NORMAL;
            }

            if (itemTemplate->Flags2 & ITEM_FLAGS_EXTRA_HORDE_ONLY)
            {
                if (FactionEntry const* faction = sFactionStore.LookupEntry(HORDE))
                    if ((itemTemplate->AllowableRace & faction->BaseRepRaceMask[0]) == 0)
                        sLog->outErrorDb("Item (Entry: %u) has value (%u) in `AllowableRace` races, not compatible with ITEM_FLAGS_EXTRA_HORDE_ONLY (%u) in Flags field, item cannot be equipped or used by these races.",
                            entry, itemTemplate->AllowableRace, ITEM_FLAGS_EXTRA_HORDE_ONLY);

                if (itemTemplate->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY)
                    sLog->outErrorDb("Item (Entry: %u) has value (%u) in `Flags2` flags (ITEM_FLAGS_EXTRA_ALLIANCE_ONLY) and ITEM_FLAGS_EXTRA_HORDE_ONLY (%u) in Flags field, this is a wrong combination.",
                        entry, ITEM_FLAGS_EXTRA_ALLIANCE_ONLY, ITEM_FLAGS_EXTRA_HORDE_ONLY);
            }
            else if (itemTemplate->Flags2 & ITEM_FLAGS_EXTRA_ALLIANCE_ONLY)
            {
                if (FactionEntry const* faction = sFactionStore.LookupEntry(ALLIANCE))
                    if ((itemTemplate->AllowableRace & faction->BaseRepRaceMask[0]) == 0)
                        sLog->outErrorDb("Item (Entry: %u) has value (%u) in `AllowableRace` races, not compatible with ITEM_FLAGS_EXTRA_ALLIANCE_ONLY (%u) in Flags field, item cannot be equipped or used by these races.",
                            entry, itemTemplate->AllowableRace, ITEM_FLAGS_EXTRA_ALLIANCE_ONLY);
            }

            if (itemTemplate->BuyCount <= 0)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong BuyCount value (%u), set to default(1).", entry, itemTemplate->BuyCount);
                itemTemplate->BuyCount = 1;
            }

            if (itemTemplate->InventoryType >= MAX_INVTYPE)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong InventoryType value (%u)", entry, itemTemplate->InventoryType);
                itemTemplate->InventoryType = INVTYPE_NON_EQUIP;
            }

            if (itemTemplate->RequiredSkill >= MAX_SKILL_TYPE)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong RequiredSkill value (%u)", entry, itemTemplate->RequiredSkill);
                itemTemplate->RequiredSkill = 0;
            }

            {
                // can be used in equip slot, as page read use in inventory, or spell casting at use
                bool req = itemTemplate->InventoryType != INVTYPE_NON_EQUIP || itemTemplate->PageText;
                if (!req)
                    for (uint8 j = 0; j < MAX_ITEM_PROTO_SPELLS; ++j)
                    {
                        if (itemTemplate->Spells[j].SpellId)
                        {
                            req = true;
                            break;
                        }
                    }

                if (req)
                {
                    if (!(itemTemplate->AllowableClass & CLASSMASK_ALL_PLAYABLE))
                        sLog->outErrorDb("Item (Entry: %u) does not have any playable classes (%u) in `AllowableClass` and can't be equipped or used.", entry, itemTemplate->AllowableClass);

                    if (!(itemTemplate->AllowableRace & RACEMASK_ALL_PLAYABLE))
                        sLog->outErrorDb("Item (Entry: %u) does not have any playable races (%u) in `AllowableRace` and can't be equipped or used.", entry, itemTemplate->AllowableRace);
                }
            }

            if (itemTemplate->RequiredSpell && !sSpellMgr->GetSpellInfo(itemTemplate->RequiredSpell))
            {
                sLog->outErrorDb("Item (Entry: %u) has a wrong (non-existing) spell in RequiredSpell (%u)", entry, itemTemplate->RequiredSpell);
                itemTemplate->RequiredSpell = 0;
            }

            if (itemTemplate->RequiredReputationRank >= MAX_REPUTATION_RANK)
                sLog->outErrorDb("Item (Entry: %u) has wrong reputation rank in RequiredReputationRank (%u), item can't be used.", entry, itemTemplate->RequiredReputationRank);

            if (itemTemplate->RequiredReputationFaction)
            {
                if (!sFactionStore.LookupEntry(itemTemplate->RequiredReputationFaction))
                {
                    sLog->outErrorDb("Item (Entry: %u) has wrong (not existing) faction in RequiredReputationFaction (%u)", entry, itemTemplate->RequiredReputationFaction);
                    itemTemplate->RequiredReputationFaction = 0;
                }

                if (itemTemplate->RequiredReputationRank == MIN_REPUTATION_RANK)
                    sLog->outErrorDb("Item (Entry: %u) has min. reputation rank in RequiredReputationRank (0) but RequiredReputationFaction > 0, faction setting is useless.", entry);
            }

            if (itemTemplate->MaxCount < -1)
            {
                sLog->outErrorDb("Item (Entry: %u) has too large negative in maxcount (%i), replace by value (-1) no storing limits.", entry, itemTemplate->MaxCount);
                itemTemplate->MaxCount = -1;
            }

            if (itemTemplate->Stackable == 0)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong value in stackable (%i), replace by default 1.", entry, itemTemplate->Stackable);
                itemTemplate->Stackable = 1;
            }
            else if (itemTemplate->Stackable < -1)
            {
                sLog->outErrorDb("Item (Entry: %u) has too large negative in stackable (%i), replace by value (-1) no stacking limits.", entry, itemTemplate->Stackable);
                itemTemplate->Stackable = -1;
            }

            if (itemTemplate->ContainerSlots > MAX_BAG_SIZE)
            {
                sLog->outErrorDb("Item (Entry: %u) has too large value in ContainerSlots (%u), replace by hardcoded limit (%u).", entry, itemTemplate->ContainerSlots, MAX_BAG_SIZE);
                itemTemplate->ContainerSlots = MAX_BAG_SIZE;
            }

            if (itemTemplate->StatsCount > MAX_ITEM_PROTO_STATS)
            {
                sLog->outErrorDb("Item (Entry: %u) has too large value in statscount (%u), replace by hardcoded limit (%u).", entry, itemTemplate->StatsCount, MAX_ITEM_PROTO_STATS);
                itemTemplate->StatsCount = MAX_ITEM_PROTO_STATS;
            }

            for (uint8 j = 0; j < itemTemplate->StatsCount; ++j)
            {
                // for ItemStatValue != 0
                if (itemTemplate->ItemStat[j].ItemStatValue && itemTemplate->ItemStat[j].ItemStatType >= MAX_ITEM_MOD)
                {
                    sLog->outErrorDb("Item (Entry: %u) has wrong (non-existing?) stat_type%d (%u)", entry, j + 1, itemTemplate->ItemStat[j].ItemStatType);
                    itemTemplate->ItemStat[j].ItemStatType = 0;
                }

                switch (itemTemplate->ItemStat[j].ItemStatType)
                {
                case ITEM_MOD_SPELL_HEALING_DONE:
                case ITEM_MOD_SPELL_DAMAGE_DONE:
                    sLog->outErrorDb("Item (Entry: %u) has deprecated stat_type%d (%u)", entry, j + 1, itemTemplate->ItemStat[j].ItemStatType);
                    break;
                default:
                    break;
                }
            }

            for (uint8 j = 0; j < MAX_ITEM_PROTO_DAMAGES; ++j)
            {
                if (itemTemplate->Damage[j].DamageType >= MAX_SPELL_SCHOOL)
                {
                    sLog->outErrorDb("Item (Entry: %u) has wrong dmg_type%d (%u)", entry, j + 1, itemTemplate->Damage[j].DamageType);
                    itemTemplate->Damage[j].DamageType = 0;
                }
            }

            // special format
            if ((itemTemplate->Spells[0].SpellId == 483) || (itemTemplate->Spells[0].SpellId == 55884))
            {
                // spell_1
                if (itemTemplate->Spells[0].SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
                {
                    sLog->outErrorDb("Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u) for special learning format", entry, 0 + 1, itemTemplate->Spells[0].SpellTrigger);
                    itemTemplate->Spells[0].SpellId = 0;
                    itemTemplate->Spells[0].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                    itemTemplate->Spells[1].SpellId = 0;
                    itemTemplate->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }

                // spell_2 have learning spell
                if (itemTemplate->Spells[1].SpellTrigger != ITEM_SPELLTRIGGER_LEARN_SPELL_ID)
                {
                    sLog->outErrorDb("Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u) for special learning format.", entry, 1 + 1, itemTemplate->Spells[1].SpellTrigger);
                    itemTemplate->Spells[0].SpellId = 0;
                    itemTemplate->Spells[1].SpellId = 0;
                    itemTemplate->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
                else if (!itemTemplate->Spells[1].SpellId)
                {
                    sLog->outErrorDb("Item (Entry: %u) does not have an expected spell in spellid_%d in special learning format.", entry, 1 + 1);
                    itemTemplate->Spells[0].SpellId = 0;
                    itemTemplate->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                }
                else if (itemTemplate->Spells[1].SpellId != -1)
                {
                    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itemTemplate->Spells[1].SpellId);
                    if (!spellInfo && !DisableMgr::IsDisabledFor(DISABLE_TYPE_SPELL, itemTemplate->Spells[1].SpellId, NULL))
                    {
                        sLog->outErrorDb("Item (Entry: %u) has wrong (not existing) spell in spellid_%d (%d)", entry, 1 + 1, itemTemplate->Spells[1].SpellId);
                        itemTemplate->Spells[0].SpellId = 0;
                        itemTemplate->Spells[1].SpellId = 0;
                        itemTemplate->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                    }
                    // allowed only in special format
                    else if ((itemTemplate->Spells[1].SpellId == 483) || (itemTemplate->Spells[1].SpellId == 55884))
                    {
                        sLog->outErrorDb("Item (Entry: %u) has broken spell in spellid_%d (%d)", entry, 1 + 1, itemTemplate->Spells[1].SpellId);
                        itemTemplate->Spells[0].SpellId = 0;
                        itemTemplate->Spells[1].SpellId = 0;
                        itemTemplate->Spells[1].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                    }
                }

                // spell_3*, spell_4*, spell_5* is empty
                for (uint8 j = 2; j < MAX_ITEM_PROTO_SPELLS; ++j)
                {
                    if (itemTemplate->Spells[j].SpellTrigger != ITEM_SPELLTRIGGER_ON_USE)
                    {
                        sLog->outErrorDb("Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u)", entry, j + 1, itemTemplate->Spells[j].SpellTrigger);
                        itemTemplate->Spells[j].SpellId = 0;
                        itemTemplate->Spells[j].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                    }
                    else if (itemTemplate->Spells[j].SpellId != 0)
                    {
                        sLog->outErrorDb("Item (Entry: %u) has wrong spell in spellid_%d (%d) for learning special format", entry, j + 1, itemTemplate->Spells[j].SpellId);
                        itemTemplate->Spells[j].SpellId = 0;
                    }
                }
            }
            // normal spell list
            else
            {
                for (uint8 j = 0; j < MAX_ITEM_PROTO_SPELLS; ++j)
                {
                    if (itemTemplate->Spells[j].SpellTrigger >= MAX_ITEM_SPELLTRIGGER || itemTemplate->Spells[j].SpellTrigger == ITEM_SPELLTRIGGER_LEARN_SPELL_ID)
                    {
                        sLog->outErrorDb("Item (Entry: %u) has wrong item spell trigger value in spelltrigger_%d (%u)", entry, j + 1, itemTemplate->Spells[j].SpellTrigger);
                        itemTemplate->Spells[j].SpellId = 0;
                        itemTemplate->Spells[j].SpellTrigger = ITEM_SPELLTRIGGER_ON_USE;
                    }

                    if (itemTemplate->Spells[j].SpellId && itemTemplate->Spells[j].SpellId != -1)
                    {
                        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(itemTemplate->Spells[j].SpellId);
                        if (!spellInfo && !DisableMgr::IsDisabledFor(DISABLE_TYPE_SPELL, itemTemplate->Spells[j].SpellId, NULL))
                        {
                            sLog->outErrorDb("Item (Entry: %u) has wrong (not existing) spell in spellid_%d (%d)", entry, j + 1, itemTemplate->Spells[j].SpellId);
                            itemTemplate->Spells[j].SpellId = 0;
                        }
                        // allowed only in special format
                        else if ((itemTemplate->Spells[j].SpellId == 483) || (itemTemplate->Spells[j].SpellId == 55884))
                        {
                            sLog->outErrorDb("Item (Entry: %u) has broken spell in spellid_%d (%d)", entry, j + 1, itemTemplate->Spells[j].SpellId);
                            itemTemplate->Spells[j].SpellId = 0;
                        }
                    }
                }
            }

            if (itemTemplate->Bonding >= MAX_BIND_TYPE)
                sLog->outErrorDb("Item (Entry: %u) has wrong Bonding value (%u)", entry, itemTemplate->Bonding);

            if (itemTemplate->PageText && !sObjectMgr->GetPageText(itemTemplate->PageText))
                sLog->outErrorDb("Item (Entry: %u) has non existing first page (Id:%u)", entry, itemTemplate->PageText);

            if (itemTemplate->LockID && !sLockStore.LookupEntry(itemTemplate->LockID))
                sLog->outErrorDb("Item (Entry: %u) has wrong LockID (%u)", entry, itemTemplate->LockID);

            if (itemTemplate->Sheath >= MAX_SHEATHETYPE)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong Sheath (%u)", entry, itemTemplate->Sheath);
                itemTemplate->Sheath = SHEATHETYPE_NONE;
            }

            if (itemTemplate->RandomProperty)
            {
                if (itemTemplate->RandomProperty == -1)
                    itemTemplate->RandomProperty = 0;

                else if (!sItemRandomPropertiesStore.LookupEntry(GetItemEnchantMod(itemTemplate->RandomProperty)))
                {
                    sLog->outErrorDb("Item (Entry: %u) has unknown (wrong or not listed in `item_enchantment_template`) RandomProperty (%u)", entry, itemTemplate->RandomProperty);
                    itemTemplate->RandomProperty = 0;
                }
            }

            if (itemTemplate->RandomSuffix && !sItemRandomSuffixStore.LookupEntry(GetItemEnchantMod(itemTemplate->RandomSuffix)))
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong RandomSuffix (%u)", entry, itemTemplate->RandomSuffix);
                itemTemplate->RandomSuffix = 0;
            }

            if (itemTemplate->ItemSet && !sItemSetStore.LookupEntry(itemTemplate->ItemSet))
            {
                sLog->outErrorDb("Item (Entry: %u) have wrong ItemSet (%u)", entry, itemTemplate->ItemSet);
                itemTemplate->ItemSet = 0;
            }

            if (itemTemplate->Area && !sAreaTableStore.LookupEntry(itemTemplate->Area))
                sLog->outErrorDb("Item (Entry: %u) has wrong Area (%u)", entry, itemTemplate->Area);

            if (itemTemplate->Map && !sMapStore.LookupEntry(itemTemplate->Map))
                sLog->outErrorDb("Item (Entry: %u) has wrong Map (%u)", entry, itemTemplate->Map);

            if (itemTemplate->BagFamily)
            {
                // check bits
                for (uint32 j = 0; j < sizeof(itemTemplate->BagFamily) * 8; ++j)
                {
                    uint32 mask = 1 << j;
                    if ((itemTemplate->BagFamily & mask) == 0)
                        continue;

                    ItemBagFamilyEntry const* bf = sItemBagFamilyStore.LookupEntry(j + 1);
                    if (!bf)
                    {
                        sLog->outErrorDb("Item (Entry: %u) has bag family bit set not listed in ItemBagFamily.dbc, remove bit", entry);
                        itemTemplate->BagFamily &= ~mask;
                        continue;
                    }

                    if (BAG_FAMILY_MASK_CURRENCY_TOKENS & mask)
                    {
                        CurrencyTypesEntry const* ctEntry = sCurrencyTypesStore.LookupEntry(itemTemplate->ItemId);
                        if (!ctEntry)
                        {
                            sLog->outErrorDb("Item (Entry: %u) has currency bag family bit set in BagFamily but not listed in CurrencyTypes.dbc, remove bit", entry);
                            itemTemplate->BagFamily &= ~mask;
                        }
                    }
                }
            }

            if (itemTemplate->TotemCategory && !sTotemCategoryStore.LookupEntry(itemTemplate->TotemCategory))
                sLog->outErrorDb("Item (Entry: %u) has wrong TotemCategory (%u)", entry, itemTemplate->TotemCategory);

            for (uint8 j = 0; j < MAX_ITEM_PROTO_SOCKETS; ++j)
            {
                if (itemTemplate->Socket[j].Color && (itemTemplate->Socket[j].Color & SOCKET_COLOR_ALL) != itemTemplate->Socket[j].Color)
                {
                    sLog->outErrorDb("Item (Entry: %u) has wrong socketColor_%d (%u)", entry, j + 1, itemTemplate->Socket[j].Color);
                    itemTemplate->Socket[j].Color = 0;
                }
            }

            if (itemTemplate->GemProperties && !sGemPropertiesStore.LookupEntry(itemTemplate->GemProperties))
                sLog->outErrorDb("Item (Entry: %u) has wrong GemProperties (%u)", entry, itemTemplate->GemProperties);

            if (itemTemplate->FoodType >= MAX_PET_DIET)
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong FoodType value (%u)", entry, itemTemplate->FoodType);
                itemTemplate->FoodType = 0;
            }

            if (itemTemplate->ItemLimitCategory && !sItemLimitCategoryStore.LookupEntry(itemTemplate->ItemLimitCategory))
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong LimitCategory value (%u)", entry, itemTemplate->ItemLimitCategory);
                itemTemplate->ItemLimitCategory = 0;
            }

            if (itemTemplate->HolidayId && !sHolidaysStore.LookupEntry(itemTemplate->HolidayId))
            {
                sLog->outErrorDb("Item (Entry: %u) has wrong HolidayId value (%u)", entry, itemTemplate->HolidayId);
                itemTemplate->HolidayId = 0;
            }

            if (itemTemplate->FlagsCu & ITEM_FLAGS_CU_DURATION_REAL_TIME && !itemTemplate->Duration)
            {
                sLog->outErrorDb("Item (Entry %u) has flag ITEM_FLAGS_CU_DURATION_REAL_TIME but it does not have duration limit", entry);
                itemTemplate->FlagsCu &= ~ITEM_FLAGS_CU_DURATION_REAL_TIME;
            }

            // Fill categories map
            for (uint8 i = 0; i < MAX_ITEM_PROTO_SPELLS; ++i)
            {
                if (itemTemplate->Spells[i].SpellId && itemTemplate->Spells[i].SpellCategory && itemTemplate->Spells[i].SpellCategoryCooldown)
                {
                    SpellCategoryStore::const_iterator ct = sSpellsByCategoryStore.find(itemTemplate->Spells[i].SpellCategory);
                    if (ct != sSpellsByCategoryStore.end())
                    {
                        const SpellCategorySet& ct_set = ct->second;
                        if (ct_set.find(itemTemplate->Spells[i].SpellId) == ct_set.end())
                            sSpellsByCategoryStore[itemTemplate->Spells[i].SpellCategory].insert(itemTemplate->Spells[i].SpellId);
                    }
                    else
                        sSpellsByCategoryStore[itemTemplate->Spells[i].SpellCategory].insert(itemTemplate->Spells[i].SpellId);
                }
            }

            Player* player = handler->GetSession()->GetPlayer();

            SendItemQuery(player, itemTemplate);

            // safety check
            if (pItems.size() == slots.size())
            {
                // re-equip the item to apply the new stats
                for (size_t i = 0; i < pItems.size(); i++)
                    player->EquipItem(slots.at(i), pItems.at(i), true);
            }

            handler->PSendSysMessage("Reloaded item template entry %u", entry);
        }

        return true;
    }

private:
    static void SendItemQuery(Player* player, ItemTemplate* item)
    {
        if (!player || !item)
            return;

        std::string name = item->Name1;
        std::string description = item->Description;
        int loc_idx = player->GetSession()->GetSessionDbLocaleIndex();
        if (loc_idx >= 0)
        {
            if (ItemLocale const* il = sObjectMgr->GetItemLocale(item->ItemId))
            {
                ObjectMgr::GetLocaleString(il->Name, loc_idx, name);
                ObjectMgr::GetLocaleString(il->Description, loc_idx, description);
            }
        }
        WorldPacket data(SMSG_ITEM_QUERY_SINGLE_RESPONSE, 600);
        data << item->ItemId;
        data << item->Class;
        data << item->SubClass;
        data << item->SoundOverrideSubclass;
        data << name;
        data << uint8(0x00);
        data << uint8(0x00);
        data << uint8(0x00);
        data << item->DisplayInfoID;
        data << item->Quality;
        data << item->Flags;
        data << item->Flags2;
        data << item->BuyPrice;
        data << item->SellPrice;
        data << item->InventoryType;
        data << item->AllowableClass;
        data << item->AllowableRace;
        data << item->ItemLevel;
        data << item->RequiredLevel;
        data << item->RequiredSkill;
        data << item->RequiredSkillRank;
        data << item->RequiredSpell;
        data << item->RequiredHonorRank;
        data << item->RequiredCityRank;
        data << item->RequiredReputationFaction;
        data << item->RequiredReputationRank;
        data << int32(item->MaxCount);
        data << int32(item->Stackable);
        data << item->ContainerSlots;
        data << item->StatsCount;
        for (uint32 i = 0; i < item->StatsCount; ++i)
        {
            data << item->ItemStat[i].ItemStatType;
            data << item->ItemStat[i].ItemStatValue;
        }
        data << item->ScalingStatDistribution;
        data << item->ScalingStatValue;
        for (int i = 0; i < MAX_ITEM_PROTO_DAMAGES; ++i)
        {
            data << item->Damage[i].DamageMin;
            data << item->Damage[i].DamageMax;
            data << item->Damage[i].DamageType;
        }
        data << item->Armor;
        data << item->HolyRes;
        data << item->FireRes;
        data << item->NatureRes;
        data << item->FrostRes;
        data << item->ShadowRes;
        data << item->ArcaneRes;
        data << item->Delay;
        data << item->AmmoType;
        data << item->RangedModRange;
        for (int s = 0; s < MAX_ITEM_PROTO_SPELLS; ++s)
        {
            SpellInfo const* spell = sSpellMgr->GetSpellInfo(item->Spells[s].SpellId);
            if (spell)
            {
                bool db_data = item->Spells[s].SpellCooldown >= 0 || item->Spells[s].SpellCategoryCooldown >= 0;

                data << item->Spells[s].SpellId;
                data << item->Spells[s].SpellTrigger;
                data << uint32(-abs(item->Spells[s].SpellCharges));

                if (db_data)
                {
                    data << uint32(item->Spells[s].SpellCooldown);
                    data << uint32(item->Spells[s].SpellCategory);
                    data << uint32(item->Spells[s].SpellCategoryCooldown);
                }
                else
                {
                    data << uint32(spell->RecoveryTime);
                    data << uint32(spell->GetCategory());
                    data << uint32(spell->CategoryRecoveryTime);
                }
            }
            else
            {
                data << uint32(0);
                data << uint32(0);
                data << uint32(0);
                data << uint32(-1);
                data << uint32(0);
                data << uint32(-1);
            }
        }
        data << item->Bonding;
        data << description;
        data << item->PageText;
        data << item->LanguageID;
        data << item->PageMaterial;
        data << item->StartQuest;
        data << item->LockID;
        data << int32(item->Material);
        data << item->Sheath;
        data << item->RandomProperty;
        data << item->RandomSuffix;
        data << item->Block;
        data << item->ItemSet;
        data << item->MaxDurability;
        data << item->Area;
        data << item->Map;
        data << item->BagFamily;
        data << item->TotemCategory;
        for (int s = 0; s < MAX_ITEM_PROTO_SOCKETS; ++s)
        {
            data << item->Socket[s].Color;
            data << item->Socket[s].Content;
        }
        data << item->socketBonus;
        data << item->GemProperties;
        data << item->RequiredDisenchantSkill;
        data << item->ArmorDamageModifier;
        data << item->Duration;
        data << item->ItemLimitCategory;
        data << item->HolidayId;
        player->GetSession()->SendPacket(&data);
    }
};

void AddBetterItemReloadingScripts()
{
    new BetterItemReloading();
}