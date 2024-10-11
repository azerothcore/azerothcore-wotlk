-- DB update 2022_04_23_03 -> 2022_04_23_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_03 2022_04_23_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649705878401365511'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649705878401365511');

DELETE FROM `creature_template_locale` WHERE `entry` IN (30652,30653) AND `locale` IN ('esES','esMX');
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(30652, 'esES', 'Tótem de cólera II', '', 18019),
(30652, 'esMX', 'Tótem de cólera II', '', 18019),
(30653, 'esES', 'Tótem de cólera III', '', 18019),
(30653, 'esMX', 'Tótem de cólera III', '', 18019);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_04' WHERE sql_rev = '1649705878401365511';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
