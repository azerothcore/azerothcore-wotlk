-- DB update 2023_08_11_02 -> 2023_08_11_03
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_inoculate_nestlewood_owlkin';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(29528, 'spell_inoculate_nestlewood_owlkin');

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 16518;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16518);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1651800) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8));
