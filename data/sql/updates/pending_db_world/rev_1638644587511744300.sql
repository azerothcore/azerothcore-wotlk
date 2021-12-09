INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638644587511744300');

/* Apply 'Permanent Feign Death' aura to Citizen of New Avalon
*/

DELETE FROM `creature_addon` WHERE (`guid` IN (129727, 129769));

INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(129727, 0, 0, 0, 0, 0, 0, '29266'),
(129769, 0, 0, 0, 0, 0, 0, '29266');
