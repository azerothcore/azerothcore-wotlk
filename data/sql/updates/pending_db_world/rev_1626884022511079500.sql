INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626884022511079500');

-- Slowed the movement speed of Dragonmaw Battlemaster from 1.54 to 1 as the rest of the orcs there
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 1037);

