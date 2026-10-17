-- DB update 2025_11_28_05 -> 2025_11_28_06
--
-- Increase despawn timer
UPDATE `smart_scripts` SET `action_param3`=180000 WHERE `entryorguid` IN (-125414, -123669, -123663, -123660) AND `source_type`=0 AND `id`=0;

-- Spawn only when there's a  Wyrm Reanimator nearby
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (-125414, -123669, -123663, -123660)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 31731) AND (`ConditionValue2` = 30) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, -125414, 0, 0, 29, 1, 31731, 30, 0, 0, 0, 0, '', 'must be near \'Wyrm Reanimator\''),
(22, 1, -123669, 0, 0, 29, 1, 31731, 30, 0, 0, 0, 0, '', 'must be near \'Wyrm Reanimator\''),
(22, 1, -123663, 0, 0, 29, 1, 31731, 30, 0, 0, 0, 0, '', 'must be near \'Wyrm Reanimator\''),
(22, 1, -123660, 0, 0, 29, 1, 31731, 30, 0, 0, 0, 0, '', 'must be near \'Wyrm Reanimator\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31702);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31702, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 19, 31731, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - On Just Summoned - Store Targetlist'),
(31702, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3170200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - On Just Summoned - Run Script'),
(31702, 0, 2, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 80, 3170201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - On Reached Point 1 - Run Script'),
(31702, 0, 3, 0, 0, 0, 100, 0, 0, 5000, 5000, 15000, 0, 0, 11, 60667, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - In Combat - Cast \'Frost Breath\''),
(31702, 0, 4, 0, 17, 0, 100, 0, 31731, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - On Summoned Unit - Store Targetlist');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3170200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3170200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Set Fly On'),
(3170200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 30, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Despawn Instant'),
(3170200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 31731, 1, 120000, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Summon Creature \'Wyrm Reanimator\''),
(3170200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Set Active On'),
(3170200, 9, 4, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Move To Stored');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3170201);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3170201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 36380, 2, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Cast \'Special Unarmed\''),
(3170201, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 52391, 2, 12, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Cross Cast \'Ride Vehicle\''),
(3170201, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 2, 317020, 0, 0, 0, 1, 8, 0, 0, 0, 0, 7326.43, 1289.52, 611.652, 0, 'Frostbrood Spawn - Actionlist - Start Waypoint Path 317020'),
(3170201, 9, 3, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Despawn Instant'),
(3170201, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostbrood Spawn - Actionlist - Despawn Instant');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31731);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31731, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 15000, 15000, 0, 0, 11, 32063, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - In Combat - Cast \'Corruption\''),
(31731, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 3000, 4000, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - In Combat - Cast \'Shadow Bolt\''),
(31731, 0, 2, 0, 0, 0, 100, 0, 4000, 7000, 16000, 22000, 0, 0, 11, 11443, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - In Combat - Cast \'Cripple\''),
(31731, 0, 3, 0, 1, 1, 100, 0, 0, 0, 30000, 30000, 0, 0, 11, 59661, 0, 0, 0, 0, 0, 19, 27047, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - Out of Combat - Cast \'Icecrown Purple Beam\' (Phase 1)'),
(31731, 0, 4, 5, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 92, 0, 59661, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - On Just Summoned - Interrupt Spell \'Icecrown Purple Beam\''),
(31731, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52385, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - On Just Summoned - Cast \'Cosmetic - Periodic Cower\''),
(31731, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - On Just Summoned - Set Event Phase 2'),
(31731, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrm Reanimator - On Respawn - Set Event Phase 1');
