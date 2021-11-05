INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635700076222913000');

-- remove sneak from iron guard
DELETE FROM `creature_addon` WHERE `guid` = 137990;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(137990, 1379900, 0, 0, 1, 0, 0, '');


-- remove "remove sneak" from assassin, this way they drop the sneak on attacking
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10318;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10318 AND `source_type` = 0 AND `id` = 1;
