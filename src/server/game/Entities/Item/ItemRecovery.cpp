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

#include "ItemRecovery.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "Mail.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "StringConvert.h"
#include "Tokenize.h"
#include "World.h"
#include <array>
#include <map>
#include <mutex>
#include <unordered_set>

namespace
{
    // Temporary enchants are not restored, and the random property slots are rebuilt from RandomPropertyId
    constexpr std::array<EnchantmentSlot, 6> RecoveryEnchantmentSlots =
    {
        PERM_ENCHANTMENT_SLOT,
        SOCK_ENCHANTMENT_SLOT,
        SOCK_ENCHANTMENT_SLOT_2,
        SOCK_ENCHANTMENT_SLOT_3,
        BONUS_ENCHANTMENT_SLOT,
        PRISMATIC_ENCHANTMENT_SLOT
    };

    // The restore transaction deletes its row asynchronously, so a repeated restore could still load it.
    // Recovery ids are never reused, so remembering them for the process lifetime is enough.
    std::mutex RestoredIdsLock;
    std::unordered_set<uint32> RestoredIds;

    RecoveryItemLoot LoadLoot(uint32 recoveryId)
    {
        RecoveryItemLoot loot;

        CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM_LOOT);
        stmt->SetData(0, recoveryId);
        if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
        {
            do
            {
                Field* fields = result->Fetch();
                loot.emplace_back(fields[0].Get<uint32>(), fields[1].Get<uint32>());
            } while (result->NextRow());
        }

        return loot;
    }
}

bool ItemRecovery::Save(Item const* item, uint32 count, RecoveryItemSource source, uint32 money, RecoveryItemLoot const& loot)
{
    ItemTemplate const* proto = item->GetTemplate();
    if (!sWorld->getBoolConfig(CONFIG_ITEMDELETE_METHOD)
        || proto->Quality < sWorld->getIntConfig(CONFIG_ITEMDELETE_QUALITY)
        || proto->ItemLevel < sWorld->getIntConfig(CONFIG_ITEMDELETE_ITEM_LEVEL))
        return false;

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    uint8 index = 0;
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_RECOVERY_ITEM);
    stmt->SetData(index++, item->GetOwnerGUID().GetCounter());
    stmt->SetData(index++, item->GetEntry());
    stmt->SetData(index++, item->GetGUID().GetCounter());
    stmt->SetData(index++, count);
    stmt->SetData(index++, uint8(source));
    stmt->SetData(index++, money);
    stmt->SetData(index++, item->GetItemRandomPropertyId());
    stmt->SetData(index++, item->GetEnchantmentsString());
    stmt->SetData(index++, item->GetGuidValue(ITEM_FIELD_CREATOR).GetCounter());
    stmt->SetData(index++, uint8(item->IsSoulBound()));
    trans->Append(stmt);

    std::map<uint32, uint32> lootCounts;
    for (auto const& [itemEntry, itemCount] : loot)
        lootCounts[itemEntry] += itemCount;

    // recovery_item_loot has no auto-increment column, so LAST_INSERT_ID() keeps pointing at the row above
    for (auto const& [itemEntry, itemCount] : lootCounts)
    {
        stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_RECOVERY_ITEM_LOOT);
        stmt->SetData(0, itemEntry);
        stmt->SetData(1, itemCount);
        trans->Append(stmt);
    }

    // Synchronous, so the row exists before a buyback of the same item tries to delete it
    CharacterDatabase.DirectCommitTransaction(trans);
    return true;
}

