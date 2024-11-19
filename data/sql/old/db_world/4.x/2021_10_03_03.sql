-- DB update 2021_10_03_02 -> 2021_10_03_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_03_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_03_02 2021_10_03_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632775659744514900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632775659744514900');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 12938;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 12938, 0, 0, 31, 0, 3, 7665, 0, 0, 0, 0, '', 'Fel Curse Targets Grol the Destroyer'),
(13, 1, 12938, 0, 1, 31, 0, 3, 7666, 0, 0, 0, 0, '', 'Fel Curse Targets Archmage Allistarj'),
(13, 1, 12938, 0, 2, 31, 0, 3, 7667, 0, 0, 0, 0, '', 'Fel Curse Targets Lady Sevine'),
(13, 1, 12938, 0, 3, 31, 0, 3, 7664, 0, 0, 0, 0, '', 'Fel Curse Targets Razelikh the Defiler'),
(13, 1, 12938, 0, 4, 31, 0, 3, 7668, 0, 0, 0, 0, '', 'Fel Curse Targets Servent of Razelikh');

-- Grol the Destroyer
DELETE FROM `smart_scripts` WHERE `entryorguid` = 7665 AND `source_type` = 0 AND `id` IN (3, 4, 5);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7665, 0, 3, 0, 8, 0, 100, 0, 12938, 0, 0, 0, 0, 11, 12943, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grol the Destroyer - On Spellhit Fel Curse - Cast Fel Curse Effect'),
(7665, 0, 4, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grol the Destroyer - On Reset - Set HP Invincibility'),
(7665, 0, 5, 0, 8, 0, 100, 0, 12938, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grol the Destroyer - On Spellhit Fel Curse - Remove Invincibility');

-- Archmage Allistarj
DELETE FROM `smart_scripts` WHERE `entryorguid` = 7666 AND `source_type` = 0 AND `id` IN (6, 7, 8);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7666, 0, 6, 0, 8, 0, 100, 0, 12938, 0, 0, 0, 0, 11, 12943, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Allistarj - On Spellhit Fel Curse - Cast Fel Curse Effect'),
(7666, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Allistarj - On Reset - Set HP Invincibility'),
(7666, 0, 8, 0, 8, 0, 100, 0, 12938, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archmage Allistarj - On Spellhit Fel Curse - Remove Invincibility');

-- Lady Sevine
DELETE FROM `smart_scripts` WHERE `entryorguid` = 7667 AND `source_type` = 0 AND `id` IN (5, 6, 7);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7667, 0, 5, 0, 8, 0, 100, 0, 12938, 0, 0, 0, 0, 11, 12943, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Sevine - On Spellhit Fel Curse - Cast Fel Curse Effect'),
(7667, 0, 6, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Sevine - On Reset - Set HP Invincibility'),
(7667, 0, 7, 0, 8, 0, 100, 0, 12938, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Sevine - On Spellhit Fel Curse - Remove Invincibility');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_03_03' WHERE sql_rev = '1632775659744514900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
