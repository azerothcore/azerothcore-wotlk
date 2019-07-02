-- DB update 2019_07_02_00 -> 2019_07_02_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_02_00 2019_07_02_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561387934007172065'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561387934007172065');

-- Use SpellScript to summon the correct "Argent Knight" (Horde/Alliance) for "Argent War Horn"
DELETE FROM `spell_script_names` WHERE `spell_id` = 54307;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (54307,'spell_item_summon_argent_knight');

-- Set "Argent Dawn Banner (Visual)" not selectable
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 33554432 WHERE `entry` = 29443;

-- Despawn "Argent Tome" after 10 seconds; not clickable by players
UPDATE `gameobject_template` SET `type` = 5, `Data3` = 10000, `Data5` = 1 WHERE `entry` = 191312;

-- Prevent the "Argent Tome" trigger creature from falling down
UPDATE `creature_template` SET `InhabitType` = `InhabitType` | 4 WHERE `entry` = 29401;

-- "Argent Tome" SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29401;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29401 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2940100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29401,0,0,1,54,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Argent Tome - On Just Summoned - Set Rooted On'),
(29401,0,1,0,61,0,100,0,0,0,0,0,0,80,2940100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Argent Tome - Linked - Call Timed Action List'),
(2940100,9,0,0,0,0,100,0,0,0,0,0,0,20,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Argent Tome - Linked - Stop Auto Attack'),
(2940100,9,1,0,0,0,100,0,0,0,0,0,0,50,191312,10,0,0,0,0,1,0,0,0,0,0,0,0,0,'Argent Tome - On Script - Summon GO ''Argent Tome'''),
(2940100,9,2,0,0,0,100,0,1000,1000,0,0,0,9,0,0,0,0,0,0,15,191312,1,0,0,0,0,0,0,'Argent Tome - On Script - Activate GO ''Argent Tome'''),
(2940100,9,3,0,0,0,100,0,500,500,0,0,0,11,54419,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Argent Tome - On Script - Cast ''Argent Wisdom''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
