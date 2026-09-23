--
-- These rares were in the wrong disenchant band for their item level: eight in vanilla ones,
-- Skoll's Fang (49227) in the Northrend epic band, where it gave a guaranteed Abyss Crystal
UPDATE `item_template` SET `DisenchantID` = 53 WHERE `entry` IN (35664, 35665, 35666);
UPDATE `item_template` SET `DisenchantID` = 54 WHERE `entry` IN (34138, 34139, 44391, 44392, 49227, 51958);
