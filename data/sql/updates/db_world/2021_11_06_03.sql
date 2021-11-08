-- DB update 2021_11_06_02 -> 2021_11_06_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_06_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_06_02 2021_11_06_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635944366683482486'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635944366683482486');

-- Add missing weapons to Gordunni npcs
DELETE FROM `creature_equip_template` WHERE `CreatureID` IN (5239,5234,5236,5240);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(5239,1,5304,0,0,0),
(5234,1,1903,2809,0,0),
(5236,1,1907,0,0,0),
(5240,1,2559,0,0,0);

-- Pathing was added to these spawns without setting bytes2
UPDATE `creature_addon` SET `bytes2`=1 WHERE `guid` IN (50242,50267,50213,50209,50228,50275);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_06_03' WHERE sql_rev = '1635944366683482486';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
