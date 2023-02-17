-- DB update 2023_02_17_04 -> 2023_02_17_05
-- Delete old stuff
DELETE FROM `creature` WHERE `id1` IN (21797, 22395, 21872, 22417) AND `guid` IN (86139, 78730, 78756, 78757, 76573);

-- New Altar of Shadows
DELETE FROM `gameobject` WHERE `guid`=25598 AND `id`=184738;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(25598, 184738, 530, 3520, 3944, 1, 1, -4547.79541015625, 1018.7100830078125, 10.07028961181640625, 3.900815248489379882, -0.02837467193603515, -0.0582284927368164, -0.92608070373535156, 0.371724128723144531, 120, 255, 1, 48069);

-- New Creatures
SET @CGUID := 100050;

DELETE FROM `creature` WHERE `id1` IN (21797, 22395, 21872, 22417);
DELETE FROM `creature` WHERE `id1` IN (21797, 22395, 21872, 22417) AND `guid` BETWEEN @CGUID+0 AND @CGUID+4;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 21797, 530, 3520, 3944, 1, 1, 0, -4543.6923828125, 1022.35357666015625, 9.979041099548339843, 3.874630928039550781, 120, 0, 0, 10175, 5325, 0, 0, 0, 0, 48069),
(@CGUID+1, 21872, 530, 3520, 3944, 1, 1, 0, -4540.8115234375, 1018.708984375, 10.46528816223144531, 5.777040004730224609, 120, 0, 0, 2035, 0, 0, 0, 0, 0, 48069),
(@CGUID+2, 22395, 530, 3520, 3944, 1, 1, 0, -4546.8544921875, 1019.9014892578125, 10.90510845184326171, 0.715584993362426757, 120, 0, 0, 2035, 0, 0, 0, 0, 0, 48069),
(@CGUID+3, 22417, 530, 3520, 3944, 1, 1, 0, -4559.91357421875, 1031.919189453125, 20.39095115661621093, 5.462880611419677734, 120, 0, 0, 2035, 0, 0, 0, 0, 0, 48069),
(@CGUID+4, 22417, 530, 3520, 3944, 1, 1, 0, -4532.3037109375, 1004.79168701171875, 22.8793182373046875, 2.39110112190246582, 120, 0, 0, 2035, 0, 0, 0, 0, 0, 48069);
-- (@CGUID+5, 21877, 530, 3520, 3944, 1, 1, 0, -4535.7939453125, 1029.2843017578125, 8.836360931396484375, 3.787364482879638671, 120, 0, 0, 5088, 1704, 0, 0, 0, 0, 48069), -- Tarsius

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2179700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2179700, 9, 0 , 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Orientation Player (Stored)'),
(2179700, 9, 1 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0'),
(2179700, 9, 3 , 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 36, 21867, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Update Template To \'Teron Gorefiend\''),
(2179700, 9, 4 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Flags Immune To Players'),
(2179700, 9, 5 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Npc Flag '),
(2179700, 9, 6 , 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 75, 37782, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Add Aura \'Serverside - Disembodied Spirit\''),
(2179700, 9, 7 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 85, 37769, 2, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Invoker Cast \'Serverside - Teron Gorefiend\''),
(2179700, 9, 8 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 37728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Cast \'Haste\''),
(2179700, 9, 9 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 37789, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Cast \'Teron Freed\''),
(2179700, 9, 10, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 12, 21877, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -4535.79, 1029.28, 8.83636, 3.78736, 'Ancient Shadowmoon Spirit - Actionlist - Summon Creature \'Karsius the Ancient Watcher\''),
(2179700, 9, 11, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 21877, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0'),
(2179700, 9, 12, 0, 0, 0, 100, 512, 9000, 9000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 21872, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0');

-- Remove invisibility aura from Karsius (not in sniff)
UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` = 21877);

-- Change type for one of Teron's texts
UPDATE `creature_text` SET `Type`=12 WHERE `CreatureID`=21797 AND `GroupID`=0;

-- Add missing line when Event fails
DELETE FROM `creature_text` WHERE `CreatureID`=21877 AND `Text`='Let this be a lesson to those that would do evil to our lands!';
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `Text`, `Type`, `Probability`, `BroadcastTextId`, `comment`) VALUES
(21877, 2, 'Let this be a lesson to those that would do evil to our lands!', 14, 100, 19505, 'Karsius the Ancient Watcher when Teron Dies');

UPDATE `smart_scripts` SET `link`=15 WHERE (`entryorguid` = 21877) AND (`source_type` = 0) AND (`id` IN (10));

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21877) AND (`source_type` = 0) AND (`id` IN (15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21877, 0, 15, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Evade - Say Line 2');

-- Chain of Shadows only spam Enforced Submission on aggro
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21876;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21876);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21876, 0, 0, 1, 11, 0, 100, 1, 0, 0, 0, 0, 0, 11, 37761, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chain of Shadows - On Respawn - Cast \'Ancient Draenei Warden\' (No Repeat)'),
(21876, 0, 1, 0, 61, 0, 100, 1, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chain of Shadows - On Respawn - Set Emote State 333 (No Repeat)'),
(21876, 0, 2, 0, 1, 0, 33, 0, 8000, 21000, 8000, 21000, 0, 11, 37784, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chain of Shadows - Out of Combat - Cast \'Enforced Submission\''),
(21876, 0, 3, 0, 38, 0, 100, 1, 1, 1, 0, 0, 0, 11, 37784, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Chain of Shadows - On Data Set 1 1 - Cast \'Enforced Submission\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21877) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21877, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 21876, 0, 200, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Aggro - Chain of Shadows Casts Enforced Submission');

-- Improve ending
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21877) AND (`source_type` = 0) AND (`id` IN (13, 16));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21877, 0, 13, 16, 61, 0, 100, 512, 0, 0, 0, 0, 0, 28, 37748, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - Just Died - Remove Aura Teron Gorefiend from Player'),
(21877, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 28, 37748, 0, 0, 0, 0, 0, 9, 21867, 0, 200, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - Just Died - Remove Aura Teron Gorefiend from Teron Gorefiend');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21867);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21867, 0, 0, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Teron Gorefiend - On Data Set 1 1 - Set Event Phase 1'),
(21867, 0, 1, 0, 1, 0, 100, 513, 1200, 1200, 0, 0, 0, 80, 2179701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Teron Gorefiend - Out of Combat - Run Script (No Repeat)'),
(21867, 0, 2, 0, 1, 0, 100, 513, 300000, 300000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Teron Gorefiend - Out of Combat - Despawn Instant (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2179701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2179701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Evade'),
(2179701, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 43, 0, 10720, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Mount To Model 10720'),
(2179701, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0'),
(2179701, 9, 3, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 1'),
(2179701, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 53, 1, 21867, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Start Waypoint');
