-- DB update 2022_04_18_02 -> 2022_04_18_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_18_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_18_02 2022_04_18_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648562925756409969'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648562925756409969');

DELETE FROM `quest_request_items_locale` WHERE `ID` = 12718 AND `locale` = "frFR" ;
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12718,"frFR","La mixture toxique bouillonne dans le chaudron de peste, répandant une épaisse fumée aux alentours.$b$bAvez-vous plus de crânes de croisés à y jeter ?",18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_18_03' WHERE sql_rev = '1648562925756409969';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
