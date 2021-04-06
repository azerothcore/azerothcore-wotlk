INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617672426976371900');

UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=2 WHERE `entry`=4984;
DELETE FROM `gossip_menu` WHERE `MenuID`=12093 AND `TextID`=16981;
DELETE FROM `npc_text` WHERE `id`=16981;

