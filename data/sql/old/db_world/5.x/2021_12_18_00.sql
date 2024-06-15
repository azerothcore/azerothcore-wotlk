-- DB update 2021_12_17_16 -> 2021_12_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_17_16';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_17_16 2021_12_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639268079290723100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639268079290723100');

-- Hotfix (2010-02-18): The drop rate of Frost Lotus, from herbs in Northrend, has been increased by 50%. From 5% to 7.5%
UPDATE `gameobject_loot_template` SET `Chance` = 7.5 WHERE `Entry` = 24093 AND `Item` = 36908;
UPDATE `gameobject_loot_template` SET `Chance` = 7.5 WHERE `Entry` = 24224 AND `Item` = 36908;
UPDATE `gameobject_loot_template` SET `Chance` = 7.5 WHERE `Entry` = 24225 AND `Item` = 36908;
UPDATE `gameobject_loot_template` SET `Chance` = 7.5 WHERE `Entry` = 24226 AND `Item` = 36908;
UPDATE `gameobject_loot_template` SET `MaxCount` = 1, `Chance` = 7.5 WHERE `Entry` = 24227 AND `Item` = 36908;
UPDATE `gameobject_loot_template` SET `Chance` = 7.5 WHERE `Entry` = 25089 AND `Item` = 36908;
UPDATE `gameobject_loot_template` SET `Chance` = 7.5 WHERE `Entry` = 25093 AND `Item` = 36908;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_18_00' WHERE sql_rev = '1639268079290723100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
