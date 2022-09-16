-- DB update 2021_08_30_02 -> 2021_08_30_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_30_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_30_02 2021_08_30_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629809640673167100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629809640673167100');

# Restrict quest Report to Splintertree Post(ID 9428), Delivery to the Sepulcher(ID 9189) and Report to Tarren Mill(ID 9425) to only allow blood elfs
UPDATE `quest_template` SET `AllowableRaces` = 512 WHERE `ID` IN (9189, 9425, 9428);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_30_03' WHERE sql_rev = '1629809640673167100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
