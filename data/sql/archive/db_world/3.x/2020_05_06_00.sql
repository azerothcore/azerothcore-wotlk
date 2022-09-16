-- DB update 2020_05_05_00 -> 2020_05_06_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_05_00 2020_05_06_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1585171529989474800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1585171529989474800');

UPDATE `item_template_locale` SET `Description`='Eröffnet den Schwierigkeitsgrad ''Heroisch'' für Dungeons der Höllenfeuerzitadelle.' WHERE  `ID`=30622 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Eröffnet den Schwierigkeitsgrad ''Heroisch'' für Dungeons des Echsenkessels.' WHERE  `ID`=30623 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Eröffnet den Schwierigkeitsgrad ''Heroisch'' für Dungeons von Auchindoun.' WHERE  `ID`=30633 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Eröffnet den Schwierigkeitsgrad ''Heroisch'' für Dungeons der Festung der Stürme.' WHERE  `ID`=30634 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Eröffnet den Schwierigkeitsgrad ''Heroisch'' für Dungeons der Höhlen der Zeit.' WHERE  `ID`=30635 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Eröffnet den Schwierigkeitsgrad ''Heroisch'' für Dungeons der Höllenfeuerzitadelle.' WHERE  `ID`=30637 AND `locale`='deDE';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
