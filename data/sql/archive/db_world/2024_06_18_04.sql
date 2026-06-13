-- DB update 2024_06_18_03 -> 2024_06_18_04
-- Mote of Shadow
UPDATE `creature_loot_template` SET `Chance` = 25 WHERE `Item` = 22577 and `Entry` IN (18869,18870);
