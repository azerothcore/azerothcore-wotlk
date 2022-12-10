-- DB update 2021_09_01_24 -> 2021_09_01_25
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_24';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_24 2021_09_01_25 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630334062369804993'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630334062369804993');

-- Remove Rethban and Underlight ores from non-specific area drops
DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (1502, 1503) AND `Item` IN (2798, 22634);

-- Change Tirisfal outlier node to standard non-Redridge copper node 
UPDATE `gameobject` SET `id` = 1731 WHERE `id` = 2055 AND `guid` = 5483;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_25' WHERE sql_rev = '1630334062369804993';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
