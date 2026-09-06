-- DB update 2026_08_03_04 -> 2026_08_03_05
--
UPDATE `creature_template` SET `HealthModifier` = 1 WHERE (`entry` = 25743);
