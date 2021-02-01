-- DB update 2019_07_24_00 -> 2019_07_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_24_00 2019_07_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1560396171418694700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1560396171418694700');

UPDATE `gameobject_template_addon` SET `faction`=35 WHERE `entry`=193070; -- Nexus Raid Platform now has faction 35, instead of 0 and is friendly to players.
UPDATE `gameobject_template` SET `Data0`=6000000 WHERE `entry`=193070;    -- Nexus Raid Platform has a lot more hp in order not to break in case any siege damage is taken, initial value was 100. (double safety)

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
