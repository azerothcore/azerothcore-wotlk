INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621968262932056500');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 3928) AND (`Item` IN (2592, 4306, 5519, 6712, 16747, 16748));
