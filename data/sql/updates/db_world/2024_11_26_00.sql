-- DB update 2024_11_25_01 -> 2024_11_26_00
--
-- Adds "Disarm" immunity to Creautre (Boss) "Nalorakk" - [Zul'Aman]
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 4 WHERE `entry` = 23576;
