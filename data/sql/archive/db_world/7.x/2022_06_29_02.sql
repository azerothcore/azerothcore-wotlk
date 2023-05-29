-- DB update 2022_06_29_01 -> 2022_06_29_02
--
UPDATE `creature_template` SET `npcflag`=`npcflag`&~1, `gossip_menu_id` = 0 WHERE `entry` = 15187;
