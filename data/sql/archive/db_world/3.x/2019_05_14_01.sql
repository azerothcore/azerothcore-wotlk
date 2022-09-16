-- DB update 2019_05_14_00 -> 2019_05_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_05_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_05_14_00 2019_05_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1557266833616361000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1557266833616361000');


UPDATE `creature_template` SET `ScriptName`='npc_burning_spirit' WHERE `entry`=9178;

DELETE FROM `creature_text` WHERE `CreatureID` = 9156;
INSERT INTO `creature_text` (`CreatureID`, `Text`, `Type`, `Probability`, `comment`) VALUES ('9156', 'Your reign of terror ends now! Face your doom mortals!', '14', '100', 'Ambassador_flamelash_aggro');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
