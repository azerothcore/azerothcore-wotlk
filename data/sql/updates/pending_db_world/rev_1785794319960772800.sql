--
DELETE FROM `creature` WHERE `id` = 26231 AND `guid` = 40270;
DELETE FROM `waypoint_data` WHERE `id` = 402700;
DELETE FROM `creature_addon` WHERE `guid` = 40270;

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 26231);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(26231, 0, 0, 1, 0, 0, 0, 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26231);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26231, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2623100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - On Respawn - Run Script'),
(26231, 0, 1, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 2623101, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - On Reached Point 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2623100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2623100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 239, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - Actionlist - Set AnimTier 3'),
(2623100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4026.4883, 7297.1025, 640.27356, 0, 'Saragosa - Actionlist - Move To Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2623101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2623101, 9, 0, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 5, 293, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - Actionlist - Play Emote 293'),
(2623101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4026.49, 7297.1, 635.957, 0, 'Saragosa - Actionlist - Move To Position'),
(2623101, 9, 2, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 0, 239, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - Actionlist - Set AnimTier 0'),
(2623101, 9, 3, 0, 0, 0, 100, 0, 1600, 1600, 0, 0, 0, 0, 11, 46802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - Actionlist - Cast \'Frost Breath\''),
(2623101, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 5, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - Actionlist - Play Emote 15'),
(2623101, 9, 5, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 227, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - Actionlist - Set Scale to 10%'),
(2623101, 9, 7, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 12, 26232, 4, 60000, 0, 0, 0, 8, 0, 0, 0, 0, 4027.11, 7298.14, 636.055, 1.50098, 'Saragosa - Actionlist - Summon Creature \'Saragosa\''),
(2623101, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26265);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26265, 0, 0, 0, 8, 0, 100, 0, 46793, 0, 0, 0, 0, 0, 80, 2626500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa\'s End Invisman - On Spellhit \'Activate Power Focus\' - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2626500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2626500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 26231, 5, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3993.1567, 7182.951, 672.23444, 1.217250943183899, 'Saragosa\'s End Invisman - Actionlist - Summon Creature \'Saragosa\''),
(2626500, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46789, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa\'s End Invisman - Actionlist - Cast \'Blue Power Focus\''),
(2626500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46796, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa\'s End Invisman - Actionlist - Cast \'Blue Flame Shield\''),
(2626500, 9, 3, 0, 0, 0, 100, 0, 13000, 13000, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saragosa\'s End Invisman - Actionlist - Remove Auras');
