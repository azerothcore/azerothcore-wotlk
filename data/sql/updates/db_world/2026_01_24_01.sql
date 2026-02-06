-- DB update 2026_01_24_00 -> 2026_01_24_01
--
UPDATE `creature_loot_template` SET `Chance` = 100 WHERE `Entry` = 32491 AND `Item` IN (44168, 44663, 44682);
