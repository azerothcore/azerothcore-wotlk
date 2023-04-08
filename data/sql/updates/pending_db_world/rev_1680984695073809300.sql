--
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |33554432, `ScriptName` = '' WHERE `entry` IN (17954, 20631);

DELETE FROM `creature_template_addon` WHERE `entry` IN (17954, 20631);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(17954, 0, 0, 0, 0, 0, 0, '25900'),
(20631, 0, 0, 0, 0, 0, 0, '25900');

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (17954, 20631);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Rooted`) VALUES
(17954, 1, 1), (20631, 1, 1);

SELECT * FROM creature_template_movement WHERE creatureid = 17954;

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_warlords_rage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(31543, 'spell_warlords_rage');
