-- DB update 2024_01_05_03 -> 2024_01_06_00
-- Update gameobject Caribou Trap' spawns with sniffed values
SET @GO1  := 187982;
SET @GO2  := 187995;
SET @GO3  := 187996;
SET @GO4  := 187997;
SET @GO5  := 187998;
SET @GO6  := 187999;
SET @GO7  := 188000;
SET @GO8  := 188001;
SET @GO9  := 188002;
SET @GO10 := 188003;
SET @GO11 := 188004;
SET @GO12 := 188005;
SET @GO13 := 188006;
SET @GO14 := 188007;
SET @GO15 := 188008;

DELETE FROM `gameobject` WHERE (`id` IN (@GO1 , @GO2 , @GO3 , @GO4 , @GO5 , @GO6 , @GO7 , @GO8 , @GO9 , @GO10, @GO11, @GO12, @GO13, @GO14, @GO15)) AND (`guid` IN (67649, 67650, 67651, 67652, 67654, 67656, 67658, 67660, 67662, 67664, 67666, 67668, 67670, 67672, 67674));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(67649, @GO1 , 571, 0, 0, 1, 1, 3117.048583984375, 5249.89306640625, 60.58690261840820312, 2.548179388046264648, 0, 0, 0.956304550170898437, 0.292372345924377441, 120, 255, 1, "", 50664, NULL),
(67650, @GO2 , 571, 0, 0, 1, 1, 3124.70751953125, 5314.42919921875, 54.23194122314453125, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 255, 1, "", 50664, NULL),
(67651, @GO3 , 571, 0, 0, 1, 1, 3084.696533203125, 5285.15380859375, 59.66245651245117187, 0.087265998125076293, 0, 0, 0.043619155883789062, 0.999048233032226562, 120, 255, 1, "", 52237, NULL),
(67652, @GO4 , 571, 0, 0, 1, 1, 3079.166748046875, 5340.39501953125, 58.0425567626953125, 1.361356139183044433, 0, 0, 0.629320144653320312, 0.77714616060256958, 120, 255, 1, "", 52237, NULL),
(67654, @GO5 , 571, 0, 0, 1, 1, 3062.737060546875, 5236.79052734375, 65.0161895751953125, 3.769911527633666992, 0, 0, -0.95105648040771484, 0.309017121791839599, 120, 255, 1, "", 52237, NULL),
(67656, @GO6 , 571, 0, 0, 1, 1, 3030.972900390625, 5270.9775390625, 61.4695587158203125, 4.502951622009277343, 0, 0, -0.7771453857421875, 0.629321098327636718, 120, 255, 1, "", 52237, NULL),
(67658, @GO7 , 571, 0, 0, 1, 1, 3043.903564453125, 5318.7685546875, 59.84929275512695312, 3.892086982727050781, 0, 0, -0.93041706085205078, 0.366502493619918823, 120, 255, 1, "", 52237, NULL),
(67660, @GO8 , 571, 0, 0, 1, 1, 3000.58203125, 5332.9013671875, 62.8029327392578125, 4.258606910705566406, 0, 0, -0.84804725646972656, 0.529920578002929687, 120, 255, 1, "", 52237, NULL),
(67662, @GO9 , 571, 0, 0, 1, 1, 2975.4111328125, 5288.84033203125, 61.54396438598632812, 0.715584874153137207, 0, 0, 0.350207328796386718, 0.936672210693359375, 120, 255, 1, "", 52237, NULL),
(67664, @GO10, 571, 0, 0, 1, 1, 2997.2783203125, 5228.3857421875, 62.96576690673828125, 1.535889506340026855, 0, 0, 0.694658279418945312, 0.719339847564697265, 120, 255, 1, "", 52237, NULL),
(67666, @GO11, 571, 0, 0, 1, 1, 2950.942626953125, 5246.1806640625, 60.91431427001953125, 4.468043327331542968, 0, 0, -0.7880105972290039, 0.615661680698394775, 120, 255, 1, "", 52237, NULL),
(67668, @GO12, 571, 0, 0, 1, 1, 2955.75439453125, 5329.66552734375, 63.11111831665039062, 5.462882041931152343, 0, 0, -0.39874839782714843, 0.917060375213623046, 120, 255, 1, "", 52237, NULL),
(67670, @GO13, 571, 0, 0, 1, 1, 2924.13720703125, 5295.95654296875, 60.57286834716796875, 0.331610709428787231, 0, 0, 0.16504669189453125, 0.986285746097564697, 120, 255, 1, "", 52237, NULL),
(67672, @GO14, 571, 0, 0, 1, 1, 2908.415283203125, 5216.09814453125, 63.61669158935546875, 2.844882726669311523, 0, 0, 0.989015579223632812, 0.147811368107795715, 120, 255, 1, "", 52237, NULL),
(67674, @GO15, 571, 0, 0, 1, 1, 2893.058837890625, 5260.7236328125, 60.23470687866210937, 2.076939344406127929, 0, 0, 0.861628532409667968, 0.50753939151763916, 120, 255, 1, "", 52237, NULL);

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE (`entry` IN (@GO1 , @GO2 , @GO3 , @GO4 , @GO5 , @GO6 , @GO7 , @GO8 , @GO9 , @GO10, @GO11, @GO12, @GO13, @GO14, @GO15));

