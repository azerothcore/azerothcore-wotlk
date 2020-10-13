INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601827252211534700');
/*
 * Raid: The Eye of Eternity 
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 4125, `maxdmg` = 6362, `DamageModifier` = 1.03 WHERE `entry` = 30245;
UPDATE `creature_template` SET `mindmg` = 6417, `maxdmg` = 8561, `DamageModifier` = 1.03 WHERE `entry` = 31750;
UPDATE `creature_template` SET `mindmg` = 3502, `maxdmg` = 5614, `DamageModifier` = 1.03 WHERE `entry` = 30249;
UPDATE `creature_template` SET `mindmg` = 5959, `maxdmg` = 7781, `DamageModifier` = 1.03 WHERE `entry` = 31751;

/* BOSS */ 
UPDATE `creature_template` SET `mindmg` = 12400, `maxdmg` = 16850, `DamageModifier` = 1.01 WHERE `entry` = 28859;
UPDATE `creature_template` SET `mindmg` = 25450, `maxdmg` = 34150, `DamageModifier` = 1.01 WHERE `entry` = 31734;
