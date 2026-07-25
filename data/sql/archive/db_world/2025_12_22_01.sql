-- DB update 2025_12_22_00 -> 2025_12_22_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 15402 AND `id` IN (5, 6, 7, 8));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15402, 0, 5, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Respawn - Set Flags Immune To NPC\'s'),
(15402, 0, 6, 7, 1, 1, 100, 512, 1000, 1000, 1000, 1000, 0, 0, 80, 1540202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Out of Combat - Run Script (Phase 1)'),
(15402, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 26, 8488, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - Out of Combat - Quest Credit \'Unexpected Results\' (Phase 1)'),
(15402, 0, 8, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 211, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Apprentice Mirveda - On Initialize - Flag reset 0');

-- summons attack summoner
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1540201) AND (`source_type` = 9) AND (`id` IN (4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1540201, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 15958, 4, 15000, 0, 1, 0, 8, 0, 0, 0, 0, 8750.1, -7129.7, 35.2976, 3.8041, 'Apprentice Mirveda - Actionlist - Summon Creature \'Gharsul the Remorseless\''),
(1540201, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 15656, 4, 15000, 0, 1, 0, 8, 0, 0, 0, 0, 8753.61, -7133.15, 35, 3.8576, 'Apprentice Mirveda - Actionlist - Summon Creature \'Angershade\''),
(1540201, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 15656, 4, 15000, 0, 1, 0, 8, 0, 0, 0, 0, 8747.14, -7125.71, 35.848, 3.8576, 'Apprentice Mirveda - Actionlist - Summon Creature \'Angershade\'');

-- Remove smartAI
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 15958;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15958) AND (`source_type` = 0);
-- Delete action 'Apprentice Merveda'
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 15656) AND (`source_type` = 0) AND (`id` IN (2));

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 15402) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 7, 15402, 0, 0, 29, 0, 15958, 100, 0, 1, 0, 0, '', 'must not be near \'Gharsul the Remorseless\'');
UPDATE `conditions` SET `ConditionTarget` = 1 WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 7) AND (`SourceEntry` = 15402) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 15958) AND (`ConditionValue2` = 100) AND (`ConditionValue3` = 0);
