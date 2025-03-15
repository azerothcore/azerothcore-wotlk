DELETE FROM `creature_text` WHERE `CreatureID`=15693;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(15693, 0, 0, '$n, Champion of the Bronze Dragonflight, has rung the Scarab Gong. The ancient gates of Ahn\'Qiraj open, revealing the horrors of a forgotten war...', 16, 0, 100, 1, 0, 0, 11427, 4, 'EMOTE_AQ_GONG_1'),
(15693, 1, 0, 'Massive Qiraji resonating crystals break through the earthen crust of Kalimdor. Colossal creatures made of obsidian stone breach the freshly broken land...', 16, 0, 100, 1, 0, 0, 11432, 4, 'EMOTE_AQ_GONG_2'),
(15693, 2, 0, 'Colossus of Zora casts its massive shadow upon the whole of Silithus.', 16, 0, 100, 1, 0, 0, 0, 4, 'EMOTE_AQ_GONG_3'),
(15693, 3, 0, 'Colossus of Ashi breaks free of its cocoon beneath Hive\'Ashi.', 16, 0, 100, 1, 0, 0, 0, 4, 'EMOTE_AQ_GONG_4'),
(15693, 4, 0, 'Colossus of Regal hears the call to battle and rises to serve its master.', 16, 0, 100, 1, 0, 0, 0, 4, 'EMOTE_AQ_GONG_5');

DELETE FROM `gameobject_queststarter` WHERE `id` = 180718;
INSERT INTO `gameobject_queststarter` (`id`, `quest`) VALUES
(180718, 8743);

DELETE FROM `gameobject_questender` WHERE `id` = 180718;
INSERT INTO `gameobject_questender` (`id`, `quest`) VALUES
(180718, 8743);

UPDATE `gameobject_template` SET `type` = 2 WHERE `entry` = 180718;

UPDATE `gameobject_template_addon` SET `flags` = 16 WHERE `entry` = 180810;

-- remove flag CREATURE_FLAG_EXTRA_INSTANCE_BIND
UPDATE `creature_template` SET `flags_extra` = `flags_extra` & ~(1) WHERE `entry` = 15818;

DELETE FROM `creature` WHERE `id1` IN (15810, 15813, 15742, 15741, 15740, 15758, 15818);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(311600,15810,0,0,1,0,0,1,1,0,4386.996582, 550.179260, 54.762119, 0.581150,1800,5,0,0,0,1,0,0,0,'',0),
(311601,15810,0,0,1,0,0,1,1,0,4388.178711, 513.457581, 53.590897, 3.921458,1800,5,0,0,0,1,0,0,0,'',0),
(311602,15810,0,0,1,0,0,1,1,0,4356.629395, 519.999329, 58.591854, 3.295495,1800,5,0,0,0,1,0,0,0,'',0),
(311603,15810,0,0,1,0,0,1,1,0,4361.684570, 558.289734, 56.632832, 4.635385,1800,5,0,0,0,1,0,0,0,'',0),
(311604,15813,0,0,1,0,0,1,1,0,4372.355957, 536.665649, 59.118938, 4.758702,1800,0,0,0,0,0,0,0,0,'',0), -- boss darkshore 1

(311605,15810,0,0,1,0,0,1,1,0, 5083.312988, 90.152863, 45.683632, 4.534914,1800,5,0,0,0,1,0,0,0,'',0),
(311606,15810,0,0,1,0,0,1,1,0, 5057.701660, 83.685188, 49.825253, 3.410223,1800,5,0,0,0,1,0,0,0,'',0),
(311607,15810,0,0,1,0,0,1,1,0, 5046.050781, 122.508644, 43.164379, 2.331871,1800,5,0,0,0,1,0,0,0,'',0),
(311608,15810,0,0,1,0,0,1,1,0, 5071.985840, 138.409653, 41.266869, 0.861605,1800,5,0,0,0,1,0,0,0,'',0),
(311609,15813,0,0,1,0,0,1,1,0, 5064.384277, 107.279877, 42.528320, 3.140021,1800,0,0,0,0,0,0,0,0,'',0), -- boss darkshore 2

