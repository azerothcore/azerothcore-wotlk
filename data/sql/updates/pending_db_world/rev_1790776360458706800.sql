-- Hand of the Deceiver: on aggro, tell the Kil'jaeden controller to start the encounter (replaces Call For Help)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25588);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25588, 0, 0, 0, 0, 0, 100, 0, 10000, 25000, 30000, 30000, 0, 0, 11, 46875, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - In Combat - Cast Felfire Portal'),
(25588, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 12000, 12000, 0, 0, 11, 45770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - In Combat - Cast Shadow Bolt Volley'),
(25588, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 0, 11, 45772, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - Between Health 0-20% - Cast Shadow Infusion'),
(25588, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - On Aggro - Set Data 1 1 on Summoner'),
(25588, 0, 4, 0, 1, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 46757, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hand of the Deceiver - Out of Combat - Cast Shadow Channeling');
