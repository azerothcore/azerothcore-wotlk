-- DB update 2017_06_12_00 -> 2017_06_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_06_12_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_06_12_00 2017_06_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1494246194005123844'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1494246194005123844');

DELETE FROM `areatrigger_involvedrelation` WHERE `id` in (302,1667);
INSERT INTO `areatrigger_involvedrelation` VALUES (1667,1265);


DELETE FROM `areatrigger_scripts` WHERE `entry` = 302;
INSERT INTO `areatrigger_scripts` VALUES (302,'at_sentry_point');

UPDATE `creature_template` SET `ScriptName` = 'npc_archmage_tervosh' WHERE `entry` = 4967;

DELETE FROM `creature_text` WHERE `entry` = 4967 AND `groupid` = 0 and `id` = 0;
INSERT INTO `creature_text` VALUES (4967, 0, 0, 'Go with grace, and may the Lady\'s magic protect you.', 12, 0, 100, 0, 0, 0, 1751, 0, 'SAY1');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
