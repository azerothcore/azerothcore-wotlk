INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642521638013653400');

SET @WATER_ELEMENTAL_RIFT = 179665;
SET @WATERY_INVADER = 14458;
SET @PRINCESS_TEMPESTRIA = 247210;

-- Adding Boss to Game event 13: Elemental Invasions
DELETE FROM `game_event_creature` WHERE `eventEntry` = 13 AND `guid` = @PRINCESS_TEMPESTRIA;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (13, @PRINCESS_TEMPESTRIA);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = @WATER_ELEMENTAL_RIFT);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@WATER_ELEMENTAL_RIFT, 1, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Elemental Rift - On Respawn - Set Event Phase 1'),
(@WATER_ELEMENTAL_RIFT, 1, 1, 2, 60, 1, 100, 0, 0, 1000, 30000, 30000, 0, 12, @WATERY_INVADER, 6, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Elemental Rift - On Update - Summon Creature \'Watery Invader\' (Phase 1)'),
(@WATER_ELEMENTAL_RIFT, 1, 2, 0, 61, 0, 100, 0, 0, 1000, 30000, 30000, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Elemental Rift - On Update - (After spawning Invader) Increase counter by 1'),
(@WATER_ELEMENTAL_RIFT, 1, 3, 0, 77, 0, 100, 0, 1, 3, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Counter set to 3 (3 Watery Invaders Spawned) - Set Event Phase 2'),
(@WATER_ELEMENTAL_RIFT, 1, 4, 0, 77, 0, 100, 0, 1, 2, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Counter set to 2 (2 Watery Invaders Spawned) - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @WATERY_INVADER);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@WATERY_INVADER, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watery Invader - On Just Summoned - Start Random Movement'),
(@WATERY_INVADER, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 1, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Watery Invader - On Just Died - Remove 1 counter from Rift'),
(@WATERY_INVADER, 0, 2, 0, 0, 0, 100, 0, 2000, 5000, 5000, 8000, 0, 11, 20005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watery Invader - In Combat - Cast \'Chilled\''),
(@WATERY_INVADER, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 8000, 15000, 0, 11, 19133, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watery Invader - In Combat - Cast \'Frost Shock\'');
