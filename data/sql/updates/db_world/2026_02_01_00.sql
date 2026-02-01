-- DB update 2026_01_31_03 -> 2026_02_01_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15551);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15551, 0, 0, 0, 4, 0, 30, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Stable Hand - On Aggro - Say Line 0'),
(15551, 0, 1, 0, 6, 0, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Stable Hand - On Just Died - Say Line 1'),
(15551, 0, 2, 0, 1, 0, 60, 0, 0, 70000, 80000, 190000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Stable Hand - Out of Combat - Say Line 2'),
(15551, 0, 3, 0, 0, 0, 100, 0, 2000, 11000, 12000, 21000, 0, 0, 11, 18812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Stable Hand - In Combat - Cast \'Knockdown\''),
(15551, 0, 4, 0, 0, 0, 100, 0, 2000, 15000, 17000, 28000, 0, 0, 11, 6016, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Stable Hand - In Combat - Cast \'Pierce Armor\''),
(15551, 0, 5, 0, 14, 0, 100, 0, 10000, 40, 12000, 22000, 0, 0, 11, 29339, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Stable Hand - Friendly Missing 10k HP and Near a Valid Target - Cast \'Healing Touch\''),
(15551, 0, 6, 0, 0, 0, 100, 0, 2000, 15000, 21000, 38000, 0, 0, 11, 29340, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Spectral Stable Hand - In Combat and Near a Valid Target - Cast \'Whip Rage\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (6, 7)) AND (`SourceEntry` = 15551) AND (`ConditionTypeOrReference` = 29);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 6, 15551, 0, 0, 29, 1, 15547, 20, 0, 0, 0, 0, '', 'Spectral Stable Hand Healing Touch (29339) Requires Valid Target Nearby'),
(22, 6, 15551, 0, 1, 29, 1, 15548, 20, 0, 0, 0, 0, '', 'Spectral Stable Hand Healing Touch (29339) Requires Valid Target Nearby'),
(22, 7, 15551, 0, 0, 29, 1, 15547, 20, 0, 0, 0, 0, '', 'Spectral Stable Hand Whip Rage (29340) Requires Valid Target Nearby'),
(22, 7, 15551, 0, 1, 29, 1, 15548, 20, 0, 0, 0, 0, '', 'Spectral Stable Hand Whip Rage (29340) Requires Valid Target Nearby');
