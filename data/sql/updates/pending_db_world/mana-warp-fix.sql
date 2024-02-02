--
DELETE FROM `smart_scripts` WHERE `entryorguid` = 16530 AND `source_type` = 0; 
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16530, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Warp - On Reset - Set HP Invincibility'),
(16530, 0, 1, 0, 2, 0, 100, 513, 0, 10, 0, 0, 0, 0, 11, 37079, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Warp - Between Health 0-10% - Cast Warp Breach'),
(16530, 0, 2, 0, 2, 0, 100, 513, 0, 10, 0, 0, 0, 0, 11, 29919, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Warp - Between Health 0-10% - Cast Warp Breach'),
(16530, 0, 3, 0, 2, 0, 100, 513, 0, 10, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Warp - Between Health 0-10% - Set Event Phase'),
(16530, 0, 4, 0, 0, 1, 100, 512, 2500, 2500, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Warp - In Combat - Die');
