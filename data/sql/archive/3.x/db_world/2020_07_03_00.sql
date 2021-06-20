-- DB update 2020_07_02_00 -> 2020_07_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_02_00 2020_07_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1589130360356001400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1589130360356001400');
/*
 * Dungeon: Auchenai Crypts
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 856, `maxdmg` = 1258, `DamageModifier` = 1.03 WHERE `entry` = 18495;
UPDATE `creature_template` SET `mindmg` = 951, `maxdmg` = 1398, `DamageModifier` = 1.03 WHERE `entry` = 20302;
UPDATE `creature_template` SET `mindmg` = 856, `maxdmg` = 1258, `DamageModifier` = 1.03 WHERE `entry` = 18493;
UPDATE `creature_template` SET `mindmg` = 951, `maxdmg` = 1398, `DamageModifier` = 1.03 WHERE `entry` = 20301;
UPDATE `creature_template` SET `mindmg` = 738, `maxdmg` = 1089, `DamageModifier` = 1.03 WHERE `entry` = 18497;
UPDATE `creature_template` SET `mindmg` = 1023, `maxdmg` = 1508, `DamageModifier` = 1.03 WHERE `entry` = 20299;
UPDATE `creature_template` SET `mindmg` = 516, `maxdmg` = 819, `DamageModifier` = 1.03 WHERE `entry` = 18503;
UPDATE `creature_template` SET `mindmg` = 653, `maxdmg` = 984, `DamageModifier` = 1.03 WHERE `entry` = 20309;
UPDATE `creature_template` SET `mindmg` = 514, `maxdmg` = 817, `DamageModifier` = 1.03 WHERE `entry` = 18500;
UPDATE `creature_template` SET `mindmg` = 623, `maxdmg` = 907, `DamageModifier` = 1.03 WHERE `entry` = 20320;
UPDATE `creature_template` SET `mindmg` = 628, `maxdmg` = 880, `DamageModifier` = 1.03 WHERE `entry` = 18498;
UPDATE `creature_template` SET `mindmg` = 1013, `maxdmg` = 1492, `DamageModifier` = 1.03 WHERE `entry` = 20321;
UPDATE `creature_template` SET `mindmg` = 589, `maxdmg` = 824, `DamageModifier` = 1.03 WHERE `entry` = 18499;
UPDATE `creature_template` SET `mindmg` = 988, `maxdmg` = 1398, `DamageModifier` = 1.03 WHERE `entry` = 20322;
UPDATE `creature_template` SET `mindmg` = 596, `maxdmg` = 923, `minrangedmg` = 703, `maxrangedmg` = 1045, `DamageModifier` = 1.03 WHERE `entry` = 18501;
UPDATE `creature_template` SET `mindmg` = 687, `maxdmg` = 994, `minrangedmg` = 956, `maxrangedmg` = 1286, `DamageModifier` = 1.03 WHERE `entry` = 20323;
UPDATE `creature_template` SET `mindmg` = 969, `maxdmg` = 1431, `DamageModifier` = 1.03 WHERE `entry` = 18521;
UPDATE `creature_template` SET `mindmg` = 1075, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 20315;
UPDATE `creature_template` SET `mindmg` = 969, `maxdmg` = 1361, `DamageModifier` = 1.03 WHERE `entry` = 18524;
UPDATE `creature_template` SET `mindmg` = 1024, `maxdmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 20298;
UPDATE `creature_template` SET `mindmg` = 897, `maxdmg` = 1258, `DamageModifier` = 1.03 WHERE `entry` = 18702;
UPDATE `creature_template` SET `mindmg` = 999, `maxdmg` = 1469, `DamageModifier` = 1.03 WHERE `entry` = 20300;
UPDATE `creature_template` SET `mindmg` = 969, `maxdmg` = 1431, `DamageModifier` = 1.03 WHERE `entry` = 18700;
UPDATE `creature_template` SET `mindmg` = 1075, `maxdmg` = 1585, `DamageModifier` = 1.03 WHERE `entry` = 20317;
UPDATE `creature_template` SET `mindmg` = 527, `maxdmg` = 886, `DamageModifier` = 1.03 WHERE `entry` = 18441;
UPDATE `creature_template` SET `mindmg` = 751, `maxdmg` = 943, `DamageModifier` = 1.03 WHERE `entry` = 20305;
UPDATE `creature_template` SET `mindmg` = 1153, `maxdmg` = 1623, `DamageModifier` = 1.03 WHERE `entry` = 18478;
UPDATE `creature_template` SET `mindmg` = 1584, `maxdmg` = 2466, `DamageModifier` = 1.03 WHERE `entry` = 20303;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 897, `maxdmg` = 1258, `DamageModifier` = 1.01 WHERE `entry` = 18371;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1027, `maxdmg` = 1455, `DamageModifier` = 1.01 WHERE `entry` = 20318;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 940, `maxdmg` = 1321, `DamageModifier` = 1.01 WHERE `entry` = 18373;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1037, `maxdmg` = 1469, `DamageModifier` = 1.01 WHERE `entry` = 20306;

/* SMARTSCRIPT*/
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18478;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18478);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18478, 0, 0, 0, 0, 0, 100, 0, 3500, 5500, 7500, 8500, 11, 16856, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - In Combat - Cast \'16856\''),
(18478, 0, 1, 0, 0, 0, 100, 0, 1500, 3000, 9500, 12000, 11, 16145, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - In Combat - Cast \'16145\''),
(18478, 0, 2, 0, 7, 0, 100, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Avatar of the Martyred - On Evade - Despawn In 5000 ms');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
