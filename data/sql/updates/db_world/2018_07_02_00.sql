-- DB update 2018_06_29_00 -> 2018_07_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_06_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_06_29_00 2018_07_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1528849180165830100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1528849180165830100');


-- proper coords: 
-- 3465.16, -3940.45, 308.788, 0.441179, -0.305481, 0.637715, 0.305481, 0.637716,
-- requires two guids, one for the 'visual effect' and one for the 
-- teleporter gameobject itself

-- teleporter itself
UPDATE `gameobject` SET
    `spawnmask` = 3, `phasemask`= 1,
    `position_x` = 3465.16, `position_y` = -3940.45, `position_z` = 308.788,`orientation` = 0.441179, 
    `rotation0` = -0.305481, `rotation1` = 0.637715, `rotation2` = 0.305481, `rotation3` = 0.637716
    where `guid` = 65857; -- check if guid is valid

-- visual effect
UPDATE `gameobject` SET
    `spawnmask` = 3, `phasemask`= 2,
    `position_x` = 3465.16, `position_y` = -3940.45, `position_z` = 308.788,`orientation` = 0.441179, 
    `rotation0` = -0.305481, `rotation1` = 0.637715, `rotation2` = 0.305481, `rotation3` = 0.637716
    WHERE `guid` = 268045; -- check if guid is valid

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
