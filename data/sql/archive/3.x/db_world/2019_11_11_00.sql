-- DB update 2019_11_09_00 -> 2019_11_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_09_00 2019_11_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1571737953110374673'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571737953110374673');

DELETE FROM `spell_script_names` WHERE `spell_id` = 17179;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(17179,'spell_scholomance_boon_of_life');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 10508 AND `SourceEntry` = 13626 AND `ConditionTypeOrReference` = 13;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(1,10508,13626,0,0,13,0,2,1,0,0,0,0,'','Instance - Get Data - Can only loot ''Human Head of Ras Frostwhisper'' if Ras is in human form');

DELETE FROM `creature_text` WHERE `CreatureID` = 10508;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(10508,0,0,'THIS CANNOT BE!!',14,0,100,0,0,0,6371,0,'Ras Frostwhisper');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
