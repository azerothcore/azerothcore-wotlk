-- DB update 2025_09_20_03 -> 2025_09_20_04
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 33554432 WHERE `entry` IN (29311, 31464);
