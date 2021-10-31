INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635700076222913000');

DELETE FROM `creature_addon` WHERE (`guid` IN (137990));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(137990, 1379900, 0, 0, 1, 0, 0, '');
