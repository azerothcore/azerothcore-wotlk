-- DB update 2022_03_03_03 -> 2022_03_03_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_03_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_03_03 2022_03_03_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643990187122091800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643990187122091800');

UPDATE `page_text` SET `Text` = 'Nessa,$B$BIt is good to hear from you.$B$BThe collection of bones and scales  you sent me was incredible. Never have I seen fish of that size off the mainland.  the fishers of Rut\'theran must pull in easily a ton of fish each day!$B$BI envy the size of their bounty, but I am a small bit troubled as well. Could our new world tree make the fish grow to such a size? If that is so, what other effects might it have?$B$BQuestions to ponder,$B-Laird' WHERE `ID` = 2513;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_03_04' WHERE sql_rev = '1643990187122091800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
