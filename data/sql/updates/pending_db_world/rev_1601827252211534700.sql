INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827252211534700');
/*
 * Raid: The Eye of Eternity 
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 4137, `maxdmg` = 6356, `DamageModifier` = 1.03 WHERE `entry` = 30245;
UPDATE `creature_template` SET `mindmg` = 8274, `maxdmg` = 12712, `DamageModifier` = 1.03 WHERE `entry` = 31750;
UPDATE `creature_template` SET `mindmg` = 3514, `maxdmg` = 5614, `DamageModifier` = 1.03 WHERE `entry` = 30249;
UPDATE `creature_template` SET `mindmg` = 7028, `maxdmg` = 11228, `DamageModifier` = 1.03 WHERE `entry` = 31751;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 18815, `maxdmg` = 24905, `DamageModifier` = 1.01 WHERE `entry` = 28859;
UPDATE `creature_template` SET `mindmg` = 37630, `maxdmg` = 49810, `DamageModifier` = 1.01 WHERE `entry` = 31734;
