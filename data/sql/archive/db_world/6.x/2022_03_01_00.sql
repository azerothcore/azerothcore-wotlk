-- DB update 2022_02_26_01 -> 2022_03_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_26_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_26_01 2022_03_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643833370324565100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643833370324565100');
/* THIS IS A WIP THAT NEEDS INFORMATION FROM WOTLK FOR ACCURACY TO PUSH */
UPDATE `creature_template` SET `gossip_menu_id`='5855' WHERE  `entry`=6094;
-- Condition for source Gossip menu condition type Skill
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=5855 AND `SourceEntry` IN (7026,7027,7028) AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 5855, 7026, 0, 0, 7, 0, 129, 225, 0, 0, 0, 0, '', 'Show gossip menu 5855 text id 7026 if player must have reached 225 on skill First Aid.'),
(14, 5855, 7027, 0, 0, 7, 0, 129, 150, 0, 0, 0, 0, '', 'Show gossip menu 5855 text id 7027 if player must have reached 150 on skill First Aid.'),
(14, 5855, 7028, 0, 0, 7, 0, 129, 150, 0, 1, 0, 0, '', 'Show gossip menu 5855 text id 7028 if player must not have reached 150 on skill First Aid.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_01_00' WHERE sql_rev = '1643833370324565100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
