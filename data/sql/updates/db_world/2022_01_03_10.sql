-- DB update 2022_01_03_09 -> 2022_01_03_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_09 2022_01_03_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640970254313471461'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640970254313471461');

-- Remove SAI path.
UPDATE `creature_template` SET `AIName`="", `ScriptName`='' WHERE `entry`=18947;
DELETE FROM `smart_scripts` WHERE `entryorguid`=18947 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1894700,1894701,1894702) AND `source_type`=9;
DELETE FROM `waypoints` WHERE `entry`=18947;

-- Pathing for Solanin <Bag Vendor> Entry: 18947
SET @NPC := 68009;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=9309.143,`position_y`=-6555.4087,`position_z`=34.67163 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,9311.077,-6546.257,34.846924,0,6000,0,1078,100,0), -- Emote Kneel 16
(@PATH,2,9305.104,-6541.021,34.835205,0,6000,0,1078,100,0), -- Emote Kneel 16
(@PATH,3,9301.6,-6547.752,34.710205,0,0,0,0,100,0),
(@PATH,4,9300,-6554.6353,33.846703,0,12000,0,0,100,0),
(@PATH,5,9311.535,-6549.8223,34.948242,0,0,0,0,100,0),
(@PATH,6,9311.535,-6549.8223,34.948242,3.00197,14000,0,6,100,0), -- Text 0, Text 1
(@PATH,7,9309.143,-6555.4087,34.67163,0,0,0,0,100,0),
(@PATH,8,9309.143,-6555.4087,34.67163,2.49582,175000,0,0,100,0);
-- Path scripting for Solanin <Bag Vendor>
DELETE FROM `waypoint_scripts` WHERE `id`=6;
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`,`guid`) VALUES
(6,1,0,0,0,16099,0,0,0,0,16), -- Text 0
(6,1,1,6,0,0,0,0,0,0,17), -- Emote 6
(6,7,0,0,0,16100,0,0,0,0,18), -- Text 1
(6,7,1,1,0,0,0,0,0,0,19); -- Emote 1

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_10' WHERE sql_rev = '1640970254313471461';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
