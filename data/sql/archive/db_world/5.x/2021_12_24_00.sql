-- DB update 2021_12_23_07 -> 2021_12_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_23_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_23_07 2021_12_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640281609265649594'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640281609265649594');

-- High Warlord Whirlaxis is not skinnable fix. Never was skinnable. Flags Corrected.
UPDATE `creature_template` SET `unit_flags`=0, `skinloot`=0 WHERE  `entry`=15204;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_24_00' WHERE sql_rev = '1640281609265649594';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
