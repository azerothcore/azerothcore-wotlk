-- DB update 2024_07_18_00 -> 2024_07_19_00
--
UPDATE `creature_template_addon` SET `bytes2` = 1, `auras` = '18950' WHERE (`entry` = 22878);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22878);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22878, 0, 0, 0, 0, 0, 100, 0, 7000, 11000, 9000, 13000, 0, 0, 11, 40100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast \'Crashing Wave\''),
(22878, 0, 1, 0, 0, 0, 100, 0, 9000, 15000, 6000, 12000, 0, 0, 11, 40099, 0, 0, 0, 0, 0, 5, 100, 1, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast \'Vile Slime\''),
(22878, 0, 2, 3, 0, 0, 100, 0, 14000, 18000, 30000, 40000, 0, 0, 11, 40101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Cast \'Serverside - Summon Aqueous Spawn\''),
(22878, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 22883, 4, 30000, 0, 0, 0, 202, 10, 1, 1, 0, 0, 0, 0, 0, 'Aqueous Lord - In Combat - Summon Creature \'Aqueous Spawn\'');

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|2048, `mechanic_immune_mask` = `mechanic_immune_mask`&~8, `flags_extra` = `flags_extra`|256 WHERE (`entry` = 22960);

DELETE FROM `creature_text` WHERE (`CreatureID` = 23028);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23028, 0, 0, 'I\'ve seen female Gnomes hit harder than you!', 14, 0, 100, 0, 0, 0, 21354, 0, 'Bonechewer Taskmaster'),
(23028, 0, 1, 'If you don\'t start throwing some real punches, you\'ll be cleaning the drake stalls for a year!', 14, 0, 100, 0, 0, 0, 21356, 0, 'Bonechewer Taskmaster'),
(23028, 0, 2, 'Stop your slacking and fight like a true fel orc!', 14, 0, 100, 0, 0, 0, 21353, 0, 'Bonechewer Taskmaster'),
(23028, 0, 3, 'You call that an offense? I\'ve seen more offensive tallstriders!', 14, 0, 100, 0, 0, 0, 21355, 0, 'Bonechewer Taskmaster'),
(23028, 1, 0, '%s becomes increasingly enraged as he sees his allies fall in battle!', 16, 0, 100, 0, 0, 0, 21352, 0, 'Bonechewer Taskmaster');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 23028);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23028, 0, 0, 1, 0, 0, 100, 0, 5000, 15000, 14000, 14000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - In Combat - Talk'),
(23028, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 67, 1, 3000, 3000, 0, 0, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - In Combat - Create Timed Event'),
(23028, 0, 2, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 11, 40851, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - On Timed Event - Cast Disgruntled'),
(23028, 0, 3, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 11, 40845, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - On Data Set 1 1 - Cast \'Fury\''),
(23028, 0, 4, 0, 38, 0, 100, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Taskmaster - On Data Set 1 1 - Say Line 1 (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22963);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22963, 0, 0, 0, 0, 0, 100, 1, 5000, 15000, 0, 0, 0, 0, 11, 40844, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Worker - In Combat - Cast \'Throw Pick\' (No Repeat)'),
(22963, 0, 1, 0, 8, 0, 100, 0, 40851, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Worker - On Spellhit \'Disgruntled\' - Say Line 0'),
(22963, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 23028, 40, 0, 0, 0, 0, 0, 0, 'Bonechewer Worker - On Just Died - Set Data 1 1');

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|4|16|64|256|512|1024|2048|4096|8192|131072|4194304|8388608|33554432 WHERE (`entry` = 22954);
