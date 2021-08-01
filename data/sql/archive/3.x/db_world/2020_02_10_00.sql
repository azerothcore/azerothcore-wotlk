-- DB update 2020_02_05_00 -> 2020_02_10_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_02_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_02_05_00 2020_02_10_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1579389922264853693'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1579389922264853693');

-- Sasha: Fix talk targets; fix shooting Anatoly
UPDATE `smart_scripts` SET `action_param3` = 1, `target_type` = 9, `target_param1` = 26971, `target_param2` = 0, `target_param3` = 20 WHERE `entryorguid` = 26935 AND `source_type` = 0 AND `id` IN (0,1,2);
UPDATE `smart_scripts` SET `action_param3` = 1, `target_type` = 9, `target_param1` = 26971, `target_param2` = 0, `target_param3` = 30 WHERE `entryorguid` = 2693500 AND `source_type` = 9 AND `id` IN (0,1,2);
UPDATE `smart_scripts` SET `event_param1` = 12700, `event_param2` = 12700, `action_param1` = 48424 WHERE `entryorguid` = 2693500 AND `source_type` = 9 AND `id` = 3;

-- Tatjana: Stop attack / combat movement after being hit by the Tranquilizer Dart
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27627 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27627,0,0,0,11,0,100,0,0,0,0,0,0,11,43671,0,0,0,0,0,9,27626,0,5,0,0,0,0,0,'Tatjana - On Respawn - Cast Spell ''Ride Vehicle'''),
(27627,0,1,2,8,0,100,0,49134,0,0,0,0,11,49135,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana - On Spell Hit ''Tranquilizer Dart'' - Cast Spell ''Tatjana Ping'''),
(27627,0,2,3,61,0,100,0,0,0,0,0,0,18,393984,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana - Linked - Set Unit Flags ''STUNNED'', ''PACIFIED'', ''IMMUNE_TO_PC'', ''IMMUNE_TO_NPC'''),
(27627,0,3,4,61,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana - Linked - Stop Auto Attack'),
(27627,0,4,0,61,0,100,0,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana - Linked - Stop Combat Movement'),
(27627,0,5,0,0,0,100,0,2000,6000,9000,12000,0,11,32009,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Tatjana - IC - Cast Spell ''Cutdown'''),
(27627,0,6,0,38,0,100,0,0,1,0,0,0,41,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana - On Data Set 0 1 - Despawn After 15 Seconds'),
(27627,0,7,0,38,0,100,0,0,2,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana - On data set 0 2 - Set home position');

-- Tatjana''s Horse: Use stored target to complete the quest
UPDATE `smart_scripts` SET `target_type` = 12, `target_param1` = 1 WHERE `entryorguid` = 27626 AND `source_type` = 0 AND `id` = 6;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2762600 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2762600,9,0,0,0,0,100,0,500,500,0,0,0,53,1,27626,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana''s Horse - On Script - Start WP movement'),
(2762600,9,1,0,0,0,100,0,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tatjana''s Horse - On Script - Set Faction'),
(2762600,9,2,0,0,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Tatjana''s Horse - On Script - Store Target List 1');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
