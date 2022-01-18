INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642523321403051600');

SET @AIR_ELEMENTAL_RIFT = 179667;
SET @WHIRLING_INVADER = 14455;
SET @THE_WINDREAVER = 14454;

-- Adding Boss to Game event 13: Elemental Invasions
DELETE FROM `game_event_creature` WHERE `eventEntry` = 13 AND `guid` = @THE_WINDREAVER;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (13, @THE_WINDREAVER);

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = @AIR_ELEMENTAL_RIFT);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@AIR_ELEMENTAL_RIFT, 1, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Air Elemental Rift - On Respawn - Set Event Phase 1'),
(@AIR_ELEMENTAL_RIFT, 1, 1, 2, 60, 1, 100, 0, 0, 1000, 30000, 30000, 0, 12, @WHIRLING_INVADER, 6, 120000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Air Elemental Rift - On Update - Summon Creature \'Whirling Invader\' (Phase 1)'),
(@AIR_ELEMENTAL_RIFT, 1, 2, 0, 61, 0, 100, 0, 0, 1000, 30000, 30000, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Air Elemental Rift - On Update - (After spawning Invader) Increase counter by 1'),
(@AIR_ELEMENTAL_RIFT, 1, 3, 0, 77, 0, 100, 0, 1, 3, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Counter set to 3 (3 Whirling Invaders Spawned) - Set Event Phase 2'),
(@AIR_ELEMENTAL_RIFT, 1, 4, 0, 77, 0, 100, 0, 1, 2, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'On Counter set to 2 (2 Whirling Invaders Spawned) - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @WHIRLING_INVADER);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@WHIRLING_INVADER, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 89, 30, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Whirling Invader - On Just Summoned - Start Random Movement'),
(@WHIRLING_INVADER, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 63, 1, 1, 0, 1, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Whirling Invader - On Just Died - Remove 1 counter from Rift'),
(@WHIRLING_INVADER, 0, 2, 0, 0, 0, 100, 0, 100, 500, 9000, 12000, 0, 11, 17207, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Whirling Invader - In Combat - Cast \'Whirlwind\''),
(@WHIRLING_INVADER, 0, 3, 0, 0, 0, 100, 0, 100, 200, 10000, 12000, 0, 11, 12550, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Whirling Invader - In Combat - Cast \'Lightning Shield\'');
