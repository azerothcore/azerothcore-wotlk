-- DB update 2017_08_18_00 -> 2017_08_18_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_18_00 2017_08_18_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1499101625045878500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1499101625045878500');

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (46337, 'spell_gen_crab_disguise');
UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` = 25863;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(25863, 0, 0, 0, 4, 0, 100, 0, 1000, 1000, 1800000, 1800000, 11, 184, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Firesworn - On Aggro - Cast \'Fire Shield\''),
(25863, 0, 1, 0, 0, 0, 100, 0, 0, 0, 3400, 5400, 11, 20793, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Twilight Firesworn - In Combat CMC - Cast \'Fireball\''),
(25863, 0, 2, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Twilight Firesworn - Between 0-15% Health - Flee For Assist (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
