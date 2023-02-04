-- DB update 2022_09_07_06 -> 2022_09_07_07
--
UPDATE `creature_template_addon` SET `bytes1` = 54432 WHERE `entry` = 15963;
UPDATE `creature_template_addon` SET `auras` = '18943' WHERE `entry` = 15275;

DELETE FROM `areatrigger_scripts` WHERE `ScriptName` = 'at_twin_emperors';
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4047, 'at_twin_emperors');

DELETE FROM `creature_text` WHERE `CreatureID` IN (15275, 15276) AND `GroupID` IN (0, 1, 2, 3, 4, 5, 6);
DELETE FROM `creature_text` WHERE `CreatureID` = 15963;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15275, 0, 0, 'Where are your manners, brother. Let us properly welcome our guests.', 14, 0, 100, 6, 0, 0, 11706, 0, 'Emperor Vek\'nilash INTRO_0'),
(15275, 1, 0, 'Oh so much pain...', 14, 0, 100, 5, 0, 0, 11708, 0, 'Emperor Vek\'nilash INTRO_1'),
(15275, 2, 0, 'The feast of souls begins now...', 14, 0, 100, 0, 0, 0, 11710, 0, 'Emperor Vek\'nilash INTRO_2'),
(15275, 3, 0, 'Your fate is sealed!', 14, 0, 100, 0, 0, 8635, 11455, 0, 'Emperor Vek\'nilash KILL'),
(15275, 4, 0, 'Vek\'lor, I feel your pain!', 14, 0, 100, 0, 0, 8636, 11454, 0, 'Emperor Vek\'nilash DEATH'),
(15276, 0, 0, 'Only flesh and bone. Mortals are such easy prey...', 14, 0, 100, 1, 0, 0, 11702, 0, 'Emperor Vek\'lor INTRO_0'),
(15276, 1, 0, 'There will be pain...', 14, 0, 100, 273, 0, 0, 11707, 0, 'Emperor Vek\'lor INTRO_1'),
(15276, 2, 0, 'Come, little ones.', 14, 0, 100, 0, 0, 0, 11709, 0, 'Emperor Vek\'lor INTRO_2'),
(15276, 3, 0, 'You will not escape death!', 14, 0, 100, 0, 0, 8629, 11453, 0, 'Emperor Vek\'lor KILL'),
(15276, 4, 0, 'My brother, no!', 14, 0, 100, 0, 0, 8625, 11452, 0, 'Emperor Vek\'lor DEATH'),
(15276, 5, 0, '%s goes into a berserker rage!', 16, 0, 100, 0, 0, 0, 34057, 0, 'Emperor Vek\'lor ENRAGE'),
(15963, 0, 0, 'The massive floating eyeball in the center of the chamber turns its gaze upon you. You stand before a god.', 16, 0, 100, 0, 0, 0, 11700, 1, 'Masters Eye - On Areatrigger');

UPDATE `creature_template_movement` SET `Ground` = 2, `Flight` = 1 WHERE `CreatureId` = 15963;

UPDATE `creature_template` SET `unit_flags` = `unit_flags`|512|256 WHERE `entry` = 15963;
UPDATE `creature_template` SET `spell_school_immune_mask` = `spell_school_immune_mask`|1 WHERE `entry` = 15276; -- Vek'lor immunity to phys
UPDATE `creature_template` SET `spell_school_immune_mask` = `spell_school_immune_mask`|4|8|16|32|64 WHERE `entry` = 15275; -- Vek'nilash immunity to everything but holy and phys

DELETE FROM `spell_script_names` WHERE `spell_id` IN (802, 804);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(802, 'spell_mutate_explode_bug'),
(804, 'spell_mutate_explode_bug');

UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id1` IN (15316, 15317);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (15316, 15317);

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (15316, 15317)) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15317, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 2, 311, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Scorpion - On Reset - Set Faction 311'),
(15316, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 2, 311, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Qiraji Scarab - On Reset - Set Faction 311');
