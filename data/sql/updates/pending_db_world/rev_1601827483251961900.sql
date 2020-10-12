INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827483251961900');
/*
 * Raid: Vault of Archavon
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 3162, `maxdmg` = 4399, `DamageModifier` = 1.03 WHERE `entry` = 32353;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 32368;
UPDATE `creature_template` SET `mindmg` = 3112, `maxdmg` = 4170, `DamageModifier` = 1.03 WHERE `entry` = 35143;
UPDATE `creature_template` SET `mindmg` = 5951, `maxdmg` = 8217, `DamageModifier` = 1.03 WHERE `entry` = 35359;
UPDATE `creature_template` SET `mindmg` = 3337, `maxdmg` = 4676, `DamageModifier` = 1.03 WHERE `entry` = 34015;
UPDATE `creature_template` SET `mindmg` = 5853, `maxdmg` = 8179, `DamageModifier` = 1.03 WHERE `entry` = 34016;
UPDATE `creature_template` SET `mindmg` = 3438, `maxdmg` = 4724, `DamageModifier` = 1.03 WHERE `entry` = 33998;
UPDATE `creature_template` SET `mindmg` = 5327, `maxdmg` = 7426, `DamageModifier` = 1.03 WHERE `entry` = 34200;
UPDATE `creature_template` SET `mindmg` = 3433, `maxdmg` = 4738, `DamageModifier` = 1.03 WHERE `entry` = 38482;
UPDATE `creature_template` SET `mindmg` = 5962, `maxdmg` = 8186, `DamageModifier` = 1.03 WHERE `entry` = 38483;

/* BOSS */ 
/* 1st: Available at opening. */
UPDATE `creature_template` SET `mindmg` = 18352, `maxdmg` = 24482, `DamageModifier` = 1.01 WHERE `entry` = 31125; 
UPDATE `creature_template` SET `mindmg` = 36368, `maxdmg` = 48484, `DamageModifier` = 1.01 WHERE `entry` = 31722;
/* 2nd: Second one to appear, towards Tier 8 */
UPDATE `creature_template` SET `mindmg` = 18536, `maxdmg` = 25488, `DamageModifier` = 1.01 WHERE `entry` = 33993;
UPDATE `creature_template` SET `mindmg` = 36571, `maxdmg` = 49486, `DamageModifier` = 1.01 WHERE `entry` = 33994;
 /* 3rd: Towards Tier 8.5 / 9. */
UPDATE `creature_template` SET `mindmg` = 18720, `maxdmg` = 26481, `DamageModifier` = 1.01 WHERE `entry` = 35013;
UPDATE `creature_template` SET `mindmg` = 36740, `maxdmg` = 50487, `DamageModifier` = 1.01 WHERE `entry` = 35360;
 /* 4th: Towards Tier 10 and last PvP Season. */
UPDATE `creature_template` SET `mindmg` = 18934, `maxdmg` = 27483, `DamageModifier` = 1.01 WHERE `entry` = 38433;
UPDATE `creature_template` SET `mindmg` = 36932, `maxdmg` = 51485, `DamageModifier` = 1.01 WHERE `entry` = 38462;
