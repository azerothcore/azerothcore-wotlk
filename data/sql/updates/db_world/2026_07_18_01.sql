-- DB update 2026_07_18_00 -> 2026_07_18_01
--
DELETE FROM `creature_loot_template` WHERE (`Entry` = 2950) AND (`Item` IN (3771, 4599));