std::optional<RecoveryItem> ItemRecovery::Load(uint32 recoveryId)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RECOVERY_ITEM);
    stmt->SetData(0, recoveryId);
    PreparedQueryResult result = CharacterDatabase.Query(stmt);
    if (!result)
        return std::nullopt;

    Field* fields = result->Fetch();

    RecoveryItem recovery;
    recovery.Id               = fields[0].Get<uint32>();
    recovery.OwnerGuid        = fields[1].Get<uint32>();
    recovery.ItemEntry        = fields[2].Get<uint32>();
    recovery.ItemGuid         = fields[3].Get<uint32>();
    recovery.Count            = fields[4].Get<uint32>();
    recovery.Source           = RecoveryItemSource(fields[5].Get<uint8>());
    recovery.Money            = fields[6].Get<uint32>();
    recovery.RandomPropertyId = fields[7].Get<int32>();
    recovery.Enchantments     = fields[8].Get<std::string>();
    recovery.CreatorGuid      = fields[9].Get<uint32>();
    recovery.Bound            = fields[10].Get<uint8>() != 0;
    recovery.Loot             = LoadLoot(recovery.Id);

    return recovery;
}

bool ItemRecovery::Restore(RecoveryItem const& recovery, Player* owner)
{
    if (!sObjectMgr->GetItemTemplate(recovery.ItemEntry))
        return false;

    {
        std::lock_guard<std::mutex> lock(RestoredIdsLock);
        if (!RestoredIds.insert(recovery.Id).second)
            return false;
    }

    // A zero id rolls a new random property, which only matters for legacy rows recorded without one
    Item* item = Item::CreateItem(recovery.ItemEntry, recovery.Count, nullptr, false, uint32(recovery.RandomPropertyId));
    if (!item)
    {
        std::lock_guard<std::mutex> lock(RestoredIdsLock);
        RestoredIds.erase(recovery.Id);
        return false;
    }

    // An online receiver takes this very object from the mail, and a soulbound item must already be theirs
    item->SetOwnerGUID(ObjectGuid::Create<HighGuid::Player>(recovery.OwnerGuid));

    // Item::SetEnchantment logs to and queues the item for its owner, who may be offline and does not hold it yet
    std::vector<std::string_view> enchantments = Acore::Tokenize(recovery.Enchantments, ' ', false);
    if (enchantments.size() == MAX_ENCHANTMENT_SLOT * MAX_ENCHANTMENT_OFFSET)
    {
        for (EnchantmentSlot slot : RecoveryEnchantmentSlots)
        {
            uint32 const field = slot * MAX_ENCHANTMENT_OFFSET + ENCHANTMENT_ID_OFFSET;
            if (Optional<uint32> enchantId = Acore::StringTo<uint32>(enchantments[field]); enchantId && *enchantId)
                item->SetUInt32Value(ITEM_FIELD_ENCHANTMENT_1_1 + field, *enchantId);
        }
    }

    if (recovery.CreatorGuid)
        item->SetGuidValue(ITEM_FIELD_CREATOR, ObjectGuid::Create<HighGuid::Player>(recovery.CreatorGuid));

    // A bind-on-equip item would otherwise come back tradeable
    if (recovery.Bound)
        item->SetBinding(true);

    CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();

    item->SaveToDB(trans);
    MailDraft("Recovered Item", "We recovered a lost item in the twisting nether and noted that it was yours.$B$BPlease find said object enclosed.")
        .AddItem(item)
        .SendMailTo(trans, MailReceiver(owner, recovery.OwnerGuid), MailSender(MAIL_CREATURE, 34337 /* The Postmaster */));

    DeleteFromDB(trans, recovery.Id);
    CharacterDatabase.CommitTransaction(trans);
    return true;
}

void ItemRecovery::DeleteFromDB(CharacterDatabaseTransaction trans, uint32 recoveryId)
{
    CharacterDatabasePreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_RECOVERY_ITEM_LOOT_BY_RECOVERY_ID);
    stmt->SetData(0, recoveryId);
    trans->Append(stmt);

    stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_RECOVERY_ITEM_BY_RECOVERY_ID);
    stmt->SetData(0, recoveryId);
    trans->Append(stmt);
}

bool ItemRecovery::IsInBuyback(Player* player, RecoveryItem const& recovery)
{
    for (uint32 slot = BUYBACK_SLOT_START; slot < BUYBACK_SLOT_END; ++slot)
        if (Item* item = player->GetItemFromBuyBackSlot(slot))
            if (item->GetGUID().GetCounter() == recovery.ItemGuid && item->GetEntry() == recovery.ItemEntry)
                return true;

    return false;
}
