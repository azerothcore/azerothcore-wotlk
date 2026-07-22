--
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1.28968 WHERE (`entry` = 2794);

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 2715;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 2715);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2715, 1, 0, 0, 71, 0, 100, 0, 413, 0, 0, 0, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Runed Pedestal - On Event 413 (Use Enchanted Agate) - Summon Creature Group');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 2715 AND `summonerType` = 1 AND `groupId` = 0;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(2715, 1, 0, 2794, -1776.3521728515625, -1523.4576416015625, 65.00421142578125, 1.570796370506286621,    4, 60000, 'Runed Pedestal - Summoned Guardian'),
(2715, 1, 0, 2794, -1777.7584228515625, -1516.91162109375, 99.33446502685546875, 4.293509960174560546,   4, 60000, 'Runed Pedestal - Summoned Guardian'),
(2715, 1, 0, 2794, -1772.38427734375, -1522.574951171875, 75.32105255126953125, 2.129301786422729492,    4, 60000, 'Runed Pedestal - Summoned Guardian'),
(2715, 1, 0, 2794, -1748.8072509765625, -1555.64599609375, 58.52048110961914062, 4.380776405334472656,   4, 60000, 'Runed Pedestal - Summoned Guardian'),
(2715, 1, 0, 2794, -1782.6334228515625, -1508.9366455078125, 99.33446502685546875, 3.089232683181762695, 4, 60000, 'Runed Pedestal - Summoned Guardian'),
(2715, 1, 0, 2794, -1770.3160400390625, -1510.4705810546875, 90.59513092041015625, 0.890117883682250976, 4, 60000, 'Runed Pedestal - Summoned Guardian'),
(2715, 1, 0, 2794, -1758.890625, -1555.829833984375, 58.64284896850585937, 5.113814830780029296,         4, 60000, 'Runed Pedestal - Summoned Guardian');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 2715) AND (`SourceId` = 1) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 2794) AND (`ConditionValue2` = 200) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 2715, 1, 0, 29, 1, 2794, 50, 0, 1, 0, 0, '', 'Only Summon Creature Group if None are Already Spawned');
