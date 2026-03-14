-- DB update 2025_10_04_02 -> 2025_10_04_03

-- Set MT and WD
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id1` = 27482) AND (`guid` IN (104181));

-- Set byte1 (Kneel)
UPDATE `creature_addon` SET `bytes1` = 8 WHERE (`guid` IN (104181, 104184));

-- Update SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27482;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27482);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27482, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - On Reset - Set Reactstate Passive'),
(27482, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - On Aggro - Set Reactstate Aggressive'),
(27482, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 8000, 12000, 0, 0, 11, 32771, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - In Combat - Cast \'Holy Shock\''),
(27482, 0, 3, 0, 0, 0, 100, 0, 3000, 6000, 32000, 36000, 0, 0, 11, 29385, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - In Combat - Cast \'Seal of Command\''),
(27482, 0, 4, 0, 8, 0, 100, 512, 48845, 0, 0, 0, 0, 0, 80, 2748200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - On Spellhit \'Renew Infantry\' - Run Script');

-- Set Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2748200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2748200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 48813, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - Actionlist - Cast \'Kill Credit\''),
(2748200, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - Actionlist - Remove FlagStandstate Kneel'),
(2748200, 9, 2, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 0, 66, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - Actionlist - Set Orientation Invoker'),
(2748200, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 5, 113, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - Actionlist - Play Emote 113'),
(2748200, 9, 4, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - Actionlist - Say Line 0'),
(2748200, 9, 5, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 53, 1, 27482, 0, 0, 2000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wounded Westfall Infantry - Actionlist - Start Waypoint Path 27482');
