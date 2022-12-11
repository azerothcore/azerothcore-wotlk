-- DB update 2022_12_11_03 -> 2022_12_11_04
-- fix pr13832
-- https://github.com/azerothcore/azerothcore-wotlk/commit/c791e2080e287e052fcaf717e3106977c822d28f
DELETE FROM `creature_loot_template` WHERE `Entry` IN (17917, 20627) AND (`Item` IN (13926));
UPDATE `creature_template` SET `lootid` = 0 WHERE (`entry` IN (17917, 20627));
