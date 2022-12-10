-- DB update 2021_06_02_09 -> 2021_06_02_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_02_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_02_09 2021_06_02_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622117565567403115'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622117565567403115');

-- Remove Shriveled Heart from Farmer Ray
DELETE FROM `creature_loot_template` WHERE `Entry` = 232 AND `Item` = 9243;
-- Remove Sunroc Mask from Sawtooth Crocolisk
DELETE FROM `creature_loot_template` WHERE `Entry` = 1082 AND `Item` = 24737;
-- Remove Sunroc Gloves from Sawtooth Snapper
DELETE FROM `creature_loot_template` WHERE `Entry` = 1087 AND `Item` = 24736;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_02_10' WHERE sql_rev = '1622117565567403115';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
