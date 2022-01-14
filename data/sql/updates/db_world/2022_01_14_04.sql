-- DB update 2022_01_14_03 -> 2022_01_14_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_14_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_14_03 2022_01_14_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641389002880170100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641389002880170100');

SET @SPIRESTONE_WARLORD = 9216;
SET @SMOLDERTHORN_BERSERKER = 9268;
SET @BLOODAXE_VETERAN = 9583;
SET @BLOODAXE_EVOKER = 9693;

-- Clearing up un-desired entries
DELETE FROM `creature` WHERE `guid` IN (45818, 45810, 45812, 45822, 45821, 45820, 45811, 45819, 45809, 45815, 45816, 45813, 45814, 45817);

-- Update Overlord Wyrmthalak position according to sniffs
UPDATE `creature` SET `position_x` = -22.6325, `position_y` = -486.186, `position_z` = 90.7531, `orientation` = 3.14159 WHERE `guid` = 45757;

-- Spirestone Warlord
-- Health modifier is 1.35 which according to video, health should be 14355 maximum (these values are on vmangos db too)
DELETE FROM `creature` WHERE `creature_id1` IN (@SPIRESTONE_WARLORD);
INSERT INTO `creature` (`guid`, `creature_id1`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `curhealth`) VALUES 
(24181, @SPIRESTONE_WARLORD, 229, -79.4547, -523.615, 82.6267, 0.80285, 7200, 0, 10633),
(24182, @SPIRESTONE_WARLORD, 229, -56.9907, -427.546, 77.8323, 1.44862, 7200, 0, 8883),
(24183, @SPIRESTONE_WARLORD, 229, -20.5394, -390.931, 48.5351, 3.01552, 10800, 0, 10633),
(24184, @SPIRESTONE_WARLORD, 229, -22.0032, -343.162, 31.6102, 5.37632, 10800, 0, 10633),
(24185, @SPIRESTONE_WARLORD, 229, -40.7202, -361.08, 31.6183, 4.6267, 10800, 0, 10633),
(24186, @SPIRESTONE_WARLORD, 229, -31.6468, -380.597, 31.6183, 4.68053, 10800, 0, 10633),
(24187, @SPIRESTONE_WARLORD, 229, -55.7517, -369.555, 52.4265, 6.10359, 10800, 0, 10633),
(24188, @SPIRESTONE_WARLORD, 229, -34.5044, -370.328, 50.3211, 3.8986, 10800, 0, 10633);

-- Smolderthorn Berserker
DELETE FROM `creature` WHERE `creature_id1` IN (@SMOLDERTHORN_BERSERKER);
INSERT INTO `creature` (`guid`, `creature_id1`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `curhealth`) VALUES 
(42188, @SMOLDERTHORN_BERSERKER, 229, -77.5619, -516.932, 81.4632, 4.5204, 7200, 0, 8613),
(42189, @SMOLDERTHORN_BERSERKER, 229, -63.3201, -485.629, 77.9991, 0.85521, 7200, 0, 8613),
(42190, @SMOLDERTHORN_BERSERKER, 229, -49.6838, -514.303, 88.396, 5.44524, 7200, 0, 8613),
(42191, @SMOLDERTHORN_BERSERKER, 229, -41.2549, -448.49, -18.6442, 3.89064, 10800, 0, 8613),
(42192, @SMOLDERTHORN_BERSERKER, 229, -0.63, -482, -18.62, 4.06, 10800, 0, 8613),
(42193, @SMOLDERTHORN_BERSERKER, 229, -4.77, -517.7, -6.96, 2.78, 10800, 0, 8613),
(42194, @SMOLDERTHORN_BERSERKER, 229, -19.2055, -557.706, -18.7785, 3.00598, 10800, 0, 8613),
(42195, @SMOLDERTHORN_BERSERKER, 229, -64.9942, -490.286, -18.7951, 6.17529, 10800, 0, 8613),
(42196, @SMOLDERTHORN_BERSERKER, 229, -64.9189, -538.769, -18.798, 0.177575, 10800, 0, 8613),
(42197, @SMOLDERTHORN_BERSERKER, 229, -77.47, -513.12, -6.96, 6.1, 10800, 0, 8613),
(42198, @SMOLDERTHORN_BERSERKER, 229, -64.8845, -517.005, -18.8117, 6.21651, 10800, 0, 8613),
(42199, @SMOLDERTHORN_BERSERKER, 229, -77.0484, -521.654, -7.14287, 6.201, 10800, 0, 8613),
(43100, @SMOLDERTHORN_BERSERKER, 229, -49.0348, -427.765, 77.8322, 1.64061, 7200, 0, 10633),
(43101, @SMOLDERTHORN_BERSERKER, 229, -53.6383, -442.827, 78.2854, 4.70957, 7200, 0, 8883);

