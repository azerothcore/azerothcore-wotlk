-- DB update 2025_09_15_01 -> 2025_09_15_02
--
DELETE FROM `creature_text` WHERE `CreatureId` = 24877 AND `GroupID` = 2;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24877, 2, 0, '%s laughs.', 16, 0, 100, 0, 0, 2047, 0, 'Isuldof Iceheart');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24877);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24877, 0, 0, 1, 8, 0, 100, 0, 45323, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Isuldof Iceheart - On Spellhit \'Returning Vrykul Artifact\' - Say Line 2'),
(24877, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 24877, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Isuldof Iceheart - On Spellhit \'Returning Vrykul Artifact\' - Quest Credit \'null\''),
(24877, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 187383, 60, 0, 0, 0, 0, 8, 0, 0, 0, 0, -83.3153, -5014.22, 306.416, 6.26573, 'Isuldof Iceheart - On Spellhit \'Returning Vrykul Artifact\' - Summon Gameobject \'The Frozen Heart of Isuldof\''),
(24877, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Isuldof Iceheart - On Spellhit \'Returning Vrykul Artifact\' - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24876) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24876, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 24876, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rodin the Reckless - On Spellhit \'Returning Vrykul Artifact\' - Quest Credit \'A Return to Resting\' (No Repeat)'),
(24876, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 187385, 60, 0, 0, 0, 0, 8, 0, 0, 0, 0, 11.990668296813965, -4981.400390625, 303.3150939941406, 1.0646495819091797, 'Rodin the Reckless - On Spellhit \'Returning Vrykul Artifact\' - Summon Gameobject \'The Staff of Storm\'s Fury\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24874) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24874, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 24874, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fengir the Disgraced - On Spellhit \'Returning Vrykul Artifact\' - Quest Credit \'A Return to Resting\' (No Repeat)'),
(24874, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 187386, 60, 0, 0, 0, 0, 8, 0, 0, 0, 0, -17.07861328125, -4883.18212890625, 298.53485107421875, 0.10471932590007782, 'Fengir the Disgraced - On Spellhit \'Returning Vrykul Artifact\' - Summon Gameobject \'The Shield of the Aesirites\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24875) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24875, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 24875, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Windan of the Kvaldir - On Spellhit \'Returning Vrykul Artifact\' - Quest Credit \'A Return to Resting\' (No Repeat)'),
(24875, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 187384, 60, 0, 0, 0, 0, 8, 0, 0, 0, 0, -108.64334106445312, -5143.8330078125, 324.7471008300781, 2.4609127044677734, 'Windan of the Kvaldir - On Spellhit \'Returning Vrykul Artifact\' - Summon Gameobject \'The Ancient Armor of the Kvaldir\'');

UPDATE `creature_addon` SET `auras` = '44792' WHERE `guid` = 100024;

UPDATE `creature_template` SET `ScriptName` = 'npc_rodin_lightning_enabler' WHERE `entry` = 24883;
