-- DB update 2021_04_29_02 -> 2021_04_29_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_29_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_29_02 2021_04_29_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1619550059726252710'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619550059726252710');

SET
@POOL            = 50003,
@POOLSIZE        = 40,
@RESPAWN         = 60,
@GUID = '4527,6810,6829,6830,19259,19285,19286,19296,19299,19315,19316,19321,19324,19339,19340,19346,19361,19362,19366,19367,19387,19388,19395,19407,19408,19426,19430,19433,19470,19475,19484,19493,19494,19510,19516,19520,19554,19566,19577,19596,19597,19624,19625,19634,19640,19641,19642,19643,19652,19653,29585,33419,39952,39954,63632,86416,87305,
16028,16042,16052,16054,16058,16059,16068,16069,16082,16106,16131,16155,16192,16225,16226,16227,39957,39958,87177,
4525,6823,6857,6873,18944,18954,18955,18958,18961,18962,18963,18970,18979,19018,19020,19024,19025,19034,19039,19042,19049,19051,19096,19109,19114,19150,19180,19194,19217,19226,
4600,6832,19666,19668,19688,19714,19723,19737,19742,19757,19760,19774,19779,19803,19806,19814,19818,19819,19820,19821,19832,19865,29584,35301,39955,65277';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,'MASTER Herbs Burning Steppes zone 46');

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(4527,@POOL,0,'Dreamfoil zone 46, node 1'),
(6810,@POOL,0,'Dreamfoil zone 46, node 2'),
(6829,@POOL,0,'Dreamfoil zone 46, node 3'),
(6830,@POOL,0,'Dreamfoil zone 46, node 4'),
(19259,@POOL,0,'Dreamfoil zone 46, node 5'),
(19285,@POOL,0,'Dreamfoil zone 46, node 6'),
(19286,@POOL,0,'Dreamfoil zone 46, node 7'),
(19296,@POOL,0,'Dreamfoil zone 46, node 8'),
(19299,@POOL,0,'Dreamfoil zone 46, node 9'),
(19315,@POOL,0,'Dreamfoil zone 46, node 10'),
(19316,@POOL,0,'Dreamfoil zone 46, node 11'),
(19321,@POOL,0,'Dreamfoil zone 46, node 12'),
(19324,@POOL,0,'Dreamfoil zone 46, node 13'),
(19339,@POOL,0,'Dreamfoil zone 46, node 14'),
(19340,@POOL,0,'Dreamfoil zone 46, node 15'),
(19346,@POOL,0,'Dreamfoil zone 46, node 16'),
(19361,@POOL,0,'Dreamfoil zone 46, node 17'),
(19362,@POOL,0,'Dreamfoil zone 46, node 18'),
(19366,@POOL,0,'Dreamfoil zone 46, node 19'),
(19367,@POOL,0,'Dreamfoil zone 46, node 20'),
(19387,@POOL,0,'Dreamfoil zone 46, node 21'),
(19388,@POOL,0,'Dreamfoil zone 46, node 22'),
(19395,@POOL,0,'Dreamfoil zone 46, node 23'),
(19407,@POOL,0,'Dreamfoil zone 46, node 24'),
(19408,@POOL,0,'Dreamfoil zone 46, node 25'),
(19426,@POOL,0,'Dreamfoil zone 46, node 26'),
(19430,@POOL,0,'Dreamfoil zone 46, node 27'),
(19433,@POOL,0,'Dreamfoil zone 46, node 28'),
(19470,@POOL,0,'Dreamfoil zone 46, node 29'),
(19475,@POOL,0,'Dreamfoil zone 46, node 30'),
(19484,@POOL,0,'Dreamfoil zone 46, node 31'),
(19493,@POOL,0,'Dreamfoil zone 46, node 32'),
(19494,@POOL,0,'Dreamfoil zone 46, node 33'),
(19510,@POOL,0,'Dreamfoil zone 46, node 34'),
(19516,@POOL,0,'Dreamfoil zone 46, node 35'),
(19520,@POOL,0,'Dreamfoil zone 46, node 36'),
(19554,@POOL,0,'Dreamfoil zone 46, node 37'),
(19566,@POOL,0,'Dreamfoil zone 46, node 38'),
(19577,@POOL,0,'Dreamfoil zone 46, node 39'),
(19596,@POOL,0,'Dreamfoil zone 46, node 40'),
(19597,@POOL,0,'Dreamfoil zone 46, node 41'),
(19624,@POOL,0,'Dreamfoil zone 46, node 42'),
(19625,@POOL,0,'Dreamfoil zone 46, node 43'),
(19634,@POOL,0,'Dreamfoil zone 46, node 44'),
(19640,@POOL,0,'Dreamfoil zone 46, node 45'),
(19641,@POOL,0,'Dreamfoil zone 46, node 46'),
(19642,@POOL,0,'Dreamfoil zone 46, node 47'),
(19643,@POOL,0,'Dreamfoil zone 46, node 48'),
(19652,@POOL,0,'Dreamfoil zone 46, node 49'),
(19653,@POOL,0,'Dreamfoil zone 46, node 50'),
(29585,@POOL,0,'Dreamfoil zone 46, node 51'),
(33419,@POOL,0,'Dreamfoil zone 46, node 52'),
(39952,@POOL,0,'Dreamfoil zone 46, node 53'),
(39954,@POOL,0,'Dreamfoil zone 46, node 54'),
(63632,@POOL,0,'Dreamfoil zone 46, node 55'),
(86416,@POOL,0,'Dreamfoil zone 46, node 56'),
(87305,@POOL,0,'Dreamfoil zone 46, node 57'),
(16028,@POOL,0,'Sungrass zone 46, node 1'),
(16042,@POOL,0,'Sungrass zone 46, node 2'),
(16052,@POOL,0,'Sungrass zone 46, node 3'),
(16054,@POOL,0,'Sungrass zone 46, node 4'),
(16058,@POOL,0,'Sungrass zone 46, node 5'),
(16059,@POOL,0,'Sungrass zone 46, node 6'),
(16068,@POOL,0,'Sungrass zone 46, node 7'),
(16069,@POOL,0,'Sungrass zone 46, node 8'),
(16082,@POOL,0,'Sungrass zone 46, node 9'),
(16106,@POOL,0,'Sungrass zone 46, node 10'),
(16131,@POOL,0,'Sungrass zone 46, node 11'),
(16155,@POOL,0,'Sungrass zone 46, node 12'),
(16192,@POOL,0,'Sungrass zone 46, node 13'),
(16225,@POOL,0,'Sungrass zone 46, node 14'),
(16226,@POOL,0,'Sungrass zone 46, node 15'),
(16227,@POOL,0,'Sungrass zone 46, node 16'),
(39957,@POOL,0,'Sungrass zone 46, node 17'),
(39958,@POOL,0,'Sungrass zone 46, node 18'),
(87177,@POOL,0,'Sungrass zone 46, node 19'),
(4525,@POOL,0,'Golden Sansam zone 46, node 1'),
(6823,@POOL,0,'Golden Sansam zone 46, node 2'),
(6857,@POOL,0,'Golden Sansam zone 46, node 3'),
(6873,@POOL,0,'Golden Sansam zone 46, node 4'),
(18944,@POOL,0,'Golden Sansam zone 46, node 5'),
(18954,@POOL,0,'Golden Sansam zone 46, node 6'),
(18955,@POOL,0,'Golden Sansam zone 46, node 7'),
(18958,@POOL,0,'Golden Sansam zone 46, node 8'),
(18961,@POOL,0,'Golden Sansam zone 46, node 9'),
(18962,@POOL,0,'Golden Sansam zone 46, node 10'),
(18963,@POOL,0,'Golden Sansam zone 46, node 11'),
(18970,@POOL,0,'Golden Sansam zone 46, node 12'),
(18979,@POOL,0,'Golden Sansam zone 46, node 13'),
(19018,@POOL,0,'Golden Sansam zone 46, node 14'),
(19020,@POOL,0,'Golden Sansam zone 46, node 15'),
(19024,@POOL,0,'Golden Sansam zone 46, node 16'),
(19025,@POOL,0,'Golden Sansam zone 46, node 17'),
(19034,@POOL,0,'Golden Sansam zone 46, node 18'),
(19039,@POOL,0,'Golden Sansam zone 46, node 19'),
(19042,@POOL,0,'Golden Sansam zone 46, node 20'),
(19049,@POOL,0,'Golden Sansam zone 46, node 21'),
(19051,@POOL,0,'Golden Sansam zone 46, node 22'),
(19096,@POOL,0,'Golden Sansam zone 46, node 23'),
(19109,@POOL,0,'Golden Sansam zone 46, node 24'),
(19114,@POOL,0,'Golden Sansam zone 46, node 25'),
(19150,@POOL,0,'Golden Sansam zone 46, node 26'),
(19180,@POOL,0,'Golden Sansam zone 46, node 27'),
(19194,@POOL,0,'Golden Sansam zone 46, node 28'),
(19217,@POOL,0,'Golden Sansam zone 46, node 29'),
(19226,@POOL,0,'Golden Sansam zone 46, node 30'),
(4600,@POOL,0,'Mountain Silversage zone 46, node 1'),
(6832,@POOL,0,'Mountain Silversage zone 46, node 2'),
(19666,@POOL,0,'Mountain Silversage zone 46, node 3'),
(19668,@POOL,0,'Mountain Silversage zone 46, node 4'),
(19688,@POOL,0,'Mountain Silversage zone 46, node 5'),
(19714,@POOL,0,'Mountain Silversage zone 46, node 6'),
(19723,@POOL,0,'Mountain Silversage zone 46, node 7'),
(19737,@POOL,0,'Mountain Silversage zone 46, node 8'),
(19742,@POOL,0,'Mountain Silversage zone 46, node 9'),
(19757,@POOL,0,'Mountain Silversage zone 46, node 10'),
(19760,@POOL,0,'Mountain Silversage zone 46, node 11'),
(19774,@POOL,0,'Mountain Silversage zone 46, node 12'),
(19779,@POOL,0,'Mountain Silversage zone 46, node 13'),
(19803,@POOL,0,'Mountain Silversage zone 46, node 14'),
(19806,@POOL,0,'Mountain Silversage zone 46, node 15'),
(19814,@POOL,0,'Mountain Silversage zone 46, node 16'),
(19818,@POOL,0,'Mountain Silversage zone 46, node 17'),
(19819,@POOL,0,'Mountain Silversage zone 46, node 18'),
(19820,@POOL,0,'Mountain Silversage zone 46, node 19'),
(19821,@POOL,0,'Mountain Silversage zone 46, node 20'),
(19832,@POOL,0,'Mountain Silversage zone 46, node 21'),
(19865,@POOL,0,'Mountain Silversage zone 46, node 22'),
(29584,@POOL,0,'Mountain Silversage zone 46, node 23'),
(35301,@POOL,0,'Mountain Silversage zone 46, node 24'),
(39955,@POOL,0,'Mountain Silversage zone 46, node 25'),
(65277,@POOL,0,'Mountain Silversage zone 46, node 26');

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);
UPDATE `gameobject` SET `zoneId`= '46' WHERE FIND_IN_SET (`guid`,@GUID);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
