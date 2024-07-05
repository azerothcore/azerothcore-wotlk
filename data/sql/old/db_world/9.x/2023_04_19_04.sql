-- DB update 2023_04_19_03 -> 2023_04_19_04
-- 21767 (Harbinger of the Raven)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21767);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21767, 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, 0, 1, 0, 7000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Just Summoned - Say Line 0'),
(21767, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Just Summoned - Set Gravity Off'),
(21767, 0, 2, 0, 60, 0, 100, 257, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3211, 5348.21, 146.53, 5.54, 'Harbinger of the Raven - On Update - Move To Position'),
(21767, 0, 3, 4, 52, 0, 100, 0, 0, 21767, 0, 0, 0, 11, 37446, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Cast Ruuan ok Oracle Transformation'),
(21767, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 2, 954, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Set Faction'),
(21767, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Set Reactstate Aggressive'),
(21767, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Attack Start'),
(21767, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 210, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text Over Line 0 - Move Fall'),
(21767, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Text 0 Over - Set Gravity On'),
(21767, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 3211, 5348.21, 144.53, 5.54, 'Harbinger of the Raven - On Text 0 Over - Set Home Position'),
(21767, 0, 10, 0, 7, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - On Evade - Despawn Instant'),
(21767, 0, 11, 0, 1, 0, 100, 512, 15000, 15000, 15000, 15000, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Harbinger of the Raven - Out of Combat 15s - Despawn Instant');
