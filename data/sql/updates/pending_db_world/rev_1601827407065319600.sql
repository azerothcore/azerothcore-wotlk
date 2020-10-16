INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827407065319600');
/*
 * Raid: Onyxia Lair
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */
UPDATE `creature_template` SET `mindmg` = 4293, `maxdmg` = 6560, `DamageModifier` = 1.03 WHERE `entry` = 12129;
UPDATE `creature_template` SET `mindmg` = 8586, `maxdmg` = 13120, `DamageModifier` = 1.03 WHERE `entry` = 36572;
UPDATE `creature_template` SET `mindmg` = 776, `maxdmg` = 912, `DamageModifier` = 1.03 WHERE `entry` = 11262;
UPDATE `creature_template` SET `mindmg` = 1552, `maxdmg` = 1824, `DamageModifier` = 1.03 WHERE `entry` = 36566;
UPDATE `creature_template` SET `mindmg` = 3165, `maxdmg` = 4395, `DamageModifier` = 1.03 WHERE `entry` = 36561;
UPDATE `creature_template` SET `mindmg` = 6330, `maxdmg` = 8790, `DamageModifier` = 1.03 WHERE `entry` = 36571;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 26250, `maxdmg` = 36750, `DamageModifier` = 1.01 WHERE `entry` = 10184;
UPDATE `creature_template` SET `mindmg` = 52500, `maxdmg` = 73500, `DamageModifier` = 1.01 WHERE `entry` = 36538;
