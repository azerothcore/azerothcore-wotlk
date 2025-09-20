-- DB update 2025_09_06_02 -> 2025_09_06_03
-- Remove heroic casts as it is already handled by spelldifficulty_dbc and add on aggro engage
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28729);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28729, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 15000, 20000, 0, 0, 11, 52524, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast \'Blinding Webs\''),
(28729, 0, 2, 0, 0, 0, 100, 0, 6000, 15000, 20000, 25000, 0, 0, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast \'Web Wrap\''),
(28729, 0, 3, 0, 0, 0, 100, 0, 4000, 12000, 9000, 15000, 0, 0, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Cast \'Infected Bite\''),
(28729, 0, 5, 0, 8, 0, 100, 0, 52343, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - On Spellhit \'Krik`Thir Subboss Aggro Trigger\' - Set In Combat With Zone'),
(28729, 0, 6, 0, 0, 0, 100, 1, 500, 500, 0, 0, 0, 0, 39, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - In Combat - Call For Help (No Repeat)'),
(28729, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 205, 0, 1, 0, 0, 0, 0, 0, 0, 'Watcher Narjil - On Aggro - Do Action ID 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28730);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28730, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 15000, 20000, 0, 0, 11, 52470, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast \'Enrage\''),
(28730, 0, 1, 0, 0, 0, 100, 0, 6000, 15000, 20000, 25000, 0, 0, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast \'Web Wrap\''),
(28730, 0, 2, 0, 0, 0, 100, 0, 4000, 12000, 9000, 15000, 0, 0, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Cast \'Infected Bite\''),
(28730, 0, 4, 0, 8, 0, 100, 0, 52343, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - On Spellhit \'Krik`Thir Subboss Aggro Trigger\' - Set In Combat With Zone'),
(28730, 0, 5, 0, 0, 0, 100, 1, 500, 500, 0, 0, 0, 0, 39, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - In Combat - Call For Help (No Repeat)'),
(28730, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 205, 0, 1, 0, 0, 0, 0, 0, 0, 'Watcher Gashra - On Aggro - Do Action ID 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28731);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28731, 0, 0, 0, 0, 0, 100, 0, 2000, 6000, 15000, 20000, 0, 0, 11, 52493, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast \'Poison Spray\''),
(28731, 0, 2, 0, 0, 0, 100, 0, 6000, 15000, 20000, 25000, 0, 0, 11, 52086, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast \'Web Wrap\''),
(28731, 0, 3, 0, 0, 0, 100, 0, 4000, 12000, 9000, 15000, 0, 0, 11, 52469, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Cast \'Infected Bite\''),
(28731, 0, 5, 0, 8, 0, 100, 0, 52343, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - On Spellhit \'Krik`Thir Subboss Aggro Trigger\' - Set In Combat With Zone'),
(28731, 0, 6, 0, 0, 0, 100, 1, 500, 500, 0, 0, 0, 0, 39, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - In Combat - Call For Help (No Repeat)'),
(28731, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 205, 0, 1, 0, 0, 0, 0, 0, 0, 'Watcher Silthik - On Aggro - Do Action ID 1');

UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 33554432 WHERE `entry` IN (28684, 31612);
