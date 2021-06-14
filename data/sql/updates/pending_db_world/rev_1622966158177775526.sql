INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622966158177775526');

-- Removes lvl 27 Cuirboulli Boots from lvl 21 Blackfathom Tide Priestess
DELETE FROM `creature_loot_template` WHERE `Entry` = 4802 AND `Item` = 2143;

-- Removes lvl 27 Cuirboulli Boots from lvl 21 Blackfathom Oracle
DELETE FROM `creature_loot_template` WHERE `Entry` = 4803 AND `Item` = 2143;

-- Removes lvl 65 Idol of Brutality from lvl 59 Hive'Zora Tunneler
DELETE FROM `creature_loot_template` WHERE `Entry` = 11726 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Twilight Stonecaller
DELETE FROM `creature_loot_template` WHERE `Entry` = 11882 AND `Item` = 23198;

-- Removes lvl 17 Stonesplinter Rags from lvl 12 Stonesplinter Scout
DELETE FROM `creature_loot_template` WHERE `Entry` = 1162 AND `Item` = 5109;

-- Removes lvl 17 Stonesplinter Rags from lvl 12 Stonesplinter Trogg
DELETE FROM `creature_loot_template` WHERE `Entry` = 1161 AND `Item` = 5109;

-- Removes lvl 23 Scouting Spaulders from lvl 18 Foreman Thistlenettle
DELETE FROM `creature_loot_template` WHERE `Entry` = 626 AND `Item` = 6588;

-- Removes lvl 65 Idol of Brutality from lvl 60 Scourge Champion
DELETE FROM `creature_loot_template` WHERE `Entry` = 8529 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Hive'Zora Hive Sister
DELETE FROM `creature_loot_template` WHERE `Entry` = 11729 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Hive'Regal Ambusher
DELETE FROM `creature_loot_template` WHERE `Entry` = 11730 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Hive'Regal Spitfire
DELETE FROM `creature_loot_template` WHERE `Entry` = 11732 AND `Item` = 23198;

