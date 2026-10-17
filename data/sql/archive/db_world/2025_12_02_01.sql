-- DB update 2025_12_02_00 -> 2025_12_02_01
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29796) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29796, 0, 0, 0, 19, 0, 100, 0, 12886, 0, 0, 0, 0, 0, 11, 55253, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gretta the Arbiter - On Quest \'The Drakkensryd\' Taken - Cast \'Force Cast Initial Proto-Drake\'');

UPDATE `creature_template` SET `speed_run` = 3.2 WHERE (`entry` = 29679);

-- 55971 Eagle Flight
UPDATE `creature_template_addon` SET `auras` = '55971' WHERE (`entry` = 29679);

-- Update comments, Exit vehicle on death
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29694) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29694, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 5000, 9000, 0, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hyldsmeet Drakerider - In Combat - Cast \'Mortal Strike\''),
(29694, 0, 1, 2, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 33, 29800, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hyldsmeet Drakerider - On Just Died - Quest Credit \'null\''),
(29694, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 203, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hyldsmeet Drakerider - On Just Died - Exit vehicle');

-- Hyldsmeet Drakerider eject NPC passenger vertically
DELETE FROM `vehicle_seat_addon` WHERE (`SeatEntry` = 2101);
INSERT INTO `vehicle_seat_addon` (`SeatEntry`, `SeatOrientation`, `ExitParamX`, `ExitParamY`, `ExitParamZ`, `ExitParamO`, `ExitParamValue`) VALUES
(2101, 0, 0, 0, 4, 0, 1);

-- Update Comments, Reduce despawn time from 2s to 1s
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29679) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29679, 0, 0, 0, 60, 0, 100, 513, 1000, 1000, 0, 0, 0, 0, 53, 2, 29679, 0, 0, 1000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hyldsmeet Proto-Drake - On Update - Start Waypoint Path 29679 (No Repeat)'),
(29679, 0, 1, 0, 60, 0, 100, 513, 500, 500, 0, 0, 0, 0, 60, 1, 500, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hyldsmeet Proto-Drake - On Update - Set Fly On (No Repeat)'),
(29679, 0, 2, 0, 28, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hyldsmeet Proto-Drake - On Passenger Removed - Despawn In 1000 ms');

DELETE FROM `spell_area` WHERE `spell` IN (55012, 72914) AND `area` IN (4430, 4431, 4432) AND `quest_start` = 12886;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(55012, 4430, 12886, 0, 0, 0, 2, 1, 10, 0),
(55012, 4431, 12886, 0, 0, 0, 2, 1, 10, 0),
(55012, 4432, 12886, 0, 0, 0, 2, 1, 10, 0),
(72914, 4430, 12886, 0, 0, 0, 2, 1, 10, 0),
(72914, 4431, 12886, 0, 0, 0, 2, 1, 10, 0),
(72914, 4432, 12886, 0, 0, 0, 2, 1, 10, 0);
