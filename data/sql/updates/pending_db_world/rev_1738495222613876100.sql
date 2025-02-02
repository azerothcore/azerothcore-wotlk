-- Delete Severed Arm from fish loot
DELETE FROM `fishing_loot_template` WHERE `Entry`=4567 AND `Item`=45323;
-- Delete Bloated Slippery Eel from fish loot
DELETE FROM `fishing_loot_template` WHERE `Entry`=3979 AND `Item`=45328;
-- Delete Bloated Slippery Eel from gameobject loot
DELETE FROM `gameobject_loot_template` WHERE  `Entry`=25671 AND `Item`=45328;
-- Delete Corroded Jewelry from fish loot
DELETE FROM `fishing_loot_template` WHERE `Entry`=4560 AND `Item`=45903;
-- Update Bloated Slippery Eel Entry in reference loot
UPDATE `reference_loot_template` SET `Entry`=11024 WHERE `Entry`=11026 AND `Item`=45328;
