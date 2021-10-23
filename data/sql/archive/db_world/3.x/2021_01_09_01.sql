-- DB update 2021_01_09_00 -> 2021_01_09_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_09_00 2021_01_09_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1595505810975581600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595505810975581600');

DELETE FROM `spell_script_names` WHERE  `spell_id`=45980 AND `ScriptName`='spell_gen_despawn_self';

UPDATE `creature_template` SET `unit_flags` = 2 WHERE (`entry` = 25773);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25773);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25773, 0, 0, 3, 54, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Survivor - On Just Summoned - Say Line 0'),
(25773, 0, 1, 2, 1, 0, 100, 0, 5000, 5000, 5000, 5000, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Survivor - Out of Combat - Despawn In 2000 ms'),
(25773, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 11, 41232, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Survivor - Out of Combat - Cast \'Teleport Visual Only\''),
(25773, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Survivor - On Just Summoned - Set Reactstate Passive');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25814);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25814, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Aggro - Say Line 1 (Phase 1) (No Repeat)'),
(25814, 0, 1, 2, 8, 0, 100, 0, 46485, 0, 0, 0, 0, 33, 26096, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Spellhit \'The Greatmother\'s Soulcatcher\' - Quest Credit \'Souls of the Decursed\''),
(25814, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Mechagnome - On Spellhit \'The Greatmother\'s Soulcatcher\' - Despawn In 10 ms');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
