INSERT INTO version_db_world (`sql_rev`) VALUES ('1545780720578767600');

DELETE FROM `creature_template_addon` WHERE `entry` = 27267;
INSERT INTO `creature_template_addon` (`entry`, `bytes1`, `bytes2`, `emote`) VALUES (27267, 0, 0, 233);
UPDATE `gossip_menu_option` SET `option_id` = 3, `npc_option_npcflag` = 128 WHERE `menu_id` = 9487;
