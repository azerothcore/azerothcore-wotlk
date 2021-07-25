INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626854857651022900');

-- Reduced the speed from 3.16 to 1.6 as the rest of the ogres in that place
UPDATE `creature_template` SET `speed_walk` = 1.6 WHERE (`entry` = 7371);

