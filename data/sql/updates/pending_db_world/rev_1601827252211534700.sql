INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827252211534700');
/*
 * Raid: The Eye of Eternity 
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 591, `maxdmg` = 908, `DamageModifier` = 7 WHERE `entry` = 30245;
UPDATE `creature_template` SET `mindmg` = 591, `maxdmg` = 908, `DamageModifier` = 14 WHERE `entry` = 31750;
UPDATE `creature_template` SET `mindmg` = 502, `maxdmg` = 802, `DamageModifier` = 7 WHERE `entry` = 30249;
UPDATE `creature_template` SET `mindmg` = 502, `maxdmg` = 802, `DamageModifier` = 14 WHERE `entry` = 31751;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 537, `maxdmg` = 712, `DamageModifier` = 35 WHERE `entry` = 28859;
UPDATE `creature_template` SET `mindmg` = 537, `maxdmg` = 712, `DamageModifier` = 70 WHERE `entry` = 31734;
