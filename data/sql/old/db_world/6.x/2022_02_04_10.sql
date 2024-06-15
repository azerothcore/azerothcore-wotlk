-- DB update 2022_02_04_09 -> 2022_02_04_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_04_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_04_09 2022_02_04_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643318127094399900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643318127094399900');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 14 AND `SourceGroup` IN (3183, 3184) AND `SourceEntry` IN (4039, 4040);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` IN (3183, 3184) AND `SourceEntry` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 3184, 4039, 0, 0, 8, 0, 5217, 0, 0, 0, 0, 0, '', 'Only show TextID 4039 if player completed the quest \'Return to Chillwind Camp\''),
(15, 3184, 0, 0, 0, 8, 0, 5217, 0, 0, 0, 0, 0, '', 'Show gossip option if player has completed quest \'Return to Chillwind Camp\''),
(14, 3183, 4040, 0, 0, 8, 0, 5230, 0, 0, 0, 0, 0, '', 'Only show TextID 4040 if player completed the quest \'Return to the Bulwark\''),
(15, 3183, 0, 0, 0, 8, 0, 5230, 0, 0, 0, 0, 0, '', 'Show gossip option if player has completed quest \'Return to the Bulwark\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_04_10' WHERE sql_rev = '1643318127094399900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
