INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827407065319600');
/*
 * Raid: Onyxia Lair
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 3293, `maxdmg` = 4560, `DamageModifier` = 1.03 WHERE `entry` = 12129;
UPDATE `creature_template` SET `mindmg` = 5708, `maxdmg` = 7905, `DamageModifier` = 1.03 WHERE `entry` = 36572;
UPDATE `creature_template` SET `mindmg` = 576, `maxdmg` = 812, `DamageModifier` = 1.03 WHERE `entry` = 12262;
UPDATE `creature_template` SET `mindmg` = 724, `maxdmg` = 986, `DamageModifier` = 1.03 WHERE `entry` = 36566;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 16120, `maxdmg` = 22340, `DamageModifier` = 1.01 WHERE `entry` = 10184;
UPDATE `creature_template` SET `mindmg` = 32247, `maxdmg` = 45110, `DamageModifier` = 1.01 WHERE `entry` = 36538;
