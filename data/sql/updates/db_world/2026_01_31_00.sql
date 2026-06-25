-- DB update 2026_01_30_01 -> 2026_01_31_00
--
UPDATE `creature_loot_template` SET `Chance` = 40 WHERE `Item` = 42422 AND `Entry` IN (29880, 30037, 30243, 30250, 30632, 30725);
