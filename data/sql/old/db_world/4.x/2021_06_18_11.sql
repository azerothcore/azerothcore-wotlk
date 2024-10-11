-- DB update 2021_06_18_10 -> 2021_06_18_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_10 2021_06_18_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623407387579164400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623407387579164400');

DELETE FROM `smart_scripts` WHERE `entryorguid`=24914 AND `id` BETWEEN 2 AND 5;
INSERT INTO `smart_scripts` VALUES
(24914,0,2,3,8,0,100,0,45008,0,0,0,0,102,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - On spell hit Big Gun Assault - disable health regen'),
(24914,0,3,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - On spell hit Big Gun Assault - set phase to 1'),
(24914,0,4,5,1,1,100,0,15000,15000,0,0,0,102,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - OOC (phase 1) - enable health regen'),
(24914,0,5,0,61,1,100,0,0,0,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sorlof - OOC (phase 1) - set phase to 0');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_11' WHERE sql_rev = '1623407387579164400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
