INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827337526865700');
/*
 * Raid: The Obsidian Sanctum
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 3293, `maxdmg` = 4560, `DamageModifier` = 1.03 WHERE `entry` = 30682;
UPDATE `creature_template` SET `mindmg` = 5708, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 31000;
UPDATE `creature_template` SET `mindmg` = 3254, `maxdmg` = 4522, `DamageModifier` = 1.03 WHERE `entry` = 30681;
UPDATE `creature_template` SET `mindmg` = 5641, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 30998;
UPDATE `creature_template` SET `mindmg` = 3293, `maxdmg` = 4790, `DamageModifier` = 1.03 WHERE `entry` = 30680;
UPDATE `creature_template` SET `mindmg` = 5780, `maxdmg` = 7950, `DamageModifier` = 1.03 WHERE `entry` = 30999;
UPDATE `creature_template` SET `mindmg` = 3293, `maxdmg` = 4670, `DamageModifier` = 1.03 WHERE `entry` = 30453;
UPDATE `creature_template` SET `mindmg` = 5730, `maxdmg` = 7940, `DamageModifier` = 1.03 WHERE `entry` = 31001;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 14850, `maxdmg` = 18750, `DamageModifier` = 1.01 WHERE `entry` = 28860;
UPDATE `creature_template` SET `mindmg` = 21757, `maxdmg` = 35350, `DamageModifier` = 1.01 WHERE `entry` = 31311;
UPDATE `creature_template` SET `mindmg` = 13743, `maxdmg` = 18441, `DamageModifier` = 1.01 WHERE `entry` = 30449;
UPDATE `creature_template` SET `mindmg` = 22905, `maxdmg` = 30735, `DamageModifier` = 1.01 WHERE `entry` = 31535;
UPDATE `creature_template` SET `mindmg` = 13751, `maxdmg` = 18447, `DamageModifier` = 1.01 WHERE `entry` = 30451;
UPDATE `creature_template` SET `mindmg` = 22879, `maxdmg` = 30727, `DamageModifier` = 1.01 WHERE `entry` = 31520;
UPDATE `creature_template` SET `mindmg` = 13785, `maxdmg` = 18439, `DamageModifier` = 1.01 WHERE `entry` = 30452;
UPDATE `creature_template` SET `mindmg` = 22768, `maxdmg` = 30734, `DamageModifier` = 1.01 WHERE `entry` = 31534;
