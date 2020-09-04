-- DB update 2020_09_04_00 -> 2020_09_04_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_09_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_09_04_00 2020_09_04_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1598193186708522500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598193186708522500');
/*
 * Dungeon: Lower Blackrock
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 323, `maxdmg` = 437, `DamageModifier` = 1.03 WHERE `entry` = 9097;
UPDATE `creature_template` SET `mindmg` = 300, `maxdmg` = 405, `DamageModifier` = 1.03 WHERE `entry` = 9045;
UPDATE `creature_template` SET `mindmg` = 302, `maxdmg` = 407, `DamageModifier` = 1.03 WHERE `entry` = 9098;
UPDATE `creature_template` SET `mindmg` = 329, `maxdmg` = 446, `DamageModifier` = 1.03 WHERE `entry` = 9258;
UPDATE `creature_template` SET `mindmg` = 237, `maxdmg` = 321, `DamageModifier` = 1.03 WHERE `entry` = 9416;
UPDATE `creature_template` SET `mindmg` = 298, `maxdmg` = 386, `DamageModifier` = 1.03 WHERE `entry` = 9257;
UPDATE `creature_template` SET `mindmg` = 309, `maxdmg` = 405, `DamageModifier` = 1.03 WHERE `entry` = 9201;
UPDATE `creature_template` SET `mindmg` = 328, `maxdmg` = 441, `DamageModifier` = 1.03 WHERE `entry` = 9199;
UPDATE `creature_template` SET `mindmg` = 319, `maxdmg` = 437, `DamageModifier` = 1.03 WHERE `entry` = 9197;
UPDATE `creature_template` SET `mindmg` = 329, `maxdmg` = 446, `DamageModifier` = 1.03 WHERE `entry` = 9200;
UPDATE `creature_template` SET `mindmg` = 306, `maxdmg` = 414, `DamageModifier` = 1.03 WHERE `entry` = 9198;
UPDATE `creature_template` SET `mindmg` = 257, `maxdmg` = 347, `DamageModifier` = 1.03 WHERE `entry` = 9216;
UPDATE `creature_template` SET `mindmg` = 306, `maxdmg` = 414, `DamageModifier` = 1.03 WHERE `entry` = 9240;
UPDATE `creature_template` SET `mindmg` = 329, `maxdmg` = 446, `DamageModifier` = 1.03 WHERE `entry` = 9267;
UPDATE `creature_template` SET `mindmg` = 311, `maxdmg` = 417, `DamageModifier` = 1.03 WHERE `entry` = 9239;
UPDATE `creature_template` SET `mindmg` = 309, `maxdmg` = 412, `DamageModifier` = 1.03 WHERE `entry` = 9269;
UPDATE `creature_template` SET `mindmg` = 296, `maxdmg` = 387, `DamageModifier` = 1.03 WHERE `entry` = 9265;
UPDATE `creature_template` SET `mindmg` = 342, `maxdmg` = 464, `DamageModifier` = 1.03 WHERE `entry` = 9268;
UPDATE `creature_template` SET `mindmg` = 297, `maxdmg` = 376, `DamageModifier` = 1.03 WHERE `entry` = 9241;
UPDATE `creature_template` SET `mindmg` = 284, `maxdmg` = 352, `DamageModifier` = 1.03 WHERE `entry` = 9266;
UPDATE `creature_template` SET `mindmg` = 354, `maxdmg` = 478, `DamageModifier` = 1.03 WHERE `entry` = 9259; 
UPDATE `creature_template` SET `mindmg` = 312, `maxdmg` = 407, `DamageModifier` = 1.03 WHERE `entry` = 9261;
UPDATE `creature_template` SET `mindmg` = 307, `maxdmg` = 401, `DamageModifier` = 1.03 WHERE `entry` = 9262;
UPDATE `creature_template` SET `mindmg` = 257, `maxdmg` = 332, `DamageModifier` = 1.03 WHERE `entry` = 9264;
UPDATE `creature_template` SET `mindmg` = 296, `maxdmg` = 382, `DamageModifier` = 1.03 WHERE `entry` = 9260;
UPDATE `creature_template` SET `mindmg` = 301, `maxdmg` = 371, `DamageModifier` = 1.03 WHERE `entry` = 10374;
UPDATE `creature_template` SET `mindmg` = 243, `maxdmg` = 313, `DamageModifier` = 1.03 WHERE `entry` = 10375;
UPDATE `creature_template` SET `mindmg` = 418, `maxdmg` = 515, `DamageModifier` = 1.03 WHERE `entry` = 10601;
UPDATE `creature_template` SET `mindmg` = 377, `maxdmg` = 440, `DamageModifier` = 1.03 WHERE `entry` = 10602;
UPDATE `creature_template` SET `mindmg` = 298, `maxdmg` = 387, `DamageModifier` = 1.03 WHERE `entry` = 9716;
UPDATE `creature_template` SET `mindmg` = 189, `maxdmg` = 231, `DamageModifier` = 1.03 WHERE `entry` = 10221;
UPDATE `creature_template` SET `mindmg` = 283, `maxdmg` = 368, `DamageModifier` = 1.03 WHERE `entry` = 9583;
UPDATE `creature_template` SET `mindmg` = 275, `maxdmg` = 342, `DamageModifier` = 1.03 WHERE `entry` = 9692;
UPDATE `creature_template` SET `mindmg` = 131, `maxdmg` = 247, `DamageModifier` = 1.03 WHERE `entry` = 9696;
UPDATE `creature_template` SET `mindmg` = 187, `maxdmg` = 298, `DamageModifier` = 1.03 WHERE `entry` = 9717;
UPDATE `creature_template` SET `mindmg` = 182, `maxdmg` = 287, `DamageModifier` = 1.03 WHERE `entry` = 9693;
UPDATE `creature_template` SET `mindmg` = 312, `maxdmg` = 438, `DamageModifier` = 1.03 WHERE `entry` = 10447;
UPDATE `creature_template` SET `mindmg` = 239, `maxdmg` = 323, `DamageModifier` = 1.03 WHERE `entry` = 10442;

/* RARE */
UPDATE `creature_template` SET `mindmg` = 415, `maxdmg` = 528, `DamageModifier` = 1.02 WHERE `entry` = 9219;
UPDATE `creature_template` SET `mindmg` = 409, `maxdmg` = 517, `DamageModifier` = 1.02 WHERE `entry` = 9218;
UPDATE `creature_template` SET `mindmg` = 369, `maxdmg` = 436, `DamageModifier` = 1.02 WHERE `entry` = 9217;
UPDATE `creature_template` SET `mindmg` = 368, `maxdmg` = 497, `DamageModifier` = 1.02 WHERE `entry` = 9596;
UPDATE `creature_template` SET `mindmg` = 352, `maxdmg` = 485, `DamageModifier` = 1.02 WHERE `entry` = 10376;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 476, `maxdmg` = 634, `DamageModifier` = 1.01 WHERE `entry` = 9196;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 498, `maxdmg` = 642, `DamageModifier` = 1.01 WHERE `entry` = 9237;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 487, `maxdmg` = 626, `DamageModifier` = 1.01 WHERE `entry` = 9236;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 414, `maxdmg` = 571, `DamageModifier` = 1.01 WHERE `entry` = 9736;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 439, `maxdmg` = 613, `DamageModifier` = 1.01 WHERE `entry` = 10596;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 465, `maxdmg` = 647, `DamageModifier` = 1.01 WHERE `entry` = 10584;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 448, `maxdmg` = 607, `DamageModifier` = 1.01 WHERE `entry` = 10220;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 457, `maxdmg` = 618, `DamageModifier` = 1.01 WHERE `entry` = 10268;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 445, `maxdmg` = 592, `DamageModifier` = 1.01 WHERE `entry` = 9568;

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9416;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9416);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9416, 0, 0, 0, 2, 0, 100, 1, 40, 80, 0, 0, 11, 3604, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarshield Worg - Between 40-80% Health - Cast \'3604\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9219;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9219);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9219, 0, 0, 0, 0, 0, 100, 0, 2100, 3300, 12500, 14000, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spirestone Butcher - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9218;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9218);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9218, 0, 0, 0, 0, 0, 100, 0, 2100, 3300, 12500, 14000, 11, 13496, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Spirestone Battle Lord - In Combat - Cast \'13496\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 9596;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 9596);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9596, 0, 0, 0, 0, 0, 100, 0, 2300, 3200, 9500, 11000, 11, 6466, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Bannok Grimaxe - In Combat - Cast \'6466\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
