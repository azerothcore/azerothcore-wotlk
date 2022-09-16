-- DB update 2017_02_03_46 -> 2017_02_03_47
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_02_03_46';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_02_03_46 2017_02_03_47 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1486125349482449900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1486125349482449900');

DELETE FROM `creature` WHERE `guid` = "1978829";
DELETE FROM `creature` WHERE `guid` = "1978828";
DELETE FROM `linked_respawn` WHERE `guid` = "79283";
DELETE FROM `linked_respawn` WHERE `guid` = "79284";
DELETE FROM `linked_respawn` WHERE `guid` = "79285";
DELETE FROM `linked_respawn` WHERE `guid` = "79368";
DELETE FROM `linked_respawn` WHERE `guid` = "79378";
DELETE FROM `linked_respawn` WHERE `guid` = "79379";
DELETE FROM `linked_respawn` WHERE `guid` = "79380";
DELETE FROM `linked_respawn` WHERE `guid` = "79383";
UPDATE `quest_template_addon` SET `SpecialFlags` = "2" WHERE `ID` = "10409";--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