-- SAI copied from 187982, only comments updated with Keira 3.5.4
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND (`entryorguid` IN (@GO1 , @GO2 , @GO3 , @GO4 , @GO5 , @GO6 , @GO7 , @GO8 , @GO9 , @GO10, @GO11, @GO12, @GO13, @GO14, @GO15)));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@GO1 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO1 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO1 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO1 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO1 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO1 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO1 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO2 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO2 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO2 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO2 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO2 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO2 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO2 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO3 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO3 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO3 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO3 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO3 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO3 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO3 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO4 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO4 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO4 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO4 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO4 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO4 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO4 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO5 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO5 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO5 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO5 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO5 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO5 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO5 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO6 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO6 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO6 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO6 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO6 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO6 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO6 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO7 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO7 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO7 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO7 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO7 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO7 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO7 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO8 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO8 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO8 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO8 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO8 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO8 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO8 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO9 , 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO9 , 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO9 , 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO9 , 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO9 , 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO9 , 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO9 , 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO10, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO10, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO10, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO10, 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO10, 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO10, 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO10, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO11, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO11, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO11, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO11, 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO11, 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO11, 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO11, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO12, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO12, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO12, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO12, 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO12, 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO12, 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO12, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO13, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO13, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO13, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO13, 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO13, 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO13, 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO13, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO14, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO14, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO14, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO14, 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO14, 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO14, 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO14, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated'),
--
(@GO15, 1, 0, 1, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 50, 187983, 15, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Summon Gameobject \'High Quality Fur\''),
(@GO15, 1, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 19, 25835, 30, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Set Data 1 0'),
(@GO15, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Gossip Hello - Store Targetlist'),
(@GO15, 1, 3, 4, 38, 0, 100, 0, 2, 0, 0, 0, 0, 0, 118, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Set GO State To 0'),
(@GO15, 1, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 67, 1, 5000, 5000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Create Timed Event'),
(@GO15, 1, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 25835, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Data Set 2 0 - Quest Credit \'null\''),
(@GO15, 1, 6, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Caribou Trap - On Timed Event 1 Triggered - Set Lootstate Deactivated');

-- conditions copied from gameobject 187982
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceEntry` = 46085) AND (`ConditionTypeOrReference` = 30) AND (`ConditionValue1` IN (@GO1 , @GO2 , @GO3 , @GO4 , @GO5 , @GO6 , @GO7 , @GO8 , @GO9 , @GO10, @GO11, @GO12, @GO13, @GO14, @GO15));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 46085, 0, 0 , 30, 0, @GO1 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 1 , 30, 0, @GO2 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 2 , 30, 0, @GO3 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 3 , 30, 0, @GO4 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 4 , 30, 0, @GO5 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 5 , 30, 0, @GO6 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 6 , 30, 0, @GO7 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 7 , 30, 0, @GO8 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 8 , 30, 0, @GO9 , 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 9 , 30, 0, @GO10, 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 10, 30, 0, @GO11, 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 11, 30, 0, @GO12, 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 12, 30, 0, @GO13, 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 13, 30, 0, @GO14, 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby'),
(17, 0, 46085, 0, 14, 30, 0, @GO15, 2, 0, 0, 22, 0, '', 'Requires \'Caribou Trap\' Nearby');

-- update SAI of creature 25835 , also comments updated with Keira 3.5.4
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25835;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25835);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25835, 0, 0, 1, 38, 0, 100, 1, 1, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 20, 187983, 30, 0, 0, 1, 0, 0, 0, 'Nesingwary Trapper - On Data Set 1 0 - Move To Closest Creature \'High Quality Fur\' (No Repeat)'),
(25835, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Data Set 1 0 - Set Visibility On (No Repeat)'),
(25835, 0, 2, 3, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Respawn - Set Visibility Off'),
(25835, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Respawn - Set Reactstate Passive'),
(25835, 0, 4, 0, 34, 0, 100, 512, 8, 1, 0, 0, 0, 0, 80, 2583500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - On Reached Point 1 - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2583500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2583500, 9, 0 , 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 20, 187983, 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Orientation Closest Creature \'High Quality Fur\''),
(2583500, 9, 1 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Say Line 0'),
(2583500, 9, 2 , 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Flag Standstate Kneel'),
(2583500, 9, 3 , 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO1 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 4 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO2 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 5 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO3 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 6 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO4 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 7 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO5 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 8 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO6 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 9 , 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO7 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO8 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO9 , 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO10, 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO11, 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO12, 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 15, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO13, 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO14, 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 20, @GO15, 5, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Set Data 2 0'),
(2583500, 9, 18, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Kill Self'),
(2583500, 9, 19, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nesingwary Trapper - Actionlist - Despawn In 5000 ms');
