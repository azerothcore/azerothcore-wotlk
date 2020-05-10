INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588335399793049400');

/*
 * Dungeon: Ragefire Chasm
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 31, `maxdmg` = 46, `DamageModifier` = 1.03 WHERE `entry` IN (11320, 11319, 11322);
UPDATE `creature_template` SET `mindmg` = 31, `maxdmg` = 42, `DamageModifier` = 1.03 WHERE `entry` = 11321;
UPDATE `creature_template` SET `mindmg` = 31, `maxdmg` = 50, `DamageModifier` = 1.03 WHERE `entry` IN (11318, 11323);
UPDATE `creature_template` SET `mindmg` = 22, `maxdmg` = 38, `DamageModifier` = 1.03 WHERE `entry` = 11324;
UPDATE `creature_template` SET `mindmg` = 38, `maxdmg` = 47, `DamageModifier` = 1.03 WHERE `entry` = 8996;
UPDATE `creature_template` SET `mindmg` = 89, `maxdmg` = 113, `DamageModifier` = 1.03 WHERE `entry` = 17830;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 74, `maxdmg` = 96, `DamageModifier` = 1.01 WHERE `entry` IN (11520, 11518, 11519);
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 101, `maxdmg` = 130, `DamageModifier` = 1.01 WHERE `entry` = 11517;
