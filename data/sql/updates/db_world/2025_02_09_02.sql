-- DB update 2025_02_09_01 -> 2025_02_09_02

-- Theremis
UPDATE `creature_template_movement` SET `Flight` = 1, `Ground` = 2 WHERE (`CreatureId` = 25976);

-- Shattered Sun Archmage
UPDATE `creature_template_movement` SET `Flight` = 1, `Ground` = 2 WHERE (`CreatureId` = 25170);

-- Yrma
UPDATE `creature_template_movement` SET `Flight` = 1, `Ground` = 2 WHERE (`CreatureId` = 25977);
