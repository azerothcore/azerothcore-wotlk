-- DB update 2021_08_06_01 -> 2021_08_06_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_06_01 2021_08_06_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627741035221642000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627741035221642000');

-- Set the Creature Azurous a patrol route movement
UPDATE `creature` SET  `MovementType` = 2  WHERE (`id` = 10202) AND (`guid` = 51890);

-- Changed his movement from 1.74 to 1 so he dont speedwalk.
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 10202);

-- Delete previous routes
DELETE FROM `creature_addon` WHERE (`guid` = 51890);

-- Routes
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(51890, 518900, 0, 0, 0, 0, 0, NULL);

-- Delete all waypoints routes
DELETE FROM `waypoint_data` WHERE (`id` = 518900);

-- Waypoint route 1 (GUID: 51890)
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(518900,1,6448.333,-4494.53,734.90,0,0,0,0,100,0),
(518900,2,6437.67,-4434.99,727.15,0,0,0,0,100,0),
(518900,3,6385.43,-4397.43,733.18,0,0,0,0,100,0),
(518900,4,6352.442,-4414.85,746.33,0,0,0,0,100,0),
(518900,5,6352.72,-4433.61,754.56,0,0,0,0,100,0),
(518900,6,6390.195,-4489.12,753.99,0,0,0,0,100,0),
(518900,7,6394.71,-4519.01,748.153,0,0,0,0,100,0),
(518900,8,6431.722,-4518.271,737.40,0,0,0,0,100,0),
(518900,9,6487.26,-4542.47,717.283,0,0,0,0,100,0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_06_02' WHERE sql_rev = '1627741035221642000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
