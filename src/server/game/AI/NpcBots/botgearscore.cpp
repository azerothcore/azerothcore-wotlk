#include "bot_ai.h"
#include "botdatamgr.h"
#include "botgearscore.h"
#include "Creature.h"
#include "Item.h"

#include <map>

#ifdef _MSC_VER
# pragma warning(push, 4)
#endif

constexpr float GS_scale = 1.8618f;

static const std::map<uint32, float> ItemSlotMods = {
    { INVTYPE_HEAD, 1.0f },
    { INVTYPE_NECK, 0.5625f },
    { INVTYPE_SHOULDERS, 0.75f },
    { INVTYPE_CHEST, 1.0f },
    { INVTYPE_WAIST, 0.75f },
    { INVTYPE_LEGS, 1.0f },
    { INVTYPE_FEET, 0.75f },
    { INVTYPE_WRISTS, 0.5625f },
    { INVTYPE_HANDS, 0.75f },
    { INVTYPE_FINGER, 0.5625f },
    { INVTYPE_TRINKET, 0.5625f },
    { INVTYPE_WEAPON, 1.0f },
    { INVTYPE_SHIELD, 1.0f },
    { INVTYPE_RANGED, 0.3164f },
    { INVTYPE_CLOAK, 0.5625f },
    { INVTYPE_2HWEAPON, 2.0f },
    { INVTYPE_ROBE, 1.0f },
    { INVTYPE_WEAPONMAINHAND, 1.0f },
    { INVTYPE_WEAPONOFFHAND, 1.0f },
    { INVTYPE_HOLDABLE, 1.0f },
    { INVTYPE_THROWN, 0.3164f },
    { INVTYPE_RANGEDRIGHT, 0.3164f },
    { INVTYPE_RELIC, 0.3164f }
};

constexpr std::pair<float, float> ItemLevelFactors[2][5] = {
    {
        { 0.0f,    1.0f },
        { 0.0f,    1.0f },
        { 73.0f,   1.0f },
        { 81.375f, 0.8125f },
        { 91.45f,  0.65f }
    },
    {
        { 0.0f,    1.0f },
        { 0.0f,    2.25f },
        { 8.0f,    2.0f },
        { 0.75f,   1.8f },
        { 26.0f,   1.2f }
    }
};

float CalculateItemGearScoreRaw(ItemTemplate const* proto)
{
    auto smcit = ItemSlotMods.find(proto->InventoryType);
    if (smcit == ItemSlotMods.cend())
        return 0.0f;

    uint32 quality = proto->Quality;
    float itemlvl = proto->ItemLevel;
    float slotmod = smcit->second;
    float qscale = 1.0f;

    if (quality == ITEM_QUALITY_LEGENDARY)
    {
        quality = ITEM_QUALITY_EPIC;
        qscale = 1.3f;
    }
    else if (quality <= ITEM_QUALITY_NORMAL)
    {
        quality = ITEM_QUALITY_UNCOMMON;
        qscale = 0.005f;
    }
    else if (quality == ITEM_QUALITY_HEIRLOOM)
    {
        quality = ITEM_QUALITY_RARE;
        itemlvl = 187.05f;
    }

    if (!(quality >= ITEM_QUALITY_UNCOMMON && quality <= ITEM_QUALITY_EPIC))
        return 0.0f;

    auto const& p = ItemLevelFactors[size_t(itemlvl <= 120.0f)][quality];
    return floor(((itemlvl - p.first) / p.second) * slotmod * qscale * GS_scale);
}

float CalculateItemGearScore(ItemTemplate const* proto, uint32 botentry/* = 0*/, uint8 botlevel/* = 0*/, uint8 botclass/* = 0*/, uint8 botspec/* = 0*/, uint8 slot/* = 18*/)
{
    EquipmentInfo const* einfo = nullptr;
    if (botentry)
    {
        ASSERT(slot < BOT_INVENTORY_SIZE, "Invalid bot equip slot %u!", uint32(slot));
        einfo = BotDataMgr::GetBotEquipmentInfo(botentry);
        ASSERT(einfo, "Trying to CalculateItemGearScore for bot %u with no equip info!", botentry);
    }

    float itemscore = 0.0f;

    if (slot > BOT_SLOT_RANGED || !einfo || einfo->ItemEntry[slot] != proto->ItemId)
    {
        itemscore = CalculateItemGearScoreRaw(proto);

        if (botspec == BOT_SPEC_WARRIOR_FURY && botlevel >= 60 && proto->InventoryType == INVTYPE_2HWEAPON)
            itemscore *= 0.5f;
        else if (botclass == BOT_CLASS_HUNTER)
        {
            if (proto->InventoryType == INVTYPE_WEAPON || proto->InventoryType == INVTYPE_WEAPONMAINHAND ||
                proto->InventoryType == INVTYPE_WEAPONOFFHAND || proto->InventoryType == INVTYPE_THROWN)
                itemscore *= 0.3164f;
            else if (proto->InventoryType == INVTYPE_RANGED || proto->InventoryType == INVTYPE_RANGEDRIGHT)
               itemscore *= 5.3224f;
        }
    }

    return std::max<float>(itemscore, 0.0f);
}

std::pair<float, float> CalculateBotGearScore(uint32 botentry, uint8 botlevel, uint8 botclass, uint8 botspec, Item const* const items[BOT_INVENTORY_SIZE])
{
    uint8 items_count = 0;
    float totalscore = 0.0f;

    for (uint8 i = 0; i < BOT_INVENTORY_SIZE; ++i)
    {
        if (Item const* item = items[i])
        {
            float itemscore = CalculateItemGearScore(item->GetTemplate(), botentry, botlevel, botclass, botspec, i);
            if (itemscore > 0.0f)
            {
                ++items_count;
                totalscore += itemscore;
            }
        }
    }

    return { totalscore, totalscore / std::max<uint8>(items_count, 1) };
}

#ifdef _MSC_VER
# pragma warning(pop)
#endif
