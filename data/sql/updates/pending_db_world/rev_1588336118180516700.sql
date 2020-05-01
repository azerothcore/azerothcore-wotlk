INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588336118180516700');

/*
 * Dungeon: Wailing Caverns
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 3637;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 3636;
UPDATE `creature_template` SET `mindmg` = 43, `maxdmg` = 61, `DamageModifier` = 1.03 WHERE `entry` = 3640;
UPDATE `creature_template` SET `mindmg` = 44, `maxdmg` = 59, `DamageModifier` = 1.03 WHERE `entry` = 3840;
UPDATE `creature_template` SET `mindmg` = 27, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 5053;
UPDATE `creature_template` SET `mindmg` = 44, `maxdmg` = 59, `DamageModifier` = 1.03 WHERE `entry` = 5761;
UPDATE `creature_template` SET `mindmg` = 29, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 5055;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 5756;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 5056;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 5048;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 5755;
UPDATE `creature_template` SET `mindmg` = 27, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 8886;
UPDATE `creature_template` SET `mindmg` = 30, `maxdmg` = 40, `DamageModifier` = 1.03 WHERE `entry` = 5763;
UPDATE `creature_template` SET `mindmg` = 65, `maxdmg` = 89, `DamageModifier` = 1.03 WHERE `entry` = 5762;

/* RARE */														
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 99, `maxdmg` = 127, `DamageModifier` = 1.02 WHERE `entry` = 5912;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.01 WHERE `entry` = 3671;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.01 WHERE `entry` = 3670;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 85, `maxdmg` = 110, `DamageModifier` = 1.01 WHERE `entry` = 3674;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.01 WHERE `entry` = 3673;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 201, `maxdmg` = 230, `DamageModifier` = 1.01 WHERE `entry` = 5775;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 85, `maxdmg` = 110, `DamageModifier` = 1.01 WHERE `entry` = 3653;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 95, `maxdmg` = 122, `DamageModifier` = 1.01 WHERE `entry` = 3669;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 117, `maxdmg` = 151, `DamageModifier` = 1.01 WHERE `entry` = 3654;