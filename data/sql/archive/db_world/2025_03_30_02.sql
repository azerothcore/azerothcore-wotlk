-- DB update 2025_03_30_01 -> 2025_03_30_02
-- Removes "Rod of Lianthe" and "Nightmare Vine" from "Eclipsion Hawkstrider"'s Loot
DELETE FROM `creature_loot_template` WHERE (`Entry` = 21627) AND (`Item` IN (22792, 31317));

UPDATE `creature_template` SET `lootid` = 0 WHERE (`entry` = 21627);
