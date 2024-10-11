-- DB update 2019_06_01_02 -> 2019_06_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_01_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_01_02 2019_06_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1558943884011471260'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558943884011471260');

-- Despawn "Gearmaster Mechazod" after 300 seconds (was 3000 seconds before)
UPDATE `event_scripts` SET `datalong2` = 300000 WHERE `id` = 17209 AND `command` = 10;

-- Ensure that "The Gearmaster's Manual" is consumable (both Horde and Alliance version)
UPDATE `gameobject_template` SET `Data5` = 1 WHERE `entry` IN (190334,190335);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
