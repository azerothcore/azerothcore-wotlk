--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 8904 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (8904, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 0, 31, 1, 5, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - On Aggro - Set Phase Random Between 1-5'),
    (8904, 0, 1, 0, 0, 1, 100, 0, 0, 0, 3000, 5000, 0, 0, 11, 14034, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - In Combat - Cast Fireball (Phase 1)'),
    (8904, 0, 2, 0, 16, 1, 100, 0, 2601, 1, 15000, 19000, 0, 0, 11, 2601, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - On Friendly Unit Missing Buff Fire Shield III - Cast Fire Shield III (Phase 1)'),
    (8904, 0, 3, 0, 0, 2, 100, 0, 0, 0, 3000, 5000, 0, 0, 11, 12471, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - In Combat - Cast Shadow Bolt (Phase 2)'),
    (8904, 0, 4, 0, 0, 2, 100, 0, 3000, 6000, 13000, 19000, 0, 0, 11, 14868, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - In Combat - Cast Curse of Agony (Phase 2)'),
    (8904, 0, 5, 0, 106, 4, 100, 0, 6000, 8000, 15000, 18000, 0, 10, 11, 11831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - In Combat - Cast Frost Nova (Phase 3)'),
    (8904, 0, 6, 0, 0, 8, 100, 0, 3000, 8000, 14000, 25000, 0, 0, 11, 11436, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - In Combat - Cast Slow (Phase 4)'),
    (8904, 0, 7, 0, 0, 16, 100, 0, 1000, 2000, 3000, 5000, 0, 0, 11, 15498, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - In Combat - Cast Holy Smite (Phase 5)'),
    (8904, 0, 8, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowforge Senator - Between 0-15% Health - Flee For Assist (No Repeat)');
