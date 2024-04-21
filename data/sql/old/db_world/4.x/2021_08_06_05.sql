-- DB update 2021_08_06_04 -> 2021_08_06_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_06_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_06_04 2021_08_06_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627735957987999500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627735957987999500');

-- Change the spawn points of Heavy War Golem (5854) so they spawn in the bridge
UPDATE `creature` SET `position_x` = -6681.53, `position_y` = -1352.86, `position_z` = 210.77  WHERE (`id` = 5854) AND (`guid` = 5608);
UPDATE `creature` SET `position_x` = -6663.55, `position_y` = -1317.16, `position_z` = 208.48  WHERE (`id` = 5854) AND (`guid` = 5687);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_06_05' WHERE sql_rev = '1627735957987999500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
