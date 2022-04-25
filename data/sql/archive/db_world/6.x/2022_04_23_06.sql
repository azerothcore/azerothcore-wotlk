-- DB update 2022_04_23_05 -> 2022_04_23_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_05 2022_04_23_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650071065104177600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650071065104177600');

DELETE FROM `item_template_locale` WHERE `ID`=13065 AND `locale` IN ('esES','esMX');
INSERT INTO `item_template_locale` (`ID`, `locale`, `Name`, `Description`, `VerifiedBuild`) VALUES
(13065, 'esES', 'Varita de Allistarj', '', 0),
(13065, 'esMX', 'Varita de Allistarj', '', 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_06' WHERE sql_rev = '1650071065104177600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
