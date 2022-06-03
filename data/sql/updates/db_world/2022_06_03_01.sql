-- DB update 2022_06_03_00 -> 2022_06_03_01
--
UPDATE `creature_template` SET `speed_run` = 1.14286, `speed_walk` = 1.32 WHERE `entry` = 14517;

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_batrider_bomb';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(23970, 'spell_batrider_bomb');

UPDATE `gameobject_template` SET `Data2` = 6 WHERE `entry` = 180125;
