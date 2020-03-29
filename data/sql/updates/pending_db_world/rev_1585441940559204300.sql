INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1585441940559204300');

DELETE FROM `creature_addon` WHERE `GUID` IN (127996,128030,127997,128029,127995,127998);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES 
(127996, 0, 0, 8, 1, 0, 1, '21157'),
(128030, 0, 0, 8, 1, 0, 1, '21157'),
(128029, 0, 0, 8, 1, 0, 1, '21157'),
(127998, 0, 0, 8, 1, 0, 1, '21157'),
(127995, 0, 0, 8, 1, 0, 1, '21157'),
(127997, 0, 0, 8, 1, 0, 1, '21157');
