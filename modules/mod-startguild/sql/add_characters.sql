/*
-- ###################################################################################### --
--  ____    __                                         ____                           
-- /\  _`\ /\ \__                  __                 /\  _`\                         
-- \ \,\L\_\ \ ,_\  __  __     __ /\_\     __      ___\ \ \/\_\    ___   _ __    __   
--  \/_\__ \\ \ \/ /\ \/\ \  /'_ `\/\ \  /'__`\  /' _ `\ \ \/_/_  / __`\/\`'__\/'__`\ 
--    /\ \L\ \ \ \_\ \ \_\ \/\ \L\ \ \ \/\ \L\.\_/\ \/\ \ \ \L\ \/\ \L\ \ \ \//\  __/ 
--    \ `\____\ \__\\/`____ \ \____ \ \_\ \__/.\_\ \_\ \_\ \____/\ \____/\ \_\\ \____\
--     \/_____/\/__/ `/___/> \/___L\ \/_/\/__/\/_/\/_/\/_/\/___/  \/___/  \/_/ \/____/
--                      /\___/ /\____/                                                
--                      \/__/  \_/__/          http://stygianthebest.github.io                                         
-- 
-- ###################################################################################### --
--
-- AUTH: DEFAULT GUILDMASTER CHARACTERS
--
-- Creates two characters on the default admin account and sets them each to Guildmaster
-- for the Horde and Alliance default guilds. These are for use with the StygianCore
-- StartGuild module.
--
-- ###################################################################################### --
*/

-- Koiter 
-- Male Orc Warrior 
-- Horde Default Guildmaster (GUID 1) 
-- Rest In Peace Twincruiser!
REPLACE INTO `azer_characters`.`characters` (`guid`, `account`, `name`, `race`, `class`, `gender`, `level`, `xp`, `money`, `skin`, `face`, `hairStyle`, `hairColor`, `facialStyle`, `bankSlots`, `restState`, `playerFlags`, `position_x`, `position_y`, `position_z`, `map`, `instance_id`, `instance_mode_mask`, `orientation`, `taximask`, `online`, `cinematic`, `totaltime`, `leveltime`, `logout_time`, `is_logout_resting`, `rest_bonus`, `resettalents_cost`, `resettalents_time`, `trans_x`, `trans_y`, `trans_z`, `trans_o`, `transguid`, `extra_flags`, `stable_slots`, `at_login`, `zone`, `death_expire_time`, `taxi_path`, `arenaPoints`, `totalHonorPoints`, `todayHonorPoints`, `yesterdayHonorPoints`, `totalKills`, `todayKills`, `yesterdayKills`, `chosenTitle`, `knownCurrencies`, `watchedFaction`, `drunk`, `health`, `power1`, `power2`, `power3`, `power4`, `power5`, `power6`, `power7`, `latency`, `talentGroupsCount`, `activeTalentGroup`, `exploredZones`, `equipmentCache`, `ammoId`, `knownTitles`, `actionBars`, `grantableLevels`, `deleteInfos_Account`, `deleteInfos_Name`, `deleteDate`) VALUES ('1', '1', 'Koiter', '2', '1', '0', '1', '0', '10000000', '8', '3', '2', '0', '0', '0', '2', '0', '-618.518', '-4251.67', '38.718', '1', '0', '0', '0', '4194304 0 0 4 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '0', '1544530457', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '32', '14', '0', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '4294967295', '0', '80', '0', '0', '0', '100', '0', '0', '0', '1', '1', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 6125 0 0 0 0 0 139 0 140 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12282 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0 0 0 0 0 0 ', '0', '0', NULL, NULL, NULL);

