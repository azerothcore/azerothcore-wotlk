-- DB update 2026_08_27_10 -> 2026_08_27_11
--
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` IN (6215, 7361);
