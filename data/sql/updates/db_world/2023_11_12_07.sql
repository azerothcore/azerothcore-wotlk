-- DB update 2023_11_12_06 -> 2023_11_12_07
-- Redeemed Hatchling SAI (Source: https://www.youtube.com/watch?v=zgalBODgYdA)
SET @ID := 22339;
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = @ID;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @ID AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ID,0,0,1,54,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Redeemed Hatchling - On Just Summoned - Set Run Off"),
(@ID,0,1,2,61,0,100,0,0,0,0,0,0,69,1,0,0,0,0,0,19,22340,0,0,0,0,0,0,0,"Redeemed Hatchling - On Link - Move To Closest Creature 'Terokkar Arakkoa Fly Target'"),
(@ID,0,2,0,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Redeemed Hatchling - On Link - Say Line 0"),
(@ID,0,3,0,34,0,100,0,8,1,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Redeemed Hatchling - On Reached Point 1 - Despawn (0)");

DELETE FROM `creature_text` WHERE `CreatureID` = @ID;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@ID,0,0,"The %s flies up through the trees, free of Terokk's corruption.",16,0,100,0,0,0,20136,0,"Redeemed Hatchling");

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 22339;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES
(22339,1,0,1,0,0,0);

-- Not necessary already has summon spell effect
UPDATE `gameobject_template` SET `AIName` = '' WHERE `entry` = 185211;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 185211);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 18521100);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 18521101);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 22337) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22337, 0, 2, 0, 1, 0, 100, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Malevolent Hatchling - Out of Combat - Start Random Movement');

DELETE FROM `gameobject` WHERE `guid` IN (26093, 26094, 26095, 2135479, 2135531, 26096, 26097, 2135504, 2135505, 2135530) AND `id` IN (185211,185210);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(26093, 185211, 530, 3519, 3686, 1, 1, -3660.15, 5811.12, 0.02822, 1.98968, 0, 0, 0.838671, 0.544639, 181, 100, 1, '', 0),
(26094, 185211, 530, 3519, 3686, 1, 1, -3678.81, 5733.74, -1.00285, 0.733038, 0, 0, 0.358368, 0.93358, 181, 100, 1, '', 0),
(26095, 185211, 530, 3519, 3686, 1, 1, -3639.31, 5831.26, 0.07337, -2.44346, 0, 0, 0.939693, -0.34202, 181, 100, 1, '', 0),
(2135479, 185211, 530, 0, 0, 1, 1, -3579.06, 5817.54, -3.24684, 3.7348, 0, 0, -0.956334, 0.292275, 181, 100, 1, '', 0),
(2135531, 185211, 530, 0, 0, 1, 1, -3674.35, 5709.55, -0.758734, 1.02344, 0, 0, -0.489679, -0.871903, 181, 100, 1, '', 0),
(26096, 185210, 530, 3519, 3686, 1, 1, -3568.34, 5772.01, -2.86157, 2.72271, 0, 0, 0.978148, 0.207912, 181, 100, 1, '', 0),
(26097, 185210, 530, 3519, 3686, 1, 1, -3560.05, 5771.58, -3.12615, -0.506145, 0, 0, 0.25038, -0.968148, 181, 100, 1, '', 0),
(2135504, 185210, 530, 0, 0, 1, 1, -3550.81, 5709.02, 0.112858, 1.5979, 0, 0, -0.716625, -0.697459, 181, 100, 1, '', 0),
(2135505, 185210, 530, 0, 0, 1, 1, -3687.46, 5732.52, -0.673687, 0.680559, 0, 0, -0.333751, -0.942661, 181, 100, 1, '', 0),
(2135530, 185210, 530, 0, 0, 1, 1, -3620.8, 5760.07, 1.91674, 5.29837, 0, 0, -0.472748, 0.881198, 181, 100, 1, '', 0);
