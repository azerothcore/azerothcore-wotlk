-- DB update 2022_02_10_01 -> 2022_02_10_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_10_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_10_01 2022_02_10_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642981864918755200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642981864918755200');

DELETE FROM `creature_text` WHERE `CreatureID` IN (4949, 10719) AND `GroupID` IN (0, 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(4949, 0, 0, 'Honor your heroes! On this day, they have dealt a great blow against one of our most hated enemies! The false Warchief, Rend Blackhand, has fallen!', 14, 0, 100, 22, 0, 0, 6013, 2, 'For The Horde! quest completion'),
(4949, 1, 0, 'Be bathed in my power! Drink in my might! Battle for the glory of the Horde!', 14, 0, 100, 22, 0, 0, 6014, 2, 'For The Horde! quest completion'),
(10719, 0, 0, 'Honor your heroes! On this day, they have dealt a great blow against one of our most hated enemies! The false Warchief, Rend Blackhand, has fallen!', 14, 0, 100, 22, 0, 0, 6013, 2, 'For The Horde! quest completion'),
(10719, 1, 0, 'Be bathed in the power of the Warchief! Drink in his might! Battle for the glory of the Horde!', 14, 0, 100, 22, 0, 0, 6015, 2, 'For The Horde! quest completion');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10719;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10719) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10719, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Herald of Thrall - On Just Summoned - Set Flags Not Attackable'),
(10719, 0, 1, 0, 1, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 0, 13, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Herald of Thrall - Out of Combat - Say Line 0'),
(10719, 0, 2, 0, 1, 0, 100, 0, 13000, 13000, 0, 0, 0, 1, 1, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Herald of Thrall - Out of Combat - Say Line 1'),
(10719, 0, 3, 0, 1, 0, 100, 0, 15000, 15000, 0, 0, 0, 11, 16609, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Herald of Thrall - Out of Combat - Cast \'Warchief`s Blessing\'');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_10_02' WHERE sql_rev = '1642981864918755200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
