INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631537204810734698');

-- Adds voidwalker summon to Apothecary Falthis
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3735 AND `source_type` = 0 AND `id` = 2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3735, 0, 2, 0, 1, 0, 100, 1, 100, 1000, 0, 0, 0, 11, 12746, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apothecary Falthis - Out of Combat - Cast \'Summon Voidwalker\' (No Repeat)');

-- Moves Apothecary Falthis slightly to correct position
UPDATE `creature` SET `position_x` = 3845.6,  `position_y` = -213.6, `position_z` = 4.8, `orientation` = 1.67 WHERE `id` = 3735 AND `guid` = 32913;

