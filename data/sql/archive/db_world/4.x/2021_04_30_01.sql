-- DB update 2021_04_30_00 -> 2021_04_30_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_30_00 2021_04_30_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619629615739305133'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619629615739305133');

SET
@POOL            = 11657,
@POOLSIZE        = 5,
@POOLDESC        = 'Treasures - Alterac Mountains',
@RESPAWN         = 900,
@GUID = '33304,33206,33207,33200,33193,33208';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(33304,@POOL,0,'Solid Chest, Alterac Mountains, node 1'),
(33206,@POOL,0,'Solid Chest, Alterac Mountains, node 2'),
(33207,@POOL,0,'Solid Chest, Alterac Mountains, node 3'),
(33200,@POOL,0,'Solid Chest, Alterac Mountains, node 4'),
(33193,@POOL,0,'Solid Chest, Alterac Mountains, node 5'),
(33208,@POOL,0,'Solid Chest, Alterac Mountains, node 6');

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);
UPDATE `gameobject` SET `zoneId`= '36' WHERE FIND_IN_SET (`guid`,@GUID);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
