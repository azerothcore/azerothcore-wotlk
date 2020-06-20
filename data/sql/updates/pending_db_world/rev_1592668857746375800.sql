INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1592668857746375800');
/*
 * Dungeon: Dark Portal
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 1323, `maxdmg` = 1872, `DamageModifier` = 1.03 WHERE `entry` = 21104;
UPDATE `creature_template` SET `mindmg` = 1892, `maxdmg` = 2293, `DamageModifier` = 1.03 WHERE `entry` = 22170;
UPDATE `creature_template` SET `mindmg` = 1282, `maxdmg` = 1769, `DamageModifier` = 1.03 WHERE `entry` = 21148;
UPDATE `creature_template` SET `mindmg` = 1826, `maxdmg` = 2183, `DamageModifier` = 1.03 WHERE `entry` = 22171;
UPDATE `creature_template` SET `mindmg` = 1867, `maxdmg` = 2755, `DamageModifier` = 1.03 WHERE `entry` = 21140;
UPDATE `creature_template` SET `mindmg` = 2170, `maxdmg` = 3498, `DamageModifier` = 1.03 WHERE `entry` = 22172;
UPDATE `creature_template` SET `mindmg` = 486, `maxdmg` = 789, `DamageModifier` = 1.03 WHERE `entry` = 21818;
UPDATE `creature_template` SET `mindmg` = 592, `maxdmg` = 915, `DamageModifier` = 1.03 WHERE `entry` = 22169;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1321, `DamageModifier` = 1.03 WHERE `entry` = 17835;
UPDATE `creature_template` SET `mindmg` = 1215, `maxdmg` = 1521, `DamageModifier` = 1.03 WHERE `entry` = 22164;
UPDATE `creature_template` SET `mindmg` = 1389, `maxdmg` = 1890, `DamageModifier` = 1.03 WHERE `entry` = 17839;
UPDATE `creature_template` SET `mindmg` = 2054, `maxdmg` = 3289, `DamageModifier` = 1.03 WHERE `entry` = 20744;
UPDATE `creature_template` SET `mindmg` = 723, `maxdmg` = 915, `DamageModifier` = 1.03 WHERE `entry` = 17892;
UPDATE `creature_template` SET `mindmg` = 827, `maxdmg` = 1015, `DamageModifier` = 1.03 WHERE `entry` = 20741;
UPDATE `creature_template` SET `mindmg` = 1078, `maxdmg` = 1321, `DamageModifier` = 1.03 WHERE `entry` = 18994;
UPDATE `creature_template` SET `mindmg` = 1114, `maxdmg` = 1218, `DamageModifier` = 1.03 WHERE `entry` = 22166;
UPDATE `creature_template` SET `mindmg` = 615, `maxdmg` = 872, `DamageModifier` = 1.03 WHERE `entry` = 18995;
UPDATE `creature_template` SET `mindmg` = 749, `maxdmg` = 918, `DamageModifier` = 1.03 WHERE `entry` = 22168;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1327, `maxdmg` = 1884, `DamageModifier` = 1.01 WHERE `entry` = 17879;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 2386, `maxdmg` = 3383, `DamageModifier` = 1.01 WHERE `entry` = 20738;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1486, `maxdmg` = 2210, `DamageModifier` = 1.01 WHERE `entry` = 17880;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 2576, `maxdmg` = 3657, `DamageModifier` = 1.01 WHERE `entry` = 20745;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 1432, `maxdmg` = 2030, `DamageModifier` = 1.01 WHERE `entry` = 17881;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 2481, `maxdmg` = 3518, `DamageModifier` = 1.01 WHERE `entry` = 20737;