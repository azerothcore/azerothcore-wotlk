-- DB update 2021_12_09_03 -> 2021_12_09_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_09_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_09_03 2021_12_09_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638374497455068200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638374497455068200');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` IN (15)) AND (`SourceGroup` = 7083);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7083, 1, 0, 0, 47, 0, 8924, 8, 0, 0, 0, 0, '', 'Display Gossip option if quest not complete "Hunting for Ectoplasm"'),
(15, 7083, 1, 0, 0, 2, 0, 21946, 1, 0, 1, 0, 0, '', 'If the player does not have "Ectoplasmic Distiller" on his/her inventory.'),
(15, 7083, 1, 0, 0, 2, 0, 21946, 1, 1, 1, 0, 0, '', 'If the player does not have "Ectoplasmic Distiller" on the bank.'),
(15, 7083, 0, 0, 1, 2, 0, 22115, 1, 0, 1, 0, 0, '', 'If the player does not have "Extra-Dimensional Ghost Revealer" on his/her inventory.'),
(15, 7083, 0, 0, 1, 2, 0, 22115, 1, 1, 1, 0, 0, '', 'If the player does not have "Extra-Dimensional Ghost Revealer" on the bank.'),
(15, 7083, 0, 0, 2, 2, 0, 22115, 1, 0, 1, 0, 0, '', 'If the player does not have "Extra-Dimensional Ghost Revealer" on his/her inventory.'),
(15, 7083, 0, 0, 2, 2, 0, 22115, 1, 1, 1, 0, 0, '', 'If the player does not have "Extra-Dimensional Ghost Revealer" on the bank.'),
(15, 7083, 0, 0, 1, 47, 0, 8977, 74, 1, 0, 0, 0, '', 'If the player got or completed quest "Return to Deliana" (Alliance)'),
(15, 7083, 0, 0, 2, 47, 0, 8978, 74, 1, 0, 0, 0, '', 'If the player got or completed quest "Return to Mokvar" (Horde)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16014;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16014);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16014, 0, 0, 0, 62, 0, 100, 0, 7083, 0, 0, 0, 0, 56, 22115, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mux Manascrambler - On Gossip Option 0 Selected - Add Item \'Extra-Dimensional Ghost Revealer\' 1 Time'),
(16014, 0, 1, 0, 62, 0, 100, 0, 7083, 1, 0, 0, 0, 56, 21946, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mux Manascrambler - On Gossip Option 1 Selected - Add Item \'Ectoplasmic Distiller\' 1 Time'),
(16014, 0, 2, 0, 62, 0, 100, 0, 7083, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mux Manascrambler - On Gossip Option 0 Selected - Close Gossip'),
(16014, 0, 3, 0, 62, 0, 100, 0, 7083, 1, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mux Manascrambler - On Gossip Option 1 Selected - Close Gossip');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_09_04' WHERE sql_rev = '1638374497455068200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
