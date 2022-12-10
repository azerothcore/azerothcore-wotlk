-- DB update 2022_06_16_03 -> 2022_06_16_04
UPDATE `creature_template` SET `DamageModifier` = 29, `BaseAttackTime` = 1100 WHERE (`entry` = 15114);
UPDATE `creature_template` SET `DamageModifier` = 27, `BaseAttackTime` = 1300 WHERE (`entry` = 15083);
UPDATE `creature_template` SET `DamageModifier` = 24, `BaseAttackTime` = 2000 WHERE (`entry` = 15085);
UPDATE `creature_template` SET `DamageModifier` = 23, `BaseAttackTime` = 1108 WHERE (`entry` = 15084);
UPDATE `creature_template` SET `DamageModifier` = 20 WHERE `entry` IN (14834, 15082);
UPDATE `creature_template` SET `DamageModifier` = 17 WHERE `entry` IN (11382, 11380); 
UPDATE `creature_template` SET `DamageModifier` = 15 WHERE `entry` IN (14517, 14515);
UPDATE `creature_template` SET `DamageModifier` = 14 WHERE `entry` IN (14510, 14507);
UPDATE `creature_template` SET `DamageModifier` = 13 WHERE (`entry` = 14509);
UPDATE `creature_template` SET `BaseAttackTime` = 1108 WHERE (`entry` = 15084);
