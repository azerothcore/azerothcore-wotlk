-- DB update 2026_02_11_01 -> 2026_02_12_00
--
UPDATE `creature_template` SET `DamageModifier` = 1.5 WHERE (`entry` = 29851);
