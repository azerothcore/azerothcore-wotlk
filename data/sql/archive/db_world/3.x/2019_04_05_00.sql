-- DB update 2019_04_02_03 -> 2019_04_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_02_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_02_03 2019_04_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1554143974096714000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554143974096714000');

-- Fallen Hero of the Horde SAI
SET @ENTRY := 7572;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7572;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(7572, 0, 0, 2, 62, 0, 100, 0, 842, 0, 0, 0, 0, 26, 2784, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 0 from menu 842 selected - Action invoker: Call event happened from quest 2784 for the whole group // Fallen Hero of the Horde - On Gossip Option 0 Selected - Quest Credit \'Fall From Grace\''),
(7572, 0, 1, 2, 62, 0, 100, 0, 881, 0, 0, 0, 0, 26, 2801, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 0 from menu 881 selected - Action invoker: Call event happened from quest 2801 for the whole group // Fallen Hero of the Horde - On Gossip Option 1 Selected - Quest Credit \'A Tale of Sorrow\''),
(7572, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On link - Action invoker: Close gossip // Fallen Hero of the Horde - Close Gossip'),
(7572, 0, 3, 0, 19, 0, 100, 0, 2702, 0, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'When player accepts quest 2702 - Action invoker: Set phase id to 3 // '),
(7572, 0, 4, 0, 62, 0, 100, 0, 840, 2, 0, 0, 0, 44, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'On gossip action 2 from menu 840 selected - Action invoker: Set phase id to 3 // ');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
