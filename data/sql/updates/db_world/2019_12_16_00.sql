-- DB update 2019_12_15_00 -> 2019_12_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_12_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_12_15_00 2019_12_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1574980316492398478'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1574980316492398478');

-- Citizen of New Avalon: Delete redundant creature text entries
DELETE FROM `creature_text` WHERE `CreatureID` = 28942 AND `GroupID` = 3;

-- Citizen of New Avalon: Fix talk actions
UPDATE `smart_scripts` SET `action_param1` = 2 WHERE `entryorguid` = 28942 AND `source_type` = 0 AND `id` = 2;
UPDATE `smart_scripts` SET `action_param1` = 1, `action_param3` = 1 WHERE `entryorguid` = 2894200 AND `source_type` = 9 AND `id` = 0;
UPDATE `smart_scripts` SET `action_param1` = 0, `action_param3` = 1 WHERE `entryorguid` = 2894201 AND `source_type` = 9 AND `id` = 0;
UPDATE `smart_scripts` SET `action_param1` = 0, `action_param3` = 1 WHERE `entryorguid` = 2894202 AND `source_type` = 9 AND `id` = 0;

-- Citizen of New Avalon: Move to another position as they are standing inside each other
UPDATE `creature` SET `position_x` = 1614.72, `position_y` = -5724.37, `position_z` = 120.95, `orientation` = 3.19584 WHERE `guid` = 129804;
UPDATE `creature` SET `position_x` = 1612.18, `position_y` = -5728.73, `position_z` = 120.118, `orientation` = 2.90132 WHERE `guid` = 129774;
UPDATE `creature` SET `position_x` = 1619.92, `position_y` = -5734.29, `position_z` = 120.06, `orientation` = 2.58715 WHERE `guid` = 129733;
UPDATE `creature` SET `position_x` = 1579.9, `position_y` = -5750.36, `position_z` = 120.256, `orientation` = 1.36978 WHERE `guid` = 129765;
UPDATE `creature` SET `position_x` = 1575.3, `position_y` = -5747.62, `position_z` = 120.62, `orientation` = 0.94174 WHERE `guid` = 129767;
UPDATE `creature` SET `position_x` = 1570.77, `position_y` = -5749.48, `position_z` = 120.949, `orientation` = 0.68647 WHERE `guid` = 129783;
UPDATE `creature` SET `position_x` = 1578.68, `position_y` = -5754.74, `position_z` = 120.208, `orientation` = 1.04776 WHERE `guid` = 129750;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
