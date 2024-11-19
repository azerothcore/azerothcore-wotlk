-- DB update 2021_10_14_06 -> 2021_10_14_07
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_14_06';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_14_06 2021_10_14_07 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629293787158639200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629293787158639200');

UPDATE `creature_template` SET `InhabitType` = `InhabitType` |1|8 WHERE (`entry` = 9707);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9707);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9707, 0, 0, 0, 60, 0, 100, 2, 5000, 5000, 5000, 5000, 0, 11, 15126, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Portal - On Update - Cast \'Summon Burning Imp\' (Normal Dungeon)'),
(9707, 0, 1, 0, 60, 0, 100, 2, 11000, 11000, 11000, 11000, 0, 11, 16002, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Portal - On Update - Cast \'Summon Burning Felhound\' (Normal Dungeon)'),
(9707, 0, 2, 0, 60, 0, 10, 3, 20000, 20000, 0, 0, 0, 11, 16004, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Portal - On Update - Cast \'Summon Burning Felguard\' (No Repeat) (Normal Dungeon)'),
(9707, 0, 3, 0, 54, 0, 100, 2, 0, 0, 0, 0, 0, 41, 30000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Portal - On Just Summoned - Despawn In 30000 ms (Normal Dungeon)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_14_07' WHERE sql_rev = '1629293787158639200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
