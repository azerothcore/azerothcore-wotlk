-- DB update 2021_09_01_13 -> 2021_09_01_14
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_13 2021_09_01_14 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630148697901793648'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630148697901793648');

-- Minimum of 3 Thorium Ore drops from Rich Thorium Vein
UPDATE `gameobject_loot_template` SET `MinCount` = 3 WHERE `Item` = 10620 AND `Entry` = 12883;
-- Minimum of 4 Dense Stone drops from Rich Thorium Vein
UPDATE `gameobject_loot_template` SET `MinCount` = 4 WHERE `Item` = 12365 AND `Entry` = 12883;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_14' WHERE sql_rev = '1630148697901793648';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
