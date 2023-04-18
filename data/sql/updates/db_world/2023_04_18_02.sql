-- DB update 2023_04_18_01 -> 2023_04_18_02
--
UPDATE `creature_template` SET `dmgschool` = 0 WHERE (`entry` IN (21695, 21696, 21916, 21917));
