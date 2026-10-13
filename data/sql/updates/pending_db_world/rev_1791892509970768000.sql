--
-- Mire Hydra stands still when silenced instead of closing to melee, because its Poison Spit rows lack
-- SMARTCAST_COMBAT_MOVE and its hand-rolled combat movement never fires in that case.
-- Same conversion as 478d64959 did for the Anub'ar casters.
--

-- 18213 Mire Hydra
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18213);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18213, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 39419, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mire Hydra - On Aggro - Cast ''Poison Spit'' (No Repeat)'),
(18213, 0, 1, 0, 0, 0, 100, 0, 2400, 3800, 2400, 3800, 0, 0, 11, 39419, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Mire Hydra - In Combat - Cast ''Poison Spit''');
