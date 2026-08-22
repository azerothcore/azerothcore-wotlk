-- DB update 2026_08_21_01 -> 2026_08_22_00
 -- Clientside area trigger 4089 smart ai
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 4089 AND `SourceId` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
 -- Change it so it can trigger without equipping a weapon
(22, 1, 4089, 2, 0, 2, 0, 22691, 1, 0, 0, 'Action invoker has 1 of item Corrupted Ashbringer (22691) in backpack'),
(22, 1, 4089, 2, 0, 13, 0, 2, 0, 0, 0, 'instance data 2 equals 0');

-- Change it to pause moving for 45 seconds before starting to move again
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 429400) AND (`source_type` = 9) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(429400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 54, 45000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'AshbringerEvent - Actionlist - Pause Waypoint');

-- Update the cooldown time for repeated triggers
UPDATE `smart_scripts` SET `event_flags` = (`event_flags` & ~1),
 `event_param3` = 45000,
 `event_param4` = 45000
WHERE `source_type` = 0 AND `event_type` = 8 AND `entryorguid` IN (4294,4295,4298,4299,4300,4301,4302,4303,4540);
