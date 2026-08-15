-- DB update 2026_08_15_08 -> 2026_08_15_09
--
UPDATE `creature_loot_template` SET `Chance` = 10 WHERE `Item` = 30431 AND `Entry` IN (19995, 19998, 20334, 20728, 21296);
