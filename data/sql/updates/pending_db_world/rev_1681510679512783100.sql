--
-- Update Murmur Loot Count to always drop 2 items
UPDATE `creature_loot_template` SET `MinCount`=2 WHERE `Entry`=18708 AND `Item`=35002 AND `Reference`=35002 AND `GroupId`=2;
