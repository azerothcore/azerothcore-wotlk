-- DB update 2021_09_01_23 -> 2021_09_01_24
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_23';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_23 2021_09_01_24 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630318500363217970'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630318500363217970');

-- Set Webwood spiders(1986) and Githyiss the Vile(1994) neutral to the player instead of aggresive
UPDATE `creature_template` SET `faction` = 7 WHERE (`entry` IN (1986, 1994));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_24' WHERE sql_rev = '1630318500363217970';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
