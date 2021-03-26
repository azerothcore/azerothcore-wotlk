-- DB update 2020_11_22_01 -> 2020_11_23_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_22_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_22_01 2020_11_23_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1605340113678491500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605340113678491500');

UPDATE `quest_template_addon` SET `ExclusiveGroup` = 12582 WHERE `id` IN (12582,12689);
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `id` IN (12692,12695);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry` IN (12692,12695);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(19, 0, 12692, 0, 0, 43, 0, 12582, 0, 0, 0, 0, 0, '', 'Quest \'Return of the Lich Hunter\' available when \'Frenzyheart Champion\' has been rewarded'),
(19, 0, 12695, 0, 0, 43, 0, 12689, 0, 0, 0, 0, 0, '', 'Quest \'Return of the Friendly Dryskin\' available when \'Hand of the Oracles\' has been rewarded');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
