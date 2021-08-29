-- DB update 2020_08_10_00 -> 2020_08_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_10_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_10_00 2020_08_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1592668725846266000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592668725846266000');
/*
 * Dungeon: Magister's Terrace
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1206, `maxdmg` = 1708, `DamageModifier` = 1.03 WHERE `entry` = 24777;
UPDATE `creature_template` SET `mindmg` = 1547, `maxdmg` = 2191, `DamageModifier` = 1.03 WHERE `entry` = 25571;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1321, `DamageModifier` = 1.03 WHERE `entry` = 24683;
UPDATE `creature_template` SET `mindmg` = 1383, `maxdmg` = 1761, `DamageModifier` = 1.03 WHERE `entry` = 25568;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 24686;
UPDATE `creature_template` SET `mindmg` = 1273, `maxdmg` = 1652, `DamageModifier` = 1.03 WHERE `entry` = 25572;
UPDATE `creature_template` SET `mindmg` = 400, `maxdmg` = 555, `DamageModifier` = 1.03 WHERE `entry` = 24815;
UPDATE `creature_template` SET `mindmg` = 513, `maxdmg` = 712, `DamageModifier` = 1.03 WHERE `entry` = 25566;
UPDATE `creature_template` SET `mindmg` = 1018, `maxdmg` = 1423, `DamageModifier` = 1.03 WHERE `entry` = 24685;
UPDATE `creature_template` SET `mindmg` = 1247, `maxdmg` = 1653, `DamageModifier` = 1.03 WHERE `entry` = 25569;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 24687;
UPDATE `creature_template` SET `mindmg` = 1372, `maxdmg` = 1843, `DamageModifier` = 1.03 WHERE `entry` = 25570;
UPDATE `creature_template` SET `mindmg` = 1178, `maxdmg` = 1623, `DamageModifier` = 1.03 WHERE `entry` = 24684;
UPDATE `creature_template` SET `mindmg` = 1483, `maxdmg` = 1993, `DamageModifier` = 1.03 WHERE `entry` = 25565;
UPDATE `creature_template` SET `mindmg` = 785, `maxdmg` = 960, `DamageModifier` = 1.03 WHERE `entry` = 24690;
UPDATE `creature_template` SET `mindmg` = 1015, `maxdmg` = 1322, `DamageModifier` = 1.03 WHERE `entry` = 25576;
UPDATE `creature_template` SET `mindmg` = 890, `maxdmg` = 1015, `DamageModifier` = 1.03 WHERE `entry` = 24688;
UPDATE `creature_template` SET `mindmg` = 1095, `maxdmg` = 1418, `DamageModifier` = 1.03 WHERE `entry` = 25577;
UPDATE `creature_template` SET `mindmg` = 965, `maxdmg` = 1175, `DamageModifier` = 1.03 WHERE `entry` = 24689;
UPDATE `creature_template` SET `mindmg` = 1184, `maxdmg` = 1524, `DamageModifier` = 1.03 WHERE `entry` = 25575;
UPDATE `creature_template` SET `mindmg` = 647, `maxdmg` = 914, `DamageModifier` = 1.03 WHERE `entry` = 24761;
UPDATE `creature_template` SET `mindmg` = 834, `maxdmg` = 1172, `DamageModifier` = 1.03 WHERE `entry` = 25545;
UPDATE `creature_template` SET `mindmg` = 1206, `maxdmg` = 1708, `DamageModifier` = 1.03 WHERE `entry` = 24698;
UPDATE `creature_template` SET `mindmg` = 1547, `maxdmg` = 1991, `DamageModifier` = 1.03 WHERE `entry` = 25551;
UPDATE `creature_template` SET `mindmg` = 1098, `maxdmg` = 1486, `DamageModifier` = 1.03 WHERE `entry` = 24697;
UPDATE `creature_template` SET `mindmg` = 1358, `maxdmg` = 1861, `DamageModifier` = 1.03 WHERE `entry` = 25563;
UPDATE `creature_template` SET `mindmg` = 1015, `maxdmg` = 1320, `DamageModifier` = 1.03 WHERE `entry` = 24696;
UPDATE `creature_template` SET `mindmg` = 1242, `maxdmg` = 1685, `DamageModifier` = 1.03 WHERE `entry` = 25547;
UPDATE `creature_template` SET `mindmg` = 1042, `maxdmg` = 1485, `DamageModifier` = 1.03 WHERE `entry` = 24674;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1420, `maxdmg` = 1784, `DamageModifier` = 1.01 WHERE `entry` = 24723;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1692, `maxdmg` = 2113, `DamageModifier` = 1.01 WHERE `entry` = 25562;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1414, `maxdmg` = 1712, `DamageModifier` = 1.01 WHERE `entry` = 24744;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1636, `maxdmg` = 2232, `DamageModifier` = 1.01 WHERE `entry` = 25573;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1120, `maxdmg` = 1584, `DamageModifier` = 1.01 WHERE `entry` = 24559;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1284, `maxdmg` = 1780, `DamageModifier` = 1.01 WHERE `entry` = 25574;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1015, `maxdmg` = 1490, `DamageModifier` = 1.01 WHERE `entry` = 24558;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1180, `maxdmg` = 1612, `DamageModifier` = 1.01 WHERE `entry` = 25549;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1218, `maxdmg` = 1584, `DamageModifier` = 1.01 WHERE `entry` = 24554;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1476, `maxdmg` = 1784, `DamageModifier` = 1.01 WHERE `entry` = 25550;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1212, `maxdmg` = 1438, `DamageModifier` = 1.01 WHERE `entry` = 24555;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1398, `maxdmg` = 1757, `DamageModifier` = 1.01 WHERE `entry` = 25555;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1202, `maxdmg` = 1388, `DamageModifier` = 1.01 WHERE `entry` = 24561;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1318, `maxdmg` = 1598, `DamageModifier` = 1.01 WHERE `entry` = 25578;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1251, `maxdmg` = 1412, `DamageModifier` = 1.01 WHERE `entry` = 24553;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1312, `maxdmg` = 1538, `DamageModifier` = 1.01 WHERE `entry` = 25541;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1192, `maxdmg` = 1328, `DamageModifier` = 1.01 WHERE `entry` = 24556;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1306, `maxdmg` = 1509, `DamageModifier` = 1.01 WHERE `entry` = 25579;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1287, `maxdmg` = 1478, `DamageModifier` = 1.01 WHERE `entry` = 24557;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1362, `maxdmg` = 1518, `DamageModifier` = 1.01 WHERE `entry` = 25556;
UPDATE `creature_template` SET `rank` = 1, `mindmg` = 389, `maxdmg` = 467, `DamageModifier` = 1.01 WHERE `entry` = 24552;
UPDATE `creature_template` SET `rank` = 1, `mindmg` = 489, `maxdmg` = 556, `DamageModifier` = 1.01 WHERE `entry` = 25564;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1352, `maxdmg` = 1623, `DamageModifier` = 1.01 WHERE `entry` = 24560;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1593, `maxdmg` = 1942, `DamageModifier` = 1.01 WHERE `entry` = 25560;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1512, `maxdmg` = 1898, `DamageModifier` = 1.01 WHERE `entry` = 24664;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1586, `maxdmg` = 2389, `DamageModifier` = 1.01 WHERE `entry` = 24857;

/* SMARTSCRIPT */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24777;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 24777);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24777, 0, 0, 0, 0, 0, 100, 0, 4700, 5200, 14700, 15200, 11, 46479, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sunblade Sentinel - In Combat - Cast \'46479\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24552;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 24552);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24552, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 20000, 11, 3391, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Sliver - In Combat - Cast \'3391\'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
