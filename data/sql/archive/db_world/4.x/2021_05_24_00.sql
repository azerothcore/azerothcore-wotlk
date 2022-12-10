-- DB update 2021_05_23_03 -> 2021_05_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_23_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_23_03 2021_05_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1620427214886749400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620427214886749400');

-- Redridge Mountains 
UPDATE `gameobject` SET `position_x`=-9352.796, `position_y`=-1881.891, `position_z`=74.445, `orientation`=1.013165 WHERE `guid`=5027;

-- Durotar 
UPDATE `gameobject` SET `position_x`=-244.725, `position_y`=-4848.599, `position_z`=31.135, `orientation`=0.131648 WHERE `guid`=5471;
UPDATE `gameobject` SET `position_x`=-117.992, `position_y`=-4889.760, `position_z`=20.688, `orientation`=4.426589 WHERE `guid`=5240;
UPDATE `gameobject` SET `position_x`=-315.871, `position_y`=-5035.625, `position_z`=28.281, `orientation`=0.637474 WHERE `guid`=4661;
UPDATE `gameobject` SET `position_x`=-59.494, `position_y`=-4808.289, `position_z`=25.549, `orientation`=6.085922 WHERE `guid`=4759;

-- The Barrens
UPDATE `gameobject` SET `position_x`=-1078.733, `position_y`=-2743.502, `position_z`=105.440, `orientation`=1.118190 WHERE `guid`=5325;
UPDATE `gameobject` SET `position_x`=-1437.727, `position_y`=-3085.670, `position_z`=111.734, `orientation`=0.655799 WHERE `guid`=5454;

-- Tanaris 
UPDATE `gameobject` SET `position_x`=-8096.516, `position_y`=-4314.403, `position_z`=17.563, `orientation`=2.512113 WHERE `guid`=6494;
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
