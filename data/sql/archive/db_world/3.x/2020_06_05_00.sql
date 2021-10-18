-- DB update 2020_06_04_01 -> 2020_06_05_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_06_04_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_06_04_01 2020_06_05_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1588337316614118000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588337316614118000');

/*
 * Dungeon: Scarlet Monastery
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 112, `maxdmg` = 156, `DamageModifier` = 1.03 WHERE `entry` IN (4823, 4306);
UPDATE `creature_template` SET `mindmg` = 92, `maxdmg` = 124, `DamageModifier` = 1.03 WHERE `entry` = 6547;
UPDATE `creature_template` SET `mindmg` = 116, `maxdmg` = 156, `DamageModifier` = 1.03 WHERE `entry` IN (6427, 6426);
UPDATE `creature_template` SET `mindmg` = 146, `maxdmg` = 189, `DamageModifier` = 1.03 WHERE `entry` = 6493;
UPDATE `creature_template` SET `mindmg` = 112, `maxdmg` = 156, `DamageModifier` = 1.03 WHERE `entry` = 4308;
UPDATE `creature_template` SET `mindmg` = 103, `maxdmg` = 140, `DamageModifier` = 1.03 WHERE `entry` IN (4287, 4296);
UPDATE `creature_template` SET `mindmg` = 124, `maxdmg` = 171, `minrangedmg` = 89, `maxrangedmg` = 136, `DamageModifier` = 1.03 WHERE `entry` = 4288;
UPDATE `creature_template` SET `mindmg` = 93, `maxdmg` = 125, `DamageModifier` = 1.03 WHERE `entry` = 4304;
UPDATE `creature_template` SET `mindmg` = 106, `maxdmg` = 140, `DamageModifier` = 1.03 WHERE `entry` IN (4299, 4291);
UPDATE `creature_template` SET `mindmg` = 115, `maxdmg` = 154, `DamageModifier` = 1.03 WHERE `entry` = 4540;
UPDATE `creature_template` SET `mindmg` = 131, `maxdmg` = 177, `DamageModifier` = 1.03 WHERE `entry` = 4286;
UPDATE `creature_template` SET `mindmg` = 83, `maxdmg` = 115, `DamageModifier` = 1.03 WHERE `entry` = 4297;
UPDATE `creature_template` SET `mindmg` = 113, `maxdmg` = 152, `DamageModifier` = 1.03 WHERE `entry` = 575;
UPDATE `creature_template` SET `mindmg` = 83, `maxdmg` = 118, `DamageModifier` = 1.03 WHERE `entry` = 4289;
UPDATE `creature_template` SET `mindmg` = 108, `maxdmg` = 147, `DamageModifier` = 1.03 WHERE `entry` = 4292;
UPDATE `creature_template` SET `mindmg` = 184, `maxdmg` = 255, `DamageModifier` = 1.03 WHERE `entry` = 4290;
UPDATE `creature_template` SET `mindmg` = 115, `maxdmg` = 155, `DamageModifier` = 1.03 WHERE `entry` = 4295;
UPDATE `creature_template` SET `mindmg` = 143, `maxdmg` = 199, `DamageModifier` = 1.03 WHERE `entry` = 4301;
UPDATE `creature_template` SET `mindmg` = 30, `maxdmg` = 42, `DamageModifier` = 1.03 WHERE `entry` = 6575;
UPDATE `creature_template` SET `mindmg` = 90, `maxdmg` = 129, `DamageModifier` = 1.03 WHERE `entry` = 4300;
UPDATE `creature_template` SET `mindmg` = 87, `maxdmg` = 125, `DamageModifier` = 1.03 WHERE `entry` = 4294;
UPDATE `creature_template` SET `mindmg` = 121, `maxdmg` = 161, `DamageModifier` = 1.03 WHERE `entry` IN (4302, 4303);

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 174, `maxdmg` = 224, `DamageModifier` = 1.02 WHERE `entry` IN (6490, 6488);
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 166, `maxdmg` = 215, `DamageModifier` = 1.02 WHERE `entry` = 6489;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 193, `maxdmg` = 249, `DamageModifier` = 1.01 WHERE `entry` IN (3983, 4543, 3974, 6487);
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 215, `maxdmg` = 276, `DamageModifier` = 1.01 WHERE `entry` = 3975;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 229, `maxdmg` = 295, `DamageModifier` = 1.01 WHERE `entry` = 4542;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 269, `maxdmg` = 346, `DamageModifier` = 1.01 WHERE `entry` IN (3976, 3977);

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4285;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4285);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4285, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 8000, 12000, 11, 9734, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Disciple - In Combat - Cast \'9734\''),
(4285, 0, 1, 0, 2, 0, 100, 1, 25, 50, 0, 0, 11, 11640, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Disciple - Between 25-50% Health - Cast \'11640\' (No Repeat)'),
(4285, 0, 2, 0, 2, 0, 100, 1, 0, 10, 0, 0, 11, 11642, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Disciple - Between 0-10% Health - Cast \'11642\' (No Repeat)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4283;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 4283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4283, 0, 0, 0, 2, 0, 100, 1, 20, 80, 0, 0, 11, 3639, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Sentry - Between 20-80% Health - Cast \'3639\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
