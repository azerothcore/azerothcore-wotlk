--
-- Quest 619 "Enticing Negolash": Negolash (1494) should not attack the summoner.
-- He spawns in the sea, yells once and slowly walks towards the Ruined Lifeboat (GO 2289).
-- Spawn position from vmangos quest_end_scripts (sql/migrations/20211001113141_world.sql).
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2289 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2289, 1, 0, 0, 20, 0, 100, 0, 619, 0, 0, 0, 0, 0, 12, 1494, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -14598.6, 76.0563, -11.249, 0.925025, 'Ruined Lifeboat - On Quest ''Enticing Negolash'' Rewarded - Summon Negolash'),
(2289, 1, 1, 0, 20, 0, 100, 0, 619, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruined Lifeboat - On Quest ''Enticing Negolash'' Rewarded - Summon Gameobject Group 0');

-- Negolash: yell once on summon (was: on out of combat, which fired again after evading), then walk to the boat
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1494 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1494, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Just Summoned - Say Line 0'),
(1494, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Link - Set Walk'),
(1494, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 5, 0, 0, 20, 2289, 100, 0, 0, 0, 0, 0, 0, 'Negolash - On Link - Move To Closest Gameobject ''Ruined Lifeboat'''),
(1494, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Aggro - Set Run'),
(1494, 0, 4, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negolash - On Movement Inform - Set Home Position');
