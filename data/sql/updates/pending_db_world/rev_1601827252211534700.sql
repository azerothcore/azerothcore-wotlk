INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827252211534700');
/*
 * Raid: The Eye of Eternity 
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 3125, `maxdmg` = 4362, `DamageModifier` = 1.03 WHERE `entry` = 30245;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7561, `DamageModifier` = 1.03 WHERE `entry` = 31750;
UPDATE `creature_template` SET `mindmg` = 2502, `maxdmg` = 3614, `DamageModifier` = 1.03 WHERE `entry` = 30249;
UPDATE `creature_template` SET `mindmg` = 4959, `maxdmg` = 6781, `DamageModifier` = 1.03 WHERE `entry` = 31751;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 16336, `maxdmg` = 22546, `DamageModifier` = 1.01 WHERE `entry` = 28859;
UPDATE `creature_template` SET `mindmg` = 32757, `maxdmg` = 45138, `DamageModifier` = 1.01 WHERE `entry` = 31734;
