-- DB update 2021_08_26_04 -> 2021_08_26_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_26_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_26_04 2021_08_26_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629651893587285900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629651893587285900');

UPDATE `quest_template_locale` SET `Title`='Rückkehr zu Podrig', `Details`='Der Fledermausmeister im Grabmal ist Karos Razok. Wenn Ihr schon bei ihm gewesen seid, dann gebe ich Euch eine Fledermaus, damit Ihr zu ihm fliegen könnt.$B$B Unsere Fledermäuse fliegen stets zur Unterstadt, aber um zu entlegeneren Orten zu reisen, muss ihr Reiter zuerst die Gegend besuchen und mit dem dortigen Fledermausmeister sprechen.$B$BIhr habt Karos im Grabmal getroffen, daher könnt Ihr jetzt mit Fledermäusen dorthin fliegen. Sprecht wieder mit mir, wenn Ihr bereit seid.', `Objectives`='Bucht einen Fledermausritt zum Grabmal bei Fledermausmeister Michael Garret und bringt dann Gordons Kiste zu Todeswache Podrig beim Grabmal.' WHERE  `ID`=6324 AND `locale`='deDE';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_26_05' WHERE sql_rev = '1629651893587285900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
