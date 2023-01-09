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

#include "CharacterDatabase.h"
#include "MySQLPreparedStatement.h"

void CharacterDatabaseConnection::DoPrepareStatements()
{
    if (!m_reconnecting)
        m_stmts.resize(MAX_CHARACTERDATABASE_STATEMENTS);

    PrepareStatement(CHAR_DEL_QUEST_POOL_SAVE, "DELETE FROM pool_quest_save WHERE PoolID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_QUEST_POOL_SAVE, "INSERT INTO pool_quest_save (PoolID, QuestID) VALUES (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_NONEXISTENT_GUILD_BANK_ITEM, "DELETE FROM guild_bank_item WHERE GuildID = ? AND TabID = ? AND SlotID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_EXPIRED_BANS, "UPDATE character_banned SET Active = 0 WHERE UnbanDate <= UNIX_TIMESTAMP() AND UnbanDate <> BanDate", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_DATA_BY_NAME, "SELECT GUID, Account, Name, Gender, Race, Class, Level FROM characters WHERE DeleteDate IS NULL AND Name = ?", CONNECTION_BOTH);
    PrepareStatement(CHAR_SEL_DATA_BY_GUID, "SELECT GUID, Account, Name, Gender, Race, Class, Level FROM characters WHERE DeleteDate IS NULL AND GUID = ?", CONNECTION_BOTH);
    PrepareStatement(CHAR_SEL_CHECK_NAME, "SELECT 1 FROM characters WHERE Name = ?", CONNECTION_BOTH);
    PrepareStatement(CHAR_SEL_CHECK_GUID, "SELECT 1 FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_SUM_CHARS, "SELECT COUNT(GUID) FROM characters WHERE Account = ?", CONNECTION_BOTH);
    PrepareStatement(CHAR_SEL_CHAR_CREATE_INFO, "SELECT Level, Race, Class FROM characters WHERE Account = ? LIMIT 0, ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHARACTER_BAN, "INSERT INTO character_banned VALUES (?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+?, ?, ?, 1)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHARACTER_BAN, "UPDATE character_banned SET Active = 0 WHERE GUID = ? AND Active != 0", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHARACTER_BAN, "DELETE cb FROM character_banned cb INNER JOIN characters c ON c.GUID = cb.GUID WHERE c.Account = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_BANINFO, "SELECT FROM_UNIXTIME(BanDate, '%Y-%m-%d %H:%i:%s'), UnbanDate-BanDate, Active, UnbanDate, BanReason, BannedBy FROM character_banned WHERE GUID = ? ORDER BY BanDate ASC", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_GUID_BY_NAME_FILTER, "SELECT GUID, Name FROM characters WHERE Name LIKE CONCAT('%%', ?, '%%')", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_BANINFO_LIST, "SELECT BanDate, UnbanDate, BannedBy, BanReason FROM character_banned WHERE GUID = ? ORDER BY UnbanDate", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_BANNED_NAME, "SELECT characters.Name FROM characters, character_banned WHERE character_banned.GUID = ? AND character_banned.GUID = characters.GUID", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_ENUM, "SELECT c.GUID, c.Name, c.Race, c.Class, c.Gender, c.Skin, c.Face, c.HairStyle, c.HairColor, c.FacialStyle, c.Level, c.Zone, c.Map, c.PositionX, c.PositionY, c.PositionZ, "
                     "gm.GuildID, c.PlayerFlags, c.AtLogin, cp.Entry, cp.ModelID, cp.Level, c.EquipmentCache, cb.GUID, c.ExtraFlags "
                     "FROM characters AS c LEFT JOIN character_pet AS cp ON c.GUID = cp.Owner AND cp.Slot = ? LEFT JOIN guild_member AS gm ON c.GUID = gm.GUID "
                     "LEFT JOIN character_banned AS cb ON c.GUID = cb.GUID AND cb.Active = 1 WHERE c.Account = ? AND c.DeleteInfoName IS NULL ORDER BY COALESCE(c.Order, c.GUID)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_ENUM_DECLINED_NAME, "SELECT c.GUID, c.Name, c.Race, c.Class, c.Gender, c.Skin, c.Face, c.HairStyle, c.HairColor, c.FacialStyle, c.Level, c.Zone, c.Map, "
                     "c.PositionX, c.PositionY, c.PositionZ, gm.GuildID, c.PlayerFlags, c.AtLogin, cp.Entry, cp.ModelID, cp.Level, c.EquipmentCache, "
                     "cb.GUID, c.ExtraFlags, cd.Genitive FROM characters AS c LEFT JOIN character_pet AS cp ON c.GUID = cp.Owner AND cp.Slot = ? "
                     "LEFT JOIN character_declined_name AS cd ON c.GUID = cd.GUID LEFT JOIN guild_member AS gm ON c.GUID = gm.GUID "
                     "LEFT JOIN character_banned AS cb ON c.GUID = cb.GUID AND cb.Active = 1 WHERE c.Account = ? AND c.DeleteInfoName IS NULL ORDER BY COALESCE(c.Order, c.GUID)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_FREE_NAME, "SELECT GUID, Name, AtLogin FROM characters WHERE GUID = ? AND Account = ? AND NOT EXISTS (SELECT NULL FROM characters WHERE Name = ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHAR_ZONE, "SELECT Zone FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHARACTER_NAME_DATA, "SELECT Race, Class, Gender, Level FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_POSITION_XYZ, "SELECT Map, PositionX, PositionY, PositionZ FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_POSITION, "SELECT PositionX, PositionY, PositionZ, Orientation, Map, TaxiPath FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_DAILY, "DELETE FROM character_quest_status_daily", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_WEEKLY, "DELETE FROM character_quest_status_weekly", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_MONTHLY, "DELETE FROM character_quest_status_monthly", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_SEASONAL, "DELETE FROM character_quest_status_seasonal WHERE Event = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_DAILY_CHAR, "DELETE FROM character_quest_status_daily WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_WEEKLY_CHAR, "DELETE FROM character_quest_status_weekly WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_MONTHLY_CHAR, "DELETE FROM character_quest_status_monthly WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_QUEST_STATUS_SEASONAL_CHAR, "DELETE FROM character_quest_status_seasonal WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_BATTLEGROUND_RANDOM, "DELETE FROM character_battleground_random", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_BATTLEGROUND_RANDOM, "INSERT INTO character_battleground_random (GUID) VALUES (?)", CONNECTION_ASYNC);

    // Start LoginQueryHolder content
    PrepareStatement(CHAR_SEL_CHARACTER, "SELECT GUID, Account, Name, Race, Class, Gender, Level, XP, Money, Skin, Face, HairStyle, HairColor, FacialStyle, BankSlots, RestState, PlayerFlags, "
                     "PositionX, PositionY, PositionZ, Map, Orientation, TaxiMask, Cinematic, TotalTime, LevelTime, RestBonus, LogoutTime, IsLogoutResting, ResetTalentsCost, "
                     "ResetTalentsTime, TransportX, TransportY, TransportZ, TransportO, TransportGUID, ExtraFlags, StableSlots, AtLogin, Zone, Online, DeathExpireTime, TaxiPath, InstanceModeMask, "
                     "ArenaPoints, TotalHonorPoints, TodayHonorPoints, YesterdayHonorPoints, TotalKills, TodayKills, YesterdayKills, ChosenTitle, KnownCurrencies, WatchedFaction, Drunk, "
                     "Health, Power1, Power2, Power3, Power4, Power5, Power6, Power7, InstanceID, TalentGroupsCount, ActiveTalentGroup, ExploredZones, EquipmentCache, AmmoID, "
                     "KnownTitles, ActionBars, GrantableLevels, InnTriggerID FROM characters WHERE GUID = ?", CONNECTION_ASYNC);

    PrepareStatement(CHAR_SEL_CHARACTER_AURAS, "SELECT CasterGUID, ItemGUID, Spell, EffectMask, RecalculateMask, StackCount, Amount1, Amount2, Amount3, "
                     "BaseAmount1, BaseAmount2, BaseAmount3, MaxDuration, RemainTime, RemainCharges FROM character_aura WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_SPELL, "SELECT Spell, SpecMask FROM character_spell WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_QUESTSTATUS, "SELECT Quest, Status, Explored, Timer, MobCount1, MobCount2, MobCount3, MobCount4, "
                     "ItemCount1, ItemCount2, ItemCount3, ItemCount4, ItemCount5, ItemCount6, PlayerCount FROM character_quest_status WHERE GUID = ? AND Status <> 0", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_DAILYQUESTSTATUS, "SELECT Quest, Time FROM character_quest_status_daily WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_WEEKLYQUESTSTATUS, "SELECT Quest FROM character_quest_status_weekly WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_MONTHLYQUESTSTATUS, "SELECT Quest FROM character_quest_status_monthly WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_SEASONALQUESTSTATUS, "SELECT Quest, Event FROM character_quest_status_seasonal WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHARACTER_DAILYQUESTSTATUS, "INSERT INTO character_quest_status_daily (GUID, Quest, Time) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHARACTER_WEEKLYQUESTSTATUS, "INSERT INTO character_quest_status_weekly (GUID, Quest) VALUES (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHARACTER_MONTHLYQUESTSTATUS, "INSERT INTO character_quest_status_monthly (GUID, Quest) VALUES (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHARACTER_SEASONALQUESTSTATUS, "INSERT IGNORE INTO character_quest_status_seasonal (GUID, Quest, Event) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_REPUTATION, "SELECT Faction, Standing, Flags FROM character_reputation WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_INVENTORY, "SELECT CreatorGUID, GiftCreatorGUID, Count, Duration, Charges, Flags, Enchantments, RandomPropertyID, Durability, PlayedTime, Text, Bag, Slot, "
                     "Item, ItemEntry FROM character_inventory ci JOIN item_instance ii ON ci.Item = ii.GUID WHERE ci.GUID = ? ORDER BY Bag, Slot", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_ACTIONS, "SELECT a.Button, a.Action, a.Type FROM character_action as a, characters as c WHERE a.GUID = c.GUID AND a.Spec = c.ActiveTalentGroup AND a.GUID = ? ORDER BY Button", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_MAILCOUNT_UNREAD, "SELECT COUNT(ID) FROM mail WHERE Receiver = ? AND (Checked & 1) = 0 AND DeliverTime <= ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_MAILCOUNT_UNREAD_SYNCH, "SELECT COUNT(ID) FROM mail WHERE Receiver = ? AND (Checked & 1) = 0 AND DeliverTime <= ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_MAIL_SERVER_CHARACTER, "SELECT MailID from mail_server_character WHERE GUID = ? and MailID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_MAIL_SERVER_CHARACTER, "REPLACE INTO mail_server_character (GUID, MailID) values (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_SOCIALLIST, "SELECT Friend, Flags, Note FROM character_social JOIN characters ON characters.GUID = character_social.Friend WHERE character_social.GUID = ? AND DeleteInfoName IS NULL LIMIT 255", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_HOMEBIND, "SELECT MapID, ZoneID, PositionX, PositionY, PositionZ, Orientation FROM character_homebind WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_SPELLCOOLDOWNS, "SELECT Spell, Category, Item, Time, NeedSend FROM character_spell_cooldown WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_DECLINEDNAMES, "SELECT Genitive, Dative, Accusative, Instrumental, Prepositional FROM character_declined_name WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_ACHIEVEMENTS, "SELECT Achievement, Date FROM character_achievement WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_CRITERIAPROGRESS, "SELECT Criteria, Counter, Date FROM character_achievement_progress WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_EQUIPMENTSETS, "SELECT SetGUID, SetIndex, Name, IconName, IgnoreMask, Item0, Item1, Item2, Item3, Item4, Item5, Item6, Item7, Item8, "
                     "Item9, Item10, Item11, Item12, Item13, Item14, Item15, Item16, Item17, Item18 FROM character_equipment_sets WHERE GUID = ? ORDER BY SetIndex", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_ENTRY_POINT, "SELECT JoinX, JoinY, JoinZ, JoinO, JoinMapID, TaxiPath1, TaxiPath2, MountSpell FROM character_entry_point WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_GLYPHS, "SELECT TalentGroup, Glyph1, Glyph2, Glyph3, Glyph4, Glyph5, Glyph6 FROM character_glyphs WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_TALENTS, "SELECT Spell, SpecMask FROM character_talent WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_SKILLS, "SELECT Skill, Value, Max FROM character_skills WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_RANDOMBG, "SELECT GUID FROM character_battleground_random WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_BANNED, "SELECT GUID FROM character_banned WHERE GUID = ? AND Active = 1", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_QUESTSTATUSREW, "SELECT Quest FROM character_quest_status_rewarded WHERE GUID = ? AND Active = 1", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_ACCOUNT_INSTANCELOCKTIMES, "SELECT InstanceID, ReleaseTime FROM account_instance_times WHERE AccountID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_BREW_OF_THE_MONTH, "SELECT LastEventID FROM character_brew_of_the_month WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_BREW_OF_THE_MONTH, "REPLACE INTO character_brew_of_the_month (GUID, LastEventID) VALUES (?, ?)", CONNECTION_ASYNC);
    // End LoginQueryHolder content

    PrepareStatement(CHAR_SEL_CHARACTER_ACTIONS_SPEC, "SELECT Button, Action, Type FROM character_action WHERE GUID = ? AND Spec = ? ORDER BY Button", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_MAILITEMS, "SELECT CreatorGUID, GiftCreatorGUID, Count, Duration, Charges, Flags, Enchantments, RandomPropertyID, Durability, PlayedTime, Text, ItemGuid, ItemEntry, ii.OwnerGUID, m.ID FROM mail_items mi INNER JOIN mail m ON mi.MailID = m.ID LEFT JOIN item_instance ii ON mi.ItemGUID = ii.GUID WHERE m.Receiver = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_AUCTION_ITEMS, "SELECT CreatorGUID, GiftCreatorGUID, Count, Duration, Charges, Flags, Enchantments, RandomPropertyID, Durability, PlayedTime, Text, ItemGUID, ItemEntry FROM auction_house ah JOIN item_instance ii ON ah.ItemGUID = ii.GUID", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_AUCTIONS, "SELECT ID, HouseID, ItemGUID, ItemEntry, Count, ItemOwner, BuyoutPrice, Time, BuyGUID, LastBid, StartBid, Deposit FROM auction_house ah INNER JOIN item_instance ii ON ii.GUID = ah.ItemGUID", CONNECTION_SYNCH);
    PrepareStatement(CHAR_INS_AUCTION, "INSERT INTO auction_house (ID, HouseID, ItemGUID, ItemOwner, BuyoutPrice, Time, BuyGUID, LastBid, StartBid, Deposit) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_AUCTION, "DELETE FROM auction_house WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_AUCTION_BID, "UPDATE auction_house SET BuyGUID = ?, LastBid = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_MAIL, "INSERT INTO mail(ID, MessageType, Stationery, MailTemplateID, Sender, Receiver, Subject, Body, HasItems, ExpireTime, DeliverTime, Money, CoD, Checked) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_MAIL_BY_ID, "DELETE FROM mail WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_MAIL_ITEM, "INSERT INTO mail_items(MailID, ItemGUID, Receiver) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_MAIL_ITEM, "DELETE FROM mail_items WHERE ItemGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_INVALID_MAIL_ITEM, "DELETE FROM mail_items WHERE ItemGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_EXPIRED_MAIL, "SELECT ID, MessageType, Sender, Receiver, HasItems, ExpireTime, Stationery, Checked, MailTemplateID FROM mail WHERE ExpireTime < ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_EXPIRED_MAIL_ITEMS, "SELECT ItemGUID, ItemEntry, MailID FROM mail_items mi INNER JOIN item_instance ii ON ii.GUID = mi.ItemGUID LEFT JOIN mail mm ON mi.MailID = mm.ID WHERE mm.ID IS NOT NULL AND mm.ExpireTime < ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_UPD_MAIL_RETURNED, "UPDATE mail SET Sender = ?, Receiver = ?, ExpireTime = ?, DeliverTime = ?, CoD = 0, Checked = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_MAIL_ITEM_RECEIVER, "UPDATE mail_items SET Receiver = ? WHERE ItemGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ITEM_OWNER, "UPDATE item_instance SET OwnerGUID = ? WHERE GUID = ?", CONNECTION_ASYNC);

    PrepareStatement(CHAR_SEL_ITEM_REFUNDS, "SELECT PlayerGUID, PaidMoney, PaidExtendedCost FROM item_refund_instance WHERE ItemGUID = ? AND PlayerGUID = ? LIMIT 1", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_ITEM_BOP_TRADE, "SELECT AllowedPlayers FROM item_soulbound_trade_data WHERE ItemGUID = ? LIMIT 1", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_ITEM_BOP_TRADE, "DELETE FROM item_soulbound_trade_data WHERE ItemGUID = ? LIMIT 1", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ITEM_BOP_TRADE, "INSERT INTO item_soulbound_trade_data VALUES (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_INVENTORY_ITEM, "REPLACE INTO character_inventory (GUID, Bag, Slot, Item) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_ITEM_INSTANCE, "REPLACE INTO item_instance (ItemEntry, OwnerGUID, CreatorGUID, GiftCreatorGUID, Count, Duration, Charges, Flags, Enchantments, RandomPropertyID, Durability, PlayedTime, Text, GUID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ITEM_INSTANCE, "UPDATE item_instance SET ItemEntry = ?, OwnerGUID = ?, CreatorGUID = ?, GiftCreatorGUID = ?, Count = ?, Duration = ?, Charges = ?, Flags = ?, Enchantments = ?, RandomPropertyID = ?, Durability = ?, PlayedTime = ?, Text = ? WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ITEM_INSTANCE_ON_LOAD, "UPDATE item_instance SET Duration = ?, Flags = ?, Durability = ? WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ITEM_INSTANCE, "DELETE FROM item_instance WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ITEM_INSTANCE_BY_OWNER, "DELETE FROM item_instance WHERE OwnerGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GIFT_OWNER, "UPDATE character_gifts SET GUID = ? WHERE ItemGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GIFT, "DELETE FROM character_gifts WHERE ItemGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_GIFT_BY_ITEM, "SELECT Entry, Flags FROM character_gifts WHERE ItemGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_ACCOUNT_BY_NAME, "SELECT Account FROM characters WHERE Name = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_ACCOUNT_INSTANCE_LOCK_TIMES, "DELETE FROM account_instance_times WHERE AccountID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ACCOUNT_INSTANCE_LOCK_TIMES, "INSERT INTO account_instance_times (AccountID, InstanceID, ReleaseTime) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_MATCH_MAKER_RATING, "SELECT MatchMakerRating, MaxMMR  FROM character_arena_stats WHERE GUID = ? AND Slot = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHARACTER_COUNT, "SELECT Account, COUNT(GUID) FROM characters WHERE Account = ? GROUP BY Account", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_NAME_BY_GUID, "UPDATE characters SET Name = ? WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_DECLINED_NAME, "DELETE FROM character_declined_name WHERE GUID = ?", CONNECTION_ASYNC);
    // Guild handling
    // 0: uint32, 1: string, 2: uint32, 3: string, 4: string, 5: uint64, 6-10: uint32, 11: uint64
    PrepareStatement(CHAR_INS_GUILD, "INSERT INTO guild (GuildID, Name, LeaderGUID, Info, MOTD, CreateDate, EmblemStyle, EmblemColor, BorderStyle, BorderColor, BackgroundColor, BankMoney) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD, "DELETE FROM guild WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    // 0: string, 1: uint32
    PrepareStatement(CHAR_UPD_GUILD_NAME, "UPDATE guild SET Name = ? WHERE GuildID = ?", CONNECTION_ASYNC);
    // 0: uint32, 1: uint32, 2: uint8, 4: string, 5: string
    PrepareStatement(CHAR_INS_GUILD_MEMBER, "INSERT INTO guild_member (GuildID, GUID, Rank, PlayerNote, OfficerNote) VALUES (?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_MEMBER, "DELETE FROM guild_member WHERE GUID = ?", CONNECTION_ASYNC); // 0: uint32
    PrepareStatement(CHAR_DEL_GUILD_MEMBERS, "DELETE FROM guild_member WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    PrepareStatement(CHAR_SEL_GUILD_MEMBER_EXTENDED, "SELECT g.GuildID, g.Name, gr.RankName, gm.PlayerNote, gm.OfficerNote "
                     "FROM guild g JOIN guild_member gm ON g.GuildID = gm.GuildID "
                     "JOIN guild_rank gr ON g.GuildID = gr.GuildID AND gm.Rank = gr.RankID WHERE gm.GUID = ?", CONNECTION_BOTH);
    // 0: uint32, 1: uint8, 3: string, 4: uint32, 5: uint32
    PrepareStatement(CHAR_INS_GUILD_RANK, "INSERT INTO guild_rank (GuildID, RankID, RankName, RankRights, BankMoneyPerDay) VALUES (?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_RANKS, "DELETE FROM guild_rank WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    PrepareStatement(CHAR_DEL_GUILD_LOWEST_RANK, "DELETE FROM guild_rank WHERE GuildID = ? AND RankID >= ?", CONNECTION_ASYNC); // 0: uint32, 1: uint8
    PrepareStatement(CHAR_INS_GUILD_BANK_TAB, "INSERT INTO guild_bank_tab (GuildID, TabID) VALUES (?, ?)", CONNECTION_ASYNC); // 0: uint32, 1: uint8
    PrepareStatement(CHAR_DEL_GUILD_BANK_TAB, "DELETE FROM guild_bank_tab WHERE GuildID = ? AND TabID = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint8
    PrepareStatement(CHAR_DEL_GUILD_BANK_TABS, "DELETE FROM guild_bank_tab WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    // 0: uint32, 1: uint8, 2: uint8, 3: uint32, 4: uint32
    PrepareStatement(CHAR_INS_GUILD_BANK_ITEM, "INSERT INTO guild_bank_item (GuildID, TabID, SlotID, ItemGUID) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_BANK_ITEM, "DELETE FROM guild_bank_item WHERE GuildID = ? AND TabID = ? AND SlotID = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint8, 2: uint8
    PrepareStatement(CHAR_DEL_GUILD_BANK_ITEMS, "DELETE FROM guild_bank_item WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    // 0: uint32, 1: uint8, 2: uint8, 3: uint8, 4: uint32
    PrepareStatement(CHAR_INS_GUILD_BANK_RIGHT, "INSERT INTO guild_bank_rights (GuildID, TabID, RankID, RightsFlags, SlotPerDay) VALUES (?, ?, ?, ?, ?) "
                     "ON DUPLICATE KEY UPDATE gbright = VALUES(RightsFlags), SlotPerDay = VALUES(SlotPerDay)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_BANK_RIGHTS, "DELETE FROM guild_bank_rights WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    PrepareStatement(CHAR_DEL_GUILD_BANK_RIGHTS_FOR_RANK, "DELETE FROM guild_bank_rights WHERE GuildID = ? AND RankID = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint8
    // 0-1: uint32, 2-3: uint8, 4-5: uint32, 6: uint16, 7: uint8, 8: uint64
    PrepareStatement(CHAR_INS_GUILD_BANK_EVENTLOG, "INSERT INTO guild_bank_event_log (GuildID, LogGUID, TabID, EventType, PlayerGUID, ItemOrMoney, ItemStackCount, DestinationTabID, TimeStamp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_BANK_EVENTLOG, "DELETE FROM guild_bank_event_log WHERE GuildID = ? AND LogGUID = ? AND TabID = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint32, 2: uint8
    PrepareStatement(CHAR_DEL_GUILD_BANK_EVENTLOGS, "DELETE FROM guild_bank_event_log WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    // 0-1: uint32, 2: uint8, 3-4: uint32, 5: uint8, 6: uint64
    PrepareStatement(CHAR_INS_GUILD_EVENTLOG, "INSERT INTO guild_event_log (GuildID, LogGUID, EventType, PlayerGUID1, PlayerGUID2, NewRank, TimeStamp) VALUES (?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_EVENTLOG, "DELETE FROM guild_event_log WHERE GuildID = ? AND LogGUID = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint32
    PrepareStatement(CHAR_DEL_GUILD_EVENTLOGS, "DELETE FROM guild_event_log WHERE GuildID = ?", CONNECTION_ASYNC); // 0: uint32
    PrepareStatement(CHAR_UPD_GUILD_MEMBER_PNOTE, "UPDATE guild_member SET PlayerNote = ? WHERE GUID = ?", CONNECTION_ASYNC); // 0: string, 1: uint32
    PrepareStatement(CHAR_UPD_GUILD_MEMBER_OFFNOTE, "UPDATE guild_member SET OfficerNote = ? WHERE GUID = ?", CONNECTION_ASYNC); // 0: string, 1: uint32
    PrepareStatement(CHAR_UPD_GUILD_MEMBER_RANK, "UPDATE guild_member SET `rank` = ? WHERE guid = ?", CONNECTION_ASYNC); // 0: uint8, 1: uint32
    PrepareStatement(CHAR_UPD_GUILD_MOTD, "UPDATE guild SET motd = ? WHERE guildid = ?", CONNECTION_ASYNC); // 0: string, 1: uint32
    PrepareStatement(CHAR_UPD_GUILD_INFO, "UPDATE guild SET info = ? WHERE guildid = ?", CONNECTION_ASYNC); // 0: string, 1: uint32
    PrepareStatement(CHAR_UPD_GUILD_LEADER, "UPDATE guild SET leaderguid = ? WHERE guildid = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint32
    PrepareStatement(CHAR_UPD_GUILD_RANK_NAME, "UPDATE guild_rank SET RankName = ? WHERE RankID = ? AND GuildID = ?", CONNECTION_ASYNC); // 0: string, 1: uint8, 2: uint32
    PrepareStatement(CHAR_UPD_GUILD_RANK_RIGHTS, "UPDATE guild_rank SET RankRights = ? WHERE RankID = ? AND GuildID = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint8, 2: uint32
    // 0-5: uint32
    PrepareStatement(CHAR_UPD_GUILD_EMBLEM_INFO, "UPDATE guild SET EmblemStyle = ?, EmblemColor = ?, BorderStyle = ?, BorderColor = ?, BackgroundColor = ? WHERE guildid = ?", CONNECTION_ASYNC);
    // 0: string, 1: string, 2: uint32, 3: uint8
    PrepareStatement(CHAR_UPD_GUILD_BANK_TAB_INFO, "UPDATE guild_bank_tab SET TabName = ?, TabIcon = ? WHERE guildid = ? AND TabId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GUILD_BANK_MONEY, "UPDATE guild SET BankMoney = ? WHERE guildid = ?", CONNECTION_ASYNC); // 0: uint64, 1: uint32
    // 0: uint8, 1: uint32, 2: uint8, 3: uint32
    PrepareStatement(CHAR_UPD_GUILD_BANK_EVENTLOG_TAB, "UPDATE guild_bank_event_log SET TabID = ? WHERE GuildID = ? AND TabID = ? AND LogGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GUILD_RANK_BANK_MONEY, "UPDATE guild_rank SET BankMoneyPerDay = ? WHERE RankID = ? AND GuildID = ?", CONNECTION_ASYNC); // 0: uint32, 1: uint8, 2: uint32
    PrepareStatement(CHAR_UPD_GUILD_BANK_TAB_TEXT, "UPDATE guild_bank_tab SET TabText = ? WHERE guildid = ? AND TabId = ?", CONNECTION_ASYNC); // 0: string, 1: uint32, 2: uint8

    PrepareStatement(CHAR_INS_GUILD_MEMBER_WITHDRAW,
                     "INSERT INTO guild_member_withdraw (guid, tab0, tab1, tab2, tab3, tab4, tab5, money) VALUES (?, ?, ?, ?, ?, ?, ?, ?) "
                     "ON DUPLICATE KEY UPDATE tab0 = VALUES (tab0), tab1 = VALUES (tab1), tab2 = VALUES (tab2), tab3 = VALUES (tab3), tab4 = VALUES (tab4), tab5 = VALUES (tab5)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_MEMBER_WITHDRAW, "TRUNCATE guild_member_withdraw", CONNECTION_ASYNC);

    // 0: uint32, 1: uint32, 2: uint32
    PrepareStatement(CHAR_SEL_CHAR_DATA_FOR_GUILD, "SELECT name, level, class, gender, zone, account FROM characters WHERE guid = ?", CONNECTION_SYNCH);

    // Chat channel handling
    PrepareStatement(CHAR_INS_CHANNEL, "INSERT INTO channels(channelId, name, team, announce, lastUsed) VALUES (?, ?, ?, ?, UNIX_TIMESTAMP())", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHANNEL, "UPDATE channels SET announce = ?, password = ?, lastUsed = UNIX_TIMESTAMP() WHERE channelId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHANNEL, "DELETE FROM channels WHERE name = ? AND team = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHANNEL_USAGE, "UPDATE channels SET lastUsed = UNIX_TIMESTAMP() WHERE channelId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_OLD_CHANNELS, "DELETE FROM channels WHERE lastUsed + ? < UNIX_TIMESTAMP()", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_OLD_CHANNELS_BANS, "DELETE cb.* FROM channels_bans cb LEFT JOIN channels cn ON cb.channelId=cn.channelId WHERE cn.channelId IS NULL OR cb.banTime <= UNIX_TIMESTAMP()", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHANNEL_BAN, "REPLACE INTO channels_bans VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHANNEL_BAN, "DELETE FROM channels_bans WHERE channelId = ? AND playerGUID = ?", CONNECTION_ASYNC);

    // Equipmentsets
    PrepareStatement(CHAR_UPD_EQUIP_SET, "UPDATE character_equipment_sets SET Name=?, IconName=?, IgnoreMask=?, Item0=?, Item1=?, Item2=?, Item3=?, "
                     "Item4=?, Item5=?, Item6=?, Item7=?, Item8=?, Item9=?, Item10=?, Item11=?, Item12=?, Item13=?, Item14=?, Item15=?, Item16=?, "
                     "Item17=?, Item18=? WHERE GUID=? AND SetGUID=? AND SetIndex=?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_EQUIP_SET, "INSERT INTO character_equipment_sets (GUID, SetGUID, SetIndex, Name, IconName, IgnoreMask, Item0, Item1, Item2, Item3, "
                     "Item4, Item5, Item6, Item7, Item8, Item9, Item10, Item11, Item12, Item13, Item14, Item15, Item16, Item17, Item18) "
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_EQUIP_SET, "DELETE FROM character_equipment_sets WHERE setguid=?", CONNECTION_ASYNC);

    // Auras
    PrepareStatement(CHAR_INS_AURA, "INSERT INTO character_aura (GUID, CasterGUID, ItemGUID, Spell, EffectMask, RecalculateMask, StackCount, Amount1, Amount2, Amount3, BaseAmount1, BaseAmount2, BaseAmount3, MaxDuration, RemainTime, RemainCharges) "
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);

    // Account data
    PrepareStatement(CHAR_SEL_ACCOUNT_DATA, "SELECT type, time, data FROM account_data WHERE accountId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_ACCOUNT_DATA, "REPLACE INTO account_data (accountId, type, time, data) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ACCOUNT_DATA, "DELETE FROM account_data WHERE accountId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_PLAYER_ACCOUNT_DATA, "SELECT type, time, data FROM character_account_data WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_PLAYER_ACCOUNT_DATA, "REPLACE INTO character_account_data(guid, type, time, data) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PLAYER_ACCOUNT_DATA, "DELETE FROM character_account_data WHERE guid = ?", CONNECTION_ASYNC);

    // Tutorials
    PrepareStatement(CHAR_SEL_TUTORIALS, "SELECT Tutorial1, Tutorial2, Tutorial3, Tutorial4, Tutorial5, Tutorial6, Tutorial7, Tutorial8 FROM account_tutorial WHERE AccountID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_HAS_TUTORIALS, "SELECT 1 FROM account_tutorial WHERE AccountID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_INS_TUTORIALS, "INSERT INTO account_tutorial(Tutorial1, Tutorial2, Tutorial3, Tutorial4, Tutorial5, Tutorial6, Tutorial7, Tutorial8, AccountID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_TUTORIALS, "UPDATE account_tutorial SET Tutorial1 = ?, Tutorial2 = ?, Tutorial3 = ?, Tutorial4 = ?, Tutorial5 = ?, Tutorial6 = ?, Tutorial7 = ?, Tutorial8 = ? WHERE AccountID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_TUTORIALS, "DELETE FROM account_tutorial WHERE AccountID = ?", CONNECTION_ASYNC);

    // Instance saves
    PrepareStatement(CHAR_INS_INSTANCE_SAVE, "INSERT INTO instance (id, map, resettime, difficulty, completedEncounters, data) VALUES (?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_INSTANCE_SAVE_DATA, "UPDATE instance SET data=? WHERE id=?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_INSTANCE_SAVE_ENCOUNTERMASK, "UPDATE instance SET completedEncounters=? WHERE id=?", CONNECTION_ASYNC);

    // Game event saves
    PrepareStatement(CHAR_DEL_GAME_EVENT_SAVE, "DELETE FROM game_event_save WHERE eventEntry = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_GAME_EVENT_SAVE, "INSERT INTO game_event_save (EventEntry, State, NextStart) VALUES (?, ?, ?)", CONNECTION_ASYNC);

    // Game event condition saves
    PrepareStatement(CHAR_DEL_ALL_GAME_EVENT_CONDITION_SAVE, "DELETE FROM game_event_condition_save WHERE eventEntry = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GAME_EVENT_CONDITION_SAVE, "DELETE FROM game_event_condition_save WHERE EventEntry = ? AND ConditionID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_GAME_EVENT_CONDITION_SAVE, "INSERT INTO game_event_condition_save (EventEntry, ConditionID, Done) VALUES (?, ?, ?)", CONNECTION_ASYNC);

    // Petitions
    PrepareStatement(CHAR_DEL_ALL_PETITION_SIGNATURES, "DELETE FROM petition_sign WHERE playerguid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PETITION_SIGNATURE, "DELETE FROM petition_sign WHERE playerguid = ? AND type = ?", CONNECTION_ASYNC);

    // Arena teams
    PrepareStatement(CHAR_INS_ARENA_TEAM, "INSERT INTO arena_team (arenaTeamId, name, captainGuid, type, rating, backgroundColor, emblemStyle, emblemColor, borderStyle, borderColor) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ARENA_TEAM_MEMBER, "INSERT INTO arena_team_member (arenaTeamId, guid) VALUES (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ARENA_TEAM, "DELETE FROM arena_team WHERE arenaTeamId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ARENA_TEAM_MEMBERS, "DELETE FROM arena_team_member WHERE arenaTeamId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ARENA_TEAM_CAPTAIN, "UPDATE arena_team SET captainGuid = ? WHERE arenaTeamId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ARENA_TEAM_MEMBER, "DELETE FROM arena_team_member WHERE arenaTeamId = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ARENA_TEAM_STATS, "UPDATE arena_team SET rating = ?, weekGames = ?, weekWins = ?, seasonGames = ?, seasonWins = ?, `rank` = ? WHERE arenaTeamId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ARENA_TEAM_MEMBER, "UPDATE arena_team_member SET personalRating = ?, weekGames = ?, weekWins = ?, seasonGames = ?, seasonWins = ? WHERE arenaTeamId = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_CHARACTER_ARENA_STATS, "REPLACE INTO character_arena_stats (guid, slot, matchMakerRating, maxMMR) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_PLAYER_ARENA_TEAMS, "SELECT arena_team_member.arenaTeamId FROM arena_team_member JOIN arena_team ON arena_team_member.arenaTeamId = arena_team.arenaTeamId WHERE guid = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_UPD_ARENA_TEAM_NAME, "UPDATE arena_team SET name = ? WHERE arenaTeamId = ?", CONNECTION_ASYNC);

    // Character battleground data
    PrepareStatement(CHAR_INS_PLAYER_ENTRY_POINT, "INSERT INTO character_entry_point (GUID, JoinX, JoinY, JoinZ, JoinO, JoinMapID, TaxiPath1, TaxiPath2, MountSpell) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PLAYER_ENTRY_POINT, "DELETE FROM character_entry_point WHERE guid = ?", CONNECTION_ASYNC);

    // Character homebind
    PrepareStatement(CHAR_INS_PLAYER_HOMEBIND, "INSERT INTO character_homebind (GUID, MapID, ZoneID, PositionX, PositionY, PositionZ, Orientation) VALUES (?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_PLAYER_HOMEBIND, "UPDATE character_homebind SET MapId = ?, ZoneID = ?, PositionX = ?, PositionY = ?, PositionZ = ?, Orientation = ? WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PLAYER_HOMEBIND, "DELETE FROM character_homebind WHERE GUID = ?", CONNECTION_ASYNC);

    // Corpse
    PrepareStatement(CHAR_SEL_CORPSES, "SELECT PositionX, PositionY, PositionZ, Orientation, MapID, DisplayID, ItemCache, Bytes1, Bytes2, GuildID, Flags, DynamicFlags, Time, CorpseType, InstanceID, PhaseMask, GUID FROM corpse WHERE MapID = ? AND InstanceID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_INS_CORPSE, "INSERT INTO corpse (GUID, PositionX, PositionY, PositionZ, Orientation, MapID, DisplayID, ItemCache, Bytes1, Bytes2, GuildID, Flags, DynamicFlags, Time, CorpseType, InstanceID, PhaseMask) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CORPSE, "DELETE FROM corpse WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CORPSES_FROM_MAP, "DELETE FROM corpse WHERE MapID = ? AND InstanceID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CORPSE_LOCATION, "SELECT MapID, PositionX, PositionY, PositionZ, Orientation FROM corpse WHERE GUID = ?", CONNECTION_ASYNC);

    // Creature respawn
    PrepareStatement(CHAR_SEL_CREATURE_RESPAWNS, "SELECT guid, respawnTime FROM creature_respawn WHERE mapId = ? AND instanceId = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_REP_CREATURE_RESPAWN, "REPLACE INTO creature_respawn (guid, respawnTime, mapId, instanceId) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CREATURE_RESPAWN, "DELETE FROM creature_respawn WHERE guid = ? AND mapId = ? AND instanceId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CREATURE_RESPAWN_BY_INSTANCE, "DELETE FROM creature_respawn WHERE mapId = ? AND instanceId = ?", CONNECTION_ASYNC);

    // Gameobject respawn
    PrepareStatement(CHAR_SEL_GO_RESPAWNS, "SELECT guid, respawnTime FROM gameobject_respawn WHERE mapId = ? AND instanceId = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_REP_GO_RESPAWN, "REPLACE INTO gameobject_respawn (guid, respawnTime, mapId, instanceId) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GO_RESPAWN, "DELETE FROM gameobject_respawn WHERE guid = ? AND mapId = ? AND instanceId = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GO_RESPAWN_BY_INSTANCE, "DELETE FROM gameobject_respawn WHERE mapId = ? AND instanceId = ?", CONNECTION_ASYNC);

    // GM Tickets
    PrepareStatement(CHAR_SEL_GM_TICKETS, "SELECT ID, Type, PlayerGUID, Name, Description, CreateTime, MapID, PositionX, PositionY, PositionZ, LastModifiedTime, ClosedBy, AssignedTo, Comment, Response, Completed, Escalated, Viewed, NeedMoreHelp, ResolvedBy FROM gm_ticket", CONNECTION_SYNCH);
    PrepareStatement(CHAR_REP_GM_TICKET, "REPLACE INTO gm_ticket (ID, Type, PlayerGUID, Name, Description, CreateTime, MapID, PositionX, PositionY, PositionZ, LastModifiedTime, ClosedBy, AssignedTo, Comment, Response, Completed, Escalated, Viewed, NeedMoreHelp, ResolvedBy) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GM_TICKET, "DELETE FROM gm_ticket WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PLAYER_GM_TICKETS, "DELETE FROM gm_ticket WHERE PlayerGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_PLAYER_GM_TICKETS_ON_CHAR_DELETION, "UPDATE gm_ticket SET Type = 2 WHERE PlayerUID = ?", CONNECTION_ASYNC);

    // GM Survey/subsurvey/lag report
    PrepareStatement(CHAR_INS_GM_SURVEY, "INSERT INTO gm_survey (guid, surveyId, mainSurvey, comment, createTime) VALUES (?, ?, ?, ?, UNIX_TIMESTAMP(NOW()))", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_GM_SUBSURVEY, "INSERT INTO gm_subsurvey (surveyId, questionId, answer, answerComment) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_LAG_REPORT, "INSERT INTO lag_reports (GUID, LagType, MapID, PositionX, PositionY, PositionZ, Latency, CreateTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);

    // LFG Data
    PrepareStatement(CHAR_REP_LFG_DATA, "REPLACE INTO lfg_data (guid, dungeon, state) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_LFG_DATA, "DELETE FROM lfg_data WHERE guid = ?", CONNECTION_ASYNC);

    // Player saving
    PrepareStatement(CHAR_INS_CHARACTER, "INSERT INTO characters (guid, account, name, race, class, gender, level, xp, money, skin, face, hairStyle, hairColor, facialStyle, bankSlots, restState, playerFlags, "
                     "map, InstanceID, InstanceModeMask, PositionX, PositionY, PositionZ, orientation, TransportX, TransportY, TransportZ, TransportO, TransportGUID, "
                     "taximask, cinematic, "
                     "totaltime, leveltime, RestBonus, LogoutTime, IsLogoutResting, ResetTalentsCost, ResetTalentsTime, "
                     "ExtraFlags, StableSlots, AtLogin, zone, "
                     "DeathExpireTime, TaxiPath, arenaPoints, totalHonorPoints, todayHonorPoints, yesterdayHonorPoints, totalKills, "
                     "todayKills, yesterdayKills, chosenTitle, knownCurrencies, watchedFaction, drunk, health, power1, power2, power3, "
                     "power4, power5, power6, power7, latency, talentGroupsCount, activeTalentGroup, exploredZones, equipmentCache, "
                     "ammoId, knownTitles, actionBars, grantableLevels, innTriggerId) VALUES "
                     "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHARACTER, "UPDATE characters SET name=?,race=?,class=?,gender=?,level=?,xp=?,money=?,skin=?,face=?,hairStyle=?,hairColor=?,facialStyle=?,bankSlots=?,restState=?,playerFlags=?,"
                     "map=?,InstanceID=?,InstanceModeMask=?,PositionX=?,PositionY=?,PositionZ=?,orientation=?,TransportX=?,TransportY=?,TransportZ=?,TransportO=?,TransportGUID=?,taximask=?,cinematic=?,totaltime=?,leveltime=?,RestBonus=?,"
                     "LogoutTime=?,IsLogoutResting=?,ResetTalentsCost=?,ResetTalentsTime=?,ExtraFlags=?,StableSlots=?,AtLogin=?,zone=?,DeathExpireTime=?,TaxiPath=?,"
                     "arenaPoints=?,totalHonorPoints=?,todayHonorPoints=?,yesterdayHonorPoints=?,totalKills=?,todayKills=?,yesterdayKills=?,chosenTitle=?,knownCurrencies=?,"
                     "watchedFaction=?,drunk=?,health=?,power1=?,power2=?,power3=?,power4=?,power5=?,power6=?,power7=?,latency=?,talentGroupsCount=?,activeTalentGroup=?,exploredZones=?,"
                     "equipmentCache=?,ammoId=?,knownTitles=?,actionBars=?,grantableLevels=?,innTriggerId=?,online=? WHERE guid=?", CONNECTION_ASYNC);

    PrepareStatement(CHAR_UPD_ADD_AT_LOGIN_FLAG, "UPDATE characters SET AtLogin = AtLogin | ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_REM_AT_LOGIN_FLAG, "UPDATE characters set AtLogin = AtLogin & ~ ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ALL_AT_LOGIN_FLAGS, "UPDATE characters SET AtLogin = AtLogin | ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_BUG_REPORT, "INSERT INTO bug_report (Type, Content) VALUES(?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_PETITION_NAME, "UPDATE petition SET name = ? WHERE petitionguid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_PETITION_SIGNATURE, "INSERT INTO petition_sign (OwnerGUID, PetitionGUID, PlayerGUID, PlayerAccount) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ACCOUNT_ONLINE, "UPDATE characters SET online = 0 WHERE account = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_GROUP, "INSERT INTO `groups` (guid, leaderGuid, lootMethod, looterGuid, lootThreshold, icon1, icon2, icon3, icon4, icon5, icon6, icon7, icon8, groupType, difficulty, raidDifficulty, masterLooterGuid) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_GROUP_MEMBER, "REPLACE INTO group_member (guid, memberGuid, memberFlags, subgroup, roles) VALUES(?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GROUP_MEMBER, "DELETE FROM group_member WHERE memberGuid = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GROUP_LEADER, "UPDATE `groups` SET leaderGuid = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GROUP_TYPE, "UPDATE `groups` SET groupType = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GROUP_MEMBER_SUBGROUP, "UPDATE group_member SET subgroup = ? WHERE memberGuid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GROUP_MEMBER_FLAG, "UPDATE group_member SET memberFlags = ? WHERE memberGuid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GROUP_DIFFICULTY, "UPDATE `groups` SET difficulty = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GROUP_RAID_DIFFICULTY, "UPDATE `groups` SET raidDifficulty = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ALL_GM_TICKETS, "TRUNCATE TABLE gm_ticket", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_INVALID_SPELL_TALENTS, "DELETE FROM character_talent WHERE spell = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_INVALID_SPELL_SPELLS, "DELETE FROM character_spell WHERE spell = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_DELETE_INFO, "UPDATE characters SET DeleteInfoName = Name, DeleteInfoAccount = Account, DeleteDate = UNIX_TIMESTAMP(), Name = '', Account = 0 WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_RESTORE_DELETE_INFO, "UPDATE characters SET Name = ?, Account = ?, DeleteDate = NULL, DeleteInfoName = NULL, DeleteInfoAccount = NULL WHERE DeleteDate IS NOT NULL AND GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ZONE, "UPDATE characters SET zone = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_LEVEL, "UPDATE characters SET level = ?, xp = 0 WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_XP_ACCUMULATIVE, "UPDATE characters SET  xp = xp + ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_INVALID_ACHIEV_PROGRESS_CRITERIA, "DELETE FROM character_achievement_progress WHERE criteria = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_INVALID_ACHIEVMENT, "DELETE FROM character_achievement WHERE achievement = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ADDON, "INSERT INTO addons (name, crc) VALUES (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_INVALID_PET_SPELL, "DELETE FROM pet_spell WHERE spell = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GLOBAL_INSTANCE_RESETTIME, "UPDATE instance_reset SET resettime = ? WHERE mapid = ? AND difficulty = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_ONLINE, "UPDATE characters SET online = 1 WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_NAME_AT_LOGIN, "UPDATE characters set Name = ?, AtLogin = ? WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_WORLDSTATE, "UPDATE world_states SET Value = ? WHERE Entry = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_WORLDSTATE, "INSERT INTO world_states (Entry, Value) VALUES (?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE, "DELETE FROM character_instance WHERE instance = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE_NOT_EXTENDED, "DELETE FROM character_instance WHERE instance = ? AND extended = 0", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_INSTANCE_SET_NOT_EXTENDED, "UPDATE character_instance SET extended = 0 WHERE instance = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_INSTANCE_BY_INSTANCE_GUID, "DELETE FROM character_instance WHERE guid = ? AND instance = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_INSTANCE, "UPDATE character_instance SET instance = ?, permanent = ?, extended = 0 WHERE guid = ? AND instance = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_INSTANCE_EXTENDED, "UPDATE character_instance SET extended = ? WHERE guid = ? AND instance = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_INSTANCE, "INSERT INTO character_instance (guid, instance, permanent, extended) VALUES (?, ?, ?, 0)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ARENA_LOG_FIGHT, "INSERT INTO log_arena_fights VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ARENA_LOG_MEMBERSTATS, "INSERT INTO log_arena_member_stats VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_GENDER_AND_APPEARANCE, "UPDATE characters SET gender = ?, skin = ?, face = ?, hairStyle = ?, hairColor = ?, facialStyle = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHARACTER_SKILL, "DELETE FROM character_skills WHERE guid = ? AND skill = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_ADD_CHARACTER_SOCIAL_FLAGS, "UPDATE character_social SET flags = flags | ? WHERE guid = ? AND friend = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_REM_CHARACTER_SOCIAL_FLAGS, "UPDATE character_social SET flags = flags & ~ ? WHERE guid = ? AND friend = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHARACTER_SOCIAL, "REPLACE INTO character_social (guid, friend, flags) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHARACTER_SOCIAL, "DELETE FROM character_social WHERE guid = ? AND friend = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHARACTER_SOCIAL_NOTE, "UPDATE character_social SET note = ? WHERE guid = ? AND friend = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHARACTER_POSITION, "UPDATE characters SET PositionX = ?, PositionY = ?, PositionZ = ?, Orientation = ?, Map = ?, Zone = ?, TransportX = 0, TransportY = 0, TransportZ = 0, TransportGUID = 0, TaxiPath = '', Cinematic = 1 WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_AURA_FROZEN, "SELECT characters.name FROM characters LEFT JOIN character_aura ON (characters.guid = character_aura.guid) WHERE character_aura.spell = 9454", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHARACTER_ONLINE, "SELECT name, account, map, zone FROM characters WHERE online > 0", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_DEL_INFO_BY_GUID, "SELECT GUID, DeleteInfoName, DeleteInfoAccount, DeleteDate FROM characters WHERE DeleteDate IS NOT NULL AND GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_DEL_INFO_BY_NAME, "SELECT GUID, DeleteInfoName, DeleteInfoAccount, DeleteDate FROM characters WHERE DeleteDate IS NOT NULL AND DeleteInfoName LIKE CONCAT('%%', ?, '%%')", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_DEL_INFO, "SELECT GUID, DeleteInfoName, DeleteInfoAccount, DeleteDate FROM characters WHERE DeleteDate IS NOT NULL", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHARS_BY_ACCOUNT_ID, "SELECT guid FROM characters WHERE account = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_PINFO, "SELECT totaltime, level, money, account, race, class, map, zone, gender, health, playerFlags FROM characters WHERE guid = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_PINFO_BANS, "SELECT unbandate, bandate = unbandate, bannedby, banreason FROM character_banned WHERE guid = ? AND active ORDER BY bandate ASC LIMIT 1", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_PINFO_MAILS, "SELECT SUM(CASE WHEN (checked & 1) THEN 1 ELSE 0 END) AS 'readmail', COUNT(*) AS 'totalmail' FROM mail WHERE `receiver` = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_PINFO_XP, "SELECT a.xp, b.guid FROM characters a LEFT JOIN guild_member b ON a.guid = b.guid WHERE a.guid = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_HOMEBIND, "SELECT MapID, ZoneID, PositionX, PositionY, PositionZ, Orientation FROM character_homebind WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_GUID_NAME_BY_ACC, "SELECT guid, name FROM characters WHERE account = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_POOL_QUEST_SAVE, "SELECT QuestID FROM pool_quest_save WHERE PoolID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHARACTER_AT_LOGIN, "SELECT AtLogin FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_CLASS_LVL_AT_LOGIN, "SELECT Class, Level, AtLogin, KnownTitles FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_CUSTOMIZE_INFO, "SELECT Name, Race, Class, Gender, AtLogin FROM characters WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHAR_RACE_OR_FACTION_CHANGE_INFOS, "SELECT AtLogin, KnownTitles, Money FROM characters WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHAR_AT_LOGIN_TITLES_MONEY, "SELECT AtLogin, KnownTitles, Money FROM characters WHERE GUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_COD_ITEM_MAIL, "SELECT ID, MessageType, MailTemplateID, Sender, Subject, Body, Money, HasItems FROM mail WHERE Receiver = ? AND HasItems <> 0 AND CoD <> 0", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_SOCIAL, "SELECT DISTINCT guid FROM character_social WHERE friend = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_OLD_CHARS, "SELECT GUID, DeleteInfoAccount FROM characters WHERE DeleteDate IS NOT NULL AND DeleteDate < ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_ARENA_TEAM_ID_BY_PLAYER_GUID, "SELECT arena_team_member.arenateamid FROM arena_team_member JOIN arena_team ON arena_team_member.arenateamid = arena_team.arenateamid WHERE guid = ? AND type = ? LIMIT 1", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_MAIL, "SELECT ID, MessageType, Sender, Receiver, Subject, Body, ExpireTime, DeliverTime, Money, CoD, Checked, Stationery, MailTemplateID FROM mail WHERE Receiver = ? AND DeliverTime <= ? ORDER BY ID DESC", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_NEXT_MAIL_DELIVERYTIME, "SELECT MIN(DeliverTime) FROM mail WHERE Receiver = ? AND DeliverTime > ? AND (Checked & 1) = 0 LIMIT 1", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_CHAR_AURA_FROZEN, "DELETE FROM character_aura WHERE spell = 9454 AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHAR_INVENTORY_COUNT_ITEM, "SELECT COUNT(itemEntry) FROM character_inventory ci INNER JOIN item_instance ii ON ii.guid = ci.item WHERE itemEntry = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_MAIL_COUNT_ITEM, "SELECT COUNT(ItemEntry) FROM mail_items mi INNER JOIN item_instance ii ON ii.GUID = mi.ItemGUID WHERE ItemEntry = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_AUCTIONHOUSE_COUNT_ITEM, "SELECT COUNT(ItemEntry) FROM auction_house ah INNER JOIN item_instance ii ON ii.GUID = ah.ItemGUID WHERE ItemEntry = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_GUILD_BANK_COUNT_ITEM, "SELECT COUNT(ItemEntry) FROM guild_bank_item gbi INNER JOIN item_instance ii ON ii.GUID = gbi.ItemGUID WHERE ItemEntry = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_INVENTORY_ITEM_BY_ENTRY, "SELECT ci.item, cb.slot AS bag, ci.slot, ci.guid, c.account, c.name FROM characters c "
                     "INNER JOIN character_inventory ci ON ci.guid = c.guid "
                     "INNER JOIN item_instance ii ON ii.guid = ci.item "
                     "LEFT JOIN character_inventory cb ON cb.item = ci.bag WHERE ii.itemEntry = ? LIMIT ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_CHAR_INVENTORY_ITEM_BY_ENTRY_AND_OWNER, "SELECT ci.Item FROM character_inventory ci INNER JOIN item_instance ii ON ii.GUID = ci.Item WHERE ii.ItemEntry = ? AND ii.OwnerGUID = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_MAIL_ITEMS_BY_ENTRY, "SELECT mi.ItemGUID, m.Sender, m.Receiver, cs.Account, cs.Name, cr.Account, cr.Name "
                     "FROM mail m INNER JOIN mail_items mi ON mi.MailID = m.ID INNER JOIN item_instance ii ON ii.GUID = mi.ItemGUID "
                     "INNER JOIN characters cs ON cs.GUID = m.Sender INNER JOIN characters cr ON cr.GUID = m.Receiver WHERE ii.ItemEntry = ? LIMIT ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_AUCTIONHOUSE_ITEM_BY_ENTRY, "SELECT  ah.itemguid, ah.itemowner, c.account, c.name FROM auction_house ah INNER JOIN characters c ON c.guid = ah.itemowner INNER JOIN item_instance ii ON ii.guid = ah.itemguid WHERE ii.itemEntry = ? LIMIT ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_GUILD_BANK_ITEM_BY_ENTRY, "SELECT gi.ItemGUID, gi.GuildID, g.Name FROM guild_bank_item gi INNER JOIN guild g ON g.GuildID = gi.GuildID INNER JOIN item_instance ii ON ii.GUID = gi.ItemGUID WHERE ii.ItemEntry = ? LIMIT ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_CHAR_ACHIEVEMENT, "DELETE FROM character_achievement WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_ACHIEVEMENT_PROGRESS, "DELETE FROM character_achievement_progress WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_ACHIEVEMENT, "INSERT INTO character_achievement (guid, achievement, date) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_ACHIEVEMENT_PROGRESS_BY_CRITERIA, "DELETE FROM character_achievement_progress WHERE guid = ? AND criteria = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_ACHIEVEMENT_PROGRESS, "INSERT INTO character_achievement_progress (guid, criteria, counter, date) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_REPUTATION_BY_FACTION, "DELETE FROM character_reputation WHERE guid = ? AND faction = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_REPUTATION_BY_FACTION, "INSERT INTO character_reputation (guid, faction, standing, flags) VALUES (?, ?, ? , ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_ARENA_POINTS, "UPDATE characters SET arenaPoints = (arenaPoints + ?) WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ITEM_REFUND_INSTANCE, "DELETE FROM item_refund_instance WHERE ItemGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ITEM_REFUND_INSTANCE, "INSERT INTO item_refund_instance (ItemGUID, PlayerGUID, PaidMoney, PaidExtendedCost) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GROUP, "DELETE FROM `groups` WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GROUP_MEMBER_ALL, "DELETE FROM group_member WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_GIFT, "INSERT INTO character_gifts (GUID, ItemGUID, Entry, Flags) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_INSTANCE_BY_INSTANCE, "DELETE FROM instance WHERE id = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_MAIL_ITEM_BY_ID, "DELETE FROM mail_items WHERE MailID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_PETITION, "INSERT INTO petition (ownerguid, petitionguid, name, type) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PETITION_BY_GUID, "DELETE FROM petition WHERE petitionguid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PETITION_SIGNATURE_BY_GUID, "DELETE FROM petition_sign WHERE petitionguid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_DECLINED_NAME, "DELETE FROM character_declined_name WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_DECLINED_NAME, "INSERT INTO character_declined_name (GUID, Genitive, Dative, Accusative, Instrumental, Prepositional) VALUES (?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_RACE, "UPDATE characters SET race = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SKILL_LANGUAGES, "DELETE FROM character_skills WHERE skill IN (98, 113, 759, 111, 313, 109, 115, 315, 673, 137) AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_SKILL_LANGUAGE, "INSERT INTO `character_skills` (guid, skill, value, max) VALUES (?, ?, 300, 300)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_TAXI_PATH, "UPDATE characters SET TaxiPath = '' WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_TAXIMASK, "UPDATE characters SET taximask = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_QUESTSTATUS, "DELETE FROM character_quest_status WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SOCIAL_BY_GUID, "DELETE FROM character_social WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SOCIAL_BY_FRIEND, "DELETE FROM character_social WHERE friend = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_ACHIEVEMENT_BY_ACHIEVEMENT, "DELETE FROM character_achievement WHERE achievement = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_ACHIEVEMENT, "UPDATE character_achievement SET achievement = ? WHERE achievement = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_INVENTORY_FACTION_CHANGE, "UPDATE item_instance ii, character_inventory ci SET ii.itemEntry = ? WHERE ii.itemEntry = ? AND ci.guid = ? AND ci.item = ii.guid", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SPELL_BY_SPELL, "DELETE FROM character_spell WHERE guid = ? AND spell = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_SPELL_FACTION_CHANGE, "UPDATE character_spell SET spell = ? WHERE spell = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHAR_REP_BY_FACTION, "SELECT standing FROM character_reputation WHERE faction = ? AND guid = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_CHAR_REP_BY_FACTION, "DELETE FROM character_reputation WHERE faction = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_REP_FACTION_CHANGE, "UPDATE character_reputation SET faction = ?, standing = ? WHERE faction = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_TITLES_FACTION_CHANGE, "UPDATE characters SET knownTitles = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_RES_CHAR_TITLES_FACTION_CHANGE, "UPDATE characters SET chosenTitle = 0 WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SPELL_COOLDOWN, "DELETE FROM character_spell_cooldown WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHARACTER, "DELETE FROM characters WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_ACTION, "DELETE FROM character_action WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_AURA, "DELETE FROM character_aura WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_GIFT, "DELETE FROM character_gifts WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_INSTANCE, "DELETE FROM character_instance WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_INVENTORY, "DELETE FROM character_inventory WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED, "DELETE FROM character_quest_status_rewarded WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_REPUTATION, "DELETE FROM character_reputation WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SPELL, "DELETE FROM character_spell WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_MAIL, "DELETE FROM mail WHERE receiver = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_MAIL_ITEMS, "DELETE FROM mail_items WHERE receiver = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_ACHIEVEMENTS, "DELETE FROM character_achievement WHERE guid = ? AND achievement NOT BETWEEN '456' AND '467' AND achievement NOT BETWEEN '1400' AND '1427' AND achievement NOT IN(1463, 3117, 3259)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_EQUIPMENTSETS, "DELETE FROM character_equipment_sets WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_EVENTLOG_BY_PLAYER, "DELETE FROM guild_event_log WHERE PlayerGUID1 = ? OR PlayerGUID2 = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_GUILD_BANK_EVENTLOG_BY_PLAYER, "DELETE FROM guild_bank_event_log WHERE PlayerGUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_GLYPHS, "DELETE FROM character_glyphs WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_TALENT, "DELETE FROM character_talent WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SKILLS, "DELETE FROM character_skills WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_CHAR_HONOR_POINTS, "UPDATE characters SET totalHonorPoints = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_CHAR_HONOR_POINTS_ACCUMULATIVE, "UPDATE characters SET totalHonorPoints = totalHonorPoints + ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_CHAR_ARENA_POINTS, "UPDATE characters SET arenaPoints = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_CHAR_ARENA_POINTS_ACCUMULATIVE, "UPDATE characters SET arenaPoints = arenaPoints + ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_CHAR_MONEY, "UPDATE characters SET money = ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_CHAR_MONEY_ACCUMULATIVE, "UPDATE characters SET money = money + ? WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_REMOVE_GHOST, "UPDATE characters SET playerFlags = (playerFlags & (~16)) WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_ACTION, "INSERT INTO character_action (guid, spec, button, action, type) VALUES (?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_ACTION, "UPDATE character_action SET action = ?, type = ? WHERE guid = ? AND button = ? AND spec = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_ACTION_BY_BUTTON_SPEC, "DELETE FROM character_action WHERE guid = ? AND button = ? AND spec = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_INVENTORY_BY_ITEM, "DELETE FROM character_inventory WHERE item = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_INVENTORY_BY_BAG_SLOT, "DELETE FROM character_inventory WHERE bag = ? AND slot = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_MAIL, "UPDATE mail SET HasItems = ?, ExpireTime = ?, DeliverTime = ?, Money = ?, CoD = ?, Checked = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_CHAR_QUESTSTATUS, "REPLACE INTO character_quest_status (guid, quest, status, explored, timer, mobcount1, mobcount2, mobcount3, mobcount4, itemcount1, itemcount2, itemcount3, itemcount4, itemcount5, itemcount6, playercount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_QUESTSTATUS_BY_QUEST, "DELETE FROM character_quest_status WHERE guid = ? AND quest = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_QUESTSTATUS_REWARDED, "INSERT IGNORE INTO character_quest_status_rewarded (guid, quest, active) VALUES (?, ?, 1)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_QUESTSTATUS_REWARDED_BY_QUEST, "DELETE FROM character_quest_status_rewarded WHERE guid = ? AND quest = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_FACTION_CHANGE, "UPDATE character_quest_status_rewarded SET quest = ? WHERE quest = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_ACTIVE, "UPDATE character_quest_status_rewarded SET active = 1 WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_QUESTSTATUS_REWARDED_ACTIVE_BY_QUEST, "UPDATE character_quest_status_rewarded SET active = 0 WHERE quest = ? AND guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SKILL_BY_SKILL, "DELETE FROM character_skills WHERE guid = ? AND skill = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_SKILLS, "INSERT INTO character_skills (guid, skill, value, max) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UDP_CHAR_SKILLS, "UPDATE character_skills SET value = ?, max = ? WHERE guid = ? AND skill = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_SPELL, "INSERT INTO character_spell (guid, spell, specMask) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_STATS, "DELETE FROM character_stats WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_STATS, "INSERT INTO character_stats (GUID, MaxHealth, MaxPower1, MaxPower2, MaxPower3, MaxPower4, MaxPower5, MaxPower6, MaxPower7, Strength, Agility, Stamina, Intellect, Spirit, "
                     "Armor, ResistanceHoly, ResistanceFire, ResistanceNature, ResistanceFrost, ResistanceShadow, ResistanceArcane, BlockPercent, DodgePercent, ParryPercent, CriticalPercent, RangedCriticalPercent, SpellCriticalPercent, AttackPower, RangedAttackPower, "
                     "SpellPower, Resilience) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHAR_STATS, "SELECT maxhealth, strength, agility, stamina, intellect, spirit, armor, attackPower, spellPower, resilience FROM character_stats WHERE guid = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_PETITION_BY_OWNER, "DELETE FROM petition WHERE ownerguid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PETITION_SIGNATURE_BY_OWNER, "DELETE FROM petition_sign WHERE ownerguid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PETITION_BY_OWNER_AND_TYPE, "DELETE FROM petition WHERE ownerguid = ? AND type = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PETITION_SIGNATURE_BY_OWNER_AND_TYPE, "DELETE FROM petition_sign WHERE ownerguid = ? AND type = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_GLYPHS, "INSERT INTO character_glyphs VALUES(?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_TALENT_BY_SPELL, "DELETE FROM character_talent WHERE guid = ? AND spell = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_CHAR_TALENT, "INSERT INTO character_talent (guid, spell, specMask) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_ACTION_EXCEPT_SPEC, "DELETE FROM character_action WHERE spec<>? AND guid = ?", CONNECTION_ASYNC);

    // Items that hold loot or money
    PrepareStatement(CHAR_SEL_ITEMCONTAINER_ITEMS, "SELECT ContainerGUID, ItemID, Count, ItemIndex, RandomPropertyID, RandomSuffix, FollowLootRules, FreeForAll, IsBlocked, IsCounted, IsUnderThreshold, NeedsQuest, ConditionLootID FROM item_loot_storage", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_ITEMCONTAINER_SINGLE_ITEM, "DELETE FROM item_loot_storage WHERE ContainerGUID = ? AND ItemID = ? AND Count = ? AND ItemIndex = ? LIMIT 1", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_ITEMCONTAINER_SINGLE_ITEM, "INSERT INTO item_loot_storage (ContainerGUID, ItemID, ItemIndex, Count, RandomPropertyID, RandomSuffix, FollowLootRules, FreeForAll, IsBlocked, IsCounted, IsUnderThreshold, NeedsQuest, ConditionLootID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_ITEMCONTAINER_CONTAINER, "DELETE FROM item_loot_storage WHERE ContainerGUID = ?", CONNECTION_ASYNC);

    // Calendar
    PrepareStatement(CHAR_REP_CALENDAR_EVENT, "REPLACE INTO calendar_events (ID, Creator, Title, Description, Type, Dungeon, EventTime1, Flags, EventTime2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CALENDAR_EVENT, "DELETE FROM calendar_events WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_CALENDAR_INVITE, "REPLACE INTO calendar_invites (id, event, invitee, sender, status, statustime, `rank`, text) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CALENDAR_INVITE, "DELETE FROM calendar_invites WHERE id = ?", CONNECTION_ASYNC);

    // Pet
    PrepareStatement(CHAR_SEL_CHAR_PET_IDS, "SELECT ID FROM character_pet WHERE Owner = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME_BY_OWNER, "DELETE FROM character_pet_declined_name WHERE Owner = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_PET_DECLINEDNAME, "DELETE FROM character_pet_declined_name WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_ADD_CHAR_PET_DECLINEDNAME, "INSERT INTO character_pet_declined_name (ID, Owner, Genitive, Dative, Accusative, Instrumental, Prepositional) VALUES (?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_PET_DECLINED_NAME, "SELECT Genitive, Dative, Accusative, Instrumental, Prepositional FROM character_pet_declined_name WHERE Owner = ? AND ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_PET_AURA, "SELECT CasterGUID, Spell, EffectMask, RecalculateMask, StackCount, Amount1, Amount2, Amount3, BaseAmount1, BaseAmount2, BaseAmount3, MaxDuration, RemainTime, RemainCharges FROM pet_aura WHERE GUID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_PET_SPELL, "SELECT spell, active FROM pet_spell WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_PET_SPELL_COOLDOWN, "SELECT spell, category, time FROM pet_spell_cooldown WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PET_AURAS, "DELETE FROM pet_aura WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PET_SPELLS, "DELETE FROM pet_spell WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PET_SPELL_COOLDOWNS, "DELETE FROM pet_spell_cooldown WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_PET_SPELL_COOLDOWN, "INSERT INTO pet_spell_cooldown (guid, spell, category, time) VALUES (?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_PET_SPELL_BY_SPELL, "DELETE FROM pet_spell WHERE guid = ? AND spell = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_PET_SPELL, "INSERT INTO pet_spell (guid, spell, active) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_PET_AURA, "INSERT INTO pet_aura (GUID, CasterGUID, Spell, EffectMask, RecalculateMask, StackCount, Amount1, Amount2, Amount3, "
                     "BaseAmount1, BaseAmount2, BaseAmount3, MaxDuration, RemainTime, RemainCharges) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_CHAR_PETS, "SELECT ID, Entry, ModelID, Level, XP, ReactState, Slot, Name, Renamed, CurrentHealth, CurrentMana, CurrentHappiness, ActionBar, SaveTime, CreatedBySpell, PetType FROM character_pet WHERE Owner = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_PET_BY_OWNER, "DELETE FROM character_pet WHERE Owner = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_PET_NAME, "UPDATE character_pet SET Name = ?, Renamed = 1 WHERE Owner = ? AND ID = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_CHAR_PET_SLOT_BY_ID, "UPDATE character_pet SET slot = ? WHERE owner = ? AND id = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_PET_BY_ID, "DELETE FROM character_pet WHERE id = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_PET_BY_SLOT, "DELETE FROM character_pet WHERE owner = ? AND (slot = ? OR slot > ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_CHAR_PET, "REPLACE INTO character_pet (ID, Entry, Owner, ModelID, CreatedBySpell, PetType, Level, XP, ReactState, Name, Renamed, Slot, CurrentHealth, CurrentMana, CurrentHappiness, SaveTime, ActionBar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);

    // PvPstats
    PrepareStatement(CHAR_SEL_PVPSTATS_MAXID, "SELECT MAX(ID) FROM pvp_stats_battlegrounds", CONNECTION_SYNCH);
    PrepareStatement(CHAR_INS_PVPSTATS_BATTLEGROUND, "INSERT INTO pvp_stats_battlegrounds (ID, WinnerFaction, BracketID, Type, Date) VALUES (?, ?, ?, ?, NOW())", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INS_PVPSTATS_PLAYER, "INSERT INTO pvp_stats_players (BattlegroundID, CharacterGUID, Winner, ScoreKillingBlows, ScoreDeaths, ScoreHonorableKills, ScoreBonusHonor, ScoreDamageDone, ScoreHealingDone, Attribute1, Attribute2, Attribute3, Attribute4, Attribute5) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SEL_PVPSTATS_FACTIONS_OVERALL, "SELECT WinnerFaction, COUNT(*) AS count FROM pvp_stats_battlegrounds WHERE DATEDIFF(NOW(), date) < 7 GROUP BY WinnerFaction ORDER BY WinnerFaction ASC", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_PVPSTATS_BRACKET_MONTH, "SELECT CharacterGUID, COUNT(CharacterGUID) AS count, characters.Name as character_name FROM pvp_stats_players INNER JOIN pvp_stats_battlegrounds ON pvp_stats_players.BattlegroundID = pvp_stats_battlegrounds.ID AND BracketID = ? AND MONTH(Date) = MONTH(NOW()) AND YEAR(Date) = YEAR(NOW()) INNER JOIN characters ON pvp_stats_players.CharacterGUID = characters.GUID AND characters.DeleteDate IS NULL WHERE pvp_stats_players.Winner = 1 GROUP BY CharacterGUID ORDER BY count(CharacterGUID) DESC LIMIT 0, ?", CONNECTION_SYNCH);

    // Deserter tracker
    PrepareStatement(CHAR_INS_DESERTER_TRACK, "INSERT INTO battleground_deserters (guid, type, datetime) VALUES (?, ?, NOW())", CONNECTION_ASYNC);

    // QuestTracker
    PrepareStatement(CHAR_INS_QUEST_TRACK, "INSERT INTO quest_tracker (ID, CharacterGUID, QuestAcceptTime, CoreHash, CoreRevision) VALUES (?, ?, NOW(), ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_QUEST_TRACK_GM_COMPLETE, "UPDATE quest_tracker SET CompletedByGM = 1 WHERE ID = ? AND CharacterGUID = ? ORDER BY QuestAcceptTime DESC LIMIT 1", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_QUEST_TRACK_COMPLETE_TIME, "UPDATE quest_tracker SET QuestCompleteTime = NOW() WHERE ID = ? AND CharacterGUID = ? ORDER BY QuestAcceptTime DESC LIMIT 1", CONNECTION_ASYNC);
    PrepareStatement(CHAR_UPD_QUEST_TRACK_ABANDON_TIME, "UPDATE quest_tracker SET QuestAbandonTime = NOW() WHERE ID = ? AND CharacterGUID = ? ORDER BY QuestAcceptTime DESC LIMIT 1", CONNECTION_ASYNC);

    // Recovery Item
    PrepareStatement(CHAR_INS_RECOVERY_ITEM, "INSERT INTO recovery_item (Guid, ItemEntry, Count) VALUES (?, ?, ?)", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_RECOVERY_ITEM, "SELECT id, itemEntry, Count, Guid FROM recovery_item WHERE id = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_RECOVERY_ITEM_LIST, "SELECT id, itemEntry, Count FROM recovery_item WHERE Guid = ? ORDER BY id DESC", CONNECTION_SYNCH);
    PrepareStatement(CHAR_DEL_RECOVERY_ITEM, "DELETE FROM recovery_item WHERE Guid = ? AND ItemEntry = ? AND Count = ? ORDER BY Id DESC LIMIT 1", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_RECOVERY_ITEM_BY_RECOVERY_ID, "DELETE FROM recovery_item WHERE id = ?", CONNECTION_ASYNC);

    PrepareStatement(CHAR_SEL_HONORPOINTS, "SELECT totalHonorPoints FROM characters WHERE guid = ?", CONNECTION_SYNCH);
    PrepareStatement(CHAR_SEL_ARENAPOINTS, "SELECT arenaPoints FROM characters WHERE guid = ?", CONNECTION_SYNCH);

    // Character names
    PrepareStatement(CHAR_INS_RESERVED_PLAYER_NAME, "INSERT IGNORE INTO reserved_name (name) VALUES (?)", CONNECTION_ASYNC);

    // Character settings
    PrepareStatement(CHAR_SEL_CHAR_SETTINGS, "SELECT source, data FROM character_settings WHERE guid = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_REP_CHAR_SETTINGS, "REPLACE INTO character_settings (guid, source, data) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DEL_CHAR_SETTINGS, "DELETE FROM character_settings WHERE guid = ?", CONNECTION_ASYNC);

    // Instance saved data. Stores the states of gameobjects in instances to be loaded on server start
    PrepareStatement(CHAR_SELECT_INSTANCE_SAVED_DATA, "SELECT id, guid, state FROM instance_saved_go_state_data", CONNECTION_SYNCH);
    PrepareStatement(CHAR_UPDATE_INSTANCE_SAVED_DATA, "UPDATE instance_saved_go_state_data SET state = ? WHERE guid = ? AND id = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_INSERT_INSTANCE_SAVED_DATA, "INSERT INTO instance_saved_go_state_data (id, guid, state) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(CHAR_DELETE_INSTANCE_SAVED_DATA, "DELETE FROM instance_saved_go_state_data WHERE id = ?", CONNECTION_ASYNC);
    PrepareStatement(CHAR_SANITIZE_INSTANCE_SAVED_DATA, "DELETE FROM instance_saved_go_state_data WHERE id NOT IN (SELECT instance.id FROM instance)", CONNECTION_ASYNC);
}

CharacterDatabaseConnection::CharacterDatabaseConnection(MySQLConnectionInfo& connInfo) : MySQLConnection(connInfo)
{
}

CharacterDatabaseConnection::CharacterDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo) : MySQLConnection(q, connInfo)
{
}

CharacterDatabaseConnection::~CharacterDatabaseConnection()
{
}
