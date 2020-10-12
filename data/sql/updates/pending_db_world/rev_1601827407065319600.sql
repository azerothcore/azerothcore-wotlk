INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827407065319600');
/*
 * Raid: Onyxia Lair
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 4293, `maxdmg` = 6560, `DamageModifier` = 1.03 WHERE `entry` = 12129;
UPDATE `creature_template` SET `mindmg` = 7708, `maxdmg` = 9905, `DamageModifier` = 1.03 WHERE `entry` = 36572;
UPDATE `creature_template` SET `mindmg` = 776, `maxdmg` = 912, `DamageModifier` = 1.03 WHERE `entry` = 11262;
UPDATE `creature_template` SET `mindmg` = 824, `maxdmg` = 1286, `DamageModifier` = 1.03 WHERE `entry` = 36566;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 27120, `maxdmg` = 36490, `DamageModifier` = 1.01 WHERE `entry` = 10184;
UPDATE `creature_template` SET `mindmg` = 53247, `maxdmg` = 79460, `DamageModifier` = 1.01 WHERE `entry` = 36538;
