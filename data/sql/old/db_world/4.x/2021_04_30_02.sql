-- DB update 2021_04_30_01 -> 2021_04_30_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_30_01 2021_04_30_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619635493647808718'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619635493647808718');

SET
@POOL            = 11658,
@POOLSIZE        = 6,
@POOLDESC        = 'Treasures - Dustwallow Marsh',
@RESPAWN         = 900,
@GUID = '87386,11755,14618,85709,85714,13632,85864,85706,9096,14619,14931,40758,40772,40796,85718,85721,85722,85734,85735';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(87386,@POOL,0,'Solid Chest, Dustwallow Marsh, node 1'),
(11755,@POOL,0,'Solid Chest, Dustwallow Marsh, node 2'),
(14618,@POOL,0,'Solid Chest, Dustwallow Marsh, node 3'),
(85709,@POOL,0,'Solid Chest, Dustwallow Marsh, node 4'),
(85714,@POOL,0,'Solid Chest, Dustwallow Marsh, node 5'),
(13632,@POOL,0,'Solid Chest, Dustwallow Marsh, node 6'),
(85864,@POOL,0,'Solid Chest, Dustwallow Marsh, node 7'),
(85706,@POOL,0,'Solid Chest, Dustwallow Marsh, node 8'),
(9096,@POOL,0,'Solid Chest, Dustwallow Marsh, node 9'),
(14619,@POOL,0,'Solid Chest, Dustwallow Marsh, node 10'),
(14931,@POOL,0,'Solid Chest, Dustwallow Marsh, node 11'),
(40758,@POOL,0,'Solid Chest, Dustwallow Marsh, node 12'),
(40772,@POOL,0,'Solid Chest, Dustwallow Marsh, node 13'),
(40796,@POOL,0,'Solid Chest, Dustwallow Marsh, node 14'),
(85718,@POOL,0,'Solid Chest, Dustwallow Marsh, node 15'),
(85721,@POOL,0,'Solid Chest, Dustwallow Marsh, node 16'),
(85722,@POOL,0,'Solid Chest, Dustwallow Marsh, node 17'),
(85734,@POOL,0,'Solid Chest, Dustwallow Marsh, node 18'),
(85735,@POOL,0,'Solid Chest, Dustwallow Marsh, node 19');


-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);
UPDATE `gameobject` SET `zoneId`= '15' WHERE FIND_IN_SET (`guid`,@GUID);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
