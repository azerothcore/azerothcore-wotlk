-- DB update 2021_10_20_14 -> 2021_10_20_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_20_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_20_14 2021_10_20_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634412913533378100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634412913533378100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 3 AND `SourceEntry` = 6741;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 6741, 0, 0, 9, 0, 8354, 0, 0, 0, 0, 0, '', 'SAI id 2 for NPC Innkeeper Norman can only run if player has quest Chicken Clucking for a Mint');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 3 AND `SourceEntry` = 5111;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 5111, 0, 0, 9, 0, 8353, 0, 0, 0, 0, 0, '', 'SAI id 2 for NPC Innkeeper Firebrew can only run if player has quest Chicken Clucking for a Mint');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6741) AND (`source_type` = 0) AND (`id` IN (2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6741, 0, 2, 3, 22, 0, 100, 0, 22, 0, 0, 0, 0, 33, 6741, 0, 0, 0, 0,0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Innkeeper Norman - Received Emote 22 - Quest Credit \'Chicken Clucking for a Mint'),
(6741, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 15, 8354, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Innkeeper Norman - Received Emote 22 - Quest Credit \'Chicken Clucking for a Mint'),
(6741, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Innkeeper Norman - Received Emote 22 - Talk 0');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5111) AND (`source_type` = 0) AND (`id` = 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5111, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Innkeeper Firebrew - Received Emote 22 - Talk 0');

UPDATE `smart_scripts` SET `link` = 3 WHERE `entryorguid` = 5111 AND `source_type` = 0 AND `id` = 2;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_20_15' WHERE sql_rev = '1634412913533378100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
