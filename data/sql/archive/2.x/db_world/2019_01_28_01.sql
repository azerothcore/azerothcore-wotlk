-- DB update 2019_01_28_00 -> 2019_01_28_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_28_00 2019_01_28_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1548367133880932410'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1548367133880932410');

-- original fix by Killyana
UPDATE `quest_template_addon` SET `NextQuestID`=0 WHERE `id` IN (415, 618, 8554);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 19 AND `SourceEntry`= 619;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(19, 0, 619, 0, 0, 9, 0, 618, 0, 0, 0, 0, 0, '', "Enticing Negolash"),
(19, 0, 619, 0, 1, 9, 0, 8554, 0, 0, 0, 0, 0, '', "Enticing Negolash");
UPDATE `quest_template_addon` SET `PrevQuestID`=12294, `NextQuestID`=12225, `ExclusiveGroup`=-12222 WHERE `id` IN (12222);
UPDATE `quest_template_addon` SET `PrevQuestID`=12294, `NextQuestID`=12225, `ExclusiveGroup`=-12222 WHERE `id` IN (12223);

-- original fix by ariel-
ALTER TABLE `quest_template_addon` CHANGE `NextQuestID` `NextQuestID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT 0;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
