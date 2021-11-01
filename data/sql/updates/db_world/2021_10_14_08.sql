-- DB update 2021_10_14_07 -> 2021_10_14_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_14_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_14_07 2021_10_14_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633972846166794700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633972846166794700');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 1282 AND `SourceEntry` = 0 AND  `ConditionTypeOrReference` = 47;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1282, 0, 0, 0, 47, 0, 3566, 8, 0, 0, 0, 0, '', 'Alter of Suntara - Show gossip option only if player has quest in progress \'Rise, Obsidion!\'');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 148498) AND (`source_type` = 1) AND (`id` IN (0, 1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(148498, 1, 0, 1, 62, 0, 100, 0, 1282, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Altar of Suntara - On Gossip Option 0 Selected - Close Gossip'),
(148498, 1, 1, 2, 61, 0, 100, 0, 1282, 0, 0, 0, 0, 12, 8391, 4, 90000, 0, 0, 0, 8, 0, 0, 0, 0, -6460.53, -1267.63, 180.782, 1.89, 'Altar of Suntara - On Gossip Option 0 Selected - Summon Creature \'Lathoric the Black\''),
(148498, 1, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 105, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Altar of Suntara - On Link - Add Gameobject Flags Interact Condition'),
(148498, 1, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 300000, 300000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Altar of Suntara - On Link - Create Timed Event 1'),
(148498, 1, 4, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 106, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Altar of Suntara - On Update - Remove Gameobject Flags Interact Condition');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_14_08' WHERE sql_rev = '1633972846166794700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
