-- DB update 2020_11_01_00 -> 2020_11_01_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_01_00 2020_11_01_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1602784760535322900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602784760535322900');

UPDATE `quest_template_addon` SET `NextQuestID` = 0, `ExclusiveGroup` = 11995 WHERE `id` IN (11995, 12440);
UPDATE `quest_template_addon` SET `NextQuestID` = 12440 WHERE `id` = 12439;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `ConditionTypeOrReference` = 9 AND `SourceEntry` IN (11995, 12439, 12440);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(19, 0, 12439, 0, 0, 9, 0, 12000, 0, 0, 1, 0, 0, '', 'Quest 12439 is not available if 12000 has been taken'),
(19, 0, 11995, 0, 0, 9, 0, 12000, 0, 0, 1, 0, 0, '', 'Quest 11995 is not available if 12000 has been taken'),
(19, 0, 12440, 0, 0, 9, 0, 12000, 0, 0, 1, 0, 0, '', 'Quest 12440 is not available if 12000 has been taken');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