-- Miasara
-- Female Dwarf Warrior
-- Alliance Default Guildmaster (GUID: 2)
REPLACE INTO `azer_characters`.`characters` (`guid`, `account`, `name`, `race`, `class`, `gender`, `level`, `xp`, `money`, `skin`, `face`, `hairStyle`, `hairColor`, `facialStyle`, `bankSlots`, `restState`, `playerFlags`, `position_x`, `position_y`, `position_z`, `map`, `instance_id`, `instance_mode_mask`, `orientation`, `taximask`, `online`, `cinematic`, `totaltime`, `leveltime`, `logout_time`, `is_logout_resting`, `rest_bonus`, `resettalents_cost`, `resettalents_time`, `trans_x`, `trans_y`, `trans_z`, `trans_o`, `transguid`, `extra_flags`, `stable_slots`, `at_login`, `zone`, `death_expire_time`, `taxi_path`, `arenaPoints`, `totalHonorPoints`, `todayHonorPoints`, `yesterdayHonorPoints`, `totalKills`, `todayKills`, `yesterdayKills`, `chosenTitle`, `knownCurrencies`, `watchedFaction`, `drunk`, `health`, `power1`, `power2`, `power3`, `power4`, `power5`, `power6`, `power7`, `latency`, `talentGroupsCount`, `activeTalentGroup`, `exploredZones`, `equipmentCache`, `ammoId`, `knownTitles`, `actionBars`, `grantableLevels`, `deleteInfos_Account`, `deleteInfos_Name`, `deleteDate`) VALUES ('2', '1', 'Miasara', '3', '1', '1', '1', '0', '10000000', '3', '4', '12', '7', '4', '0', '2', '0', '-6240.32', '331.033', '382.758', '0', '0', '0', '6.17716', '32 0 0 8 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '0', '1545278591', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '32', '1', '0', '', '0', '0', '0', '0', '0', '0', '0', '0', '0', '4294967295', '0', '90', '0', '0', '0', '100', '0', '0', '0', '1', '1', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 38 0 0 0 0 0 39 0 40 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12282 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0 0 0 0 0 0 ', '0', '0', NULL, NULL, NULL);


-- --------------------------------------------------------------------------------------
-- Table structure for item_instance
-- --------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `item_instance`;
CREATE TABLE `item_instance` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `itemEntry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `owner_guid` int(10) unsigned NOT NULL DEFAULT '0',
  `creatorGuid` int(10) unsigned NOT NULL DEFAULT '0',
  `giftCreatorGuid` int(10) unsigned NOT NULL DEFAULT '0',
  `count` int(10) unsigned NOT NULL DEFAULT '1',
  `duration` int(10) NOT NULL DEFAULT '0',
  `charges` tinytext,
  `flags` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `enchantments` text NOT NULL,
  `randomPropertyId` smallint(5) NOT NULL DEFAULT '0',
  `durability` smallint(5) unsigned NOT NULL DEFAULT '0',
  `playedTime` int(10) unsigned NOT NULL DEFAULT '0',
  `text` text,
  PRIMARY KEY (`guid`),
  KEY `idx_owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item System';
-- --------------------------------------------------------------------------------------
-- Records of item_instance
-- --------------------------------------------------------------------------------------

-- 1
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('1', '12064', '1', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '20', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('2', '2586', '1', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '35', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('3', '11508', '1', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '16', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('4', '5976', '1', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('5', '701002', '1', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('6', '701004', '1', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '');

-- 2
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('7', '12064', '2', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '20', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('8', '2586', '2', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '35', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('9', '11508', '2', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '16', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('10', '5976', '2', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('11', '701002', '2', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '');
REPLACE INTO `azer_characters`.`item_instance` (`guid`, `itemEntry`, `owner_guid`, `creatorGuid`, `giftCreatorGuid`, `count`, `duration`, `charges`, `flags`, `enchantments`, `randomPropertyId`, `durability`, `playedTime`, `text`) VALUES ('12', '701004', '2', '0', '0', '1', '0', '0 0 0 0 0 ', '0', '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0', '0', '0', '');

-- --------------------------------------------------------------------------------------
-- Table structure for character_inventory
-- --------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `character_inventory`;
CREATE TABLE `character_inventory` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `bag` int(10) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Item Global Unique Identifier',
  PRIMARY KEY (`item`),
  UNIQUE KEY `guid` (`guid`,`bag`,`slot`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';
-- --------------------------------------------------------------------------------------
-- Records of character_inventory
-- --------------------------------------------------------------------------------------

-- 1
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('1', '0', '0', '1'); -- GM Hood (12064)
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('1', '0', '4', '2'); -- GM Robe (2586)
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('1', '0', '7', '3'); -- GM Slippers (11508)
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('1', '0', '18', '4'); -- Guild Tabard (5976)
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('1', '0', '23', '5'); -- Pocket Portal (710002)
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('1', '0', '24', '6'); -- Gamemaster's License

-- 2
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('2', '0', '0', '7'); -- GM Hood
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('2', '0', '4', '8'); -- GM Robe
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('2', '0', '7', '9'); -- GM Slippers
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('2', '0', '18', '10'); -- Guild Tabard
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('2', '0', '23', '11'); -- Pocket Portal
REPLACE INTO `azer_characters`.`character_inventory` (`guid`, `bag`, `slot`, `item`) VALUES ('2', '0', '24', '12'); -- Gamemaster's License

-- --------------------------------------------------------------------------------------
-- playercreaharacter_inventory 
-- --------------------------------------------------------------------------------------
REPLACE INTO `azer_world`.`playercreateinfo_item` (`race`, `class`, `itemid`, `amount`) VALUES ('0', '0', '701002', '1');
