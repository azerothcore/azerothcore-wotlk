INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618177960313931100');

-- Links a gossip text to NPC Terenthis in Auberdine, Darkshore
-- https://github.com/azerothcore/azerothcore-wotlk/issues/5227
-- https://www.youtube.com/watch?v=ZwFgc6P3ERc
DELETE FROM `gossip_menu` WHERE (`MenuID` = 6456) AND (`TextID` IN (3334));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (6456, 3334);
UPDATE `creature_template` SET `gossip_menu_id` = 6456 WHERE `entry` = 3693; -- Add created gossip menu to NPC
UPDATE `npc_text` SET `BroadcastTextID0` = '0' WHERE `ID` = 3334; -- This was set to a text with typos, not sure why
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE `entry` = 3693; -- Make sure the NPC has the gossip flag
