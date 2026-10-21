-- DB update 2026_10_06_00 -> 2026_10_06_01
--
UPDATE `creature_template` SET `npcflag` = 0, `gossip_menu_id` = 0 WHERE `entry` = 21859;