(311610,15810,0,0,1,0,0,1,1,0, 6409.220215, 4.401052, 30.286741, 2.987807,1800,5,0,0,0,1,0,0,0,'',0),
(311611,15810,0,0,1,0,0,1,1,0, 6424.186035, 30.883730, 27.005314, 0.934775,1800,5,0,0,0,1,0,0,0,'',0),
(311612,15810,0,0,1,0,0,1,1,0, 6454.531738, 28.456089, 31.199347, 0.068485,1800,5,0,0,0,1,0,0,0,'',0),
(311613,15810,0,0,1,0,0,1,1,0, 6453.624023, -5.977130, 28.319181, 5.131168,1800,5,0,0,0,1,0,0,0,'',0),
(311614,15813,0,0,1,0,0,1,1,0, 6434.273438, 12.233818, 26.357977, 0.805967,1800,0,0,0,0,0,0,0,0,'',0), -- boss darkshore 3

(311615,15742,0,0,1,0,0,1,1,0, -6458.704590, 1076.014282, -2.896275, 4.052591,3600,0,1,0,0,2,0,0,0,'',0), -- Colossus of Ashi
(311616,15741,0,0,1,0,0,1,1,0, -7922.958008, 625.548523, -29.006325, 0.844522,3600,0,1,0,0,2,0,0,0,'',0), -- Colossus of Regal
(311617,15740,0,0,1,0,0,1,1,0, -7461.777832, 1611.004272, -48.327751, 0.616755,3600,0,1,0,0,2,0,0,0,'',0), -- Colossus of Zora

(311618,15758,0,0,1,0,0,1,1,0,-7623.261719, 1416.035767, 4.126772,  4.945646,1800,5,0,0,0,1,0,0,0,'',0),
(311619,15758,0,0,1,0,0,1,1,0,-7659.168457, 1392.619751, 3.995544, 3.687438,1800,5,0,0,0,1,0,0,0,'',0),
(311620,15758,0,0,1,0,0,1,1,0,-7688.503418, 1428.886963, 3.855407, 2.550966,1800,5,0,0,0,1,0,0,0,'',0),
(311621,15758,0,0,1,0,0,1,1,0, -7652.402344, 1464.758667, 4.526736, 0.600033,1800,5,0,0,0,1,0,0,0,'',0),
(311622,15818,0,0,1,0,0,1,1,1, -7644.985840, 1422.093628, 3.326948, 5.378395,1800,0,0,0,0,0,0,0,0,'',0), -- boss Silithus 1

(311623,15758,0,0,1,0,0,1,1,0, -7806.652832, 855.699951, -4.778733, 0.353429,1800,5,0,0,0,1,0,0,0,'',0),
(311624,15758,0,0,1,0,0,1,1,0, -7831.444336, 808.078979, -9.832852, 4.501119,1800,5,0,0,0,1,0,0,0,'',0),
(311625,15758,0,0,1,0,0,1,1,0, -7881.184082, 864.466614, -1.765002, 2.737900,1800,5,0,0,0,1,0,0,0,'',0),
(311626,15758,0,0,1,0,0,1,1,0, -7832.478027, 912.945801, -2.498297, 0.817600,1800,5,0,0,0,1,0,0,0,'',0),
(311627,15818,0,0,1,0,0,1,1,1, -7830.405273, 851.316223, -4.844313, 4.929938,1800,0,0,0,0,0,0,0,0,'',0), -- boss Silithus 2

(311628,15758,0,0,1,0,0,1,1,0,-6290.943848, 736.276489, 11.109619, 5.837865,1800,5,0,0,0,1,0,0,0,'',0),
(311629,15758,0,0,1,0,0,1,1,0,-6303.743652, 703.045105, 11.219690, 4.562379,1800,5,0,0,0,1,0,0,0,'',0),
(311630,15758,0,0,1,0,0,1,1,0, -6349.953613, 715.365662, 2.037906, 3.263330,1800,5,0,0,0,1,0,0,0,'',0),
(311631,15758,0,0,1,0,0,1,1,0, -6346.292969, 777.375793, 1.782544, 1.899878,1800,5,0,0,0,1,0,0,0,'',0),
(311632,15818,0,0,1,0,0,1,1,1, -6322.091797, 738.599060, 8.332182, 2.500710,1800,0,0,0,0,0,0,0,0,'',0); -- boss Silithus 3

