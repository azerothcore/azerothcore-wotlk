-- DB update 2022_01_06_01 -> 2022_01_06_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_06_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_06_01 2022_01_06_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641335115392148600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641335115392148600');

SET @QUEST_BOLGORE = 6136;
SET @QUEST_DUSKWING = 6135;
SET @QUEST_CALL_TO_COMMAND = 14349;
SET @QUEST_DEPRECATED_1 = 6144;
SET @QUEST_DEPRECATED_2 = 6145;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 19) AND (`SourceGroup` = 0) AND (`SourceEntry` IN (@QUEST_BOLGORE, @QUEST_DUSKWING, @QUEST_CALL_TO_COMMAND));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, @QUEST_BOLGORE, 0, 0, 47, 0, 6022, 64, 0, 0, 0, 0, '', 'Display \'The Corpulent One\' if \'To Kill With Purpose\' is rewarded'),
(19, 0, @QUEST_BOLGORE, 0, 0, 47, 0, 6042, 64, 0, 0, 0, 0, '', 'Display \'The Corpulent One\' if \'Un-Life\'s Little Annoyances\' is rewarded'),
(19, 0, @QUEST_BOLGORE, 0, 0, 47, 0, 6133, 64, 0, 0, 0, 0, '', 'Display \'The Corpulent One\' if \'The Ranger Lord\'s Behest\' is rewarded'),
(19, 0, @QUEST_DUSKWING, 0, 0, 47, 0, 6022, 64, 0, 0, 0, 0, '', 'Display \'Duskwing, Oh How I Hate Thee...\' if \'To Kill With Purpose\' is rewarded'),
(19, 0, @QUEST_DUSKWING, 0, 0, 47, 0, 6042, 64, 0, 0, 0, 0, '', 'Display \'Duskwing, Oh How I Hate Thee...\' if \'Un-Life\'s Little Annoyances\' is rewarded'),
(19, 0, @QUEST_DUSKWING, 0, 0, 47, 0, 6133, 64, 0, 0, 0, 0, '', 'Display \'Duskwing, Oh How I Hate Thee...\' if \'The Ranger Lord\'s Behest\' is rewarded'),
(19, 0, @QUEST_CALL_TO_COMMAND, 0, 0, 47, 0, @QUEST_DUSKWING, 64, 0, 0, 0, 0, '', 'Display \'Call to Command\' if \'Duskwing, Oh How I Hate Thee...\' is rewarded'),
(19, 0, @QUEST_CALL_TO_COMMAND, 0, 0, 47, 0, @QUEST_BOLGORE, 64, 0, 0, 0, 0, '', 'Display \'Call to Command\' if \'The Corpulent One\' is rewarded');

DELETE FROM `disables` WHERE `entry` IN (@QUEST_DEPRECATED_1, @QUEST_DEPRECATED_2) AND `sourceType` = 1;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES 
(1, @QUEST_DEPRECATED_1, 'Disable Quest The Call to Command'),
(1, @QUEST_DEPRECATED_2, 'Disable Quest The Crimson Courier');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_06_02' WHERE sql_rev = '1641335115392148600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
