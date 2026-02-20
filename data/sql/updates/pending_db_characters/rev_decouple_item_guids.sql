-- Decouple item GUIDs: widen to BIGINT UNSIGNED for persistent DB IDs
-- Item instance primary key to BIGINT
ALTER TABLE `item_instance`
  MODIFY COLUMN `guid` BIGINT UNSIGNED NOT NULL,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (`guid`);

-- Character inventory references
ALTER TABLE `character_inventory`
  MODIFY COLUMN `item` BIGINT UNSIGNED NOT NULL;

-- Mail items references
ALTER TABLE `mail_items`
  MODIFY COLUMN `item_guid` BIGINT UNSIGNED NOT NULL;

-- Auctionhouse references
ALTER TABLE `auctionhouse`
  MODIFY COLUMN `itemguid` BIGINT UNSIGNED NOT NULL,
  DROP INDEX `item_guid`,
  ADD UNIQUE KEY `item_guid` (`itemguid`);

-- Guild bank references
ALTER TABLE `guild_bank_item`
  MODIFY COLUMN `item_guid` BIGINT UNSIGNED NOT NULL,
  DROP INDEX `Idx_item_guid`,
  ADD KEY `Idx_item_guid` (`item_guid`);

-- Refund/trade/gift tables referencing items by guid
ALTER TABLE `item_refund_instance`
  MODIFY COLUMN `item_guid` BIGINT UNSIGNED NOT NULL;

ALTER TABLE `item_soulbound_trade_data`
  MODIFY COLUMN `itemGuid` BIGINT UNSIGNED NOT NULL,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (`itemGuid`);

ALTER TABLE `character_gifts`
  MODIFY COLUMN `item_guid` BIGINT UNSIGNED NOT NULL,
  DROP PRIMARY KEY,
  ADD PRIMARY KEY (`item_guid`);
