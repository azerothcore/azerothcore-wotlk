-- DB update 2023_08_12_02 -> 2023_08_13_00
--
DELETE FROM `event_scripts` WHERE `id` = 14376;

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 185220;
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 185220);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(185220, 1, 0, 0, 70, 0, 100, 0, 2, 0, 0, 0, 0, 107, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Massive Treasure Chest - On Gameobject State Changed - Summon Creature Group');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 185220);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 185220, 1, 0, 29, 1, 22369, 100, 0, 1, 0, 0, '', 'Only Spawn Dread Relic Thrall (22369) if none are nearby already');

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 185220;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `summonType`, `summonTime`, `Comment`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3750.57, 4737.88, -19.35, 4.01853),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3744.9, 4736.18, -18.717, 2.8797),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3773.46, 4720.45, -21.5752, 1.44792),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3773.85, 4715.78, -21.6975, 1.45735),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3774.08, 4710.46, -21.7888, 0.492878),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3774.95, 4704.25, -21.977, 0),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3772.26, 4699.55, -21.3722, 0.111175),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3769.89, 4694.89, -20.7665, 0.406484),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3767.46, 4691.24, -20.1502, 6.20901),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3763.69, 4688.06, -19.2893, 0.613044),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3760.22, 4685.72, -18.5906, 0.334227),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3756.1, 4683.74, -17.9125, 0.734772),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3751.6, 4682.35, -17.3406, 1.57044),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3746.76, 4682.73, -16.8866, 1.93172),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3742.75, 4684.69, -16.6026, 1.98513),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3739.15, 4687.17, -16.4299, 1.88145),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3736.77, 4689.91, -16.3146, 2.49721),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3733.74, 4693.02, -16.24, 2.487),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3764.99, 4733.9, -20.6666, 5.65487),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3770.51, 4728.37, -21.0502, 0),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3767.97, 4731.29, -20.9252, 4.03171),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3772.36, 4724.78, -21.3002, 5.81195),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3731.43, 4697.39, -16.1774, 2.74225),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3729.91, 4701.97, -16.1335, 3.04384),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3729.4, 4706.81, -16.1222, 3.61561),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3760.43, 4736.39, -20.2451, 4.01068),
(185220, 1, 1, 22369, 4, 300000, 'Massive Chest - Quest: The Dread Relic', -3755.66, 4737.93, -19.8168, 4.3861);
