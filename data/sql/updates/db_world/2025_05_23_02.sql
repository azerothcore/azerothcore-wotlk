-- DB update 2025_05_23_01 -> 2025_05_23_02
--

-- Reduce Aku'Mai Servant damage. Auto attack = 36-45 w 1.5k armor
UPDATE `creature_template` SET `DamageModifier` = 1.7 WHERE `entry` = 4978 AND `type` = 4;
-- Reduce Deviate Moccasin damage. Auto attack = 39-44 w 1.1k armor
UPDATE `creature_template` SET `DamageModifier` = 1.8 WHERE `entry` = 5762 AND `family` = 35;
