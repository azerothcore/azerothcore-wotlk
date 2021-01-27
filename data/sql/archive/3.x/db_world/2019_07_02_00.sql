-- DB update 2019_07_01_00 -> 2019_07_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_07_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_07_01_00 2019_07_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1561467004981777657'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561467004981777657');

DELETE FROM `creature_template_addon` WHERE `entry` IN (11325,11326);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(11325,0,0,0,0,0,'69205'), -- "Sleepy Pet" aura for Panda Cub
(11326,0,0,0,0,0,'18873'); -- "Diablo" aura for Mini Diablo

-- Panda Cub SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11325;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 11325 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 1132500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(11325,0,0,0,8,0,100,0,69204,0,0,0,0,80,1132500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Panda Cub - On Spell Hit - Call Random Action List'),
(1132500,9,0,0,0,0,100,0,10000,15000,0,0,0,28,69204,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Panda Cub - On Script - Remove Aura ''Sleepy Pet'''),
(1132500,9,1,0,0,0,50,0,500,500,0,0,0,11,34999,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Panda Cub - On Script (50% Chance) - Cast Spell ''Emote Roar''');

-- Willy: disable fly / hover
UPDATE `creature_template` SET `AIName` = 'SmartAI', `InhabitType` = 3 WHERE `entry` = 23231;
UPDATE `creature_template_addon` SET `bytes1` = 0 WHERE `entry` = 23231;

-- Willy SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23231 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2323100 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(23231,0,0,0,1,0,100,1,15000,30000,0,0,0,80,2323100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Willy - OOC - Call Action List (No Repeat)'),
(2323100,9,0,0,0,0,100,0,0,0,0,0,0,11,40663,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Willy - On Script - Cast Spell ''Willy'''),
(2323100,9,1,0,0,0,100,0,15000,25000,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Willy - On Script - Evade');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
