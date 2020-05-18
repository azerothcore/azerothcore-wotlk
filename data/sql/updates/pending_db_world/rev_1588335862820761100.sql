INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588335862820761100');

/*
 * Dungeon: Deadmines
 * Update by Knindza | <www.azerothcore.org>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 43, `maxdmg` = 61, `DamageModifier` = 1.03 WHERE `entry` = 598;
UPDATE `creature_template` SET `mindmg` = 43, `maxdmg` = 61, `DamageModifier` = 1.03 WHERE `entry` = 634;
UPDATE `creature_template` SET `mindmg` = 30, `maxdmg` = 44, `DamageModifier` = 1.03 WHERE `entry` = 1729;
UPDATE `creature_template` SET `mindmg` = 38, `maxdmg` = 57, `minrangedmg` = 25, `maxrangedmg` = 43, `DamageModifier` = 1.03 WHERE `entry` = 1725;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 641;
UPDATE `creature_template` SET `mindmg` = 32, `maxdmg` = 47, `DamageModifier` = 1.03 WHERE `entry` = 4418;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `minrangedmg` = 31, `maxrangedmg` = 49, `DamageModifier` = 1.03 WHERE `entry` = 4417;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 1731;
UPDATE `creature_template` SET `mindmg` = 46, `maxdmg` = 65, `minrangedmg` = 31, `maxrangedmg` = 49, `DamageModifier` = 1.03 WHERE `entry` = 622;
UPDATE `creature_template` SET `mindmg` = 68, `maxdmg` = 88, `DamageModifier` = 1.03 WHERE `entry` = 2520;
UPDATE `creature_template` SET `mindmg` = 34, `maxdmg` = 47, `DamageModifier` = 1.03 WHERE `entry` = 1732;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 657;
UPDATE `creature_template` SET `mindmg` = 35, `maxdmg` = 50, `DamageModifier` = 1.03 WHERE `entry` = 3450;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 65, `DamageModifier` = 1.03 WHERE `entry` = 636;
UPDATE `creature_template` SET `mindmg` = 49, `maxdmg` = 69, `DamageModifier` = 1.03 WHERE `entry` = 3947;

/* RARE */ 
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 71, `maxdmg` = 93, `DamageModifier` = 1.02 WHERE `entry` = 3586;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 86, `maxdmg` = 114, `DamageModifier` = 1.01 WHERE `entry` = 644;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 79, `maxdmg` = 103, `DamageModifier` = 1.01 WHERE `entry` = 642;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 89, `maxdmg` = 115, `DamageModifier` = 1.01 WHERE `entry` = 643;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 85, `maxdmg` = 110, `DamageModifier` = 1.01 WHERE `entry` = 1763;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 89, `maxdmg` = 115, `DamageModifier` = 1.01 WHERE `entry` = 647;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 89, `maxdmg` = 116, `DamageModifier` = 1.01 WHERE `entry` = 639;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 89, `maxdmg` = 115, `DamageModifier` = 1.01 WHERE `entry` = 646;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 85, `maxdmg` = 110, `DamageModifier` = 1.01 WHERE `entry` = 645;
