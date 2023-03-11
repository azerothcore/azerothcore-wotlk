-- DB update 2022_10_15_03 -> 2022_10_15_04
-- Rookery Whelp (10161)
DELETE FROM `creature_loot_template` WHERE `Entry` = 10161;
UPDATE `creature_template` SET `lootid` = 0, `skinloot` = 0 WHERE (`entry` = 10161);
-- Broodlord Lashlayer (12017), Death Talon Dragonspawn (12422), Razorgore the Untamed (12435), Vaelastrasz the Corrupt (13020), Corrupted Whelps (14022 to 14025), Ohgan (14988)
UPDATE `creature_template` SET `skinloot` = 0 WHERE (`entry` IN (12017, 12422, 12435, 13020, 14022, 14023, 14024, 14025, 14988));
-- Remove gold drops from Razorgore adds
UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE `entry` IN (12416, 12420, 12422);
