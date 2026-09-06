-- DB update 2025_03_17_00 -> 2025_03_17_01
-- Declare variables for item IDs
SET @item_severed_arm = 45323;
SET @item_bloated_slippery_eel = 45328;
SET @quest_disarmed = 13836;

-- Delete Severed Arm from fish loot
DELETE FROM `fishing_loot_template`
WHERE `entry` = 4567 AND `item` = @item_severed_arm;

-- Delete Bloated Slippery Eel from fish loot (water outside of Dalaran, where Quest Item was before patch 3.3.3)
DELETE FROM `fishing_loot_template`
WHERE `entry` = 3979 AND `item` = @item_bloated_slippery_eel;

-- Delete Bloated Slippery Eel from gameobject loot (fishing holes outside of Dalaran, where Quest Item was before patch 3.3.3)
DELETE FROM `gameobject_loot_template`
WHERE `entry` = 25671 AND `item` = @item_bloated_slippery_eel;

-- Update Bloated Slippery Eel entry in reference loot (the quest fish already exists in loot table but is in "wrong" water; move it to outside of the prison)
UPDATE `reference_loot_template`
SET `entry` = 11024
WHERE `entry` = 11026 AND `item` = @item_bloated_slippery_eel;

-- Update conditions according to the changed entry in `reference_loot_template`
UPDATE `conditions`
SET `sourceGroup` = 11024
WHERE `sourceGroup` = 11026 AND `sourceEntry` = @item_bloated_slippery_eel AND `conditionValue1` = @quest_disarmed;

-- Delete outdated condition
DELETE FROM `conditions`
WHERE `sourceGroup` = 25671 AND `sourceEntry` = @item_bloated_slippery_eel AND `conditionValue1` = @quest_disarmed;

-- Delete duplicated Corroded Jewelry from fish loot
DELETE FROM `fishing_loot_template`
WHERE `entry` = 4560 AND `item` = 45903;