-- Bloodaxe Veteran
DELETE FROM `creature` WHERE `creature_id1` IN (@BLOODAXE_VETERAN);
INSERT INTO `creature` (`guid`, `creature_id1`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `curhealth`) VALUES 
(43102, @BLOODAXE_VETERAN, 229, -58.8099, -481.005, 77.9991, 4.41568, 7200, 0, 8883),
(43103, @BLOODAXE_VETERAN, 229, -43.5588, -515.171, 88.5866, 3.70166, 7200, 0, 8883),
(43104, @BLOODAXE_VETERAN, 229, -55.6649, -344.772, 70.9419, 1.35292, 10800, 0, 8883),
(43105, @BLOODAXE_VETERAN, 229, -83.8081, -316.187, 70.9524, 1.5988, 10800, 0, 8883),
(43106, @BLOODAXE_VETERAN, 229, -72.07, -322.15, 71.15, 3.22, 10800, 0, 8883),
(43107, @BLOODAXE_VETERAN, 229, -72.31, -319.25, 71.15, 3.26, 10800, 0, 8883),
(43108, @BLOODAXE_VETERAN, 229, -88.5819, -345.828, 70.9535, 1.63021, 10800, 0, 8883),
(43109, @BLOODAXE_VETERAN, 229, -111.371, -292.305, 70.9524, 5.4586, 10800, 0, 8883),
(43110, @BLOODAXE_VETERAN, 229, -121.23, -329.798, 70.9525, 3.77626, 10800, 0, 8883),
(43111, @BLOODAXE_VETERAN, 229, -135.892, -298.899, 70.9524, 3.47851, 10800, 0, 8883),
(43112, @BLOODAXE_VETERAN, 229, -202.92, -478.59, 87.57, 0, 10800, 0, 8883),
(43113, @BLOODAXE_VETERAN, 229, -163.515, -417.251, 76.1473, 1.52424, 10800, 0, 8883),
(43114, @BLOODAXE_VETERAN, 229, -155.045, -343.796, 64.4458, 3.10946, 10800, 0, 8883),
(43115, @BLOODAXE_VETERAN, 229, -138.983, -369.133, 58.079, 3.13493, 10800, 0, 8883);

-- Bloodaxe Evoker
DELETE FROM `creature` WHERE `creature_id1` IN (@BLOODAXE_EVOKER);
INSERT INTO `creature` (`guid`, `creature_id1`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `curhealth`, `curmana`) VALUES 
(52124, @BLOODAXE_EVOKER, 229, -72.4302, -520.961, 82.3316, 3.40339, 7200, 0, 7107, 2369),
(52125, @BLOODAXE_EVOKER, 229, -57.4802, -487.082, 77.9991, 3.22886, 7200, 0, 7107, 2369),
(52126, @BLOODAXE_EVOKER, 229, -47.775, -520.564, 87.5643, 1.30227, 7200, 0, 7107, 2369),
(52127, @BLOODAXE_EVOKER, 229, -54.2904, -312.739, 70.9486, 4.63863, 10800, 0, 7107, 2369),
(52128, @BLOODAXE_EVOKER, 229, -43.4876, -298.825, 70.9432, 4.82546, 10800, 0, 7107, 2369),
(52129, @BLOODAXE_EVOKER, 229, -85.0565, -349.983, 70.9535, 1.63021, 10800, 0, 7107, 2369),
(52130, @BLOODAXE_EVOKER, 229, -118.456, -330.025, 70.9525, 3.73699, 10800, 0, 7107, 2369),
(52131, @BLOODAXE_EVOKER, 229, -143.994, -300.378, 70.9525, 4.78619, 10800, 0, 7107, 2369),
(52132, @BLOODAXE_EVOKER, 229, -167.412, -412.151, 76.1473, 1.52424, 10800, 0, 7107, 2369),
(52133, @BLOODAXE_EVOKER, 229, -163.553, -320.97, 64.3954, 4.62636, 10800, 0, 7107, 2369),
(52134, @BLOODAXE_EVOKER, 229, -87.0651, -313.17, 70.9535, 6.25575, 10800, 0, 7107, 2369);

-- Smoldering waypoints
DELETE FROM `waypoints` WHERE `entry` IN (926800) AND `pointid` IN (1, 2, 3);
INSERT INTO `waypoints` (`entry`, `pointid`,`position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(926800, 1, -53.638302, -442.826996, 78.285423, 'Smoldering Berseker'),
(926800, 2, -53.289654, -405.473114, 77.761635, 'Smoldering Berseker'),
(926800, 3, -52.799553, -389.966125, 77.770241, 'Smoldering Berseker');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = -43101) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-43101, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 926800, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Smolderthorn Berserker - On Reset - Start Waypoint');

DELETE FROM `creature_formations` WHERE (`leaderGUID` IN (42190, 42189, 24181));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES 
(42190, 42190, 0, 0, 3),
(42190, 52126, 0, 0, 3),
(42190, 43103, 0, 0, 3),
(42189, 42189, 0, 0, 3),
(42189, 43102, 0, 0, 3),
(42189, 52125, 0, 0, 3),
(24181, 24181, 0, 0, 3),
(24181, 52124, 0, 0, 3),
(24181, 42188, 0, 0, 3);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_14_04' WHERE sql_rev = '1641389002880170100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
