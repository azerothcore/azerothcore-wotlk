-- DB update 2020_06_07_00 -> 2020_06_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_07_00 2020_06_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588338165355317100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588338165355317100');

/*
 * Dungeon: Zul'Farrak
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 176, `maxdmg` = 242, `DamageModifier` = 1.03 WHERE `entry` IN (5649, 8095);
UPDATE `creature_template` SET `mindmg` = 113, `maxdmg` = 170, `DamageModifier` = 1.03 WHERE `entry` = 5648;
UPDATE `creature_template` SET `mindmg` = 161, `maxdmg` = 224, `DamageModifier` = 1.03 WHERE `entry` IN (5650, 7247);
UPDATE `creature_template` SET `mindmg` = 176, `maxdmg` = 234, `DamageModifier` = 1.03 WHERE `entry` = 7269;
UPDATE `creature_template` SET `mindmg` = 149, `maxdmg` = 213, `minrangedmg` = 70, `maxrangedmg` = 112, `DamageModifier` = 1.03 WHERE `entry` = 7246;
UPDATE `creature_template` SET `mindmg` = 112, `maxdmg` = 177, `DamageModifier` = 1.03 WHERE `entry` = 8130;
UPDATE `creature_template` SET `mindmg` = 78, `maxdmg` = 95, `DamageModifier` = 1.03 WHERE `entry` = 7076;
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 204, `DamageModifier` = 1.03 WHERE `entry` = 7286;
UPDATE `creature_template` SET `mindmg` = 186, `maxdmg` = 264, `DamageModifier` = 1.03 WHERE `entry` = 7274;
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 226, `minrangedmg` = 86, `maxrangedmg` = 112, `DamageModifier` = 1.03 WHERE `entry` = 7607;
UPDATE `creature_template` SET `mindmg` = 141, `maxdmg` = 187, `DamageModifier` = 1.03 WHERE `entry` = 7605;
UPDATE `creature_template` SET `mindmg` = 167, `maxdmg` = 213, `DamageModifier` = 1.03 WHERE `entry` = 7608;
UPDATE `creature_template` SET `mindmg` = 122, `maxdmg` = 170, `DamageModifier` = 1.03 WHERE `entry` = 7606;
UPDATE `creature_template` SET `mindmg` = 152, `maxdmg` = 198, `DamageModifier` = 1.03 WHERE `entry` = 7789;
UPDATE `creature_template` SET `mindmg` = 73, `maxdmg` = 96, `DamageModifier` = 1.03 WHERE `entry` = 7788;
UPDATE `creature_template` SET `mindmg` = 88, `maxdmg` = 99, `DamageModifier` = 1.03 WHERE `entry` = 8877;
UPDATE `creature_template` SET `mindmg` = 77, `maxdmg` = 98, `DamageModifier` = 1.03 WHERE `entry` = 7787;
UPDATE `creature_template` SET `mindmg` = 58, `maxdmg` = 87, `DamageModifier` = 1.03 WHERE `entry` = 8876;
UPDATE `creature_template` SET `mindmg` = 182, `maxdmg` = 242, `DamageModifier` = 1.03 WHERE `entry` = 8120;
UPDATE `creature_template` SET `mindmg` = 155, `maxdmg` = 206, `DamageModifier` = 1.03 WHERE `entry` = 7268;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 198, `maxdmg` = 237, `DamageModifier` = 1.02, `unit_flags` = 0 WHERE `entry` = 10080;
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 179, `maxdmg` = 223, `DamageModifier` = 1.02, `unit_flags` = 0 WHERE `entry` = 10081;
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 169, `maxdmg` = 185, `DamageModifier` = 1.02, `unit_flags` = 0 WHERE `entry` = 10082;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 233, `maxdmg` = 309, `DamageModifier` = 1.01 WHERE `entry` = 7272; 
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 172, `maxdmg` = 228, `DamageModifier` = 1.01 WHERE `entry` IN (8127, 7271); 
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 182, `maxdmg` = 242, `DamageModifier` = 1.01 WHERE `entry` = 7604; 
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 131, `maxdmg` = 183, `DamageModifier` = 1.01 WHERE `entry` = 7795; 
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 269, `maxdmg` = 346, `DamageModifier` = 1.01 WHERE `entry` = 7796; 
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 259, `maxdmg` = 334, `DamageModifier` = 1.01 WHERE `entry` = 7275; 
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 251, `maxdmg` = 325, `DamageModifier` = 1.01 WHERE `entry` = 7273;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 237, `maxdmg` = 314, `DamageModifier` = 1.01 WHERE `entry` IN (7797, 7267); 

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10080;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10080);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10080, 0, 0, 0, 37, 0, 90, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Sandarr Dunereaver - On Initialize - Despawn In 500 ms'),
(10080, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandarr Dunereaver - On Aggro - Cast \'13730\''),
(10080, 0, 2, 0, 0, 0, 100, 0, 2700, 3100, 9600, 12300, 11, 14516, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandarr Dunereaver - In Combat - Cast \'14516\''),
(10080, 0, 3, 0, 0, 0, 100, 0, 8100, 8100, 19600, 19600, 11, 15615, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sandarr Dunereaver - In Combat - Cast \'15615\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10081;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10081);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10081, 0, 0, 0, 37, 0, 90, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Dustwraith - On Initialize - Despawn In 500 ms'),
(10081, 0, 1, 0, 0, 0, 100, 0, 1300, 1600, 15200, 16100, 11, 12251, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dustwraith - In Combat - Cast \'12251\''),
(10081, 0, 2, 0, 0, 0, 100, 0, 4200, 4600, 8200, 9400, 11, 14873, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Dustwraith - In Combat - Cast \'14873\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 10082;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 10082);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10082, 0, 0, 0, 37, 0, 90, 0, 0, 0, 0, 0, 41, 500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Zerillis - On Initialize - Despawn In 500 ms'),
(10082, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6533, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zerillis - On Aggro - Cast \'6533\''),
(10082, 0, 2, 0, 0, 0, 100, 0, 2100, 2500, 8600, 9400, 11, 15547, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zerillis - In Combat - Cast \'15547\''),
(10082, 0, 3, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 12551, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Zerillis - Between 20-40% Health - Cast \'12551\' (No Repeat)');

/* SPAWN */
DELETE FROM `creature` WHERE `guid` IN (205800, 205801, 205802);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(205800, 10081, 209, 0, 0, 1, 1, 0, 1, 1863.89, 1151.66, 12.9287, 0.540263, 86400, 0, 0, 5757, 0, 0, 0, 0, 0, '', 0),
(205801, 10082, 209, 0, 0, 1, 1, 0, 1, 1674.24, 904.853, 8.92432, 0.304632, 86400, 0, 0, 5544, 0, 0, 0, 0, 0, '', 0),
(205802, 10080, 209, 0, 0, 1, 1, 0, 1, 1546.16, 1015.47, 8.87699, 0.202525, 86400, 0, 0, 5544, 0, 0, 0, 0, 0, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
