-- Delete Severed Arm from fish loot
DELETE FROM `fishing_loot_template` WHERE `Entry`=4567 AND `Item`=45323;
-- Delete Bloated Slippery Eel from fish loot (water outside of Dalaran, where Quest Item was before patch 3.3.3)
DELETE FROM `fishing_loot_template` WHERE `Entry`=3979 AND `Item`=45328;
-- Delete Bloated Slippery Eel from gameobject loot (fishing holes outside of Dalaran, where Quest Item was before patch 3.3.3)
DELETE FROM `gameobject_loot_template` WHERE `Entry`=25671 AND `Item`=45328;
-- Update Bloated Slippery Eel Entry in reference loot (the quest fish already exist in loot table, but it is in "wrong" water. Right now it in the sewers. Lets move it to outside of the prison)
UPDATE `reference_loot_template` SET `Entry`=11024 WHERE `Entry`=11026 AND `Item`=45328;
-- Update conditions according to changed entry in `reference_loot_template`
UPDATE `conditions` SET `SourceGroup`=11024 WHERE `SourceGroup`=11026 AND `SourceEntry`=45328 AND `ConditionValue1`=13836;
-- Delete outdated condition
DELETE FROM `conditions` WHERE `SourceGroup`=25671 AND `SourceEntry`=45328 AND `ConditionValue1`=13836;

-- Delete duplicated Corroded Jewelry from fish loot
DELETE FROM `fishing_loot_template` WHERE `Entry`=4560 AND `Item`=45903;
