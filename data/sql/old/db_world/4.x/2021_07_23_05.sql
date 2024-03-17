-- DB update 2021_07_23_04 -> 2021_07_23_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_04 2021_07_23_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626687838564902600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626687838564902600');

-- Pyrewood leatherworker, Pyrewood Armorer,Moonrage armorer, Moonrage Leatherworker 
UPDATE `creature_template` SET `ArmorModifier` = 1.5 WHERE `entry` IN (3532, 3528, 3529, 3533);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_05' WHERE sql_rev = '1626687838564902600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
