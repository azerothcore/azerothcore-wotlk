-- DB update 2022_03_27_22 -> 2022_03_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_22';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_22 2022_03_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648398529574716400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648398529574716400');

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (5481, 5482) AND `OptionID` = 0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`,`OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(5481, 0, 0, 'Rokaro, I have lost the Drakefire Amulet. Could another be created?', 9014, 1, 1, 0, 0, 0, 0, '', 0, 0),
(5482, 0, 0, 'Haleh, I have lost the Drakefire Amulet. Could you fashion another?', 9016, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` IN (5481, 5482)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 5481, 0, 0, 0, 2, 0, 16309, 1, 0, 1, 0, 0, '', 'Rokaro - Restore Drakefire Amulet - Must not have item Drakefire Amulet (16309)'),
(15, 5481, 0, 0, 0, 8, 0, 6502, 0, 0, 0, 0, 0, '', 'Rokaro - Restore Drakefire Amulet - Require quest Drakefire Amulet (6502) rewarded'),
(15, 5482, 0, 0, 0, 2, 0, 16309, 1, 0, 1, 0, 0, '', 'Haleh - Restore Drakefire Amulet - Must not have item Drakefire Amulet (16309)'),
(15, 5482, 0, 0, 0, 8, 0, 6602, 0, 0, 0, 0, 0, '', 'Haleh - Restore Drakefire Amulet - Require quest Drakefire Amulet (6502) rewarded');

-- Found spell Summon Drakefire Amulet DND (22207), but seems wrong, only targets self.
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (10929, 10182)) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10182, 0, 1, 2, 62, 0, 100, 0, 5481, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokaro - On Gossip Option 0 Selected - Close Gossip'),
(10182, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 56, 16309, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rokaro - On Link - Create \'Drakefire Amulet\''),
(10929, 0, 1, 2, 62, 0, 100, 0, 5482, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Haleh - On Gossip Option 1 Selected - Close Gossip'),
(10929, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 56, 16309, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Haleh - On Link - Create \'Drakefire Amulet\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_28_00' WHERE sql_rev = '1648398529574716400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
