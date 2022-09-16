-- DB update 2020_07_25_00 -> 2020_07_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_07_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_07_25_00 2020_07_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1590935660292123100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1590935660292123100');
/*
 * Dungeon: The Botanica
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1044, `maxdmg` = 1479, `DamageModifier` = 1.03 WHERE `entry` = 18405;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21578;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 17993;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21548;
UPDATE `creature_template` SET `mindmg` = 968, `maxdmg` = 1367, `DamageModifier` = 1.03 WHERE `entry` = 18419;
UPDATE `creature_template` SET `mindmg` = 1031, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21546;
UPDATE `creature_template` SET `mindmg` = 858, `maxdmg` = 1244, `DamageModifier` = 1.03 WHERE `entry` = 19633;
UPDATE `creature_template` SET `mindmg` = 1149, `maxdmg` = 1667, `DamageModifier` = 1.03 WHERE `entry` = 21547;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 17994;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21545;
UPDATE `creature_template` SET `mindmg` = 889, `maxdmg` = 1256, `DamageModifier` = 1.03 WHERE `entry` = 18155;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1472, `DamageModifier` = 1.03 WHERE `entry` = 21544;
UPDATE `creature_template` SET `mindmg` = 1152, `maxdmg` = 1485, `DamageModifier` = 1.03 WHERE `entry` = 18404;
UPDATE `creature_template` SET `mindmg` = 1245, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21549;
UPDATE `creature_template` SET `mindmg` = 169, `maxdmg` = 239, `DamageModifier` = 1.03 WHERE `entry` = 20078;
UPDATE `creature_template` SET `mindmg` = 211, `maxdmg` = 289, `DamageModifier` = 1.03 WHERE `entry` = 21569;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 19557;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 21555;
UPDATE `creature_template` SET `mindmg` = 1005, `maxdmg` = 1423, `DamageModifier` = 1.03 WHERE `entry` = 18421;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21577;
UPDATE `creature_template` SET `mindmg` = 1015, `maxdmg` = 1413, `DamageModifier` = 1.03 WHERE `entry` = 19486;
UPDATE `creature_template` SET `mindmg` = 1178, `maxdmg` = 1523, `DamageModifier` = 1.03 WHERE `entry` = 21572;
UPDATE `creature_template` SET `mindmg` = 1013, `maxdmg` = 1389, `DamageModifier` = 1.03 WHERE `entry` = 18422;
UPDATE `creature_template` SET `mindmg` = 1089, `maxdmg` = 1496, `DamageModifier` = 1.03 WHERE `entry` = 21570;
UPDATE `creature_template` SET `mindmg` = 1035, `maxdmg` = 1412, `DamageModifier` = 1.03 WHERE `entry` = 18587;
UPDATE `creature_template` SET `mindmg` = 1098, `maxdmg` = 1486, `DamageModifier` = 1.03 WHERE `entry` = 21552;
UPDATE `creature_template` SET `mindmg` = 1075, `maxdmg` = 1386, `DamageModifier` = 1.03 WHERE `entry` = 18420;
UPDATE `creature_template` SET `mindmg` = 1132, `maxdmg` = 1512, `DamageModifier` = 1.03 WHERE `entry` = 21574;
UPDATE `creature_template` SET `mindmg` = 162, `maxdmg` = 228, `DamageModifier` = 1.03 WHERE `entry` = 19964;
UPDATE `creature_template` SET `mindmg` = 204, `maxdmg` = 287, `DamageModifier` = 1.03 WHERE `entry` = 21566;
UPDATE `creature_template` SET `mindmg` = 164, `maxdmg` = 243, `DamageModifier` = 1.03 WHERE `entry` = 19953;
UPDATE `creature_template` SET `mindmg` = 209, `maxdmg` = 291, `DamageModifier` = 1.03 WHERE `entry` = 21553;
UPDATE `creature_template` SET `mindmg` = 1065, `maxdmg` = 1534, `DamageModifier` = 1.03 WHERE `entry` = 19843;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21565;
UPDATE `creature_template` SET `mindmg` = 1075, `maxdmg` = 1548, `DamageModifier` = 1.03 WHERE `entry` = 19511;
UPDATE `creature_template` SET `mindmg` = 1120, `maxdmg` = 1680, `DamageModifier` = 1.03 WHERE `entry` = 21563;
UPDATE `creature_template` SET `mindmg` = 1090, `maxdmg` = 1520, `DamageModifier` = 1.03 WHERE `entry` = 19512;
UPDATE `creature_template` SET `mindmg` = 1215, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21564;
UPDATE `creature_template` SET `mindmg` = 896, `maxdmg` = 1312, `DamageModifier` = 1.03 WHERE `entry` = 19505;
UPDATE `creature_template` SET `mindmg` = 1198, `maxdmg` = 1676, `DamageModifier` = 1.03 WHERE `entry` = 21571;
UPDATE `creature_template` SET `mindmg` = 1090, `maxdmg` = 1480, `DamageModifier` = 1.03 WHERE `entry` = 19508;
UPDATE `creature_template` SET `mindmg` = 1160, `maxdmg` = 1640, `DamageModifier` = 1.03 WHERE `entry` = 21576;
UPDATE `creature_template` SET `mindmg` = 896, `maxdmg` = 1315, `DamageModifier` = 1.03 WHERE `entry` = 19507;
UPDATE `creature_template` SET `mindmg` = 1195, `maxdmg` = 1614, `DamageModifier` = 1.03 WHERE `entry` = 21573;
UPDATE `creature_template` SET `mindmg` = 1112, `maxdmg` = 1489, `DamageModifier` = 1.03 WHERE `entry` = 19509;
UPDATE `creature_template` SET `mindmg` = 1218, `maxdmg` = 1643, `DamageModifier` = 1.03 WHERE `entry` = 21575;
UPDATE `creature_template` SET `mindmg` = 1041, `maxdmg` = 1402, `DamageModifier` = 1.03 WHERE `entry` = 19598;
UPDATE `creature_template` SET `mindmg` = 1142, `maxdmg` = 1570, `DamageModifier` = 1.03 WHERE `entry` = 21561;
UPDATE `creature_template` SET `mindmg` = 1012, `maxdmg` = 1478, `DamageModifier` = 1.03 WHERE `entry` = 19513;
UPDATE `creature_template` SET `mindmg` = 1142, `maxdmg` = 1580, `DamageModifier` = 1.03 WHERE `entry` = 21560;
UPDATE `creature_template` SET `mindmg` = 1015, `maxdmg` = 1380, `DamageModifier` = 1.03 WHERE `entry` = 19865;
UPDATE `creature_template` SET `mindmg` = 1142, `maxdmg` = 1582, `DamageModifier` = 1.03 WHERE `entry` = 21562;
UPDATE `creature_template` SET `mindmg` = 156, `maxdmg` = 242, `DamageModifier` = 1.03 WHERE `entry` = 19920;
UPDATE `creature_template` SET `mindmg` = 189, `maxdmg` = 264, `DamageModifier` = 1.03 WHERE `entry` = 21579;
UPDATE `creature_template` SET `mindmg` = 132, `maxdmg` = 232, `DamageModifier` = 1.03 WHERE `entry` = 19919;
UPDATE `creature_template` SET `mindmg` = 176, `maxdmg` = 258, `DamageModifier` = 1.03 WHERE `entry` = 21580;
UPDATE `creature_template` SET `mindmg` = 1025, `maxdmg` = 1392, `DamageModifier` = 1.03 WHERE `entry` = 19608;
UPDATE `creature_template` SET `mindmg` = 1114, `maxdmg` = 1572, `DamageModifier` = 1.03 WHERE `entry` = 21554;
UPDATE `creature_template` SET `mindmg` = 178, `maxdmg` = 257, `DamageModifier` = 1.03 WHERE `entry` = 19949;
UPDATE `creature_template` SET `mindmg` = 191, `maxdmg` = 271, `DamageModifier` = 1.03 WHERE `entry` = 21567;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 878, `maxdmg` = 1245, `DamageModifier` = 1.01 WHERE `entry` = 17976;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1126, `maxdmg` = 1597, `DamageModifier` = 1.01 WHERE `entry` = 21551;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1215, `maxdmg` = 1535, `DamageModifier` = 1.01 WHERE `entry` = 17975;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1354, `maxdmg` = 1687, `DamageModifier` = 1.01 WHERE `entry` = 21558;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1144, `maxdmg` = 1535, `DamageModifier` = 1.01 WHERE `entry` = 17978;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1263, `maxdmg` = 1676, `DamageModifier` = 1.01 WHERE `entry` = 21581;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1126, `maxdmg` = 1660, `DamageModifier` = 1.01 WHERE `entry` = 17980;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1254, `maxdmg` = 1778, `DamageModifier` = 1.01 WHERE `entry` = 21559;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1169, `maxdmg` = 1692, `DamageModifier` = 1.01 WHERE `entry` = 17977;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1276, `maxdmg` = 1812, `DamageModifier` = 1.01 WHERE `entry` = 21582;

/* SMARTSCRIPTS */
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18405;
DELETE FROM `smart_scripts` WHERE (source_type = 0 AND entryorguid = 18405);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18405, 0, 0, 0, 0, 0, 100, 0, 2500, 3000, 12500, 13000, 11, 34793, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - In Combat - Cast \'34793\''),
(18405, 0, 1, 0, 2, 0, 100, 1, 60, 80, 0, 0, 11, 34791, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - Between 60-80% Health - Cast \'34791\' (No Repeat)'),
(18405, 0, 2, 0, 2, 0, 100, 1, 20, 40, 0, 0, 11, 34785, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Tempest-Forge Peacekeeper - Between 20-40% Health - Cast \'34785\' (No Repeat)');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
