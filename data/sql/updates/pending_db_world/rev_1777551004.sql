
-- Edit SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24824;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24824);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24824, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 17856, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Dwarf Relic - On Reset - Morph To Model 17856'),
(24824, 0, 1, 0, 8, 0, 100, 512, 44611, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Iron Dwarf Relic - On Spellhit \'Collect Data Credit\' - Despawn Instant');
