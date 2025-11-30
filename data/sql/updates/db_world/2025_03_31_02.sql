-- DB update 2025_03_31_01 -> 2025_03_31_02

-- Remove Sunglow Vest from Eredar Twins loot
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34085) AND (`Item` IN (34212));
