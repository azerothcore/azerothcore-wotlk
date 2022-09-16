-- DB update 2021_09_22_00 -> 2021_09_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_22_00 2021_09_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631219641576125800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631219641576125800');

UPDATE `creature_template` SET `ScriptName`='npc_shay_leafrunner', `AiName`='' WHERE `entry`=7774;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7774 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=777400 AND `source_type`=9;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_23_00' WHERE sql_rev = '1631219641576125800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
