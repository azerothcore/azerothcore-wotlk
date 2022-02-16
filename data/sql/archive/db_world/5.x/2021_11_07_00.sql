-- DB update 2021_11_06_07 -> 2021_11_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_06_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_06_07 2021_11_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633268017505597200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633268017505597200');

-- rookery guardians
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10258;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 10258 AND `source_type` = 0 AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10258, 0, 0, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 500, 1, 0, 0, 0, 0, 0, 0, 'Rookery Guardian - On Just Created - Start Attacking'),
(10258, 0, 1, 0, 0, 0, 100, 2, 10000, 12000, 10000, 15000, 0, 11, 15572, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rookery Guardian - In Combat - Cast \'Sunder Armor\' (Normal Dungeon)'),
(10258, 0, 2, 0, 0, 0, 100, 2, 5000, 7000, 4000, 6000, 0, 11, 15580, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rookery Guardian - In Combat - Cast \'Strike\' (Normal Dungeon)');

-- rookery hatcher
UPDATE `creature_template` SET `ScriptName` = 'npc_rookery_hatcher' WHERE `entry` = 10683;
DELETE FROM `creature_text` WHERE `CreatureID` = 10683;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `Comment`) VALUES
(10683, 0, 0, 'Intruders are destroying our eggs! Stop!!', 14, 0, 0, 0, 5538, 0, 'UBRS - Solakar event');

-- solakar
UPDATE `creature_template` SET `ScriptName` = 'boss_solakar_flamewreath' WHERE `entry` = 10264;

-- father flame
UPDATE `gameobject_template` SET `ScriptName` = 'go_father_flame' WHERE `entry` = 175245;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 175245 AND `source_type` = 1 AND `id` = 0;

-- partial cleanup for the eggs
DELETE FROM `gameobject_template` WHERE `entry` = 175622;
DELETE FROM `gameobject_template_addon` WHERE `entry` = 175622;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 175622;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_07_00' WHERE sql_rev = '1633268017505597200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
