INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642432018580300313');

#partially closes ##10214
DELETE FROM `creature_loot_template` WHERE `Entry` = 417;