DELETE FROM `pool_template` WHERE `entry` IN (15813, 15818);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(15813, 1, "AQ War Event Darkshore Boss"),
(15818, 1, "AQ War Event Silithus Boss");

DELETE FROM `pool_creature` WHERE `pool_entry` = 15813;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(311604, 15813, 0, 'AQ War Event Darkshore Boss'),
(311609, 15813, 0, 'AQ War Event Darkshore Boss'),
(311614, 15813, 0, 'AQ War Event Darkshore Boss'),
(311622, 15813, 0, 'AQ War Event Silithus Boss'),
(311627, 15813, 0, 'AQ War Event Slithus Boss'),
(311632, 15813, 0, 'AQ War Event Silithus Boss');

DELETE FROM `gameobject` WHERE `guid` IN (105000, 105001, 105002, 105003, 105004, 105005);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(105000, 180810, 1, 0, 0, 1, 1, 6431.208496, 7.873897, 25.929821, 6.005887, 0, 0, 0, 0, 3600, 255, 1, '', 0),
(105001, 180810, 1, 0, 0, 1, 1, 5070.317383, 106.293625, 42.326523, 3.869612, 0, 0, 0, 0, 3600, 255, 1, '', 0),
(105002, 180810, 1, 0, 0, 1, 1, 4370.228027, 540.763245, 59.281170, 6.165329, 0, 0, 0, 0, 3600, 255, 1, '', 0),
-- Silithus
(105003, 180810, 1, 0, 0, 1, 1, -7648.079590, 1426.084717, 2.876715, 3.538846, 0, 0, 0, 0, 3600, 255, 1, '', 0),
(105004, 180810, 1, 0, 0, 1, 1, -7831.400879, 857.148376, -4.281037, 1.477178, 0, 0, 0, 0, 3600, 255, 1, '', 0),
(105005, 180810, 1, 0, 0, 1, 1, -6317.880371, 738.097473, 9.361129, 2.939591, 0, 0, 0, 0, 3600, 255, 1, '', 0);


-- Colossus of Ashi pathing
SET @NPC := 15742;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -6497.195801, 1021.785889, 0.376532, 4.003111, 0, 0, 0, 100, 0),
(@PATH, 2, -6540.536133, 985.638306, 0.376532, 3.593430, 0, 0, 0, 100, 0),
(@PATH, 3, -6610.057617, 924.652832, 0.373520, 3.076638, 0, 0, 0, 100, 0),
(@PATH, 4, -6669.620117, 922.713989, -0.686892, 3.683748, 0, 0, 0, 100, 0),
(@PATH, 5, -6704.018555, 899.425293, -1.393676, 4.236665, 0, 0, 0, 100, 0),
(@PATH, 6, -4953.628418, -1206.568237, 501.659943, 5.093306, 0, 0, 0, 100, 0),
(@PATH, 7, -4944.017578, -1226.812378, 501.659241, 4.541171, 0, 0, 0, 100, 0),
(@PATH, 8, -4951.852051, -1236.240234, 501.664520, 3.806038, 0, 0, 0, 100, 0),
(@PATH, 9, -4944.017578, -1226.812378, 501.659241, 4.541171, 0, 0, 0, 100, 0),
(@PATH, 10, -4953.628418, -1206.568237, 501.659943, 5.093306, 0, 0, 0, 100, 0),
(@PATH, 11, -6704.018555, 899.425293, -1.393676, 4.236665, 0, 0, 0, 100, 0),
(@PATH, 12, -6669.620117, 922.713989, -0.686892, 3.683748, 0, 0, 0, 100, 0),
(@PATH, 13, -6610.057617, 924.652832, 0.373520, 3.076638, 0, 0, 0, 100, 0),
(@PATH, 14, -6540.536133, 985.638306, 0.376532, 3.593430, 0, 0, 0, 100, 0),
(@PATH, 15, -6497.195801, 1021.785889, 0.376532, 4.003111, 0, 0, 0, 100, 0);

DELETE FROM `creature_template_addon` WHERE `entry` IN (@NPC);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@NPC,@PATH,0,0,1,0,3, '');

