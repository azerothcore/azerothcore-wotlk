-- DB update 2024_11_24_00 -> 2024_11_24_01
--
-- Adds "Disarm" immunity to Creautre (Boss) "Halazzi" - [Zul'Aman]
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 4 WHERE `entry` = 23577;
