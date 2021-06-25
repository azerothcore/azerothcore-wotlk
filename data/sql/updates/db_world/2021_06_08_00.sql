-- DB update 2021_06_06_01 -> 2021_06_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_06_01 2021_06_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622263128329617917'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622263128329617917');

-- Remove Scarlet Gauntlets from RLTs
DELETE FROM `reference_loot_template` WHERE `Entry` = 24056 AND `Item` = 10331;
DELETE FROM `reference_loot_template` WHERE `Entry` = 526790 AND `Item` = 10331;
-- Remove Scarlet Wristguard from RLT
DELETE FROM `reference_loot_template` WHERE `Entry` = 24054 AND `Item` = 10333;



--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_08_00' WHERE sql_rev = '1622263128329617917';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
