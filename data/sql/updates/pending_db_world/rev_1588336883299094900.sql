INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588336883299094900');

/*
 * Dungeon: Stormwind Stockade
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 1707;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 80, `DamageModifier` = 1.03 WHERE `entry` = 1706;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 84, `DamageModifier` = 1.03 WHERE `entry` = 1708;
UPDATE `creature_template` SET `mindmg` = 60, `maxdmg` = 84, `DamageModifier` = 1.03 WHERE `entry` = 1711;
UPDATE `creature_template` SET `mindmg` = 82, `maxdmg` = 109, `DamageModifier` = 1.03 WHERE `entry` = 1715;

/* RARE */
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 116, `maxdmg` = 149, `DamageModifier` = 1.02 WHERE `entry` = 1720;

/* BOSS */
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 106, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 1696;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 1666;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 1663;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 129, `maxdmg` = 166, `DamageModifier` = 1.01 WHERE `entry` = 1716;
UPDATE `creature_template` SET `type_flags` = 4, `mindmg` = 134, `maxdmg` = 173, `DamageModifier` = 1.01 WHERE `entry` = 1717;
