-- DB update 2020_01_11_00 -> 2020_01_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_01_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_01_11_00 2020_01_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1578865588449656124'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1578865588449656124');

UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `guid` IN (96069,96100);
UPDATE `creature_addon` SET `bytes1` = 0 WHERE `guid` IN (96069,96100);

UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `id` = 26369 AND `guid` IN (SELECT `guid` FROM `creature_addon` WHERE `bytes1` = 1);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
