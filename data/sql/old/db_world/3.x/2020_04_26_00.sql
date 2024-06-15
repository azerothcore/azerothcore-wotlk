-- DB update 2020_04_25_01 -> 2020_04_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_25_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_25_01 2020_04_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1584403279317487100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584403279317487100');

-- Grizzly Hills, Alliance Log Ride Start
-- npc gordun
DELETE FROM `gossip_menu_option` WHERE `MenuID`=21251 AND `OptionID`=1;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES (21251, 1, 0, 'Yes, I am ready to travel to Venture Bay!', 26605, 1, 1, 0, 0, 0, 0, NULL, 0, 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27414;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27414);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27414, 0, 0, 1, 62, 0, 100, 0, 21251, 1, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordun - On Gossip Option 1 Selected - Close Gossip'),
(27414, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 85, 48622, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordun - On Gossip Option 1 Selected - Invoker Cast \'Alliance Log Ride 01 Begin\''),
(27414, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 85, 48621, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gordun - On Gossip Option 1 Selected - Invoker Cast \'Log Ride Alliance 01\'');

-- Grizzly Hills, Horde Log Ride Start
-- npc darrok
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27425;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27425);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27425, 0, 0, 1, 62, 0, 100, 0, 9528, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrok - On Gossip Option 0 Selected - Close Gossip'),
(27425, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 85, 48960, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrok - On Gossip Option 0 Selected - Invoker Cast \'Horde Log Ride 01 Begin\''),
(27425, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 85, 48961, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrok - On Gossip Option 0 Selected - Invoker Cast \'Log Ride Horde 00\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
