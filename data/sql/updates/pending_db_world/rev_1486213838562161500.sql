INSERT INTO version_db_world (`sql_rev`) VALUES ('1486213838562161500');
-- BRITTLE REVENANT LOOT TABLE AND DROP RATE fixed.
DELETE FROM `creature_loot_template` WHERE (entry = 30160) AND (item IN (42246));
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(30160, 42246, 68, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (entry = 30160) AND (item IN (42780));
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(30160, 42780, 34, 1, 0, 1, 1);

DELETE FROM `creature_loot_template` WHERE (entry = 30160) AND (item IN (37701));
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(30160, 37701, 26, 1, 0, 1, 2);