-- Colossus of Regal
SET @NPC := 15741;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -7870.958496, 687.510498, -27.781849, 0.293172, 0, 0, 0, 100, 0),
(@PATH, 2, -7791.520996, 727.871521, -37.473316, 0.432190, 0, 0, 0, 100, 0),
(@PATH, 3,  -7720.165039, 719.385498, -41.306274, 5.582830, 0, 0, 0, 100, 0),
(@PATH, 4, -7637.914551, 609.112854, -51.588173, 5.230968, 0, 0, 0, 100, 0),
(@PATH, 5,  -7720.165039, 719.385498, -41.306274, 5.582830, 0, 0, 0, 100, 0),
(@PATH, 6, -7791.520996, 727.871521, -37.473316, 0.432190, 0, 0, 0, 100, 0),
(@PATH, 7, -7870.958496, 687.510498, -27.781849, 0.293172, 0, 0, 0, 100, 0);

DELETE FROM `creature_template_addon` WHERE `entry` IN (@NPC);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@NPC,@PATH,0,0,1,0,3, '');

-- Colossus of Zora
SET @NPC := 15740;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(@PATH, 1, -7418.407227, 1649.863770, -32.103611, 1.029089, 0, 0, 0, 100, 0),
(@PATH, 2, -7409.972656, 1705.264404, -36.461433, 1.437496, 0, 0, 0, 100, 0),
(@PATH, 3, -7352.450684, 1710.901733, -38.267399, 5.460305, 0, 0, 0, 100, 0),
(@PATH, 4, -7329.275391, 1640.641968, -32.322731, 5.153214, 0, 0, 0, 100, 0),
(@PATH, 5, -7299.695801, 1599.568481, -30.213583, 5.754819, 0, 0, 0, 100, 0),
(@PATH, 6, -7250.575195, 1534.470459, -10.517513, 5.041683, 0, 0, 0, 100, 0),
(@PATH, 7, -7299.695801, 1599.568481, -30.213583, 5.754819, 0, 0, 0, 100, 0),
(@PATH, 8, -7329.275391, 1640.641968, -32.322731, 5.153214, 0, 0, 0, 100, 0),
(@PATH, 9, -7352.450684, 1710.901733, -38.267399, 5.460305, 0, 0, 0, 100, 0),
(@PATH, 10, -7409.972656, 1705.264404, -36.461433, 1.437496, 0, 0, 0, 100, 0),
(@PATH, 11, -7418.407227, 1649.863770, -32.103611, 1.029089, 0, 0, 0, 100, 0);

DELETE FROM `creature_template_addon` WHERE `entry` IN (@NPC);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(@NPC,@PATH,0,0,1,0,3, '');

UPDATE `creature_text` SET `TextRange` = 4 WHERE `CreatureID` = 15341 AND `GroupID` = 12;

DELETE FROM `creature_loot_template` WHERE `entry` = 15740;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(15740, 14555, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 3475, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 1728, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 811, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 1263, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 14554, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 647, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 2099, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 944, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 2243, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 2245, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 1443, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 2244, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 14558, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 833, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 2246, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 14553, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 1168, 0, 0, 0, 1, 1, 1, 1, 'Colossus of Zora, Regal, Ashi - Epic'),
(15740, 13036, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13126, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13009, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13120, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13075, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13133, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13123, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 9402, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13013, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13125, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 2564, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13077, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13040, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13067, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13003, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13135, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13007, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13107, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13106, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13073, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13111, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13070, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13015, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13144, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13118, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13146, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13116, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13000, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13072, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 6622, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13060, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13004, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13047, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13130, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13066, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 1203, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13096, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13030, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13083, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13085, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13002, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 4496, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13001, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 13091, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 1973, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 7734, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue'),
(15740, 11302, 0, 0, 0, 1, 2, 1, 1, 'Colossus of Zora, Regal, Ashi - Blue');

DELETE FROM `creature_loot_template` WHERE `entry` IN (15741, 15742);

UPDATE `creature_template` SET `LootId` = 15740 WHERE `entry` IN (15740, 15741, 15742);

UPDATE `creature_template` SET `maxgold` = 23909 WHERE `entry` = 15758; -- previously 83909
