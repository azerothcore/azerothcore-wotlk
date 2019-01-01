INSERT INTO version_db_world (`sql_rev`) VALUES ('1546372382749787200');

-- creature_text
ALTER TABLE `creature_text` CHANGE `entry` `CreatureID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `groupid` `GroupID` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `id` `ID` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `text` `Text` LONGTEXT;
ALTER TABLE `creature_text` CHANGE `type` `Type` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `language` `Language` TINYINT(3) NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `probability` `Probability` FLOAT UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `emote` `Emote` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `duration` `Duration` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE `sound` `Sound` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0';
ALTER TABLE `creature_text` CHANGE COLUMN `BroadcastTextID` `BroadcastTextId` mediumint(6) NOT NULL DEFAULT 0 AFTER `Sound`;

-- npc_text
ALTER TABLE `npc_text` ADD `BroadcastTextID0` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text0_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID1` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text1_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID2` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text2_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID3` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text3_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID4` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text4_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID5` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text5_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID6` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text6_1`;
ALTER TABLE `npc_text` ADD `BroadcastTextID7` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `text7_1`;

-- gossip_menu
ALTER TABLE `gossip_menu` CHANGE `entry` `MenuID` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu` CHANGE `text_id` `TextID` mediumint(8) unsigned NOT NULL DEFAULT '0';

-- gossip_menu_option
ALTER TABLE `gossip_menu_option` CHANGE `menu_id` `MenuID` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `id` `OptionID` smallint(5) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `option_icon` `OptionIcon` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `option_text` `OptionText` text;
ALTER TABLE `gossip_menu_option` CHANGE `option_id` `OptionType` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `npc_option_npcflag` `OptionNpcFlag` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `action_menu_id` `ActionMenuID` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `action_poi_id` `ActionPoiID` mediumint(8) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_coded` `BoxCoded` tinyint(3) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_money` `BoxMoney` int(10) unsigned NOT NULL DEFAULT '0';
ALTER TABLE `gossip_menu_option` CHANGE `box_text` `BoxText` text;
ALTER TABLE `gossip_menu_option` ADD `OptionBroadcastTextID` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `OptionText`;
ALTER TABLE `gossip_menu_option` ADD `BoxBroadcastTextID` MEDIUMINT(6) DEFAULT 0 NOT NULL AFTER `BoxText`;
ALTER TABLE `gossip_menu_option` ADD COLUMN `VerifiedBuild` smallint(5) NOT NULL DEFAULT 0 AFTER `BoxBroadcastTextID`;

-- Drop table
DROP TABLE `db_script_string`; -- RIP
