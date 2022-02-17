INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644946104908761300');

UPDATE `creature_template` SET `gossip_menu_id`=361, `npcflag` = `npcflag`|1 WHERE `entry`=3702;
