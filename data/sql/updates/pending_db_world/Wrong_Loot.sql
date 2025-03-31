
-- Remove Sunglow Vest from Eredar Twins loot
DELETE FROM `reference_loot_template` WHERE (`Entry` = 34085) AND (`Item` IN (34212));
