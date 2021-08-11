INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628691033880289424');

-- Removes skinning loot from various lvl 1 pets, critters and items
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (1419, 2230, 4781, 6728, 7507, 7508, 7509, 7557, 8662, 10116, 10577, 10657, 12202, 14453, 14646, 14869);

