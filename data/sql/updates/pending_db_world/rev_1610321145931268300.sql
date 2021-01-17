INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1610321145931268300');

-- Airman Skyhopper mace sheathing fix

DELETE FROM `creature_template_addon` WHERE (`entry` = 25737);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(25737, 0, 0, 0, 0, 0, 0, '');

