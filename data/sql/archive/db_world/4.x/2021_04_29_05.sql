-- DB update 2021_04_29_04 -> 2021_04_29_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_29_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_29_04 2021_04_29_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619641851979377067'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619641851979377067');

SET
@POOL            = 11659,
@POOLSIZE        = 5,
@POOLDESC        = 'Treasures - Tanaris',
@RESPAWN         = 900,
@GUID = '87386,11755,14618,85709,85714,13632,85864,85706,9096,14619,14931,40758,40772,40796,85718,85721,85722,85734,85735';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(87386,@POOL,0,'Solid Chest, Tanaris, node 1'),
(17298,@POOL,0,'Solid Chest, Tanaris, node 2'),
(17299,@POOL,0,'Solid Chest, Tanaris, node 3'),
(17300,@POOL,0,'Solid Chest, Tanaris, node 4'),
(17329,@POOL,0,'Solid Chest, Tanaris, node 5'),
(17330,@POOL,0,'Solid Chest, Tanaris, node 6'),
(17331,@POOL,0,'Solid Chest, Tanaris, node 7'),
(85717,@POOL,0,'Solid Chest, Tanaris, node 8'),
(85720,@POOL,0,'Solid Chest, Tanaris, node 9'),
(85729,@POOL,0,'Solid Chest, Tanaris, node 10'),
(85731,@POOL,0,'Solid Chest, Tanaris, node 11'),
(85733,@POOL,0,'Solid Chest, Tanaris, node 12'),
(85736,@POOL,0,'Solid Chest, Tanaris, node 13'),
(85737,@POOL,0,'Solid Chest, Tanaris, node 14'),
(85738,@POOL,0,'Solid Chest, Tanaris, node 15'),
(85781,@POOL,0,'Solid Chest, Tanaris, node 16'),
(85782,@POOL,0,'Solid Chest, Tanaris, node 17'),
(85783,@POOL,0,'Solid Chest, Tanaris, node 18'),
(85784,@POOL,0,'Solid Chest, Tanaris, node 19'),
(85895,@POOL,0,'Solid Chest, Tanaris, node 20'),
(85896,@POOL,0,'Solid Chest, Tanaris, node 21');



-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);
UPDATE `gameobject` SET `zoneId`= '440' WHERE FIND_IN_SET (`guid`,@GUID);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
