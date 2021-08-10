INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628170702879843880');

-- removes skinning loot from Ranger Jaela and Vile'rel
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (15416, 9036);

