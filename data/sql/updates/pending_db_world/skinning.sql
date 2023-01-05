-- Create a new skinning loot with right percentage
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Chance`) VALUES (70068, 21887, 80);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Chance`, `MaxCount`) VALUES (70068, 25649, 20, 3);
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Chance`) VALUES (70068, 35229, 25);

-- Creature with 80% Knothide Leather and 20% Knothide Leather Scraps
UPDATE `creature_template` SET `skinloot`= 70068 WHERE (`entry` IN (21879, 21408, 21864, 21901, 21462, 21878, 21195, 20610, 20773, 18879, 20671, 20634, 18880, 20777));

-- Create a new skinning loot with right percentage
INSERT INTO `skinning_loot_template` (`Entry`, `Item`, `Chance`) VALUES (70069, 21887, 100);

-- Creature with 100% Knothide Leather
UPDATE `creature_template` SET `skinloot`= 70069 WHERE (`entry` IN (23501, 22181));
