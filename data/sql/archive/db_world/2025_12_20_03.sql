-- DB update 2025_12_20_02 -> 2025_12_20_03
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24439);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24439, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Reset - Set Reactstate Passive'),
(24439, 0, 1, 0, 25, 0, 100, 513, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Reset - Set Event Phase 1'),
(24439, 0, 2, 0, 8, 1, 100, 1, 43770, 0, 0, 0, 0, 0, 11, 46598, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Spellhit \'Grappling Hook\' - Cast \'Ride Vehicle Hardcoded\' (Phase 1)'),
(24439, 0, 3, 0, 23, 0, 100, 513, 46598, 1, 1000, 1000, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Aura \'Ride Vehicle Hardcoded\' - Set Event Phase 2'),
(24439, 0, 4, 6, 8, 2, 100, 513, 43770, 0, 0, 0, 0, 0, 28, 46598, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Spellhit \'Grappling Hook\' - Remove Aura \'Ride Vehicle Hardcoded\' (Phase 2)'),
(24439, 0, 5, 0, 8, 0, 100, 513, 43770, 0, 0, 0, 0, 0, 33, 24439, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Spellhit \'Grappling Hook\' - Quest Credit'),
(24439, 0, 6, 0, 61, 0, 100, 513, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Spellhit \'Grappling Hook\' - Despawn In 5000 ms'),
(24439, 0, 7, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sack of Relics - On Data Set 1 1 - Set Event Phase 1');
