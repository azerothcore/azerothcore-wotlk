-- DB update 2019_09_08_00 -> 2019_09_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_08_00 2019_09_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1566257693610996077'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1566257693610996077');

-- Infesting Jormungars

-- Delete wrong SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30148 AND `source_type` = 0 AND `id` NOT IN (8,9);

-- Relocate one of the jormungars
UPDATE `creature` SET `position_x` = 7899.12, `position_y` = -1603.28, `position_z` = 913.483, `orientation` = 5.14769, `spawndist` = 5, `MovementType` = 1 WHERE `guid` = 114459;

-- Add aura "Permanent Feign Death" to the jormungars in the worg lair
DELETE FROM `creature_addon` WHERE `guid` IN (114372,114373,114381);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(114372,0,0,0,0,0,'29266'),
(114373,0,0,0,0,0,'29266'),
(114381,0,0,0,0,0,'29266');


-- Cavedweller Worgs

-- Use randomized models from the creature template
UPDATE `creature` SET `modelid` = 0 WHERE `id` = 30164;

-- Relocate two of the worgs
UPDATE `creature` SET `position_x` = 7911.61, `position_y` = -1515.89, `position_z` = 917.746, `orientation` = 3.26274 WHERE `guid` = 115912;
UPDATE `creature` SET `position_x` = 7857.7, `position_y` = -1519.06, `position_z` = 926.433, `orientation` = 3.81876 WHERE `guid` = 115909;

-- Add a few more worgs to fight against the jormungars and bolster their numbers in the worg lair
DELETE FROM `creature` WHERE `guid` IN (114375,115838,115840,115846,115847,115880,115897,115898,115899,115900);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`)
VALUES
(114375,30164,571,0,0,1,1,0,0,7697.82,-1587.62,965.778,3.70255,300,0,0,8522,0,0,0,0,0,'',0),
(115838,30164,571,0,0,1,1,0,0,7907.68,-1578.23,915.404,1.95505,300,5,0,8522,0,1,0,0,0,'',0),
(115840,30164,571,0,0,1,1,0,0,7915.92,-1572.97,914.931,1.97469,300,5,0,8522,0,1,0,0,0,'',0),
(115846,30164,571,0,0,1,1,0,0,8025.01,-1506.32,900.037,4.16202,300,0,0,8522,0,0,0,0,0,'',0),
(115847,30164,571,0,0,1,1,0,0,8011.97,-1499.65,903.506,4.5665,300,0,0,8522,0,0,0,0,0,'',0),
(115880,30164,571,0,0,1,1,0,0,7909.27,-1528.26,919.583,2.76008,300,0,0,8522,0,0,0,0,0,'',0),
(115897,30164,571,0,0,1,1,0,0,7740.37,-1601.19,947.069,0.476892,300,5,0,8522,0,1,0,0,0,'',0),
(115898,30164,571,0,0,1,1,0,0,7708.8,-1664.36,953.947,0.901011,300,5,0,8522,0,1,0,0,0,'',0),
(115899,30164,571,0,0,1,1,0,0,7655.22,-1603.08,966.405,5.85294,300,5,0,8522,0,1,0,0,0,'',0),
(115900,30164,571,0,0,1,1,0,0,7631.87,-1559.32,973.025,5.66052,300,5,0,8522,0,1,0,0,0,'',0);

-- Add emote "STATE_CUSTOM_SPELL_01" (feeding emote) to the worgs in the worg lair
DELETE FROM `creature_addon` WHERE `guid` IN (115903,115904,115905,115906,115907,115908);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(115903,0,0,0,0,416,NULL),
(115904,0,0,0,0,416,NULL),
(115905,0,0,0,0,416,NULL),
(115906,0,0,0,0,416,NULL),
(115907,0,0,0,0,416,NULL),
(115908,0,0,0,0,416,NULL);


-- Add a few more Cave Mushrooms
DELETE FROM `gameobject` WHERE `guid` IN (56804,56805,56806,56812,56814,56815,56816,56943,56944,56945,56946);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`)
VALUES
(56804,192556,571,0,0,1,1,7662.32,-1557.45,969.031,5.58593,0,0,0,1,300,100,1,'',0),
(56805,192556,571,0,0,1,1,7698.66,-1593.91,965.806,2.94698,0,0,0,1,300,100,1,'',0),
(56806,192556,571,0,0,1,1,7743.1,-1645.03,951.768,2.62497,0,0,0,1,300,100,1,'',0),
(56812,192556,571,0,0,1,1,7729.65,-1592.61,946.609,2.18122,0,0,0,1,300,100,1,'',0),
(56814,192556,571,0,0,1,1,7757.67,-1576.78,944.997,1.75239,0,0,0,1,300,100,1,'',0),
(56815,192556,571,0,0,1,1,7797.42,-1547.83,940.213,3.43471,0,0,0,1,300,100,1,'',0),
(56816,192556,571,0,0,1,1,7830.84,-1537.4,932.346,1.94637,0,0,0,1,300,100,1,'',0),
(56943,192556,571,0,0,1,1,7852.54,-1526.72,929.039,3.20694,0,0,0,1,300,100,1,'',0),
(56944,192556,571,0,0,1,1,7912.11,-1510.36,917.7,3.16374,0,0,0,1,300,100,1,'',0),
(56945,192556,571,0,0,1,1,7911.99,-1535.46,921.207,6.02653,0,0,0,1,300,100,1,'',0),
(56946,192556,571,0,0,1,1,7883.22,-1511.09,923.026,0.218518,0,0,0,1,300,100,1,'',0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
