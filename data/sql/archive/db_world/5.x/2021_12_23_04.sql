-- DB update 2021_12_23_03 -> 2021_12_23_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_23_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_23_03 2021_12_23_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640263955874251100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640263955874251100');

-- Set 100% drop chance for Abyssal crest in Crimson Templar / Azure Templar / Hoary Templar / Earthen Templar
UPDATE `creature_loot_template` SET `Chance`='100' WHERE `Item`=20513 AND `Reference`=0 AND `GroupId`=0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_23_04' WHERE sql_rev = '1640263955874251100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
