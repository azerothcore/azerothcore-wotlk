-- DB update 2022_02_04_03 -> 2022_02_04_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_04_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_04_03 2022_02_04_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643223104276234400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643223104276234400');

UPDATE `creature_template` SET `npcflag` = `npcflag`|1, `gossip_menu_id`= 2871, `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry`= 10668;

DELETE FROM `gossip_menu` WHERE `MenuID` IN (2871,2872);
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES
(2871, 3557),
(2872, 3558);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 2871;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 2871, 0, 0, 0, 9, 0, 4921, 0, 0, 0, 0, 0, '', 'Show gossip option 2871 if quest 4921 is taken.');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10668) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10668, 0, 0, 0, 62, 0, 100, 0, 2871, 0, 0, 0, 0, 33, 10668, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Beaten Corpse - On Gossip Option 0 Selected - Quest Credit \'Lost In Battle\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_04_04' WHERE sql_rev = '1643223104276234400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
