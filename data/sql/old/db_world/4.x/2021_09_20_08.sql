-- DB update 2021_09_20_07 -> 2021_09_20_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_07 2021_09_20_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631734068732546500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631734068732546500');

SET @Entry = 35009;

UPDATE `reference_loot_template` SET `Chance` = 13.3 WHERE `Entry` = @Entry AND `Item` IN (17707, 17710, 17711, 17715, 17766); 
UPDATE `reference_loot_template` SET `Chance` = 16.6 WHERE `Entry` = @Entry AND `Item` IN (17713, 17714); 
UPDATE `reference_loot_template` SET `Chance` = 0.3 WHERE `Entry` = @Entry AND `Item` IN (17780); 

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_08' WHERE sql_rev = '1631734068732546500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
