-- Lashh'an Kalir & Lashh'an Talonite
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20109) AND (`source_type` = 0);
UPDATE `creature_template` SET `AIName` = '' WHERE (`entry` = 20109);
DELETE FROM `creature` WHERE (`id1` = 20109);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19943);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19943, 0, 0, 0, 0, 0, 100, 0, 2600, 4000, 5000, 8000, 0, 0, 11, 37685, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Talonite - In Combat - Cast \'Backstab\''),
(19943, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 34854, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Talonite - On Reset - Cast \'Lashh`an Kaliri\''),
(19943, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 8602, 0, 0, 0, 0, 0, 204, 20109, 0, 0, 0, 0, 0, 0, 0, 'Lashh\'an Talonite - On Just Died - Add Aura \'Vengeance\' to Lashh`an Kaliri');
