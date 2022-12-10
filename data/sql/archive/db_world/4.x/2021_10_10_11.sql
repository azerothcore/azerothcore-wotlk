-- DB update 2021_10_10_10 -> 2021_10_10_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_10 2021_10_10_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633373249845490100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633373249845490100');

 -- Historian Karnik
SET @ENTRY := 2916;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 0;
UPDATE `creature_template` SET `AIName` = "SmartAI", `ScriptName` = "" WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 20, 0, 100, 0, 724, 0, 0, 0, 80, 291600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On player rewarded quest Prospect of Faith (724) - Self: Start timed action list id #291600 (update always)");


 -- Timed list 291600
SET @ENTRY := 291600;
DELETE FROM `smart_scripts` WHERE `entryOrGuid` = @ENTRY AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "After 0 seconds - Self: Remove npc flags GOSSIP, QUESTGIVER"),
(@ENTRY, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 2.30863, "After 0 seconds - Self: Set orientation to 2.30863"),
(@ENTRY, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 11, 4985, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "After 1 seconds - Self: Cast spell 4985 on Self"),
(@ENTRY, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 2915, 3, 21000, 0, 0, 0, 8, 0, 0, 0, -4633.14, -1324.99, 503.383, 5.44702, "After 0 seconds - Self: Summon creature Hammertoe's Spirit (2915) at (-4633.14, -1324.99, 503.383, 5.44702) as summon type timed despawn with duration 21 seconds"),
(@ENTRY, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 2915, 0, 0, 0, 0, 0, 0, "After 3 seconds - Closest alive creature Hammertoe's Spirit (2915) in 100 yards: Talk 0 to invoker"),
(@ENTRY, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "After 7 seconds - Self: Talk 0 to invoker"),
(@ENTRY, 9, 6, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 2915, 0, 0, 0, 0, 0, 0, "After 4 seconds - Closest alive creature Hammertoe's Spirit (2915) in 100 yards: Talk 1 to invoker"),
(@ENTRY, 9, 7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "After 8 seconds - Self: Talk 1 to invoker"),
(@ENTRY, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1.76278, "After 0 seconds - Self: Set orientation to 1.76278"),
(@ENTRY, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "After 0 seconds - Self: Add npc flags GOSSIP, QUESTGIVER");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_11' WHERE sql_rev = '1633373249845490100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
