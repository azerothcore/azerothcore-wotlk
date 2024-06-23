-- Horvon the Armorer, Greatfather Aldrimus
DELETE FROM `creature_template_addon` WHERE `entry` IN (19879,19698);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(19879, 0, 0, 0, 1, 0, 0, '32648'),
(19698, 0, 0, 8, 1, 0, 0, '32648');

UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 19698);

DELETE FROM `spell_area` WHERE `spell`=32649 AND `area`=3688;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(32649, 3688, 10045, 0, 0, 0, 2, 1, 64, 11),
(32649, 3688, 10252, 0, 0, 0, 2, 1, 64, 11);
