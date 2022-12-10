-- DB update 2021_08_04_04 -> 2021_08_04_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_04_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_04_04 2021_08_04_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627389223377644200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627389223377644200');

-- Changed the side to be alliance only so it cant be shareable between horde
UPDATE `quest_template` SET `AllowableRaces` = 1101 WHERE (`ID` = 1142);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_04_05' WHERE sql_rev = '1627389223377644200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
