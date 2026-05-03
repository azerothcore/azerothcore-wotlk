-- DB update 2026_05_02_00 -> 2026_05_02_01

-- Update Quest Requirement
UPDATE `item_loot_template` SET `QuestRequired` = 0 WHERE (`Entry` = 11107) AND (`Item` IN (11108));
