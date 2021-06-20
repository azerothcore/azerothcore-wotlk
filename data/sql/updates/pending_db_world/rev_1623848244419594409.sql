INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623848244419594409');

-- Changes Tunnel Rat Ear drop rate to 38% for Geomancers, Diggers and Surveyors
UPDATE `creature_loot_template` SET `Chance` = 38 WHERE `entry` IN (1174, 1175, 1177) AND `item` = 3110;

-- Adds Tunnel Rat Ears to Scouts with 38% drop rate
DELETE FROM `creature_loot_template` WHERE `Entry` = 1173 AND `Item` = 3110;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1173, 3110, 0, 38, 1, 1, 0, 1, 1, 'Quest drop for Rat Catching');
