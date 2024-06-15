-- DB update 2021_07_10_00 -> 2021_07_10_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_10_00 2021_07_10_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625774675099271452'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625774675099271452');

UPDATE `creature_loot_template` SET `GroupId` = 1, `Comment` = 'Chief Ukorz Sandscalp - Spellshock Leggings' WHERE `Entry` = 7267 AND `Item` = 9484; 
UPDATE `creature_loot_template` SET `GroupId` = 1 WHERE `Entry` = 8127 AND `Item` = 9484;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_10_01' WHERE sql_rev = '1625774675099271452';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
