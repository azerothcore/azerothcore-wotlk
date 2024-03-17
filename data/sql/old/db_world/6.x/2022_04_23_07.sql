-- DB update 2022_04_23_06 -> 2022_04_23_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_23_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_23_06 2022_04_23_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650152443729183400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650152443729183400');

-- Update to CONDITION_QUESTREWARDED as CONDITION_QUEST_COMPLETE is wrong for this.
UPDATE `conditions` SET `ConditionTypeOrReference` = 8, `Comment` = 'Show Gossip Menu - If Quest: What the Flux? is Rewarded' WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 5962 AND `SourceEntry` = 7115 AND `ConditionTypeOrReference` = 28;
-- Add Honored\Revered condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` = 5962 AND `SourceEntry` = 7121;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(14, 5962, 7121, 0, 0, 5, 0, 59, 96, 0, 0, 0, 0, '', 'Show Gossip Menu - If player is Honored\Revered with Thorium Brotherhood (59)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_23_07' WHERE sql_rev = '1650152443729183400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
