-- DB update 2023_04_04_10 -> 2023_04_04_11
--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 3) AND (`SourceEntry` = 20795) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 21027) AND (`ConditionValue2` = 35) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 20795, 0, 0, 29, 1, 21027, 35, 0, 0, 0, 0, '', 'Only run if Earthmender Wilda (21027) is within 35y');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-25120, -25121, -25122, -25123, -25124) AND `id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-25120, 0, 2, 3, 11, 0, 100, 512, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),
(-25120, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Set Fly Off'),
(-25121, 0, 2, 3, 11, 0, 100, 512, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),
(-25121, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Set Fly Off'),
(-25122, 0, 2, 3, 11, 0, 100, 512, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),
(-25122, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Set Fly Off'),
(-25124, 0, 2, 3, 11, 0, 100, 512, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),
(-25124, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Set Fly Off'),
(-25123, 0, 2, 3, 11, 0, 100, 512, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),
(-25123, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Set Fly Off');

UPDATE `smart_scripts` SET `action_param3` = 0 WHERE (`entryorguid` BETWEEN 2102900 AND 2102904) AND (`source_type` = 9) AND (`id` IN (3));

UPDATE `creature_template_movement` SET `Ground` = 1, `Flight` = 0 WHERE (`CreatureId` = 21029);
