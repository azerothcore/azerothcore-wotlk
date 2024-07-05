-- DB update 2023_03_01_02 -> 2023_03_01_03
-- Karsius (21877)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21877);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21877, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 86, 37784, 0, 9, 21876, 0, 100, 19, 21867, 100, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Aggro - Cross Cast \'Enforced Submission\''),
(21877, 0, 1, 0, 38, 0, 100, 512, 2, 2, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Data Set 2 2 - Evade'),
(21877, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 80, 2187700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Respawn - Run Script'),
(21877, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 21872, 200, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Just Died - Set Data 1 1'),
(21877, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 21872, 200, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Evade - Set Data 2 2');

-- Karsius On Respawn
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2187700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2187700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 17, 333, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Respawn - Set Emote State 333'),
(2187700, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Respawn - Set Unit Flags'),
(2187700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 19, 21867, 0, 0, 0, 0, 0, 0, 0, 'Karsius the Ancient Watcher - On Respawn - Set Unit Flags');

-- Success Event (On Karsius Death)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2187200, 2187201, 2187202));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Set Event Phase for success
(2187200, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 21877, 100, 1, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Death - Say Line 1'),
(2187200, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 21876, 0, 200, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Death - Despawn Chain of Shadows'),
(2187200, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 21867, 0, 0, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Death - Set Data 1 1'),
(2187200, 9, 3, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 28, 37782, 0, 0, 0, 0, 0, 17, 0, 200, 0, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Death - Remove Aura \'Serverside - Disembodied Spirit\''),
(2187200, 9, 4, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 28, 37748, 0, 0, 0, 0, 0, 17, 0, 200, 0, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Death - Remove Aura \'Teron Gorefiend\''),
(2187200, 9, 5, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 28, 37748, 0, 0, 0, 0, 0, 9, 21867, 0, 200, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Death - Remove Aura \'Teron Gorefiend\''),
(2187200, 9, 6, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 19, 21877, 100, 1, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Death - Despawn'),

-- Failure Event 1 (Evade)
-- Set Event Phase
(2187201, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 21877, 100, 0, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Evade - Say Line 2'),
(2187201, 9, 1, 0, 0, 0, 100, 512, 1200, 1200, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 9, 21876, 0, 200, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Evade - Despawn Instant'),
(2187201, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 21797, 0, 1, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Evade - Despawn Instant'),
(2187201, 9, 3, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 21867, 0, 1, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Evade - Despawn Instant'),
(2187201, 9, 4, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 21877, 100, 0, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Karsius Evade - Despawn Instant');

-- Teron Gorefiend (21867)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21867);

-- Ancient Shadowmoon Spirit (21797)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21797);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21797, 0, 0, 1, 19, 0, 100, 512, 10645, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Quest \'Teron Gorefiend, I am...\' Taken - Store Targetlist'),
(21797, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 80, 2179700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Quest \'Teron Gorefiend, I am...\' Taken - Run Script'),
(21797, 0, 2, 3, 19, 0, 100, 512, 10639, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Quest \'Teron Gorefiend, I am...\' Taken - Store Targetlist'),
(21797, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 80, 2179700, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Quest \'Teron Gorefiend, I am...\' Taken - Run Script'),
(21797, 0, 4, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 2179701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Data Set - Run Script 2'),
(21797, 0, 5, 0, 40, 0, 100, 512, 3, 21867, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Reached WP7 - Despawn'),
(21797, 0, 6, 7, 6, 0, 100, 512, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 21877, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Death - Set Data 2 2 on Karsius the Ancient Watcher'),
(21797, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 28, 37782, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Just Died - Remove Aura Disembodied Spirit'),
(21797, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 28, 37748, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Just Died - Remove Aura Teron Gorefiend'),
(21797, 0, 9, 0, 60, 1, 100, 513, 300000, 300000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - On Update - Despawn Instant (Phase 1) (No Repeat)');

-- The Voice of Gorefiend (21872)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21872;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21872);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21872, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2187200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Data Set 1 1 - Run Success Script'),
(21872, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 80, 2187201, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Voice of Gorefiend - On Data Set 2 2 - Run Failure Script');

-- Script Start
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2179700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2179700, 9, 0 , 0, 0, 0, 100, 0, 1400, 1400, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Orientation Player (Stored)'),
(2179700, 9, 1 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0'),
(2179700, 9, 2 , 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 36, 21867, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Update Template To \'Teron Gorefiend\''),
(2179700, 9, 3 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Flags Immune To Players'),
(2179700, 9, 4 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Npc Flag '),
(2179700, 9, 5 , 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 75, 37782, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Add Aura \'Serverside - Disembodied Spirit\''),
(2179700, 9, 6 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 85, 37769, 2, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Invoker Cast \'Serverside - Teron Gorefiend\''),
(2179700, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Event Phase 1'),
(2179700, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 37789, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Cast \'Teron Freed\''),
(2179700, 9, 9, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 12, 21877, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -4535.79, 1029.28, 8.83636, 3.78736, 'Ancient Shadowmoon Spirit - Actionlist - Summon Creature \'Karsius the Ancient Watcher\''),
(2179700, 9, 10, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 21877, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0'),
(2179700, 9, 11, 0, 0, 0, 100, 512, 9000, 9000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 21872, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0');

-- Script End Event
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2179701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2179701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Evade'),
(2179701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Set Event Phase 0'),
(2179701, 9, 2, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 43, 0, 10720, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Mount To Model 10720'),
(2179701, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 0'),
(2179701, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Say Line 1'),
(2179701, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 53, 1, 21867, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ancient Shadowmoon Spirit - Actionlist - Start Waypoint');

-- Cleanup Chain of Shadows Script
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 21876) AND (`source_type` = 0) AND (`id` IN (3));
