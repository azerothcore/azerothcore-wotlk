INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638924383737045000');

/* Mining type_flag for NPC Tavarok
*/

UPDATE `creature_template` SET `type_flags` = 512 WHERE (`entry` = 18343, 20268);
