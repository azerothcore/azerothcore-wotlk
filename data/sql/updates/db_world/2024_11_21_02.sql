-- DB update 2024_11_21_01 -> 2024_11_21_02
-- Eliza (314)
UPDATE `creature_template` SET `pickpocketloot` = 314 WHERE (`entry` = 314);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 314);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(314, 1710, 0, 20.0, 0, 1, 0, 1, 1, 'Eliza - Greater Healing Potion'),
(314, 3864, 0, 6.67, 0, 1, 0, 1, 1, 'Eliza - Citrine'),
(314, 4607, 0, 40.0, 0, 1, 0, 1, 1, 'Eliza - Delicious Cave Mold'),
(314, 5433, 0, 13.33, 0, 1, 0, 1, 1, 'Eliza - Rag Doll'),
(314, 16883, 0, 33.33, 0, 1, 0, 1, 1, 'Eliza - Worn Junkbox');

-- Brainwashed Noble (596)
UPDATE `creature_template` SET `pickpocketloot` = 596 WHERE (`entry` = 596);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 596);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(596, 5368, 0, 100.0, 0, 1, 0, 1, 1, 'Brainwashed Noble - Empty Wallet');

-- Sergeant Malthus (814)
UPDATE `creature_template` SET `pickpocketloot` = 814 WHERE (`entry` = 814);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 814);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(814, 1707, 0, 20.0, 0, 1, 0, 1, 1, 'Sergeant Malthus - Stormwind Brie'),
(814, 1710, 0, 10.0, 0, 1, 0, 1, 1, 'Sergeant Malthus - Greater Healing Potion'),
(814, 4539, 0, 10.0, 0, 1, 0, 1, 1, 'Sergeant Malthus - Goldenbark Apple'),
(814, 5431, 0, 60.0, 0, 1, 0, 1, 1, 'Sergeant Malthus - Empty Hip Flask');

-- Defias Renegade Mage (450)
UPDATE `creature_template` SET `pickpocketloot` = 450 WHERE (`entry` = 450);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 450);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(450, 858, 0, 22.22, 0, 1, 0, 1, 1, 'Defias Renegade Mage - Lesser Healing Potion'),
(450, 4537, 0, 44.44, 0, 1, 0, 1, 1, 'Defias Renegade Mage - Tel\'Abim Banana'),
(450, 5368, 0, 33.33, 0, 1, 0, 1, 1, 'Defias Renegade Mage - Empty Wallet');

-- Morganth (397)
UPDATE `creature_template` SET `pickpocketloot` = 397 WHERE (`entry` = 397);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 397);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(397, 929, 0, 7.69, 0, 1, 0, 1, 1, 'Morganth - Healing Potion'),
(397, 4538, 0, 23.08, 0, 1, 0, 1, 1, 'Morganth - Snapvine Watermelon'),
(397, 4542, 0, 15.38, 0, 1, 0, 1, 1, 'Morganth - Moist Cornbread'),
(397, 5374, 0, 23.08, 0, 1, 0, 1, 1, 'Morganth - Small Pocket Watch'),
(397, 16882, 0, 53.85, 0, 1, 0, 1, 1, 'Morganth - Battered Junkbox');

-- Murloc Netter (513)
UPDATE `creature_template` SET `pickpocketloot` = 513 WHERE (`entry` = 513);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 513);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(513, 858, 0, 6.25, 0, 1, 0, 1, 1, 'Murloc Netter - Lesser Healing Potion'),
(513, 1210, 0, 6.25, 0, 1, 0, 1, 1, 'Murloc Netter - Shadowgem'),
(513, 5371, 0, 37.5, 0, 1, 0, 1, 1, 'Murloc Netter - Piece of Coral'),
(513, 6289, 0, 50.0, 0, 1, 0, 1, 2, 'Murloc Netter - Raw Longjaw Mud Snapper');

-- Kurzen's Agent (775)
UPDATE `creature_template` SET `pickpocketloot` = 775 WHERE (`entry` = 775);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 775);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(775, 1529, 0, 6.67, 0, 1, 0, 1, 1, 'Kurzen\'s Agent - Jade'),
(775, 1707, 0, 6.67, 0, 1, 0, 1, 1, 'Kurzen\'s Agent - Stormwind Brie'),
(775, 1710, 0, 6.67, 0, 1, 0, 1, 1, 'Kurzen\'s Agent - Greater Healing Potion'),
(775, 4544, 0, 13.33, 0, 1, 0, 1, 1, 'Kurzen\'s Agent - Mulgore Spice Bread'),
(775, 5431, 0, 40.0, 0, 1, 0, 1, 1, 'Kurzen\'s Agent - Empty Hip Flask'),
(775, 16883, 0, 33.33, 0, 1, 0, 1, 1, 'Kurzen\'s Agent - Worn Junkbox');

-- Bookie Herod (815)
UPDATE `creature_template` SET `pickpocketloot` = 815 WHERE (`entry` = 815);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 815);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(815, 5431, 0, 66.67, 0, 1, 0, 1, 1, 'Bookie Herod - Empty Hip Flask'),
(815, 16883, 0, 33.33, 0, 1, 0, 1, 1, 'Bookie Herod - Worn Junkbox');

-- Lost One Chieftain (763)
UPDATE `creature_template` SET `pickpocketloot` = 763 WHERE (`entry` = 763);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 763);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(763, 3771, 0, 66.67, 0, 1, 0, 1, 1, 'Lost One Chieftain - Wild Hog Shank'),
(763, 5429, 0, 22.22, 0, 1, 0, 1, 1, 'Lost One Chieftain - A Pretty Rock'),
(763, 16883, 0, 22.22, 0, 1, 0, 1, 1, 'Lost One Chieftain - Worn Junkbox');

-- Lost One Cook (1106)
UPDATE `creature_template` SET `pickpocketloot` = 1106 WHERE (`entry` = 1106);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1106);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1106, 1710, 0, 33.33, 0, 1, 0, 1, 1, 'Lost One Cook - Greater Healing Potion'),
(1106, 3771, 0, 33.33, 0, 1, 0, 1, 1, 'Lost One Cook - Wild Hog Shank'),
(1106, 5429, 0, 16.67, 0, 1, 0, 1, 1, 'Lost One Cook - A Pretty Rock'),
(1106, 16883, 0, 16.67, 0, 1, 0, 1, 1, 'Lost One Cook - Worn Junkbox');

-- Saltscale Oracle (873)
UPDATE `creature_template` SET `pickpocketloot` = 873 WHERE (`entry` = 873);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 873);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(873, 1710, 0, 23.81, 0, 1, 0, 1, 1, 'Saltscale Oracle - Greater Healing Potion'),
(873, 6362, 0, 23.81, 0, 1, 0, 1, 2, 'Saltscale Oracle - Raw Rockscale Cod'),
(873, 10457, 0, 52.38, 0, 1, 0, 1, 1, 'Saltscale Oracle - Empty Sea Snail Shell'),
(873, 16883, 0, 9.52, 0, 1, 0, 1, 1, 'Saltscale Oracle - Worn Junkbox');

-- Morgan the Collector (473)
UPDATE `creature_template` SET `pickpocketloot` = 473 WHERE (`entry` = 473);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 473);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(473, 118, 0, 12.5, 0, 1, 0, 1, 1, 'Morgan the Collector - Minor Healing Potion'),
(473, 774, 0, 12.5, 0, 1, 0, 1, 1, 'Morgan the Collector - Malachite'),
(473, 1376, 0, 6.25, 0, 1, 0, 1, 1, 'Morgan the Collector - Frayed Cloak'),
(473, 2070, 0, 18.75, 0, 1, 0, 1, 1, 'Morgan the Collector - Darnassian Bleu'),
(473, 4536, 0, 12.5, 0, 1, 0, 1, 1, 'Morgan the Collector - Shiny Red Apple'),
(473, 4540, 0, 25.0, 0, 1, 0, 1, 1, 'Morgan the Collector - Tough Hunk of Bread'),
(473, 5363, 0, 18.75, 0, 1, 0, 1, 1, 'Morgan the Collector - Folded Handkerchief'),
(473, 6150, 0, 6.25, 0, 1, 0, 1, 1, 'Morgan the Collector - A Frayed Knot');

-- Skeletal Miner (623)
UPDATE `creature_template` SET `pickpocketloot` = 623 WHERE (`entry` = 623);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 623);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(623, 858, 0, 20.59, 0, 1, 0, 1, 1, 'Skeletal Miner - Lesser Healing Potion'),
(623, 4605, 0, 44.12, 0, 1, 0, 1, 1, 'Skeletal Miner - Red-speckled Mushroom'),
(623, 5370, 0, 38.24, 0, 1, 0, 1, 1, 'Skeletal Miner - Bent Spoon');

-- Commander Felstrom (771)
UPDATE `creature_template` SET `pickpocketloot` = 771 WHERE (`entry` = 771);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 771);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(771, 1710, 0, 33.33, 0, 1, 0, 1, 1, 'Commander Felstrom - Greater Healing Potion'),
(771, 5433, 0, 50.0, 0, 1, 0, 1, 1, 'Commander Felstrom - Rag Doll'),
(771, 16883, 0, 16.67, 0, 1, 0, 1, 1, 'Commander Felstrom - Worn Junkbox');

-- Frostmane Shadowcaster (1124)
UPDATE `creature_template` SET `pickpocketloot` = 1124 WHERE (`entry` = 1124);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1124);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1124, 117, 0, 14.29, 0, 1, 0, 1, 1, 'Frostmane Shadowcaster - Tough Jerky'),
(1124, 774, 0, 7.14, 0, 1, 0, 1, 1, 'Frostmane Shadowcaster - Malachite'),
(1124, 2211, 0, 7.14, 0, 1, 0, 1, 1, 'Frostmane Shadowcaster - Bent Large Shield'),
(1124, 4540, 0, 28.57, 0, 1, 0, 1, 1, 'Frostmane Shadowcaster - Tough Hunk of Bread'),
(1124, 5367, 0, 57.14, 0, 1, 0, 1, 1, 'Frostmane Shadowcaster - Primitive Rock Tool');

-- Mosshide Mystic (1013)
UPDATE `creature_template` SET `pickpocketloot` = 1013 WHERE (`entry` = 1013);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1013);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1013, 929, 0, 13.33, 0, 1, 0, 1, 1, 'Mosshide Mystic - Healing Potion'),
(1013, 3770, 0, 20.0, 0, 1, 0, 1, 1, 'Mosshide Mystic - Mutton Chop'),
(1013, 5375, 0, 26.67, 0, 1, 0, 1, 1, 'Mosshide Mystic - Scratching Stick'),
(1013, 16882, 0, 46.67, 0, 1, 0, 1, 1, 'Mosshide Mystic - Battered Junkbox');

-- Stitches (412)
UPDATE `creature_template` SET `pickpocketloot` = 412 WHERE (`entry` = 412);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 412);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(412, 1710, 0, 7.69, 0, 1, 0, 1, 1, 'Stitches - Greater Healing Potion'),
(412, 4607, 0, 7.69, 0, 1, 0, 1, 1, 'Stitches - Delicious Cave Mold'),
(412, 5433, 0, 38.46, 0, 1, 0, 1, 1, 'Stitches - Rag Doll'),
(412, 16883, 0, 53.85, 0, 1, 0, 1, 1, 'Stitches - Worn Junkbox');

-- Tunnel Rat Surveyor (1177)
UPDATE `creature_template` SET `pickpocketloot` = 1177 WHERE (`entry` = 1177);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1177);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1177, 1210, 0, 11.11, 0, 1, 0, 1, 1, 'Tunnel Rat Surveyor - Shadowgem'),
(1177, 2287, 0, 55.56, 0, 1, 0, 1, 1, 'Tunnel Rat Surveyor - Haunch of Meat'),
(1177, 5369, 0, 33.33, 0, 1, 0, 1, 1, 'Tunnel Rat Surveyor - Gnawed Bone');

-- Grawmug (1205)
UPDATE `creature_template` SET `pickpocketloot` = 1205 WHERE (`entry` = 1205);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1205);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1205, 858, 0, 20.0, 0, 1, 0, 1, 1, 'Grawmug - Lesser Healing Potion'),
(1205, 4541, 0, 40.0, 0, 1, 0, 1, 1, 'Grawmug - Freshly Baked Bread'),
(1205, 5379, 0, 40.0, 0, 1, 0, 1, 1, 'Grawmug - Broken Boot Knife');

-- Hammerspine (1119)
UPDATE `creature_template` SET `pickpocketloot` = 1119 WHERE (`entry` = 1119);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1119);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1119, 858, 0, 20.0, 0, 1, 0, 1, 1, 'Hammerspine - Lesser Healing Potion'),
(1119, 2287, 0, 60.0, 0, 1, 0, 1, 1, 'Hammerspine - Haunch of Meat'),
(1119, 5379, 0, 20.0, 0, 1, 0, 1, 1, 'Hammerspine - Broken Boot Knife');

-- Dark Iron Sapper (1222)
UPDATE `creature_template` SET `pickpocketloot` = 1222 WHERE (`entry` = 1222);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1222);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1222, 414, 0, 26.92, 0, 1, 0, 1, 1, 'Dark Iron Sapper - Dalaran Sharp'),
(1222, 818, 0, 3.85, 0, 1, 0, 1, 1, 'Dark Iron Sapper - Tigerseye'),
(1222, 858, 0, 7.69, 0, 1, 0, 1, 1, 'Dark Iron Sapper - Lesser Healing Potion'),
(1222, 4537, 0, 3.85, 0, 1, 0, 1, 1, 'Dark Iron Sapper - Tel\'Abim Banana'),
(1222, 4541, 0, 15.38, 0, 1, 0, 1, 1, 'Dark Iron Sapper - Freshly Baked Bread'),
(1222, 5368, 0, 53.85, 0, 1, 0, 1, 1, 'Dark Iron Sapper - Empty Wallet');

-- Mo'grosh Mystic (1183)
UPDATE `creature_template` SET `pickpocketloot` = 1183 WHERE (`entry` = 1183);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1183);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1183, 818, 0, 6.67, 0, 1, 0, 1, 1, 'Mo\'grosh Mystic - Tigerseye'),
(1183, 858, 0, 17.78, 0, 1, 0, 1, 1, 'Mo\'grosh Mystic - Lesser Healing Potion'),
(1183, 2287, 0, 24.44, 0, 1, 0, 1, 1, 'Mo\'grosh Mystic - Haunch of Meat'),
(1183, 4541, 0, 20.0, 0, 1, 0, 1, 1, 'Mo\'grosh Mystic - Freshly Baked Bread'),
(1183, 5379, 0, 35.56, 0, 1, 0, 1, 1, 'Mo\'grosh Mystic - Broken Boot Knife'),
(1183, 7288, 0, 2.22, 0, 1, 0, 1, 1, 'Mo\'grosh Mystic - Pattern: Rugged Leather Pants');

-- Private Merle (1421)
UPDATE `creature_template` SET `pickpocketloot` = 1421 WHERE (`entry` = 1421);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1421);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1421, 1710, 0, 10.0, 0, 1, 0, 1, 1, 'Private Merle - Greater Healing Potion'),
(1421, 5431, 0, 70.0, 0, 1, 0, 1, 1, 'Private Merle - Empty Hip Flask'),
(1421, 16883, 0, 20.0, 0, 1, 0, 1, 1, 'Private Merle - Worn Junkbox');

-- Vile Fin Muckdweller (1545)
UPDATE `creature_template` SET `pickpocketloot` = 1545 WHERE (`entry` = 1545);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1545);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1545, 118, 0, 9.09, 0, 1, 0, 1, 1, 'Vile Fin Muckdweller - Minor Healing Potion'),
(1545, 774, 0, 2.27, 0, 1, 0, 1, 1, 'Vile Fin Muckdweller - Malachite'),
(1545, 1415, 0, 2.27, 0, 1, 0, 1, 1, 'Vile Fin Muckdweller - Carpenter\'s Mallet'),
(1545, 2598, 0, 2.27, 0, 1, 0, 1, 1, 'Vile Fin Muckdweller - Pattern: Red Linen Robe'),
(1545, 2672, 0, 2.27, 0, 1, 0, 1, 1, 'Vile Fin Muckdweller - Stringy Wolf Meat'),
(1545, 5361, 0, 43.18, 0, 1, 0, 1, 1, 'Vile Fin Muckdweller - Fishbone Toothpick'),
(1545, 6303, 0, 34.09, 0, 1, 0, 1, 2, 'Vile Fin Muckdweller - Raw Slitherskin Mackerel');

-- Chok'sul (1210)
UPDATE `creature_template` SET `pickpocketloot` = 1210 WHERE (`entry` = 1210);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1210);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1210, 929, 0, 12.5, 0, 1, 0, 1, 1, 'Chok\'sul - Healing Potion'),
(1210, 1206, 0, 12.5, 0, 1, 0, 1, 1, 'Chok\'sul - Moss Agate'),
(1210, 5373, 0, 25.0, 0, 1, 0, 1, 1, 'Chok\'sul - Lucky Charm'),
(1210, 16882, 0, 75.0, 0, 1, 0, 1, 1, 'Chok\'sul - Battered Junkbox');

-- Stormwind Guard (1423)
UPDATE `creature_template` SET `pickpocketloot` = 1423 WHERE (`entry` = 1423);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1423);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1423, 4542, 0, 11.11, 0, 1, 0, 1, 1, 'Stormwind Guard - Moist Cornbread'),
(1423, 5374, 0, 66.67, 0, 1, 0, 1, 1, 'Stormwind Guard - Small Pocket Watch'),
(1423, 16882, 0, 22.22, 0, 1, 0, 1, 1, 'Stormwind Guard - Battered Junkbox');

-- Lord Gregor Lescovar (1754)
UPDATE `creature_template` SET `pickpocketloot` = 1754 WHERE (`entry` = 1754);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1754);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1754, 1707, 0, 13.33, 0, 1, 0, 1, 1, 'Lord Gregor Lescovar - Stormwind Brie'),
(1754, 1710, 0, 13.33, 0, 1, 0, 1, 1, 'Lord Gregor Lescovar - Greater Healing Potion'),
(1754, 4539, 0, 20.0, 0, 1, 0, 1, 1, 'Lord Gregor Lescovar - Goldenbark Apple'),
(1754, 4544, 0, 26.67, 0, 1, 0, 1, 1, 'Lord Gregor Lescovar - Mulgore Spice Bread'),
(1754, 5431, 0, 40.0, 0, 1, 0, 1, 1, 'Lord Gregor Lescovar - Empty Hip Flask'),
(1754, 16883, 0, 6.67, 0, 1, 0, 1, 1, 'Lord Gregor Lescovar - Worn Junkbox');

-- Mo'grosh Brute (1180)
UPDATE `creature_template` SET `pickpocketloot` = 1180 WHERE (`entry` = 1180);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1180);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1180, 818, 0, 2.44, 0, 1, 0, 1, 1, 'Mo\'grosh Brute - Tigerseye'),
(1180, 858, 0, 24.39, 0, 1, 0, 1, 1, 'Mo\'grosh Brute - Lesser Healing Potion'),
(1180, 1210, 0, 4.88, 0, 1, 0, 1, 1, 'Mo\'grosh Brute - Shadowgem'),
(1180, 2287, 0, 14.63, 0, 1, 0, 1, 1, 'Mo\'grosh Brute - Haunch of Meat'),
(1180, 4541, 0, 17.07, 0, 1, 0, 1, 1, 'Mo\'grosh Brute - Freshly Baked Bread'),
(1180, 5379, 0, 39.02, 0, 1, 0, 1, 1, 'Mo\'grosh Brute - Broken Boot Knife');

-- Bruegal Ironknuckle (1720)
UPDATE `creature_template` SET `pickpocketloot` = 1720 WHERE (`entry` = 1720);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1720);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1720, 422, 0, 6.25, 0, 1, 0, 1, 1, 'Bruegal Ironknuckle - Dwarven Mild'),
(1720, 929, 0, 12.5, 0, 1, 0, 1, 1, 'Bruegal Ironknuckle - Healing Potion'),
(1720, 4538, 0, 6.25, 0, 1, 0, 1, 1, 'Bruegal Ironknuckle - Snapvine Watermelon'),
(1720, 4542, 0, 18.75, 0, 1, 0, 1, 1, 'Bruegal Ironknuckle - Moist Cornbread'),
(1720, 5374, 0, 43.75, 0, 1, 0, 1, 1, 'Bruegal Ironknuckle - Small Pocket Watch'),
(1720, 16882, 0, 43.75, 0, 1, 0, 1, 1, 'Bruegal Ironknuckle - Battered Junkbox');

-- Defias Magician (1726)
UPDATE `creature_template` SET `pickpocketloot` = 1726 WHERE (`entry` = 1726);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1726);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1726, 818, 0, 4.55, 0, 1, 0, 1, 1, 'Defias Magician - Tigerseye'),
(1726, 858, 0, 13.64, 0, 1, 0, 1, 1, 'Defias Magician - Lesser Healing Potion'),
(1726, 4537, 0, 9.09, 0, 1, 0, 1, 1, 'Defias Magician - Tel\'Abim Banana'),
(1726, 4541, 0, 9.09, 0, 1, 0, 1, 1, 'Defias Magician - Freshly Baked Bread'),
(1726, 5368, 0, 63.64, 0, 1, 0, 1, 1, 'Defias Magician - Empty Wallet');

-- Maggot Eye (1753)
UPDATE `creature_template` SET `pickpocketloot` = 1753 WHERE (`entry` = 1753);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1753);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1753, 118, 0, 23.08, 0, 1, 0, 1, 1, 'Maggot Eye - Minor Healing Potion'),
(1753, 2598, 0, 7.69, 0, 1, 0, 1, 1, 'Maggot Eye - Pattern: Red Linen Robe'),
(1753, 4604, 0, 23.08, 0, 1, 0, 1, 1, 'Maggot Eye - Forest Mushroom Cap'),
(1753, 5362, 0, 46.15, 0, 1, 0, 1, 1, 'Maggot Eye - Chew Toy'),
(1753, 7101, 0, 7.69, 0, 1, 0, 1, 1, 'Maggot Eye - Bug Eye');

-- Rot Hide Gladerunner (1772)
UPDATE `creature_template` SET `pickpocketloot` = 1772 WHERE (`entry` = 1772);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1772);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1772, 858, 0, 12.5, 0, 1, 0, 1, 1, 'Rot Hide Gladerunner - Lesser Healing Potion'),
(1772, 2589, 0, 3.12, 0, 1, 0, 2, 2, 'Rot Hide Gladerunner - Linen Cloth'),
(1772, 4605, 0, 40.62, 0, 1, 0, 1, 1, 'Rot Hide Gladerunner - Red-speckled Mushroom'),
(1772, 5370, 0, 46.88, 0, 1, 0, 1, 1, 'Rot Hide Gladerunner - Bent Spoon');

-- Captain Perrine (1662)
UPDATE `creature_template` SET `pickpocketloot` = 1662 WHERE (`entry` = 1662);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1662);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1662, 118, 0, 5.56, 0, 1, 0, 1, 1, 'Captain Perrine - Minor Healing Potion'),
(1662, 774, 0, 11.11, 0, 1, 0, 1, 1, 'Captain Perrine - Malachite'),
(1662, 2070, 0, 5.56, 0, 1, 0, 1, 1, 'Captain Perrine - Darnassian Bleu'),
(1662, 2649, 0, 5.56, 0, 1, 0, 1, 1, 'Captain Perrine - Flimsy Chain Belt'),
(1662, 4536, 0, 11.11, 0, 1, 0, 1, 1, 'Captain Perrine - Shiny Red Apple'),
(1662, 4540, 0, 5.56, 0, 1, 0, 1, 1, 'Captain Perrine - Tough Hunk of Bread'),
(1662, 4865, 0, 5.56, 0, 1, 0, 1, 1, 'Captain Perrine - Ruined Pelt'),
(1662, 5363, 0, 44.44, 0, 1, 0, 1, 1, 'Captain Perrine - Folded Handkerchief'),
(1662, 6150, 0, 16.67, 0, 1, 0, 1, 1, 'Captain Perrine - A Frayed Knot');

-- Councilman Smithers (2060)
UPDATE `creature_template` SET `pickpocketloot` = 2060 WHERE (`entry` = 2060);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2060);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2060, 818, 0, 33.33, 0, 1, 0, 1, 1, 'Councilman Smithers - Tigerseye'),
(2060, 858, 0, 16.67, 0, 1, 0, 1, 1, 'Councilman Smithers - Lesser Healing Potion'),
(2060, 4541, 0, 33.33, 0, 1, 0, 1, 1, 'Councilman Smithers - Freshly Baked Bread'),
(2060, 5368, 0, 33.33, 0, 1, 0, 1, 1, 'Councilman Smithers - Empty Wallet');

-- Mountaineer Dokkin (2105)
UPDATE `creature_template` SET `pickpocketloot` = 2105 WHERE (`entry` = 2105);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2105);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2105, 5374, 0, 85.71, 0, 1, 0, 1, 1, 'Mountaineer Dokkin - Small Pocket Watch'),
(2105, 16882, 0, 42.86, 0, 1, 0, 1, 1, 'Mountaineer Dokkin - Battered Junkbox');

-- Archmage Ataeric (2120)
UPDATE `creature_template` SET `pickpocketloot` = 2120 WHERE (`entry` = 2120);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2120);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2120, 422, 0, 16.67, 0, 1, 0, 1, 1, 'Archmage Ataeric - Dwarven Mild'),
(2120, 16882, 0, 83.33, 0, 1, 0, 1, 1, 'Archmage Ataeric - Battered Junkbox');

-- Thule Ravenclaw (1947)
UPDATE `creature_template` SET `pickpocketloot` = 1947 WHERE (`entry` = 1947);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1947);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1947, 4538, 0, 28.57, 0, 1, 0, 1, 1, 'Thule Ravenclaw - Snapvine Watermelon'),
(1947, 4542, 0, 28.57, 0, 1, 0, 1, 1, 'Thule Ravenclaw - Moist Cornbread'),
(1947, 5374, 0, 28.57, 0, 1, 0, 1, 1, 'Thule Ravenclaw - Small Pocket Watch'),
(1947, 16882, 0, 57.14, 0, 1, 0, 1, 1, 'Thule Ravenclaw - Battered Junkbox');

-- Valdred Moray (2332)
UPDATE `creature_template` SET `pickpocketloot` = 2332 WHERE (`entry` = 2332);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2332);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2332, 929, 0, 10.0, 0, 1, 0, 1, 1, 'Valdred Moray - Healing Potion'),
(2332, 5374, 0, 10.0, 0, 1, 0, 1, 1, 'Valdred Moray - Small Pocket Watch'),
(2332, 16882, 0, 90.0, 0, 1, 0, 1, 1, 'Valdred Moray - Battered Junkbox');

-- Dalaran Warder (1913)
UPDATE `creature_template` SET `pickpocketloot` = 1913 WHERE (`entry` = 1913);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 1913);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1913, 414, 0, 28.57, 0, 1, 0, 1, 1, 'Dalaran Warder - Dalaran Sharp'),
(1913, 4537, 0, 21.43, 0, 1, 0, 1, 1, 'Dalaran Warder - Tel\'Abim Banana'),
(1913, 4541, 0, 3.57, 0, 1, 0, 1, 1, 'Dalaran Warder - Freshly Baked Bread'),
(1913, 5368, 0, 53.57, 0, 1, 0, 1, 1, 'Dalaran Warder - Empty Wallet');

-- Mountaineer Grugelm (2466)
UPDATE `creature_template` SET `pickpocketloot` = 2466 WHERE (`entry` = 2466);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2466);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2466, 4542, 0, 9.09, 0, 1, 0, 1, 1, 'Mountaineer Grugelm - Moist Cornbread'),
(2466, 5374, 0, 36.36, 0, 1, 0, 1, 1, 'Mountaineer Grugelm - Small Pocket Watch'),
(2466, 16882, 0, 54.55, 0, 1, 0, 1, 1, 'Mountaineer Grugelm - Battered Junkbox');

-- Chieftain Nek'rosh (2091)
UPDATE `creature_template` SET `pickpocketloot` = 2091 WHERE (`entry` = 2091);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2091);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2091, 3771, 0, 37.5, 0, 1, 0, 1, 1, 'Chieftain Nek\'rosh - Wild Hog Shank'),
(2091, 5427, 0, 31.25, 0, 1, 0, 1, 1, 'Chieftain Nek\'rosh - Crude Pocket Watch'),
(2091, 16883, 0, 56.25, 0, 1, 0, 1, 1, 'Chieftain Nek\'rosh - Worn Junkbox');

-- Mountaineer Rharen (2469)
UPDATE `creature_template` SET `pickpocketloot` = 2469 WHERE (`entry` = 2469);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2469);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2469, 422, 0, 28.57, 0, 1, 0, 1, 1, 'Mountaineer Rharen - Dwarven Mild'),
(2469, 5374, 0, 28.57, 0, 1, 0, 1, 1, 'Mountaineer Rharen - Small Pocket Watch'),
(2469, 16882, 0, 57.14, 0, 1, 0, 1, 1, 'Mountaineer Rharen - Battered Junkbox');

-- Greymist Oracle (2207)
UPDATE `creature_template` SET `pickpocketloot` = 2207 WHERE (`entry` = 2207);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2207);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2207, 818, 0, 12.0, 0, 1, 0, 1, 1, 'Greymist Oracle - Tigerseye'),
(2207, 858, 0, 10.0, 0, 1, 0, 1, 1, 'Greymist Oracle - Lesser Healing Potion'),
(2207, 5371, 0, 52.0, 0, 1, 0, 1, 1, 'Greymist Oracle - Piece of Coral'),
(2207, 6289, 0, 30.0, 0, 1, 0, 1, 2, 'Greymist Oracle - Raw Longjaw Mud Snapper');

-- Greymist Coastrunner (2202)
UPDATE `creature_template` SET `pickpocketloot` = 2202 WHERE (`entry` = 2202);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2202);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2202, 818, 0, 4.35, 0, 1, 0, 1, 1, 'Greymist Coastrunner - Tigerseye'),
(2202, 858, 0, 10.87, 0, 1, 0, 1, 1, 'Greymist Coastrunner - Lesser Healing Potion'),
(2202, 1210, 0, 6.52, 0, 1, 0, 1, 1, 'Greymist Coastrunner - Shadowgem'),
(2202, 5371, 0, 45.65, 0, 1, 0, 1, 1, 'Greymist Coastrunner - Piece of Coral'),
(2202, 6289, 0, 39.13, 0, 1, 0, 1, 2, 'Greymist Coastrunner - Raw Longjaw Mud Snapper');

-- Dark Iron Shadowcaster (2577)
UPDATE `creature_template` SET `pickpocketloot` = 2577 WHERE (`entry` = 2577);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2577);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2577, 1707, 0, 14.81, 0, 1, 0, 1, 1, 'Dark Iron Shadowcaster - Stormwind Brie'),
(2577, 4544, 0, 11.11, 0, 1, 0, 1, 1, 'Dark Iron Shadowcaster - Mulgore Spice Bread'),
(2577, 5431, 0, 37.04, 0, 1, 0, 1, 1, 'Dark Iron Shadowcaster - Empty Hip Flask'),
(2577, 16883, 0, 40.74, 0, 1, 0, 1, 1, 'Dark Iron Shadowcaster - Worn Junkbox');

-- Mountaineer Thar (2468)
UPDATE `creature_template` SET `pickpocketloot` = 2468 WHERE (`entry` = 2468);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2468);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2468, 422, 0, 12.5, 0, 1, 0, 1, 1, 'Mountaineer Thar - Dwarven Mild'),
(2468, 929, 0, 12.5, 0, 1, 0, 1, 1, 'Mountaineer Thar - Healing Potion'),
(2468, 1206, 0, 12.5, 0, 1, 0, 1, 1, 'Mountaineer Thar - Moss Agate'),
(2468, 4538, 0, 25.0, 0, 1, 0, 1, 1, 'Mountaineer Thar - Snapvine Watermelon'),
(2468, 5374, 0, 12.5, 0, 1, 0, 1, 1, 'Mountaineer Thar - Small Pocket Watch'),
(2468, 16882, 0, 37.5, 0, 1, 0, 1, 1, 'Mountaineer Thar - Battered Junkbox');

-- Greymist Netter (2204)
UPDATE `creature_template` SET `pickpocketloot` = 2204 WHERE (`entry` = 2204);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2204);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2204, 818, 0, 3.33, 0, 1, 0, 1, 1, 'Greymist Netter - Tigerseye'),
(2204, 858, 0, 23.33, 0, 1, 0, 1, 1, 'Greymist Netter - Lesser Healing Potion'),
(2204, 1210, 0, 3.33, 0, 1, 0, 1, 1, 'Greymist Netter - Shadowgem'),
(2204, 5371, 0, 33.33, 0, 1, 0, 1, 1, 'Greymist Netter - Piece of Coral'),
(2204, 6289, 0, 50.0, 0, 1, 0, 1, 2, 'Greymist Netter - Raw Longjaw Mud Snapper');

-- Blackwood Shaman (2171)
UPDATE `creature_template` SET `pickpocketloot` = 2171 WHERE (`entry` = 2171);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2171);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2171, 818, 0, 5.26, 0, 1, 0, 1, 1, 'Blackwood Shaman - Tigerseye'),
(2171, 858, 0, 47.37, 0, 1, 0, 1, 1, 'Blackwood Shaman - Lesser Healing Potion'),
(2171, 1210, 0, 5.26, 0, 1, 0, 1, 1, 'Blackwood Shaman - Shadowgem'),
(2171, 2287, 0, 15.79, 0, 1, 0, 1, 1, 'Blackwood Shaman - Haunch of Meat'),
(2171, 5369, 0, 31.58, 0, 1, 0, 1, 1, 'Blackwood Shaman - Gnawed Bone');

-- Dark Iron Supplier (2575)
UPDATE `creature_template` SET `pickpocketloot` = 2575 WHERE (`entry` = 2575);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2575);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2575, 1710, 0, 11.11, 0, 1, 0, 1, 1, 'Dark Iron Supplier - Greater Healing Potion'),
(2575, 5431, 0, 44.44, 0, 1, 0, 1, 1, 'Dark Iron Supplier - Empty Hip Flask'),
(2575, 16883, 0, 55.56, 0, 1, 0, 1, 1, 'Dark Iron Supplier - Worn Junkbox');

-- Singer (2600)
UPDATE `creature_template` SET `pickpocketloot` = 2600 WHERE (`entry` = 2600);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2600);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2600, 4539, 0, 14.29, 0, 1, 0, 1, 1, 'Singer - Goldenbark Apple'),
(2600, 5431, 0, 28.57, 0, 1, 0, 1, 1, 'Singer - Empty Hip Flask'),
(2600, 16883, 0, 57.14, 0, 1, 0, 1, 1, 'Singer - Worn Junkbox');

-- Greymist Tidehunter (2208)
UPDATE `creature_template` SET `pickpocketloot` = 2208 WHERE (`entry` = 2208);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2208);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2208, 858, 0, 6.9, 0, 1, 0, 1, 1, 'Greymist Tidehunter - Lesser Healing Potion'),
(2208, 1210, 0, 3.45, 0, 1, 0, 1, 1, 'Greymist Tidehunter - Shadowgem'),
(2208, 5371, 0, 72.41, 0, 1, 0, 1, 1, 'Greymist Tidehunter - Piece of Coral'),
(2208, 6289, 0, 20.69, 0, 1, 0, 1, 2, 'Greymist Tidehunter - Raw Longjaw Mud Snapper');

-- Caretaker Weston (2781)
UPDATE `creature_template` SET `pickpocketloot` = 2781 WHERE (`entry` = 2781);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2781);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2781, 3927, 0, 33.33, 0, 1, 0, 1, 1, 'Caretaker Weston - Fine Aged Cheddar'),
(2781, 4602, 0, 11.11, 0, 1, 0, 1, 1, 'Caretaker Weston - Moon Harvest Pumpkin'),
(2781, 5432, 0, 44.44, 0, 1, 0, 1, 1, 'Caretaker Weston - Hickory Pipe'),
(2781, 7910, 0, 22.22, 0, 1, 0, 1, 1, 'Caretaker Weston - Star Ruby');

-- Caretaker Alaric (2782)
UPDATE `creature_template` SET `pickpocketloot` = 2782 WHERE (`entry` = 2782);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2782);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2782, 3927, 0, 12.5, 0, 1, 0, 1, 1, 'Caretaker Alaric - Fine Aged Cheddar'),
(2782, 3928, 0, 12.5, 0, 1, 0, 1, 1, 'Caretaker Alaric - Superior Healing Potion'),
(2782, 4601, 0, 37.5, 0, 1, 0, 1, 1, 'Caretaker Alaric - Soft Banana Bread'),
(2782, 4602, 0, 12.5, 0, 1, 0, 1, 1, 'Caretaker Alaric - Moon Harvest Pumpkin'),
(2782, 5432, 0, 25.0, 0, 1, 0, 1, 1, 'Caretaker Alaric - Hickory Pipe'),
(2782, 16884, 0, 25.0, 0, 1, 0, 1, 1, 'Caretaker Alaric - Sturdy Junkbox');

-- Palemane Skinner (2950)
UPDATE `creature_template` SET `pickpocketloot` = 2950 WHERE (`entry` = 2950);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2950);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2950, 118, 0, 25.0, 0, 1, 0, 1, 1, 'Palemane Skinner - Minor Healing Potion'),
(2950, 774, 0, 12.5, 0, 1, 0, 1, 1, 'Palemane Skinner - Malachite'),
(2950, 5364, 0, 62.5, 0, 1, 0, 1, 1, 'Palemane Skinner - Dry Salt Lick');

-- Dagun the Ravenous (2937)
UPDATE `creature_template` SET `pickpocketloot` = 2937 WHERE (`entry` = 2937);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2937);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2937, 3928, 0, 11.11, 0, 1, 0, 1, 1, 'Dagun the Ravenous - Superior Healing Potion'),
(2937, 4603, 0, 55.56, 0, 1, 0, 1, 1, 'Dagun the Ravenous - Raw Spotted Yellowtail'),
(2937, 5435, 0, 11.11, 0, 1, 0, 1, 1, 'Dagun the Ravenous - Shiny Dinglehopper'),
(2937, 16884, 0, 22.22, 0, 1, 0, 1, 1, 'Dagun the Ravenous - Sturdy Junkbox');

-- Palemane Tanner (2949)
UPDATE `creature_template` SET `pickpocketloot` = 2949 WHERE (`entry` = 2949);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2949);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2949, 117, 0, 21.74, 0, 1, 0, 1, 1, 'Palemane Tanner - Tough Jerky'),
(2949, 118, 0, 21.74, 0, 1, 0, 1, 1, 'Palemane Tanner - Minor Healing Potion'),
(2949, 5364, 0, 65.22, 0, 1, 0, 1, 1, 'Palemane Tanner - Dry Salt Lick');

-- Palemane Poacher (2951)
UPDATE `creature_template` SET `pickpocketloot` = 2951 WHERE (`entry` = 2951);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2951);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2951, 117, 0, 33.33, 0, 1, 0, 1, 1, 'Palemane Poacher - Tough Jerky'),
(2951, 5364, 0, 83.33, 0, 1, 0, 1, 1, 'Palemane Poacher - Dry Salt Lick');

-- Windfury Harpy (2962)
UPDATE `creature_template` SET `pickpocketloot` = 2962 WHERE (`entry` = 2962);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2962);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2962, 117, 0, 33.33, 0, 1, 0, 1, 1, 'Windfury Harpy - Tough Jerky'),
(2962, 118, 0, 16.67, 0, 1, 0, 1, 1, 'Windfury Harpy - Minor Healing Potion'),
(2962, 774, 0, 5.56, 0, 1, 0, 1, 1, 'Windfury Harpy - Malachite'),
(2962, 5364, 0, 61.11, 0, 1, 0, 1, 1, 'Windfury Harpy - Dry Salt Lick');

-- Venture Co. Taskmaster (2977)
UPDATE `creature_template` SET `pickpocketloot` = 2977 WHERE (`entry` = 2977);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2977);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2977, 117, 0, 16.67, 0, 1, 0, 1, 1, 'Venture Co. Taskmaster - Tough Jerky'),
(2977, 774, 0, 16.67, 0, 1, 0, 1, 1, 'Venture Co. Taskmaster - Malachite'),
(2977, 5367, 0, 66.67, 0, 1, 0, 1, 1, 'Venture Co. Taskmaster - Primitive Rock Tool');

-- Bael'dun Appraiser (2990)
UPDATE `creature_template` SET `pickpocketloot` = 2990 WHERE (`entry` = 2990);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2990);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2990, 2070, 0, 9.09, 0, 1, 0, 1, 1, 'Bael\'dun Appraiser - Darnassian Bleu'),
(2990, 4536, 0, 18.18, 0, 1, 0, 1, 1, 'Bael\'dun Appraiser - Shiny Red Apple'),
(2990, 4540, 0, 18.18, 0, 1, 0, 1, 1, 'Bael\'dun Appraiser - Tough Hunk of Bread'),
(2990, 5363, 0, 18.18, 0, 1, 0, 1, 1, 'Bael\'dun Appraiser - Folded Handkerchief'),
(2990, 6150, 0, 36.36, 0, 1, 0, 1, 1, 'Bael\'dun Appraiser - A Frayed Knot');

-- Bristleback Quilboar (2952)
UPDATE `creature_template` SET `pickpocketloot` = 2952 WHERE (`entry` = 2952);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2952);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2952, 117, 0, 26.67, 0, 1, 0, 1, 1, 'Bristleback Quilboar - Tough Jerky'),
(2952, 118, 0, 6.67, 0, 1, 0, 1, 1, 'Bristleback Quilboar - Minor Healing Potion'),
(2952, 5364, 0, 66.67, 0, 1, 0, 1, 1, 'Bristleback Quilboar - Dry Salt Lick');

-- Windfury Wind Witch (2963)
UPDATE `creature_template` SET `pickpocketloot` = 2963 WHERE (`entry` = 2963);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2963);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2963, 117, 0, 33.33, 0, 1, 0, 1, 1, 'Windfury Wind Witch - Tough Jerky'),
(2963, 118, 0, 11.11, 0, 1, 0, 1, 1, 'Windfury Wind Witch - Minor Healing Potion'),
(2963, 5364, 0, 66.67, 0, 1, 0, 1, 1, 'Windfury Wind Witch - Dry Salt Lick');

-- Fizzle Darkstorm (3203)
UPDATE `creature_template` SET `pickpocketloot` = 3203 WHERE (`entry` = 3203);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3203);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3203, 858, 0, 25.0, 0, 1, 0, 1, 1, 'Fizzle Darkstorm - Lesser Healing Potion'),
(3203, 1210, 0, 8.33, 0, 1, 0, 1, 1, 'Fizzle Darkstorm - Shadowgem'),
(3203, 1380, 0, 8.33, 0, 1, 0, 1, 1, 'Fizzle Darkstorm - Frayed Robe'),
(3203, 2287, 0, 8.33, 0, 1, 0, 1, 1, 'Fizzle Darkstorm - Haunch of Meat'),
(3203, 4541, 0, 16.67, 0, 1, 0, 1, 1, 'Fizzle Darkstorm - Freshly Baked Bread'),
(3203, 5379, 0, 41.67, 0, 1, 0, 1, 1, 'Fizzle Darkstorm - Broken Boot Knife');

-- Lieutenant Benedict (3192)
UPDATE `creature_template` SET `pickpocketloot` = 3192 WHERE (`entry` = 3192);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3192);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3192, 118, 0, 18.18, 0, 1, 0, 1, 1, 'Lieutenant Benedict - Minor Healing Potion'),
(3192, 2070, 0, 18.18, 0, 1, 0, 1, 1, 'Lieutenant Benedict - Darnassian Bleu'),
(3192, 4536, 0, 27.27, 0, 1, 0, 1, 1, 'Lieutenant Benedict - Shiny Red Apple'),
(3192, 4540, 0, 9.09, 0, 1, 0, 1, 1, 'Lieutenant Benedict - Tough Hunk of Bread'),
(3192, 5363, 0, 9.09, 0, 1, 0, 1, 1, 'Lieutenant Benedict - Folded Handkerchief'),
(3192, 6150, 0, 18.18, 0, 1, 0, 1, 1, 'Lieutenant Benedict - A Frayed Knot');

-- Molok the Crusher (2604)
UPDATE `creature_template` SET `pickpocketloot` = 2604 WHERE (`entry` = 2604);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2604);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2604, 5427, 0, 20.0, 0, 1, 0, 1, 1, 'Molok the Crusher - Crude Pocket Watch'),
(2604, 16883, 0, 80.0, 0, 1, 0, 1, 1, 'Molok the Crusher - Worn Junkbox');

-- Bael'dun Digger (2989)
UPDATE `creature_template` SET `pickpocketloot` = 2989 WHERE (`entry` = 2989);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 2989);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2989, 2070, 0, 7.14, 0, 1, 0, 1, 1, 'Bael\'dun Digger - Darnassian Bleu'),
(2989, 4540, 0, 21.43, 0, 1, 0, 1, 1, 'Bael\'dun Digger - Tough Hunk of Bread'),
(2989, 5363, 0, 57.14, 0, 1, 0, 1, 1, 'Bael\'dun Digger - Folded Handkerchief'),
(2989, 6150, 0, 14.29, 0, 1, 0, 1, 1, 'Bael\'dun Digger - A Frayed Knot');

-- Bristleback Interloper (3232)
UPDATE `creature_template` SET `pickpocketloot` = 3232 WHERE (`entry` = 3232);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3232);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3232, 117, 0, 28.57, 0, 1, 0, 1, 1, 'Bristleback Interloper - Tough Jerky'),
(3232, 118, 0, 7.14, 0, 1, 0, 1, 1, 'Bristleback Interloper - Minor Healing Potion'),
(3232, 774, 0, 14.29, 0, 1, 0, 1, 1, 'Bristleback Interloper - Malachite'),
(3232, 5364, 0, 57.14, 0, 1, 0, 1, 1, 'Bristleback Interloper - Dry Salt Lick');

-- Makrura Clacker (3103)
UPDATE `creature_template` SET `pickpocketloot` = 3103 WHERE (`entry` = 3103);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3103);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3103, 118, 0, 33.33, 0, 1, 0, 1, 1, 'Makrura Clacker - Minor Healing Potion'),
(3103, 774, 0, 11.11, 0, 1, 0, 1, 1, 'Makrura Clacker - Malachite'),
(3103, 5361, 0, 44.44, 0, 1, 0, 1, 1, 'Makrura Clacker - Fishbone Toothpick'),
(3103, 6303, 0, 11.11, 0, 1, 0, 2, 2, 'Makrura Clacker - Raw Slitherskin Mackerel');

-- Witchwing Ambusher (3279)
UPDATE `creature_template` SET `pickpocketloot` = 3279 WHERE (`entry` = 3279);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3279);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3279, 2287, 0, 60.0, 0, 1, 0, 1, 1, 'Witchwing Ambusher - Haunch of Meat'),
(3279, 5369, 0, 40.0, 0, 1, 0, 1, 1, 'Witchwing Ambusher - Gnawed Bone');

-- Zalazane (3205)
UPDATE `creature_template` SET `pickpocketloot` = 3205 WHERE (`entry` = 3205);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3205);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3205, 117, 0, 16.67, 0, 1, 0, 1, 1, 'Zalazane - Tough Jerky'),
(3205, 118, 0, 33.33, 0, 1, 0, 1, 1, 'Zalazane - Minor Healing Potion'),
(3205, 4540, 0, 16.67, 0, 1, 0, 1, 1, 'Zalazane - Tough Hunk of Bread'),
(3205, 5367, 0, 41.67, 0, 1, 0, 1, 1, 'Zalazane - Primitive Rock Tool');

-- Gazz'uz (3204)
UPDATE `creature_template` SET `pickpocketloot` = 3204 WHERE (`entry` = 3204);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3204);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3204, 858, 0, 11.11, 0, 1, 0, 1, 1, 'Gazz\'uz - Lesser Healing Potion'),
(3204, 2287, 0, 33.33, 0, 1, 0, 1, 1, 'Gazz\'uz - Haunch of Meat'),
(3204, 4541, 0, 11.11, 0, 1, 0, 1, 1, 'Gazz\'uz - Freshly Baked Bread'),
(3204, 5379, 0, 44.44, 0, 1, 0, 1, 1, 'Gazz\'uz - Broken Boot Knife');

-- Tinkerer Sniggles (3471)
UPDATE `creature_template` SET `pickpocketloot` = 3471 WHERE (`entry` = 3471);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3471);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3471, 858, 0, 7.69, 0, 1, 0, 1, 1, 'Tinkerer Sniggles - Lesser Healing Potion'),
(3471, 1210, 0, 7.69, 0, 1, 0, 1, 1, 'Tinkerer Sniggles - Shadowgem'),
(3471, 2287, 0, 23.08, 0, 1, 0, 1, 1, 'Tinkerer Sniggles - Haunch of Meat'),
(3471, 4541, 0, 23.08, 0, 1, 0, 1, 1, 'Tinkerer Sniggles - Freshly Baked Bread'),
(3471, 5379, 0, 46.15, 0, 1, 0, 1, 1, 'Tinkerer Sniggles - Broken Boot Knife');

-- Serena Bloodfeather (3452)
UPDATE `creature_template` SET `pickpocketloot` = 3452 WHERE (`entry` = 3452);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3452);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3452, 858, 0, 20.0, 0, 1, 0, 1, 1, 'Serena Bloodfeather - Lesser Healing Potion'),
(3452, 2287, 0, 20.0, 0, 1, 0, 1, 1, 'Serena Bloodfeather - Haunch of Meat'),
(3452, 5369, 0, 60.0, 0, 1, 0, 1, 1, 'Serena Bloodfeather - Gnawed Bone');

-- Captain Fairmount (3393)
UPDATE `creature_template` SET `pickpocketloot` = 3393 WHERE (`entry` = 3393);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3393);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3393, 414, 0, 37.5, 0, 1, 0, 1, 1, 'Captain Fairmount - Dalaran Sharp'),
(3393, 818, 0, 12.5, 0, 1, 0, 1, 1, 'Captain Fairmount - Tigerseye'),
(3393, 858, 0, 12.5, 0, 1, 0, 1, 1, 'Captain Fairmount - Lesser Healing Potion'),
(3393, 5368, 0, 37.5, 0, 1, 0, 1, 1, 'Captain Fairmount - Empty Wallet');

-- Southsea Privateer (3384)
UPDATE `creature_template` SET `pickpocketloot` = 3384 WHERE (`entry` = 3384);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3384);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3384, 414, 0, 11.11, 0, 1, 0, 1, 1, 'Southsea Privateer - Dalaran Sharp'),
(3384, 858, 0, 16.67, 0, 1, 0, 1, 1, 'Southsea Privateer - Lesser Healing Potion'),
(3384, 1210, 0, 5.56, 0, 1, 0, 1, 1, 'Southsea Privateer - Shadowgem'),
(3384, 4537, 0, 11.11, 0, 1, 0, 1, 1, 'Southsea Privateer - Tel\'Abim Banana'),
(3384, 4541, 0, 11.11, 0, 1, 0, 1, 1, 'Southsea Privateer - Freshly Baked Bread'),
(3384, 5368, 0, 55.56, 0, 1, 0, 1, 1, 'Southsea Privateer - Empty Wallet');

-- Delmanis the Hated (3662)
UPDATE `creature_template` SET `pickpocketloot` = 3662 WHERE (`entry` = 3662);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3662);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3662, 2287, 0, 42.86, 0, 1, 0, 1, 1, 'Delmanis the Hated - Haunch of Meat'),
(3662, 5369, 0, 57.14, 0, 1, 0, 1, 1, 'Delmanis the Hated - Gnawed Bone');

-- Athrikus Narassin (3660)
UPDATE `creature_template` SET `pickpocketloot` = 3660 WHERE (`entry` = 3660);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3660);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3660, 4544, 0, 28.57, 0, 1, 0, 1, 1, 'Athrikus Narassin - Mulgore Spice Bread'),
(3660, 5431, 0, 42.86, 0, 1, 0, 1, 1, 'Athrikus Narassin - Empty Hip Flask'),
(3660, 16883, 0, 57.14, 0, 1, 0, 1, 1, 'Athrikus Narassin - Worn Junkbox');

-- Hezrul Bloodmark (3396)
UPDATE `creature_template` SET `pickpocketloot` = 3396 WHERE (`entry` = 3396);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3396);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3396, 2287, 0, 80.0, 0, 1, 0, 1, 1, 'Hezrul Bloodmark - Haunch of Meat'),
(3396, 5369, 0, 20.0, 0, 1, 0, 1, 1, 'Hezrul Bloodmark - Gnawed Bone');

-- Dalaran Brewmaster (3577)
UPDATE `creature_template` SET `pickpocketloot` = 3577 WHERE (`entry` = 3577);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3577);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3577, 414, 0, 33.33, 0, 1, 0, 1, 1, 'Dalaran Brewmaster - Dalaran Sharp'),
(3577, 858, 0, 50.0, 0, 1, 0, 1, 1, 'Dalaran Brewmaster - Lesser Healing Potion'),
(3577, 4537, 0, 33.33, 0, 1, 0, 1, 1, 'Dalaran Brewmaster - Tel\'Abim Banana'),
(3577, 5368, 0, 16.67, 0, 1, 0, 1, 1, 'Dalaran Brewmaster - Empty Wallet');

-- Apothecary Falthis (3735)
UPDATE `creature_template` SET `pickpocketloot` = 3735 WHERE (`entry` = 3735);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3735);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3735, 5376, 0, 40.0, 0, 1, 0, 1, 1, 'Apothecary Falthis - Broken Mirror'),
(3735, 16882, 0, 60.0, 0, 1, 0, 1, 1, 'Apothecary Falthis - Battered Junkbox');

-- Dark Strand Enforcer (3727)
UPDATE `creature_template` SET `pickpocketloot` = 3727 WHERE (`entry` = 3727);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3727);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3727, 414, 0, 22.22, 0, 1, 0, 1, 1, 'Dark Strand Enforcer - Dalaran Sharp'),
(3727, 858, 0, 14.81, 0, 1, 0, 1, 1, 'Dark Strand Enforcer - Lesser Healing Potion'),
(3727, 1210, 0, 3.7, 0, 1, 0, 1, 1, 'Dark Strand Enforcer - Shadowgem'),
(3727, 2407, 0, 3.7, 0, 1, 0, 1, 1, 'Dark Strand Enforcer - Pattern: White Leather Jerkin'),
(3727, 4537, 0, 14.81, 0, 1, 0, 1, 1, 'Dark Strand Enforcer - Tel\'Abim Banana'),
(3727, 4541, 0, 3.7, 0, 1, 0, 1, 1, 'Dark Strand Enforcer - Freshly Baked Bread'),
(3727, 5368, 0, 55.56, 0, 1, 0, 1, 1, 'Dark Strand Enforcer - Empty Wallet');

-- Windshear Stonecutter (4002)
UPDATE `creature_template` SET `pickpocketloot` = 4002 WHERE (`entry` = 4002);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 4002);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4002, 929, 0, 11.11, 0, 1, 0, 1, 1, 'Windshear Stonecutter - Healing Potion'),
(4002, 5375, 0, 22.22, 0, 1, 0, 1, 1, 'Windshear Stonecutter - Scratching Stick'),
(4002, 16882, 0, 77.78, 0, 1, 0, 1, 1, 'Windshear Stonecutter - Battered Junkbox');

-- Acidic Swamp Ooze (4393)
UPDATE `creature_template` SET `pickpocketloot` = 4393 WHERE (`entry` = 4393);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 4393);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4393, 4607, 0, 33.33, 0, 1, 0, 1, 1, 'Acidic Swamp Ooze - Delicious Cave Mold'),
(4393, 5433, 0, 50.0, 0, 1, 0, 1, 1, 'Acidic Swamp Ooze - Rag Doll'),
(4393, 16883, 0, 66.67, 0, 1, 0, 1, 1, 'Acidic Swamp Ooze - Worn Junkbox');

-- Grenka Bloodscreech (4490)
UPDATE `creature_template` SET `pickpocketloot` = 4490 WHERE (`entry` = 4490);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 4490);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4490, 1710, 0, 33.33, 0, 1, 0, 1, 1, 'Grenka Bloodscreech - Greater Healing Potion'),
(4490, 16883, 0, 66.67, 0, 1, 0, 1, 1, 'Grenka Bloodscreech - Worn Junkbox');

-- Ruuzel (3943)
UPDATE `creature_template` SET `pickpocketloot` = 3943 WHERE (`entry` = 3943);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 3943);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3943, 5377, 0, 14.29, 0, 1, 0, 1, 1, 'Ruuzel - Scallop Shell'),
(3943, 6308, 0, 28.57, 0, 1, 0, 1, 2, 'Ruuzel - Raw Bristle Whisker Catfish'),
(3943, 16882, 0, 71.43, 0, 1, 0, 1, 1, 'Ruuzel - Battered Junkbox');

-- Death's Head Ward Keeper (4625)
UPDATE `creature_template` SET `pickpocketloot` = 4625 WHERE (`entry` = 4625);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 4625);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4625, 858, 0, 30.0, 0, 1, 0, 1, 1, 'Death\'s Head Ward Keeper - Lesser Healing Potion'),
(4625, 5369, 0, 70.0, 0, 1, 0, 1, 1, 'Death\'s Head Ward Keeper - Gnawed Bone');

-- Captain Gerogg Hammertoe (5851)
UPDATE `creature_template` SET `pickpocketloot` = 5851 WHERE (`entry` = 5851);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 5851);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5851, 16882, 0, 100.0, 0, 1, 0, 1, 1, 'Captain Gerogg Hammertoe - Battered Junkbox');

-- Slimeshell Makrura (6020)
UPDATE `creature_template` SET `pickpocketloot` = 6020 WHERE (`entry` = 6020);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6020);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6020, 5371, 0, 22.22, 0, 1, 0, 1, 1, 'Slimeshell Makrura - Piece of Coral'),
(6020, 6289, 0, 77.78, 0, 1, 0, 1, 2, 'Slimeshell Makrura - Raw Longjaw Mud Snapper');

-- Felweaver Scornn (5822)
UPDATE `creature_template` SET `pickpocketloot` = 5822 WHERE (`entry` = 5822);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 5822);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5822, 4541, 0, 10.0, 0, 1, 0, 1, 1, 'Felweaver Scornn - Freshly Baked Bread'),
(5822, 5379, 0, 90.0, 0, 1, 0, 1, 1, 'Felweaver Scornn - Broken Boot Knife');

-- Burning Blade Invoker (4705)
UPDATE `creature_template` SET `pickpocketloot` = 4705 WHERE (`entry` = 4705);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 4705);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4705, 1710, 0, 7.69, 0, 1, 0, 1, 1, 'Burning Blade Invoker - Greater Healing Potion'),
(4705, 4544, 0, 23.08, 0, 1, 0, 1, 1, 'Burning Blade Invoker - Mulgore Spice Bread'),
(4705, 5431, 0, 53.85, 0, 1, 0, 1, 1, 'Burning Blade Invoker - Empty Hip Flask'),
(4705, 16883, 0, 23.08, 0, 1, 0, 1, 1, 'Burning Blade Invoker - Worn Junkbox');

-- Maraudine Khan Guard (6069)
UPDATE `creature_template` SET `pickpocketloot` = 6069 WHERE (`entry` = 6069);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6069);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6069, 3771, 0, 47.62, 0, 1, 0, 1, 1, 'Maraudine Khan Guard - Wild Hog Shank'),
(6069, 5429, 0, 19.05, 0, 1, 0, 1, 1, 'Maraudine Khan Guard - A Pretty Rock'),
(6069, 16883, 0, 38.1, 0, 1, 0, 1, 1, 'Maraudine Khan Guard - Worn Junkbox');

-- Geltharis (4619)
UPDATE `creature_template` SET `pickpocketloot` = 4619 WHERE (`entry` = 4619);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 4619);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4619, 1710, 0, 20.0, 0, 1, 0, 1, 1, 'Geltharis - Greater Healing Potion'),
(4619, 3771, 0, 20.0, 0, 1, 0, 1, 1, 'Geltharis - Wild Hog Shank'),
(4619, 5429, 0, 40.0, 0, 1, 0, 1, 1, 'Geltharis - A Pretty Rock'),
(4619, 16883, 0, 40.0, 0, 1, 0, 1, 1, 'Geltharis - Worn Junkbox');

-- Makrinni Scrabbler (6370)
UPDATE `creature_template` SET `pickpocketloot` = 6370 WHERE (`entry` = 6370);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6370);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6370, 3928, 0, 10.0, 0, 1, 0, 1, 1, 'Makrinni Scrabbler - Superior Healing Potion'),
(6370, 5435, 0, 50.0, 0, 1, 0, 1, 1, 'Makrinni Scrabbler - Shiny Dinglehopper'),
(6370, 8959, 0, 30.0, 0, 1, 0, 1, 1, 'Makrinni Scrabbler - Raw Spinefin Halibut'),
(6370, 16885, 0, 10.0, 0, 1, 0, 1, 1, 'Makrinni Scrabbler - Heavy Junkbox');

-- Minion of Sethir (6911)
UPDATE `creature_template` SET `pickpocketloot` = 6911 WHERE (`entry` = 6911);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6911);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6911, 117, 0, 14.29, 0, 1, 0, 1, 1, 'Minion of Sethir - Tough Jerky'),
(6911, 118, 0, 14.29, 0, 1, 0, 1, 1, 'Minion of Sethir - Minor Healing Potion'),
(6911, 5364, 0, 71.43, 0, 1, 0, 1, 1, 'Minion of Sethir - Dry Salt Lick');

-- Overseer Glibby (6606)
UPDATE `creature_template` SET `pickpocketloot` = 6606 WHERE (`entry` = 6606);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6606);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6606, 2287, 0, 75.0, 0, 1, 0, 1, 1, 'Overseer Glibby - Haunch of Meat'),
(6606, 5379, 0, 25.0, 0, 1, 0, 1, 1, 'Overseer Glibby - Broken Boot Knife');

-- Ironspine (6489)
UPDATE `creature_template` SET `pickpocketloot` = 6489 WHERE (`entry` = 6489);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6489);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6489, 1529, 0, 10.0, 0, 1, 0, 1, 1, 'Ironspine - Jade'),
(6489, 1710, 0, 20.0, 0, 1, 0, 1, 1, 'Ironspine - Greater Healing Potion'),
(6489, 4607, 0, 30.0, 0, 1, 0, 1, 1, 'Ironspine - Delicious Cave Mold'),
(6489, 5433, 0, 50.0, 0, 1, 0, 1, 1, 'Ironspine - Rag Doll'),
(6489, 16883, 0, 30.0, 0, 1, 0, 1, 1, 'Ironspine - Worn Junkbox');

-- Fallen Champion (6488)
UPDATE `creature_template` SET `pickpocketloot` = 6488 WHERE (`entry` = 6488);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6488);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6488, 1710, 0, 25.0, 0, 1, 0, 1, 1, 'Fallen Champion - Greater Healing Potion'),
(6488, 4607, 0, 41.67, 0, 1, 0, 1, 1, 'Fallen Champion - Delicious Cave Mold'),
(6488, 5433, 0, 33.33, 0, 1, 0, 1, 1, 'Fallen Champion - Rag Doll'),
(6488, 16883, 0, 33.33, 0, 1, 0, 1, 1, 'Fallen Champion - Worn Junkbox');

-- Shadowforge Ambusher (7091)
UPDATE `creature_template` SET `pickpocketloot` = 7091 WHERE (`entry` = 7091);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7091);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7091, 3927, 0, 40.0, 0, 1, 0, 1, 1, 'Shadowforge Ambusher - Fine Aged Cheddar'),
(7091, 5432, 0, 40.0, 0, 1, 0, 1, 1, 'Shadowforge Ambusher - Hickory Pipe'),
(7091, 16884, 0, 40.0, 0, 1, 0, 1, 1, 'Shadowforge Ambusher - Sturdy Junkbox');

-- Galgann Firehammer (7291)
UPDATE `creature_template` SET `pickpocketloot` = 7291 WHERE (`entry` = 7291);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7291);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7291, 3927, 0, 15.38, 0, 1, 0, 1, 1, 'Galgann Firehammer - Fine Aged Cheddar'),
(7291, 4601, 0, 23.08, 0, 1, 0, 1, 1, 'Galgann Firehammer - Soft Banana Bread'),
(7291, 4602, 0, 23.08, 0, 1, 0, 1, 1, 'Galgann Firehammer - Moon Harvest Pumpkin'),
(7291, 5432, 0, 61.54, 0, 1, 0, 1, 1, 'Galgann Firehammer - Hickory Pipe');

-- Defias Dockworker (6927)
UPDATE `creature_template` SET `pickpocketloot` = 6927 WHERE (`entry` = 6927);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 6927);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(6927, 118, 0, 28.0, 0, 1, 0, 1, 1, 'Defias Dockworker - Minor Healing Potion'),
(6927, 774, 0, 8.0, 0, 1, 0, 1, 1, 'Defias Dockworker - Malachite'),
(6927, 2070, 0, 12.0, 0, 1, 0, 1, 1, 'Defias Dockworker - Darnassian Bleu'),
(6927, 4536, 0, 4.0, 0, 1, 0, 1, 1, 'Defias Dockworker - Shiny Red Apple'),
(6927, 4540, 0, 4.0, 0, 1, 0, 1, 1, 'Defias Dockworker - Tough Hunk of Bread'),
(6927, 5363, 0, 12.0, 0, 1, 0, 1, 1, 'Defias Dockworker - Folded Handkerchief'),
(6927, 6150, 0, 32.0, 0, 1, 0, 1, 1, 'Defias Dockworker - A Frayed Knot');

-- Digmaster Shovelphlange (7057)
UPDATE `creature_template` SET `pickpocketloot` = 7057 WHERE (`entry` = 7057);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7057);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7057, 1710, 0, 14.29, 0, 1, 0, 1, 1, 'Digmaster Shovelphlange - Greater Healing Potion'),
(7057, 5427, 0, 57.14, 0, 1, 0, 1, 1, 'Digmaster Shovelphlange - Crude Pocket Watch'),
(7057, 16883, 0, 28.57, 0, 1, 0, 1, 1, 'Digmaster Shovelphlange - Worn Junkbox');

-- Ragglesnout (7354)
UPDATE `creature_template` SET `pickpocketloot` = 7354 WHERE (`entry` = 7354);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7354);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7354, 1710, 0, 33.33, 0, 1, 0, 1, 1, 'Ragglesnout - Greater Healing Potion'),
(7354, 3771, 0, 33.33, 0, 1, 0, 1, 1, 'Ragglesnout - Wild Hog Shank'),
(7354, 5429, 0, 16.67, 0, 1, 0, 1, 1, 'Ragglesnout - A Pretty Rock'),
(7354, 16883, 0, 16.67, 0, 1, 0, 1, 1, 'Ragglesnout - Worn Junkbox');

-- Lathoric the Black (8391)
UPDATE `creature_template` SET `pickpocketloot` = 8391 WHERE (`entry` = 8391);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 8391);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8391, 3928, 0, 20.0, 0, 1, 0, 1, 1, 'Lathoric the Black - Superior Healing Potion'),
(8391, 5432, 0, 30.0, 0, 1, 0, 1, 1, 'Lathoric the Black - Hickory Pipe'),
(8391, 8932, 0, 10.0, 0, 1, 0, 1, 1, 'Lathoric the Black - Alterac Swiss'),
(8391, 8953, 0, 10.0, 0, 1, 0, 1, 1, 'Lathoric the Black - Deep Fried Plantains'),
(8391, 16884, 0, 20.0, 0, 1, 0, 1, 1, 'Lathoric the Black - Sturdy Junkbox'),
(8391, 16885, 0, 20.0, 0, 1, 0, 1, 1, 'Lathoric the Black - Heavy Junkbox');

-- Sandfury Acolyte (8876)
UPDATE `creature_template` SET `pickpocketloot` = 8876 WHERE (`entry` = 8876);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 8876);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8876, 3928, 0, 17.5, 0, 1, 0, 1, 1, 'Sandfury Acolyte - Superior Healing Potion'),
(8876, 4599, 0, 5.0, 0, 1, 0, 1, 1, 'Sandfury Acolyte - Cured Ham Steak'),
(8876, 4601, 0, 15.0, 0, 1, 0, 1, 1, 'Sandfury Acolyte - Soft Banana Bread'),
(8876, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Sandfury Acolyte - An Exotic Cookbook'),
(8876, 7910, 0, 2.5, 0, 1, 0, 1, 1, 'Sandfury Acolyte - Star Ruby'),
(8876, 16884, 0, 25.0, 0, 1, 0, 1, 1, 'Sandfury Acolyte - Sturdy Junkbox');

-- Caravan Master Tset (8409)
UPDATE `creature_template` SET `pickpocketloot` = 8409 WHERE (`entry` = 8409);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 8409);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8409, 5435, 0, 42.86, 0, 1, 0, 1, 1, 'Caravan Master Tset - Shiny Dinglehopper'),
(8409, 8959, 0, 42.86, 0, 1, 0, 1, 1, 'Caravan Master Tset - Raw Spinefin Halibut'),
(8409, 16885, 0, 14.29, 0, 1, 0, 1, 1, 'Caravan Master Tset - Heavy Junkbox');

-- Omgorn the Lost (8201)
UPDATE `creature_template` SET `pickpocketloot` = 8201 WHERE (`entry` = 8201);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 8201);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8201, 4601, 0, 100.0, 0, 1, 0, 1, 1, 'Omgorn the Lost - Soft Banana Bread');

-- Kirith the Damned (7728)
UPDATE `creature_template` SET `pickpocketloot` = 7728 WHERE (`entry` = 7728);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7728);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7728, 3419, 0, 57.14, 0, 1, 0, 1, 1, 'Kirith the Damned - Red Rose'),
(7728, 3928, 0, 42.86, 0, 1, 0, 1, 1, 'Kirith the Damned - Superior Healing Potion'),
(7728, 8948, 0, 14.29, 0, 1, 0, 1, 1, 'Kirith the Damned - Dried King Bolete'),
(7728, 16885, 0, 28.57, 0, 1, 0, 1, 1, 'Kirith the Damned - Heavy Junkbox');

-- Raven (7605)
UPDATE `creature_template` SET `pickpocketloot` = 7605 WHERE (`entry` = 7605);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7605);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7605, 3927, 0, 17.24, 0, 1, 0, 1, 1, 'Raven - Fine Aged Cheddar'),
(7605, 3928, 0, 17.24, 0, 1, 0, 1, 1, 'Raven - Superior Healing Potion'),
(7605, 4601, 0, 6.9, 0, 1, 0, 1, 1, 'Raven - Soft Banana Bread'),
(7605, 4602, 0, 6.9, 0, 1, 0, 1, 1, 'Raven - Moon Harvest Pumpkin'),
(7605, 5432, 0, 31.03, 0, 1, 0, 1, 1, 'Raven - Hickory Pipe'),
(7605, 16884, 0, 31.03, 0, 1, 0, 1, 1, 'Raven - Sturdy Junkbox');

-- Antu'sul (8127)
UPDATE `creature_template` SET `pickpocketloot` = 8127 WHERE (`entry` = 8127);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 8127);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8127, 3928, 0, 13.89, 0, 1, 0, 1, 1, 'Antu\'sul - Superior Healing Potion'),
(8127, 4599, 0, 11.11, 0, 1, 0, 1, 1, 'Antu\'sul - Cured Ham Steak'),
(8127, 4601, 0, 13.89, 0, 1, 0, 1, 1, 'Antu\'sul - Soft Banana Bread'),
(8127, 5428, 0, 38.89, 0, 1, 0, 1, 1, 'Antu\'sul - An Exotic Cookbook'),
(8127, 16884, 0, 27.78, 0, 1, 0, 1, 1, 'Antu\'sul - Sturdy Junkbox');

-- Highlord Mastrogonde (8282)
UPDATE `creature_template` SET `pickpocketloot` = 8282 WHERE (`entry` = 8282);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 8282);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8282, 3928, 0, 27.27, 0, 1, 0, 1, 1, 'Highlord Mastrogonde - Superior Healing Potion'),
(8282, 5432, 0, 36.36, 0, 1, 0, 1, 1, 'Highlord Mastrogonde - Hickory Pipe'),
(8282, 8932, 0, 18.18, 0, 1, 0, 1, 1, 'Highlord Mastrogonde - Alterac Swiss'),
(8282, 16885, 0, 27.27, 0, 1, 0, 1, 1, 'Highlord Mastrogonde - Heavy Junkbox');

-- Dark Iron Steelshifter (8337)
UPDATE `creature_template` SET `pickpocketloot` = 8337 WHERE (`entry` = 8337);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 8337);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8337, 3927, 0, 6.06, 0, 1, 0, 1, 1, 'Dark Iron Steelshifter - Fine Aged Cheddar'),
(8337, 3928, 0, 9.09, 0, 1, 0, 1, 1, 'Dark Iron Steelshifter - Superior Healing Potion'),
(8337, 4601, 0, 12.12, 0, 1, 0, 1, 1, 'Dark Iron Steelshifter - Soft Banana Bread'),
(8337, 4602, 0, 6.06, 0, 1, 0, 1, 1, 'Dark Iron Steelshifter - Moon Harvest Pumpkin'),
(8337, 5432, 0, 51.52, 0, 1, 0, 1, 1, 'Dark Iron Steelshifter - Hickory Pipe'),
(8337, 16884, 0, 24.24, 0, 1, 0, 1, 1, 'Dark Iron Steelshifter - Sturdy Junkbox');

-- Archmage Allistarj (7666)
UPDATE `creature_template` SET `pickpocketloot` = 7666 WHERE (`entry` = 7666);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7666);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7666, 3928, 0, 7.14, 0, 1, 0, 1, 1, 'Archmage Allistarj - Superior Healing Potion'),
(7666, 5432, 0, 78.57, 0, 1, 0, 1, 1, 'Archmage Allistarj - Hickory Pipe'),
(7666, 8950, 0, 14.29, 0, 1, 0, 1, 1, 'Archmage Allistarj - Homemade Cherry Pie'),
(7666, 16885, 0, 7.14, 0, 1, 0, 1, 1, 'Archmage Allistarj - Heavy Junkbox');

-- Spirestone Lord Magus (9217)
UPDATE `creature_template` SET `pickpocketloot` = 9217 WHERE (`entry` = 9217);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9217);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9217, 3928, 0, 6.25, 0, 1, 0, 1, 1, 'Spirestone Lord Magus - Superior Healing Potion'),
(9217, 5428, 0, 50.0, 0, 1, 0, 1, 1, 'Spirestone Lord Magus - An Exotic Cookbook'),
(9217, 7910, 0, 6.25, 0, 1, 0, 1, 1, 'Spirestone Lord Magus - Star Ruby'),
(9217, 8950, 0, 18.75, 0, 1, 0, 1, 1, 'Spirestone Lord Magus - Homemade Cherry Pie'),
(9217, 8952, 0, 12.5, 0, 1, 0, 1, 1, 'Spirestone Lord Magus - Roasted Quail'),
(9217, 16885, 0, 18.75, 0, 1, 0, 1, 1, 'Spirestone Lord Magus - Heavy Junkbox');

-- Ok'thor the Breaker (9030)
UPDATE `creature_template` SET `pickpocketloot` = 9030 WHERE (`entry` = 9030);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9030);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9030, 3928, 0, 3.03, 0, 1, 0, 1, 1, 'Ok\'thor the Breaker - Superior Healing Potion'),
(9030, 5428, 0, 48.48, 0, 1, 0, 1, 1, 'Ok\'thor the Breaker - An Exotic Cookbook'),
(9030, 8950, 0, 21.21, 0, 1, 0, 1, 1, 'Ok\'thor the Breaker - Homemade Cherry Pie'),
(9030, 8952, 0, 12.12, 0, 1, 0, 1, 1, 'Ok\'thor the Breaker - Roasted Quail'),
(9030, 16885, 0, 30.3, 0, 1, 0, 1, 1, 'Ok\'thor the Breaker - Heavy Junkbox');

-- Zul'Farrak Dead Hero (7276)
UPDATE `creature_template` SET `pickpocketloot` = 7276 WHERE (`entry` = 7276);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 7276);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7276, 3419, 0, 54.55, 0, 1, 0, 1, 1, 'Zul\'Farrak Dead Hero - Red Rose'),
(7276, 3928, 0, 13.64, 0, 1, 0, 1, 1, 'Zul\'Farrak Dead Hero - Superior Healing Potion'),
(7276, 4608, 0, 36.36, 0, 1, 0, 1, 1, 'Zul\'Farrak Dead Hero - Raw Black Truffle'),
(7276, 16884, 0, 13.64, 0, 1, 0, 1, 1, 'Zul\'Farrak Dead Hero - Sturdy Junkbox');

-- Spirestone Butcher (9219)
UPDATE `creature_template` SET `pickpocketloot` = 9219 WHERE (`entry` = 9219);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9219);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9219, 3928, 0, 3.45, 0, 1, 0, 1, 1, 'Spirestone Butcher - Superior Healing Potion'),
(9219, 5428, 0, 27.59, 0, 1, 0, 1, 1, 'Spirestone Butcher - An Exotic Cookbook'),
(9219, 7910, 0, 3.45, 0, 1, 0, 1, 1, 'Spirestone Butcher - Star Ruby'),
(9219, 8950, 0, 27.59, 0, 1, 0, 1, 1, 'Spirestone Butcher - Homemade Cherry Pie'),
(9219, 8952, 0, 20.69, 0, 1, 0, 1, 1, 'Spirestone Butcher - Roasted Quail'),
(9219, 16885, 0, 24.14, 0, 1, 0, 1, 1, 'Spirestone Butcher - Heavy Junkbox');

-- Grizzle (9028)
UPDATE `creature_template` SET `pickpocketloot` = 9028 WHERE (`entry` = 9028);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9028);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9028, 3928, 0, 5.71, 0, 1, 0, 1, 1, 'Grizzle - Superior Healing Potion'),
(9028, 5428, 0, 45.71, 0, 1, 0, 1, 1, 'Grizzle - An Exotic Cookbook'),
(9028, 8950, 0, 17.14, 0, 1, 0, 1, 1, 'Grizzle - Homemade Cherry Pie'),
(9028, 8952, 0, 20.0, 0, 1, 0, 1, 1, 'Grizzle - Roasted Quail'),
(9028, 16885, 0, 17.14, 0, 1, 0, 1, 1, 'Grizzle - Heavy Junkbox');

-- Houndmaster Grebmar (9319)
UPDATE `creature_template` SET `pickpocketloot` = 9319 WHERE (`entry` = 9319);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9319);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9319, 5432, 0, 50.0, 0, 1, 0, 1, 1, 'Houndmaster Grebmar - Hickory Pipe'),
(9319, 8932, 0, 12.5, 0, 1, 0, 1, 1, 'Houndmaster Grebmar - Alterac Swiss'),
(9319, 16885, 0, 37.5, 0, 1, 0, 1, 1, 'Houndmaster Grebmar - Heavy Junkbox');

-- Gorosh the Dervish (9027)
UPDATE `creature_template` SET `pickpocketloot` = 9027 WHERE (`entry` = 9027);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9027);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9027, 3928, 0, 20.0, 0, 1, 0, 1, 1, 'Gorosh the Dervish - Superior Healing Potion'),
(9027, 5428, 0, 50.0, 0, 1, 0, 1, 1, 'Gorosh the Dervish - An Exotic Cookbook'),
(9027, 7910, 0, 5.0, 0, 1, 0, 1, 1, 'Gorosh the Dervish - Star Ruby'),
(9027, 8950, 0, 25.0, 0, 1, 0, 1, 1, 'Gorosh the Dervish - Homemade Cherry Pie'),
(9027, 8952, 0, 5.0, 0, 1, 0, 1, 1, 'Gorosh the Dervish - Roasted Quail'),
(9027, 16885, 0, 5.0, 0, 1, 0, 1, 1, 'Gorosh the Dervish - Heavy Junkbox');

-- Dark Keeper Vorfalk (9437)
UPDATE `creature_template` SET `pickpocketloot` = 9437 WHERE (`entry` = 9437);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9437);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9437, 5432, 0, 40.0, 0, 1, 0, 1, 1, 'Dark Keeper Vorfalk - Hickory Pipe'),
(9437, 8932, 0, 20.0, 0, 1, 0, 1, 1, 'Dark Keeper Vorfalk - Alterac Swiss'),
(9437, 8950, 0, 20.0, 0, 1, 0, 1, 1, 'Dark Keeper Vorfalk - Homemade Cherry Pie'),
(9437, 16885, 0, 20.0, 0, 1, 0, 1, 1, 'Dark Keeper Vorfalk - Heavy Junkbox');

-- Dark Keeper Bethek (9438)
UPDATE `creature_template` SET `pickpocketloot` = 9438 WHERE (`entry` = 9438);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9438);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9438, 3928, 0, 40.0, 0, 1, 0, 1, 1, 'Dark Keeper Bethek - Superior Healing Potion'),
(9438, 5432, 0, 40.0, 0, 1, 0, 1, 1, 'Dark Keeper Bethek - Hickory Pipe'),
(9438, 8950, 0, 20.0, 0, 1, 0, 1, 1, 'Dark Keeper Bethek - Homemade Cherry Pie'),
(9438, 16885, 0, 20.0, 0, 1, 0, 1, 1, 'Dark Keeper Bethek - Heavy Junkbox');

-- Boss Copperplug (9336)
UPDATE `creature_template` SET `pickpocketloot` = 9336 WHERE (`entry` = 9336);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9336);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9336, 858, 0, 28.57, 0, 1, 0, 1, 1, 'Boss Copperplug - Lesser Healing Potion'),
(9336, 2287, 0, 28.57, 0, 1, 0, 1, 1, 'Boss Copperplug - Haunch of Meat'),
(9336, 4541, 0, 14.29, 0, 1, 0, 1, 1, 'Boss Copperplug - Freshly Baked Bread'),
(9336, 5379, 0, 28.57, 0, 1, 0, 1, 1, 'Boss Copperplug - Broken Boot Knife');

-- Dark Keeper Zimrel (9441)
UPDATE `creature_template` SET `pickpocketloot` = 9441 WHERE (`entry` = 9441);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9441);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9441, 3928, 0, 11.11, 0, 1, 0, 1, 1, 'Dark Keeper Zimrel - Superior Healing Potion'),
(9441, 5432, 0, 55.56, 0, 1, 0, 1, 1, 'Dark Keeper Zimrel - Hickory Pipe'),
(9441, 8932, 0, 11.11, 0, 1, 0, 1, 1, 'Dark Keeper Zimrel - Alterac Swiss'),
(9441, 8950, 0, 11.11, 0, 1, 0, 1, 1, 'Dark Keeper Zimrel - Homemade Cherry Pie'),
(9441, 8953, 0, 33.33, 0, 1, 0, 1, 1, 'Dark Keeper Zimrel - Deep Fried Plantains');

-- Shill Dinger (9678)
UPDATE `creature_template` SET `pickpocketloot` = 9678 WHERE (`entry` = 9678);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9678);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9678, 3928, 0, 7.69, 0, 1, 0, 1, 1, 'Shill Dinger - Superior Healing Potion'),
(9678, 5432, 0, 30.77, 0, 1, 0, 1, 1, 'Shill Dinger - Hickory Pipe'),
(9678, 8932, 0, 23.08, 0, 1, 0, 1, 1, 'Shill Dinger - Alterac Swiss'),
(9678, 8950, 0, 23.08, 0, 1, 0, 1, 1, 'Shill Dinger - Homemade Cherry Pie'),
(9678, 8953, 0, 30.77, 0, 1, 0, 1, 1, 'Shill Dinger - Deep Fried Plantains');

-- Hahk'Zor (9602)
UPDATE `creature_template` SET `pickpocketloot` = 9602 WHERE (`entry` = 9602);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9602);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9602, 5428, 0, 20.0, 0, 1, 0, 1, 1, 'Hahk\'Zor - An Exotic Cookbook'),
(9602, 8950, 0, 20.0, 0, 1, 0, 1, 1, 'Hahk\'Zor - Homemade Cherry Pie'),
(9602, 8952, 0, 60.0, 0, 1, 0, 1, 1, 'Hahk\'Zor - Roasted Quail');

-- Ograbisi (9677)
UPDATE `creature_template` SET `pickpocketloot` = 9677 WHERE (`entry` = 9677);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9677);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9677, 5428, 0, 60.0, 0, 1, 0, 1, 1, 'Ograbisi - An Exotic Cookbook'),
(9677, 8952, 0, 10.0, 0, 1, 0, 1, 1, 'Ograbisi - Roasted Quail'),
(9677, 16885, 0, 40.0, 0, 1, 0, 1, 1, 'Ograbisi - Heavy Junkbox');

-- Dark Keeper Uggel (9439)
UPDATE `creature_template` SET `pickpocketloot` = 9439 WHERE (`entry` = 9439);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9439);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9439, 3928, 0, 11.11, 0, 1, 0, 1, 1, 'Dark Keeper Uggel - Superior Healing Potion'),
(9439, 5432, 0, 44.44, 0, 1, 0, 1, 1, 'Dark Keeper Uggel - Hickory Pipe'),
(9439, 8950, 0, 33.33, 0, 1, 0, 1, 1, 'Dark Keeper Uggel - Homemade Cherry Pie'),
(9439, 16885, 0, 11.11, 0, 1, 0, 1, 1, 'Dark Keeper Uggel - Heavy Junkbox');

-- Twilight's Hammer Executioner (9398)
UPDATE `creature_template` SET `pickpocketloot` = 9398 WHERE (`entry` = 9398);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9398);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9398, 3928, 0, 18.75, 0, 1, 0, 1, 1, 'Twilight\'s Hammer Executioner - Superior Healing Potion'),
(9398, 5432, 0, 31.25, 0, 1, 0, 1, 1, 'Twilight\'s Hammer Executioner - Hickory Pipe'),
(9398, 8932, 0, 6.25, 0, 1, 0, 1, 1, 'Twilight\'s Hammer Executioner - Alterac Swiss'),
(9398, 8950, 0, 6.25, 0, 1, 0, 1, 1, 'Twilight\'s Hammer Executioner - Homemade Cherry Pie'),
(9398, 8953, 0, 6.25, 0, 1, 0, 1, 1, 'Twilight\'s Hammer Executioner - Deep Fried Plantains'),
(9398, 16885, 0, 31.25, 0, 1, 0, 1, 1, 'Twilight\'s Hammer Executioner - Heavy Junkbox');

-- Kolkar Stormseer (9523)
UPDATE `creature_template` SET `pickpocketloot` = 9523 WHERE (`entry` = 9523);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9523);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9523, 858, 0, 14.29, 0, 1, 0, 1, 1, 'Kolkar Stormseer - Lesser Healing Potion'),
(9523, 2287, 0, 28.57, 0, 1, 0, 1, 1, 'Kolkar Stormseer - Haunch of Meat'),
(9523, 5369, 0, 57.14, 0, 1, 0, 1, 1, 'Kolkar Stormseer - Gnawed Bone');

-- Ribbly Screwspigot (9543)
UPDATE `creature_template` SET `pickpocketloot` = 9543 WHERE (`entry` = 9543);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9543);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9543, 3928, 0, 3.85, 0, 1, 0, 1, 1, 'Ribbly Screwspigot - Superior Healing Potion'),
(9543, 5428, 0, 57.69, 0, 1, 0, 1, 1, 'Ribbly Screwspigot - An Exotic Cookbook'),
(9543, 8950, 0, 30.77, 0, 1, 0, 1, 1, 'Ribbly Screwspigot - Homemade Cherry Pie'),
(9543, 8952, 0, 7.69, 0, 1, 0, 1, 1, 'Ribbly Screwspigot - Roasted Quail'),
(9543, 16885, 0, 3.85, 0, 1, 0, 1, 1, 'Ribbly Screwspigot - Heavy Junkbox');

-- Ghok Bashguud (9718)
UPDATE `creature_template` SET `pickpocketloot` = 9718 WHERE (`entry` = 9718);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9718);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9718, 5428, 0, 62.5, 0, 1, 0, 1, 1, 'Ghok Bashguud - An Exotic Cookbook'),
(9718, 8950, 0, 12.5, 0, 1, 0, 1, 1, 'Ghok Bashguud - Homemade Cherry Pie'),
(9718, 8952, 0, 12.5, 0, 1, 0, 1, 1, 'Ghok Bashguud - Roasted Quail'),
(9718, 16885, 0, 25.0, 0, 1, 0, 1, 1, 'Ghok Bashguud - Heavy Junkbox');

-- Crest Killer (9680)
UPDATE `creature_template` SET `pickpocketloot` = 9680 WHERE (`entry` = 9680);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9680);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9680, 3928, 0, 5.26, 0, 1, 0, 1, 1, 'Crest Killer - Superior Healing Potion'),
(9680, 5432, 0, 26.32, 0, 1, 0, 1, 1, 'Crest Killer - Hickory Pipe'),
(9680, 7910, 0, 5.26, 0, 1, 0, 1, 1, 'Crest Killer - Star Ruby'),
(9680, 8950, 0, 31.58, 0, 1, 0, 1, 1, 'Crest Killer - Homemade Cherry Pie'),
(9680, 8953, 0, 15.79, 0, 1, 0, 1, 1, 'Crest Killer - Deep Fried Plantains'),
(9680, 16885, 0, 26.32, 0, 1, 0, 1, 1, 'Crest Killer - Heavy Junkbox');

-- Kolkar Invader (9524)
UPDATE `creature_template` SET `pickpocketloot` = 9524 WHERE (`entry` = 9524);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9524);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9524, 858, 0, 5.0, 0, 1, 0, 1, 1, 'Kolkar Invader - Lesser Healing Potion'),
(9524, 1210, 0, 5.0, 0, 1, 0, 1, 1, 'Kolkar Invader - Shadowgem'),
(9524, 2287, 0, 60.0, 0, 1, 0, 1, 1, 'Kolkar Invader - Haunch of Meat'),
(9524, 5369, 0, 30.0, 0, 1, 0, 1, 1, 'Kolkar Invader - Gnawed Bone'),
(9524, 6342, 0, 5.0, 0, 1, 0, 1, 1, 'Kolkar Invader - Formula: Enchant Chest - Minor Mana');

-- Watchman Doomgrip (9476)
UPDATE `creature_template` SET `pickpocketloot` = 9476 WHERE (`entry` = 9476);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9476);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9476, 3928, 0, 12.12, 0, 1, 0, 1, 1, 'Watchman Doomgrip - Superior Healing Potion'),
(9476, 5432, 0, 42.42, 0, 1, 0, 1, 1, 'Watchman Doomgrip - Hickory Pipe'),
(9476, 8932, 0, 3.03, 0, 1, 0, 1, 1, 'Watchman Doomgrip - Alterac Swiss'),
(9476, 8950, 0, 15.15, 0, 1, 0, 1, 1, 'Watchman Doomgrip - Homemade Cherry Pie'),
(9476, 8953, 0, 18.18, 0, 1, 0, 1, 1, 'Watchman Doomgrip - Deep Fried Plantains'),
(9476, 16885, 0, 24.24, 0, 1, 0, 1, 1, 'Watchman Doomgrip - Heavy Junkbox');

-- Sandarr Dunereaver (10080)
UPDATE `creature_template` SET `pickpocketloot` = 10080 WHERE (`entry` = 10080);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10080);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10080, 4599, 0, 33.33, 0, 1, 0, 1, 1, 'Sandarr Dunereaver - Cured Ham Steak'),
(10080, 4601, 0, 25.0, 0, 1, 0, 1, 1, 'Sandarr Dunereaver - Soft Banana Bread'),
(10080, 5428, 0, 41.67, 0, 1, 0, 1, 1, 'Sandarr Dunereaver - An Exotic Cookbook'),
(10080, 16884, 0, 16.67, 0, 1, 0, 1, 1, 'Sandarr Dunereaver - Sturdy Junkbox');

-- Quartermaster Zigris (9736)
UPDATE `creature_template` SET `pickpocketloot` = 9736 WHERE (`entry` = 9736);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 9736);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9736, 3928, 0, 4.76, 0, 1, 0, 1, 1, 'Quartermaster Zigris - Superior Healing Potion'),
(9736, 5428, 0, 36.9, 0, 1, 0, 1, 1, 'Quartermaster Zigris - An Exotic Cookbook'),
(9736, 7910, 0, 3.57, 0, 1, 0, 1, 1, 'Quartermaster Zigris - Star Ruby'),
(9736, 8950, 0, 22.62, 0, 1, 0, 1, 1, 'Quartermaster Zigris - Homemade Cherry Pie'),
(9736, 8952, 0, 14.29, 0, 1, 0, 1, 1, 'Quartermaster Zigris - Roasted Quail'),
(9736, 16885, 0, 30.95, 0, 1, 0, 1, 1, 'Quartermaster Zigris - Heavy Junkbox');

-- Ribbly's Crony (10043)
UPDATE `creature_template` SET `pickpocketloot` = 10043 WHERE (`entry` = 10043);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10043);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10043, 3927, 0, 6.0, 0, 1, 0, 1, 1, 'Ribbly\'s Crony - Fine Aged Cheddar'),
(10043, 3928, 0, 12.0, 0, 1, 0, 1, 1, 'Ribbly\'s Crony - Superior Healing Potion'),
(10043, 4601, 0, 12.0, 0, 1, 0, 1, 1, 'Ribbly\'s Crony - Soft Banana Bread'),
(10043, 4602, 0, 14.0, 0, 1, 0, 1, 1, 'Ribbly\'s Crony - Moon Harvest Pumpkin'),
(10043, 5432, 0, 44.0, 0, 1, 0, 1, 1, 'Ribbly\'s Crony - Hickory Pipe'),
(10043, 7909, 0, 2.0, 0, 1, 0, 1, 1, 'Ribbly\'s Crony - Aquamarine'),
(10043, 16884, 0, 16.0, 0, 1, 0, 1, 1, 'Ribbly\'s Crony - Sturdy Junkbox');

-- Zerillis (10082)
UPDATE `creature_template` SET `pickpocketloot` = 10082 WHERE (`entry` = 10082);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10082);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10082, 3928, 0, 4.55, 0, 1, 0, 1, 1, 'Zerillis - Superior Healing Potion'),
(10082, 4599, 0, 13.64, 0, 1, 0, 1, 1, 'Zerillis - Cured Ham Steak'),
(10082, 4601, 0, 9.09, 0, 1, 0, 1, 1, 'Zerillis - Soft Banana Bread'),
(10082, 5428, 0, 59.09, 0, 1, 0, 1, 1, 'Zerillis - An Exotic Cookbook'),
(10082, 7909, 0, 4.55, 0, 1, 0, 1, 1, 'Zerillis - Aquamarine'),
(10082, 7910, 0, 9.09, 0, 1, 0, 1, 1, 'Zerillis - Star Ruby'),
(10082, 16884, 0, 18.18, 0, 1, 0, 1, 1, 'Zerillis - Sturdy Junkbox');

-- Skul (10393)
UPDATE `creature_template` SET `pickpocketloot` = 10393 WHERE (`entry` = 10393);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10393);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10393, 3419, 0, 50.0, 0, 1, 0, 1, 1, 'Skul - Red Rose'),
(10393, 8948, 0, 20.0, 0, 1, 0, 1, 1, 'Skul - Dried King Bolete'),
(10393, 16885, 0, 30.0, 0, 1, 0, 1, 1, 'Skul - Heavy Junkbox');

-- Dustwraith (10081)
UPDATE `creature_template` SET `pickpocketloot` = 10081 WHERE (`entry` = 10081);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10081);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10081, 3928, 0, 16.67, 0, 1, 0, 1, 1, 'Dustwraith - Superior Healing Potion'),
(10081, 4599, 0, 16.67, 0, 1, 0, 1, 1, 'Dustwraith - Cured Ham Steak'),
(10081, 5428, 0, 50.0, 0, 1, 0, 1, 1, 'Dustwraith - An Exotic Cookbook'),
(10081, 16884, 0, 33.33, 0, 1, 0, 1, 1, 'Dustwraith - Sturdy Junkbox');

-- Vectus (10432)
UPDATE `creature_template` SET `pickpocketloot` = 10432 WHERE (`entry` = 10432);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10432);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10432, 3419, 0, 27.27, 0, 1, 0, 1, 1, 'Vectus - Red Rose'),
(10432, 3928, 0, 9.09, 0, 1, 0, 1, 1, 'Vectus - Superior Healing Potion'),
(10432, 8948, 0, 59.09, 0, 1, 0, 1, 1, 'Vectus - Dried King Bolete'),
(10432, 16885, 0, 18.18, 0, 1, 0, 1, 1, 'Vectus - Heavy Junkbox');

-- Fleshflayer Ghoul (10407)
UPDATE `creature_template` SET `pickpocketloot` = 10407 WHERE (`entry` = 10407);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10407);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10407, 3419, 0, 42.25, 0, 1, 0, 1, 1, 'Fleshflayer Ghoul - Red Rose'),
(10407, 3928, 0, 15.89, 0, 1, 0, 1, 1, 'Fleshflayer Ghoul - Superior Healing Potion'),
(10407, 7910, 0, 1.55, 0, 1, 0, 1, 1, 'Fleshflayer Ghoul - Star Ruby'),
(10407, 8948, 0, 32.95, 0, 1, 0, 1, 1, 'Fleshflayer Ghoul - Dried King Bolete'),
(10407, 16885, 0, 16.28, 0, 1, 0, 1, 1, 'Fleshflayer Ghoul - Heavy Junkbox');

-- Ghoul Ravener (10406)
UPDATE `creature_template` SET `pickpocketloot` = 10406 WHERE (`entry` = 10406);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10406);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10406, 3419, 0, 45.25, 0, 1, 0, 1, 1, 'Ghoul Ravener - Red Rose'),
(10406, 3928, 0, 10.51, 0, 1, 0, 1, 1, 'Ghoul Ravener - Superior Healing Potion'),
(10406, 7910, 0, 1.82, 0, 1, 0, 1, 1, 'Ghoul Ravener - Star Ruby'),
(10406, 8948, 0, 32.73, 0, 1, 0, 1, 1, 'Ghoul Ravener - Dried King Bolete'),
(10406, 16885, 0, 18.38, 0, 1, 0, 1, 1, 'Ghoul Ravener - Heavy Junkbox');

-- Ramstein the Gorger (10439)
UPDATE `creature_template` SET `pickpocketloot` = 10439 WHERE (`entry` = 10439);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10439);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10439, 3419, 0, 45.59, 0, 1, 0, 1, 1, 'Ramstein the Gorger - Red Rose'),
(10439, 3928, 0, 14.71, 0, 1, 0, 1, 1, 'Ramstein the Gorger - Superior Healing Potion'),
(10439, 7910, 0, 1.47, 0, 1, 0, 1, 1, 'Ramstein the Gorger - Star Ruby'),
(10439, 8948, 0, 29.41, 0, 1, 0, 1, 1, 'Ramstein the Gorger - Dried King Bolete'),
(10439, 16885, 0, 16.18, 0, 1, 0, 1, 1, 'Ramstein the Gorger - Heavy Junkbox');

-- Black Guard Sentry (10394)
UPDATE `creature_template` SET `pickpocketloot` = 10394 WHERE (`entry` = 10394);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10394);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10394, 3419, 0, 40.57, 0, 1, 0, 1, 1, 'Black Guard Sentry - Red Rose'),
(10394, 3928, 0, 11.32, 0, 1, 0, 1, 1, 'Black Guard Sentry - Superior Healing Potion'),
(10394, 7910, 0, 0.94, 0, 1, 0, 1, 1, 'Black Guard Sentry - Star Ruby'),
(10394, 8948, 0, 41.51, 0, 1, 0, 1, 1, 'Black Guard Sentry - Dried King Bolete'),
(10394, 16885, 0, 14.15, 0, 1, 0, 1, 1, 'Black Guard Sentry - Heavy Junkbox');

-- Urok Ogre Magus (10602)
UPDATE `creature_template` SET `pickpocketloot` = 10602 WHERE (`entry` = 10602);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10602);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10602, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Urok Ogre Magus - An Exotic Cookbook'),
(10602, 8952, 0, 30.0, 0, 1, 0, 1, 1, 'Urok Ogre Magus - Roasted Quail'),
(10602, 16885, 0, 50.0, 0, 1, 0, 1, 1, 'Urok Ogre Magus - Heavy Junkbox');

-- Jed Runewatcher (10509)
UPDATE `creature_template` SET `pickpocketloot` = 10509 WHERE (`entry` = 10509);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10509);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10509, 3928, 0, 10.2, 0, 1, 0, 1, 1, 'Jed Runewatcher - Superior Healing Potion'),
(10509, 5428, 0, 46.94, 0, 1, 0, 1, 1, 'Jed Runewatcher - An Exotic Cookbook'),
(10509, 8950, 0, 8.16, 0, 1, 0, 1, 1, 'Jed Runewatcher - Homemade Cherry Pie'),
(10509, 8952, 0, 14.29, 0, 1, 0, 1, 1, 'Jed Runewatcher - Roasted Quail'),
(10509, 16885, 0, 32.65, 0, 1, 0, 1, 1, 'Jed Runewatcher - Heavy Junkbox');

-- Lady Vespia (10559)
UPDATE `creature_template` SET `pickpocketloot` = 10559 WHERE (`entry` = 10559);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10559);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10559, 929, 0, 16.67, 0, 1, 0, 1, 1, 'Lady Vespia - Healing Potion'),
(10559, 5377, 0, 33.33, 0, 1, 0, 1, 1, 'Lady Vespia - Scallop Shell'),
(10559, 6308, 0, 33.33, 0, 1, 0, 1, 1, 'Lady Vespia - Raw Bristle Whisker Catfish'),
(10559, 16882, 0, 33.33, 0, 1, 0, 1, 1, 'Lady Vespia - Battered Junkbox');

-- Lord Alexei Barov (10504)
UPDATE `creature_template` SET `pickpocketloot` = 10504 WHERE (`entry` = 10504);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10504);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10504, 5432, 0, 33.33, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Hickory Pipe'),
(10504, 8950, 0, 16.67, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Homemade Cherry Pie'),
(10504, 16885, 0, 50.0, 0, 1, 0, 1, 1, 'Lord Alexei Barov - Heavy Junkbox');

-- Marduk Blackpool (10433)
UPDATE `creature_template` SET `pickpocketloot` = 10433 WHERE (`entry` = 10433);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10433);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10433, 3419, 0, 40.74, 0, 1, 0, 1, 1, 'Marduk Blackpool - Red Rose'),
(10433, 3928, 0, 14.81, 0, 1, 0, 1, 1, 'Marduk Blackpool - Superior Healing Potion'),
(10433, 8948, 0, 25.93, 0, 1, 0, 1, 1, 'Marduk Blackpool - Dried King Bolete'),
(10433, 16885, 0, 18.52, 0, 1, 0, 1, 1, 'Marduk Blackpool - Heavy Junkbox');

-- Warchief Rend Blackhand (10429)
UPDATE `creature_template` SET `pickpocketloot` = 10429 WHERE (`entry` = 10429);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10429);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10429, 3928, 0, 16.67, 0, 1, 0, 1, 1, 'Warchief Rend Blackhand - Superior Healing Potion'),
(10429, 5428, 0, 33.33, 0, 1, 0, 1, 1, 'Warchief Rend Blackhand - An Exotic Cookbook'),
(10429, 7910, 0, 16.67, 0, 1, 0, 1, 1, 'Warchief Rend Blackhand - Star Ruby'),
(10429, 8950, 0, 33.33, 0, 1, 0, 1, 1, 'Warchief Rend Blackhand - Homemade Cherry Pie'),
(10429, 8952, 0, 33.33, 0, 1, 0, 1, 1, 'Warchief Rend Blackhand - Roasted Quail'),
(10429, 16885, 0, 16.67, 0, 1, 0, 1, 1, 'Warchief Rend Blackhand - Heavy Junkbox');

-- Thuzadin Shadowcaster (10398)
UPDATE `creature_template` SET `pickpocketloot` = 10398 WHERE (`entry` = 10398);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10398);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10398, 3928, 0, 7.87, 0, 1, 0, 1, 1, 'Thuzadin Shadowcaster - Superior Healing Potion'),
(10398, 5432, 0, 46.07, 0, 1, 0, 1, 1, 'Thuzadin Shadowcaster - Hickory Pipe'),
(10398, 7910, 0, 1.12, 0, 1, 0, 1, 1, 'Thuzadin Shadowcaster - Star Ruby'),
(10398, 8932, 0, 12.36, 0, 1, 0, 1, 1, 'Thuzadin Shadowcaster - Alterac Swiss'),
(10398, 8950, 0, 12.36, 0, 1, 0, 1, 1, 'Thuzadin Shadowcaster - Homemade Cherry Pie'),
(10398, 8953, 0, 9.74, 0, 1, 0, 1, 1, 'Thuzadin Shadowcaster - Deep Fried Plantains'),
(10398, 16885, 0, 22.1, 0, 1, 0, 1, 1, 'Thuzadin Shadowcaster - Heavy Junkbox');

-- Ravaged Cadaver (10381)
UPDATE `creature_template` SET `pickpocketloot` = 10381 WHERE (`entry` = 10381);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10381);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10381, 3419, 0, 36.82, 0, 1, 0, 1, 1, 'Ravaged Cadaver - Red Rose'),
(10381, 3928, 0, 9.55, 0, 1, 0, 1, 1, 'Ravaged Cadaver - Superior Healing Potion'),
(10381, 7910, 0, 0.91, 0, 1, 0, 1, 1, 'Ravaged Cadaver - Star Ruby'),
(10381, 8948, 0, 31.82, 0, 1, 0, 1, 1, 'Ravaged Cadaver - Dried King Bolete'),
(10381, 16885, 0, 28.64, 0, 1, 0, 1, 1, 'Ravaged Cadaver - Heavy Junkbox');

-- Jandice Barov (10503)
UPDATE `creature_template` SET `pickpocketloot` = 10503 WHERE (`entry` = 10503);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10503);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10503, 3928, 0, 12.73, 0, 1, 0, 1, 1, 'Jandice Barov - Superior Healing Potion'),
(10503, 5432, 0, 41.82, 0, 1, 0, 1, 1, 'Jandice Barov - Hickory Pipe'),
(10503, 7910, 0, 3.64, 0, 1, 0, 1, 1, 'Jandice Barov - Star Ruby'),
(10503, 8932, 0, 12.73, 0, 1, 0, 1, 1, 'Jandice Barov - Alterac Swiss'),
(10503, 8950, 0, 7.27, 0, 1, 0, 1, 1, 'Jandice Barov - Homemade Cherry Pie'),
(10503, 8953, 0, 9.09, 0, 1, 0, 1, 1, 'Jandice Barov - Deep Fried Plantains'),
(10503, 16885, 0, 21.82, 0, 1, 0, 1, 1, 'Jandice Barov - Heavy Junkbox'),
(10503, 29571, 0, 1.82, 0, 1, 0, 1, 1, 'Jandice Barov - A Steamy Romance Novel');

-- Marauding Corpse (10951)
UPDATE `creature_template` SET `pickpocketloot` = 10951 WHERE (`entry` = 10951);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10951);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10951, 3419, 0, 60.0, 0, 1, 0, 1, 1, 'Marauding Corpse - Red Rose'),
(10951, 3928, 0, 13.33, 0, 1, 0, 1, 1, 'Marauding Corpse - Superior Healing Potion'),
(10951, 8948, 0, 40.0, 0, 1, 0, 1, 1, 'Marauding Corpse - Dried King Bolete'),
(10951, 16885, 0, 26.67, 0, 1, 0, 1, 1, 'Marauding Corpse - Heavy Junkbox');

-- Reanimated Corpse (10481)
UPDATE `creature_template` SET `pickpocketloot` = 10481 WHERE (`entry` = 10481);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10481);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10481, 3419, 0, 49.11, 0, 1, 0, 1, 1, 'Reanimated Corpse - Red Rose'),
(10481, 3928, 0, 11.61, 0, 1, 0, 1, 1, 'Reanimated Corpse - Superior Healing Potion'),
(10481, 7910, 0, 1.79, 0, 1, 0, 1, 1, 'Reanimated Corpse - Star Ruby'),
(10481, 8948, 0, 25.89, 0, 1, 0, 1, 1, 'Reanimated Corpse - Dried King Bolete'),
(10481, 16885, 0, 21.43, 0, 1, 0, 1, 1, 'Reanimated Corpse - Heavy Junkbox');

-- Marauding Skeleton (10952)
UPDATE `creature_template` SET `pickpocketloot` = 10952 WHERE (`entry` = 10952);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10952);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10952, 3419, 0, 42.86, 0, 1, 0, 1, 1, 'Marauding Skeleton - Red Rose'),
(10952, 3928, 0, 9.52, 0, 1, 0, 1, 1, 'Marauding Skeleton - Superior Healing Potion'),
(10952, 8948, 0, 38.1, 0, 1, 0, 1, 1, 'Marauding Skeleton - Dried King Bolete'),
(10952, 16885, 0, 14.29, 0, 1, 0, 1, 1, 'Marauding Skeleton - Heavy Junkbox');

-- Bazzalan (11519)
UPDATE `creature_template` SET `pickpocketloot` = 11519 WHERE (`entry` = 11519);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11519);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11519, 858, 0, 11.11, 0, 1, 0, 1, 1, 'Bazzalan - Lesser Healing Potion'),
(11519, 2287, 0, 44.44, 0, 1, 0, 1, 1, 'Bazzalan - Haunch of Meat'),
(11519, 5369, 0, 44.44, 0, 1, 0, 1, 1, 'Bazzalan - Gnawed Bone');

-- Baron Rivendare (10440)
UPDATE `creature_template` SET `pickpocketloot` = 10440 WHERE (`entry` = 10440);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10440);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10440, 3419, 0, 60.0, 0, 1, 0, 1, 1, 'Baron Rivendare - Red Rose'),
(10440, 8948, 0, 50.0, 0, 1, 0, 1, 1, 'Baron Rivendare - Dried King Bolete'),
(10440, 16885, 0, 20.0, 0, 1, 0, 1, 1, 'Baron Rivendare - Heavy Junkbox');

-- Goraluk Anvilcrack (10899)
UPDATE `creature_template` SET `pickpocketloot` = 10899 WHERE (`entry` = 10899);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10899);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10899, 3928, 0, 3.33, 0, 1, 0, 1, 1, 'Goraluk Anvilcrack - Superior Healing Potion'),
(10899, 5428, 0, 30.0, 0, 1, 0, 1, 1, 'Goraluk Anvilcrack - An Exotic Cookbook'),
(10899, 8952, 0, 16.67, 0, 1, 0, 1, 1, 'Goraluk Anvilcrack - Roasted Quail'),
(10899, 16885, 0, 10.0, 0, 1, 0, 1, 1, 'Goraluk Anvilcrack - Heavy Junkbox'),
(10899, 22829, 0, 10.0, 0, 1, 0, 1, 1, 'Goraluk Anvilcrack - Super Healing Potion'),
(10899, 27854, 0, 6.67, 0, 1, 0, 1, 1, 'Goraluk Anvilcrack - Smoked Talbuk Venison'),
(10899, 29570, 0, 23.33, 0, 1, 0, 1, 1, 'Goraluk Anvilcrack - A Gnome Effigy');

-- Stratholme Courier (11082)
UPDATE `creature_template` SET `pickpocketloot` = 11082 WHERE (`entry` = 11082);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11082);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11082, 3419, 0, 36.36, 0, 1, 0, 1, 1, 'Stratholme Courier - Red Rose'),
(11082, 3928, 0, 18.18, 0, 1, 0, 1, 1, 'Stratholme Courier - Superior Healing Potion'),
(11082, 8948, 0, 36.36, 0, 1, 0, 1, 1, 'Stratholme Courier - Dried King Bolete'),
(11082, 16885, 0, 27.27, 0, 1, 0, 1, 1, 'Stratholme Courier - Heavy Junkbox');

-- Wandering Skeleton (10816)
UPDATE `creature_template` SET `pickpocketloot` = 10816 WHERE (`entry` = 10816);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10816);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10816, 3419, 0, 66.67, 0, 1, 0, 1, 1, 'Wandering Skeleton - Red Rose'),
(10816, 3928, 0, 11.11, 0, 1, 0, 1, 1, 'Wandering Skeleton - Superior Healing Potion'),
(10816, 7910, 0, 11.11, 0, 1, 0, 1, 1, 'Wandering Skeleton - Star Ruby'),
(10816, 8948, 0, 11.11, 0, 1, 0, 1, 1, 'Wandering Skeleton - Dried King Bolete'),
(10816, 16885, 0, 11.11, 0, 1, 0, 1, 1, 'Wandering Skeleton - Heavy Junkbox');

-- Ezra Grimm (11058)
UPDATE `creature_template` SET `pickpocketloot` = 11058 WHERE (`entry` = 11058);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11058);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11058, 3419, 0, 28.57, 0, 1, 0, 1, 1, 'Ezra Grimm - Red Rose'),
(11058, 3928, 0, 28.57, 0, 1, 0, 1, 1, 'Ezra Grimm - Superior Healing Potion'),
(11058, 16885, 0, 42.86, 0, 1, 0, 1, 1, 'Ezra Grimm - Heavy Junkbox');

-- Blackwood Tracker (11713)
UPDATE `creature_template` SET `pickpocketloot` = 11713 WHERE (`entry` = 11713);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11713);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11713, 858, 0, 16.67, 0, 1, 0, 1, 1, 'Blackwood Tracker - Lesser Healing Potion'),
(11713, 2287, 0, 50.0, 0, 1, 0, 1, 1, 'Blackwood Tracker - Haunch of Meat'),
(11713, 5369, 0, 50.0, 0, 1, 0, 1, 1, 'Blackwood Tracker - Gnawed Bone');

-- Crimson Hammersmith (11120)
UPDATE `creature_template` SET `pickpocketloot` = 11120 WHERE (`entry` = 11120);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11120);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11120, 5432, 0, 78.57, 0, 1, 0, 1, 1, 'Crimson Hammersmith - Hickory Pipe'),
(11120, 7910, 0, 7.14, 0, 1, 0, 1, 1, 'Crimson Hammersmith - Star Ruby'),
(11120, 8932, 0, 14.29, 0, 1, 0, 1, 1, 'Crimson Hammersmith - Alterac Swiss'),
(11120, 16885, 0, 7.14, 0, 1, 0, 1, 1, 'Crimson Hammersmith - Heavy Junkbox');

-- Vilebranch Speaker (11391)
UPDATE `creature_template` SET `pickpocketloot` = 11391 WHERE (`entry` = 11391);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11391);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11391, 5428, 0, 80.0, 0, 1, 0, 1, 1, 'Vilebranch Speaker - An Exotic Cookbook'),
(11391, 7910, 0, 10.0, 0, 1, 0, 1, 1, 'Vilebranch Speaker - Star Ruby'),
(11391, 16885, 0, 30.0, 0, 1, 0, 1, 1, 'Vilebranch Speaker - Heavy Junkbox');

-- Shatterspear Troll (10919)
UPDATE `creature_template` SET `pickpocketloot` = 10919 WHERE (`entry` = 10919);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 10919);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10919, 3928, 0, 10.0, 0, 1, 0, 1, 1, 'Shatterspear Troll - Superior Healing Potion'),
(10919, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Shatterspear Troll - An Exotic Cookbook'),
(10919, 8950, 0, 10.0, 0, 1, 0, 1, 1, 'Shatterspear Troll - Homemade Cherry Pie'),
(10919, 8952, 0, 10.0, 0, 1, 0, 1, 1, 'Shatterspear Troll - Roasted Quail'),
(10919, 16885, 0, 60.0, 0, 1, 0, 1, 1, 'Shatterspear Troll - Heavy Junkbox');

-- Crimson Elite (12128)
UPDATE `creature_template` SET `pickpocketloot` = 12128 WHERE (`entry` = 12128);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 12128);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12128, 3928, 0, 17.31, 0, 1, 0, 1, 1, 'Crimson Elite - Superior Healing Potion'),
(12128, 5432, 0, 53.85, 0, 1, 0, 1, 1, 'Crimson Elite - Hickory Pipe'),
(12128, 8932, 0, 5.77, 0, 1, 0, 1, 1, 'Crimson Elite - Alterac Swiss'),
(12128, 8950, 0, 5.77, 0, 1, 0, 1, 1, 'Crimson Elite - Homemade Cherry Pie'),
(12128, 8953, 0, 7.69, 0, 1, 0, 1, 1, 'Crimson Elite - Deep Fried Plantains'),
(12128, 16885, 0, 13.46, 0, 1, 0, 1, 1, 'Crimson Elite - Heavy Junkbox');

-- Vanndar Stormpike (11948)
UPDATE `creature_template` SET `pickpocketloot` = 11948 WHERE (`entry` = 11948);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11948);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11948, 3928, 0, 12.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Superior Healing Potion'),
(11948, 5432, 0, 27.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Hickory Pipe'),
(11948, 8932, 0, 7.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Alterac Swiss'),
(11948, 8950, 0, 10.0, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Homemade Cherry Pie'),
(11948, 8953, 0, 12.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Deep Fried Plantains'),
(11948, 16885, 0, 22.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Heavy Junkbox'),
(11948, 27855, 0, 2.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Mag\'har Grainbread'),
(11948, 27856, 0, 2.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Skethyl Berries'),
(11948, 29569, 0, 2.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Strong Junkbox'),
(11948, 29571, 0, 7.5, 0, 1, 0, 1, 1, 'Vanndar Stormpike - A Steamy Romance Novel'),
(11948, 30458, 0, 5.0, 0, 1, 0, 1, 1, 'Vanndar Stormpike - Stromgarde Muenster');

-- Hakkari Blood Priest (11340)
UPDATE `creature_template` SET `pickpocketloot` = 11340 WHERE (`entry` = 11340);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11340);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11340, 3928, 0, 12.5, 0, 1, 0, 1, 1, 'Hakkari Blood Priest - Superior Healing Potion'),
(11340, 5428, 0, 46.88, 0, 1, 0, 1, 1, 'Hakkari Blood Priest - An Exotic Cookbook'),
(11340, 7910, 0, 3.12, 0, 1, 0, 1, 1, 'Hakkari Blood Priest - Star Ruby'),
(11340, 8950, 0, 9.38, 0, 1, 0, 1, 1, 'Hakkari Blood Priest - Homemade Cherry Pie'),
(11340, 8952, 0, 12.5, 0, 1, 0, 1, 1, 'Hakkari Blood Priest - Roasted Quail'),
(11340, 16885, 0, 28.12, 0, 1, 0, 1, 1, 'Hakkari Blood Priest - Heavy Junkbox');

-- Large Vile Slime (12387)
UPDATE `creature_template` SET `pickpocketloot` = 12387 WHERE (`entry` = 12387);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 12387);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12387, 3419, 0, 14.29, 0, 1, 0, 1, 1, 'Large Vile Slime - Red Rose'),
(12387, 8948, 0, 14.29, 0, 1, 0, 1, 1, 'Large Vile Slime - Dried King Bolete'),
(12387, 16885, 0, 71.43, 0, 1, 0, 1, 1, 'Large Vile Slime - Heavy Junkbox');

-- Duriel Moonfire (12860)
UPDATE `creature_template` SET `pickpocketloot` = 12860 WHERE (`entry` = 12860);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 12860);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12860, 5374, 0, 33.33, 0, 1, 0, 1, 1, 'Duriel Moonfire - Small Pocket Watch'),
(12860, 16882, 0, 66.67, 0, 1, 0, 1, 1, 'Duriel Moonfire - Battered Junkbox');

-- Jin'do the Hexxer (11380)
UPDATE `creature_template` SET `pickpocketloot` = 11380 WHERE (`entry` = 11380);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11380);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11380, 3928, 0, 25.0, 0, 1, 0, 1, 1, 'Jin\'do the Hexxer - Superior Healing Potion'),
(11380, 5428, 0, 31.25, 0, 1, 0, 1, 1, 'Jin\'do the Hexxer - An Exotic Cookbook'),
(11380, 8950, 0, 12.5, 0, 1, 0, 1, 1, 'Jin\'do the Hexxer - Homemade Cherry Pie'),
(11380, 8952, 0, 31.25, 0, 1, 0, 1, 1, 'Jin\'do the Hexxer - Roasted Quail'),
(11380, 16885, 0, 6.25, 0, 1, 0, 1, 1, 'Jin\'do the Hexxer - Heavy Junkbox');

-- Umi Thorson (13078)
UPDATE `creature_template` SET `pickpocketloot` = 13078 WHERE (`entry` = 13078);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13078);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13078, 5432, 0, 50.0, 0, 1, 0, 1, 1, 'Umi Thorson - Hickory Pipe'),
(13078, 8950, 0, 7.14, 0, 1, 0, 1, 1, 'Umi Thorson - Homemade Cherry Pie'),
(13078, 8953, 0, 14.29, 0, 1, 0, 1, 1, 'Umi Thorson - Deep Fried Plantains'),
(13078, 16885, 0, 7.14, 0, 1, 0, 1, 1, 'Umi Thorson - Heavy Junkbox'),
(13078, 22829, 0, 14.29, 0, 1, 0, 1, 1, 'Umi Thorson - Super Healing Potion'),
(13078, 29569, 0, 7.14, 0, 1, 0, 1, 1, 'Umi Thorson - Strong Junkbox'),
(13078, 29571, 0, 7.14, 0, 1, 0, 1, 1, 'Umi Thorson - A Steamy Romance Novel');

-- Blackwing Warlock (12459)
UPDATE `creature_template` SET `pickpocketloot` = 12459 WHERE (`entry` = 12459);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 12459);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12459, 3928, 0, 14.52, 0, 1, 0, 1, 1, 'Blackwing Warlock - Superior Healing Potion'),
(12459, 5432, 0, 32.26, 0, 1, 0, 1, 1, 'Blackwing Warlock - Hickory Pipe'),
(12459, 8932, 0, 11.29, 0, 1, 0, 1, 1, 'Blackwing Warlock - Alterac Swiss'),
(12459, 8950, 0, 11.29, 0, 1, 0, 1, 1, 'Blackwing Warlock - Homemade Cherry Pie'),
(12459, 8953, 0, 12.9, 0, 1, 0, 1, 1, 'Blackwing Warlock - Deep Fried Plantains'),
(12459, 16885, 0, 24.19, 0, 1, 0, 1, 1, 'Blackwing Warlock - Heavy Junkbox');

-- Blackwing Spellbinder (12457)
UPDATE `creature_template` SET `pickpocketloot` = 12457 WHERE (`entry` = 12457);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 12457);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12457, 3928, 0, 10.53, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Superior Healing Potion'),
(12457, 5432, 0, 26.32, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Hickory Pipe'),
(12457, 7910, 0, 5.26, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Star Ruby'),
(12457, 8950, 0, 15.79, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Homemade Cherry Pie'),
(12457, 8953, 0, 15.79, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Deep Fried Plantains'),
(12457, 16885, 0, 42.11, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Heavy Junkbox');

-- Keetar (13079)
UPDATE `creature_template` SET `pickpocketloot` = 13079 WHERE (`entry` = 13079);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13079);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13079, 3928, 0, 20.0, 0, 1, 0, 1, 1, 'Keetar - Superior Healing Potion'),
(13079, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Keetar - An Exotic Cookbook'),
(13079, 16885, 0, 40.0, 0, 1, 0, 1, 1, 'Keetar - Heavy Junkbox');

-- Infected Mossflayer (12261)
UPDATE `creature_template` SET `pickpocketloot` = 12261 WHERE (`entry` = 12261);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 12261);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12261, 3928, 0, 12.2, 0, 1, 0, 1, 1, 'Infected Mossflayer - Superior Healing Potion'),
(12261, 5428, 0, 43.9, 0, 1, 0, 1, 1, 'Infected Mossflayer - An Exotic Cookbook'),
(12261, 7910, 0, 2.44, 0, 1, 0, 1, 1, 'Infected Mossflayer - Star Ruby'),
(12261, 8950, 0, 17.07, 0, 1, 0, 1, 1, 'Infected Mossflayer - Homemade Cherry Pie'),
(12261, 8952, 0, 12.2, 0, 1, 0, 1, 1, 'Infected Mossflayer - Roasted Quail'),
(12261, 16885, 0, 21.95, 0, 1, 0, 1, 1, 'Infected Mossflayer - Heavy Junkbox');

-- Irondeep Surveyor (13098)
UPDATE `creature_template` SET `pickpocketloot` = 13098 WHERE (`entry` = 13098);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13098);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13098, 3928, 0, 16.67, 0, 1, 0, 1, 1, 'Irondeep Surveyor - Superior Healing Potion'),
(13098, 5432, 0, 33.33, 0, 1, 0, 1, 1, 'Irondeep Surveyor - Hickory Pipe'),
(13098, 8932, 0, 16.67, 0, 1, 0, 1, 1, 'Irondeep Surveyor - Alterac Swiss'),
(13098, 8950, 0, 16.67, 0, 1, 0, 1, 1, 'Irondeep Surveyor - Homemade Cherry Pie'),
(13098, 8953, 0, 16.67, 0, 1, 0, 1, 1, 'Irondeep Surveyor - Deep Fried Plantains'),
(13098, 16885, 0, 16.67, 0, 1, 0, 1, 1, 'Irondeep Surveyor - Heavy Junkbox');

-- Oggleflint (11517)
UPDATE `creature_template` SET `pickpocketloot` = 11517 WHERE (`entry` = 11517);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 11517);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11517, 858, 0, 16.67, 0, 1, 0, 1, 1, 'Oggleflint - Lesser Healing Potion'),
(11517, 2287, 0, 66.67, 0, 1, 0, 1, 1, 'Oggleflint - Haunch of Meat'),
(11517, 5369, 0, 50.0, 0, 1, 0, 1, 1, 'Oggleflint - Gnawed Bone');

-- Irondeep Guard (13080)
UPDATE `creature_template` SET `pickpocketloot` = 13080 WHERE (`entry` = 13080);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13080);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13080, 5432, 0, 50.0, 0, 1, 0, 1, 1, 'Irondeep Guard - Hickory Pipe'),
(13080, 8950, 0, 16.67, 0, 1, 0, 1, 1, 'Irondeep Guard - Homemade Cherry Pie'),
(13080, 8953, 0, 33.33, 0, 1, 0, 1, 1, 'Irondeep Guard - Deep Fried Plantains');

-- Wing Commander Jeztor (13180)
UPDATE `creature_template` SET `pickpocketloot` = 13180 WHERE (`entry` = 13180);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13180);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13180, 3419, 0, 16.67, 0, 1, 0, 1, 1, 'Wing Commander Jeztor - Red Rose'),
(13180, 3928, 0, 16.67, 0, 1, 0, 1, 1, 'Wing Commander Jeztor - Superior Healing Potion'),
(13180, 8948, 0, 50.0, 0, 1, 0, 1, 1, 'Wing Commander Jeztor - Dried King Bolete'),
(13180, 16885, 0, 33.33, 0, 1, 0, 1, 1, 'Wing Commander Jeztor - Heavy Junkbox');

-- Seasoned Coldmine Surveyor (13537)
UPDATE `creature_template` SET `pickpocketloot` = 13537 WHERE (`entry` = 13537);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13537);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13537, 5428, 0, 20.0, 0, 1, 0, 1, 1, 'Seasoned Coldmine Surveyor - An Exotic Cookbook'),
(13537, 16885, 0, 80.0, 0, 1, 0, 1, 1, 'Seasoned Coldmine Surveyor - Heavy Junkbox');

-- Lieutenant Rugba (13137)
UPDATE `creature_template` SET `pickpocketloot` = 13137 WHERE (`entry` = 13137);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13137);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13137, 3928, 0, 6.25, 0, 1, 0, 1, 1, 'Lieutenant Rugba - Superior Healing Potion'),
(13137, 5428, 0, 62.5, 0, 1, 0, 1, 1, 'Lieutenant Rugba - An Exotic Cookbook'),
(13137, 8952, 0, 18.75, 0, 1, 0, 1, 1, 'Lieutenant Rugba - Roasted Quail'),
(13137, 16885, 0, 12.5, 0, 1, 0, 1, 1, 'Lieutenant Rugba - Heavy Junkbox');

-- Veteran Coldmine Guard (13535)
UPDATE `creature_template` SET `pickpocketloot` = 13535 WHERE (`entry` = 13535);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13535);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13535, 5428, 0, 27.27, 0, 1, 0, 1, 1, 'Veteran Coldmine Guard - An Exotic Cookbook'),
(13535, 8950, 0, 36.36, 0, 1, 0, 1, 1, 'Veteran Coldmine Guard - Homemade Cherry Pie'),
(13535, 16885, 0, 36.36, 0, 1, 0, 1, 1, 'Veteran Coldmine Guard - Heavy Junkbox');

-- Commander Dardosh &lt;old&gt; (13140)
UPDATE `creature_template` SET `pickpocketloot` = 13140 WHERE (`entry` = 13140);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13140);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13140, 3928, 0, 25.0, 0, 1, 0, 1, 1, 'Commander Dardosh &lt;old&gt; - Superior Healing Potion'),
(13140, 5428, 0, 50.0, 0, 1, 0, 1, 1, 'Commander Dardosh &lt;old&gt; - An Exotic Cookbook'),
(13140, 8950, 0, 12.5, 0, 1, 0, 1, 1, 'Commander Dardosh &lt;old&gt; - Homemade Cherry Pie'),
(13140, 8952, 0, 6.25, 0, 1, 0, 1, 1, 'Commander Dardosh &lt;old&gt; - Roasted Quail'),
(13140, 16885, 0, 18.75, 0, 1, 0, 1, 1, 'Commander Dardosh &lt;old&gt; - Heavy Junkbox');

-- Lieutenant Stronghoof (13143)
UPDATE `creature_template` SET `pickpocketloot` = 13143 WHERE (`entry` = 13143);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13143);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13143, 3928, 0, 13.04, 0, 1, 0, 1, 1, 'Lieutenant Stronghoof - Superior Healing Potion'),
(13143, 5428, 0, 60.87, 0, 1, 0, 1, 1, 'Lieutenant Stronghoof - An Exotic Cookbook'),
(13143, 8950, 0, 17.39, 0, 1, 0, 1, 1, 'Lieutenant Stronghoof - Homemade Cherry Pie'),
(13143, 8952, 0, 13.04, 0, 1, 0, 1, 1, 'Lieutenant Stronghoof - Roasted Quail'),
(13143, 16885, 0, 8.7, 0, 1, 0, 1, 1, 'Lieutenant Stronghoof - Heavy Junkbox');

-- Seasoned Defender (13326)
UPDATE `creature_template` SET `pickpocketloot` = 13326 WHERE (`entry` = 13326);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13326);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13326, 3928, 0, 20.0, 0, 1, 0, 1, 1, 'Seasoned Defender - Superior Healing Potion'),
(13326, 8932, 0, 20.0, 0, 1, 0, 1, 1, 'Seasoned Defender - Alterac Swiss'),
(13326, 16885, 0, 60.0, 0, 1, 0, 1, 1, 'Seasoned Defender - Heavy Junkbox');

-- Veteran Guardian (13332)
UPDATE `creature_template` SET `pickpocketloot` = 13332 WHERE (`entry` = 13332);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13332);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13332, 3928, 0, 10.34, 0, 1, 0, 1, 1, 'Veteran Guardian - Superior Healing Potion'),
(13332, 5428, 0, 31.03, 0, 1, 0, 1, 1, 'Veteran Guardian - An Exotic Cookbook'),
(13332, 8950, 0, 27.59, 0, 1, 0, 1, 1, 'Veteran Guardian - Homemade Cherry Pie'),
(13332, 8952, 0, 37.93, 0, 1, 0, 1, 1, 'Veteran Guardian - Roasted Quail'),
(13332, 16885, 0, 6.9, 0, 1, 0, 1, 1, 'Veteran Guardian - Heavy Junkbox');

-- Veteran Coldmine Surveyor (13538)
UPDATE `creature_template` SET `pickpocketloot` = 13538 WHERE (`entry` = 13538);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13538);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13538, 3928, 0, 40.0, 0, 1, 0, 1, 1, 'Veteran Coldmine Surveyor - Superior Healing Potion'),
(13538, 5428, 0, 20.0, 0, 1, 0, 1, 1, 'Veteran Coldmine Surveyor - An Exotic Cookbook'),
(13538, 8952, 0, 20.0, 0, 1, 0, 1, 1, 'Veteran Coldmine Surveyor - Roasted Quail'),
(13538, 16885, 0, 20.0, 0, 1, 0, 1, 1, 'Veteran Coldmine Surveyor - Heavy Junkbox');

-- Seasoned Guardian (13328)
UPDATE `creature_template` SET `pickpocketloot` = 13328 WHERE (`entry` = 13328);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13328);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13328, 3928, 0, 13.04, 0, 1, 0, 1, 1, 'Seasoned Guardian - Superior Healing Potion'),
(13328, 5428, 0, 43.48, 0, 1, 0, 1, 1, 'Seasoned Guardian - An Exotic Cookbook'),
(13328, 8950, 0, 21.74, 0, 1, 0, 1, 1, 'Seasoned Guardian - Homemade Cherry Pie'),
(13328, 8952, 0, 8.7, 0, 1, 0, 1, 1, 'Seasoned Guardian - Roasted Quail'),
(13328, 16885, 0, 17.39, 0, 1, 0, 1, 1, 'Seasoned Guardian - Heavy Junkbox');

-- Grunnda Wolfheart (13218)
UPDATE `creature_template` SET `pickpocketloot` = 13218 WHERE (`entry` = 13218);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13218);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13218, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Grunnda Wolfheart - An Exotic Cookbook'),
(13218, 8950, 0, 20.0, 0, 1, 0, 1, 1, 'Grunnda Wolfheart - Homemade Cherry Pie'),
(13218, 8952, 0, 20.0, 0, 1, 0, 1, 1, 'Grunnda Wolfheart - Roasted Quail'),
(13218, 16885, 0, 40.0, 0, 1, 0, 1, 1, 'Grunnda Wolfheart - Heavy Junkbox');

-- Veteran Irondeep Explorer (13541)
UPDATE `creature_template` SET `pickpocketloot` = 13541 WHERE (`entry` = 13541);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13541);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13541, 3928, 0, 5.88, 0, 1, 0, 1, 1, 'Veteran Irondeep Explorer - Superior Healing Potion'),
(13541, 5428, 0, 47.06, 0, 1, 0, 1, 1, 'Veteran Irondeep Explorer - An Exotic Cookbook'),
(13541, 7910, 0, 5.88, 0, 1, 0, 1, 1, 'Veteran Irondeep Explorer - Star Ruby'),
(13541, 8950, 0, 5.88, 0, 1, 0, 1, 1, 'Veteran Irondeep Explorer - Homemade Cherry Pie'),
(13541, 8952, 0, 23.53, 0, 1, 0, 1, 1, 'Veteran Irondeep Explorer - Roasted Quail'),
(13541, 16885, 0, 17.65, 0, 1, 0, 1, 1, 'Veteran Irondeep Explorer - Heavy Junkbox');

-- Wing Commander Mulverick (13181)
UPDATE `creature_template` SET `pickpocketloot` = 13181 WHERE (`entry` = 13181);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13181);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13181, 5428, 0, 75.0, 0, 1, 0, 1, 1, 'Wing Commander Mulverick - An Exotic Cookbook'),
(13181, 7910, 0, 25.0, 0, 1, 0, 1, 1, 'Wing Commander Mulverick - Star Ruby'),
(13181, 8950, 0, 12.5, 0, 1, 0, 1, 1, 'Wing Commander Mulverick - Homemade Cherry Pie'),
(13181, 16885, 0, 12.5, 0, 1, 0, 1, 1, 'Wing Commander Mulverick - Heavy Junkbox');

-- Seasoned Coldmine Explorer (13546)
UPDATE `creature_template` SET `pickpocketloot` = 13546 WHERE (`entry` = 13546);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13546);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13546, 5432, 0, 60.0, 0, 1, 0, 1, 1, 'Seasoned Coldmine Explorer - Hickory Pipe'),
(13546, 8932, 0, 10.0, 0, 1, 0, 1, 1, 'Seasoned Coldmine Explorer - Alterac Swiss'),
(13546, 8950, 0, 20.0, 0, 1, 0, 1, 1, 'Seasoned Coldmine Explorer - Homemade Cherry Pie'),
(13546, 16885, 0, 20.0, 0, 1, 0, 1, 1, 'Seasoned Coldmine Explorer - Heavy Junkbox');

-- Commander Louis Philips (13154)
UPDATE `creature_template` SET `pickpocketloot` = 13154 WHERE (`entry` = 13154);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13154);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13154, 3419, 0, 40.0, 0, 1, 0, 1, 1, 'Commander Louis Philips - Red Rose'),
(13154, 3928, 0, 10.0, 0, 1, 0, 1, 1, 'Commander Louis Philips - Superior Healing Potion'),
(13154, 8948, 0, 40.0, 0, 1, 0, 1, 1, 'Commander Louis Philips - Dried King Bolete'),
(13154, 16885, 0, 20.0, 0, 1, 0, 1, 1, 'Commander Louis Philips - Heavy Junkbox');

-- Seasoned Irondeep Explorer (13540)
UPDATE `creature_template` SET `pickpocketloot` = 13540 WHERE (`entry` = 13540);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13540);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13540, 5428, 0, 83.33, 0, 1, 0, 1, 1, 'Seasoned Irondeep Explorer - An Exotic Cookbook'),
(13540, 8952, 0, 16.67, 0, 1, 0, 1, 1, 'Seasoned Irondeep Explorer - Roasted Quail');

-- Burgle Eye (14230)
UPDATE `creature_template` SET `pickpocketloot` = 14230 WHERE (`entry` = 14230);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14230);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14230, 1710, 0, 16.67, 0, 1, 0, 1, 1, 'Burgle Eye - Greater Healing Potion'),
(14230, 10457, 0, 33.33, 0, 1, 0, 1, 1, 'Burgle Eye - Empty Sea Snail Shell'),
(14230, 16883, 0, 50.0, 0, 1, 0, 1, 1, 'Burgle Eye - Worn Junkbox');

-- Tamra Stormpike (14275)
UPDATE `creature_template` SET `pickpocketloot` = 14275 WHERE (`entry` = 14275);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14275);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14275, 422, 0, 20.0, 0, 1, 0, 1, 1, 'Tamra Stormpike - Dwarven Mild'),
(14275, 4538, 0, 40.0, 0, 1, 0, 1, 1, 'Tamra Stormpike - Snapvine Watermelon'),
(14275, 5374, 0, 40.0, 0, 1, 0, 1, 1, 'Tamra Stormpike - Small Pocket Watch'),
(14275, 16882, 0, 40.0, 0, 1, 0, 1, 1, 'Tamra Stormpike - Battered Junkbox');

-- Master Elemental Shaper Krixix (14401)
UPDATE `creature_template` SET `pickpocketloot` = 14401 WHERE (`entry` = 14401);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14401);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14401, 5432, 0, 50.0, 0, 1, 0, 1, 1, 'Master Elemental Shaper Krixix - Hickory Pipe'),
(14401, 16885, 0, 50.0, 0, 1, 0, 1, 1, 'Master Elemental Shaper Krixix - Heavy Junkbox');

-- Frostwolf Shaman (13284)
UPDATE `creature_template` SET `pickpocketloot` = 13284 WHERE (`entry` = 13284);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 13284);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13284, 5428, 0, 57.14, 0, 1, 0, 1, 1, 'Frostwolf Shaman - An Exotic Cookbook'),
(13284, 8952, 0, 14.29, 0, 1, 0, 1, 1, 'Frostwolf Shaman - Roasted Quail'),
(13284, 16885, 0, 28.57, 0, 1, 0, 1, 1, 'Frostwolf Shaman - Heavy Junkbox');

-- Grimmaw (14429)
UPDATE `creature_template` SET `pickpocketloot` = 14429 WHERE (`entry` = 14429);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14429);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14429, 858, 0, 25.0, 0, 1, 0, 1, 1, 'Grimmaw - Lesser Healing Potion'),
(14429, 2287, 0, 25.0, 0, 1, 0, 1, 1, 'Grimmaw - Haunch of Meat'),
(14429, 5369, 0, 62.5, 0, 1, 0, 1, 1, 'Grimmaw - Gnawed Bone');

-- Ur'dan (14522)
UPDATE `creature_template` SET `pickpocketloot` = 14522 WHERE (`entry` = 14522);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14522);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14522, 7910, 0, 14.29, 0, 1, 0, 1, 1, 'Ur\'dan - Star Ruby'),
(14522, 8952, 0, 14.29, 0, 1, 0, 1, 1, 'Ur\'dan - Roasted Quail'),
(14522, 16885, 0, 71.43, 0, 1, 0, 1, 1, 'Ur\'dan - Heavy Junkbox');

-- Harb Foulmountain (14426)
UPDATE `creature_template` SET `pickpocketloot` = 14426 WHERE (`entry` = 14426);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14426);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14426, 929, 0, 50.0, 0, 1, 0, 1, 1, 'Harb Foulmountain - Healing Potion'),
(14426, 1705, 0, 50.0, 0, 1, 0, 1, 1, 'Harb Foulmountain - Lesser Moonstone'),
(14426, 5373, 0, 16.67, 0, 1, 0, 1, 1, 'Harb Foulmountain - Lucky Charm');

-- Lady Zephris (14277)
UPDATE `creature_template` SET `pickpocketloot` = 14277 WHERE (`entry` = 14277);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14277);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14277, 1710, 0, 12.5, 0, 1, 0, 1, 1, 'Lady Zephris - Greater Healing Potion'),
(14277, 6362, 0, 12.5, 0, 1, 0, 1, 1, 'Lady Zephris - Raw Rockscale Cod'),
(14277, 10457, 0, 62.5, 0, 1, 0, 1, 1, 'Lady Zephris - Empty Sea Snail Shell'),
(14277, 16883, 0, 62.5, 0, 1, 0, 1, 1, 'Lady Zephris - Worn Junkbox');

-- Twilight Lord Everun (14479)
UPDATE `creature_template` SET `pickpocketloot` = 14479 WHERE (`entry` = 14479);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14479);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14479, 5432, 0, 33.33, 0, 1, 0, 1, 1, 'Twilight Lord Everun - Hickory Pipe'),
(14479, 8932, 0, 33.33, 0, 1, 0, 1, 1, 'Twilight Lord Everun - Alterac Swiss'),
(14479, 8950, 0, 16.67, 0, 1, 0, 1, 1, 'Twilight Lord Everun - Homemade Cherry Pie'),
(14479, 16885, 0, 16.67, 0, 1, 0, 1, 1, 'Twilight Lord Everun - Heavy Junkbox');

-- High Priestess Mar'li (14510)
UPDATE `creature_template` SET `pickpocketloot` = 14510 WHERE (`entry` = 14510);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14510);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14510, 3928, 0, 7.69, 0, 1, 0, 1, 1, 'High Priestess Mar\'li - Superior Healing Potion'),
(14510, 5428, 0, 46.15, 0, 1, 0, 1, 1, 'High Priestess Mar\'li - An Exotic Cookbook'),
(14510, 8952, 0, 30.77, 0, 1, 0, 1, 1, 'High Priestess Mar\'li - Roasted Quail'),
(14510, 16885, 0, 15.38, 0, 1, 0, 1, 1, 'High Priestess Mar\'li - Heavy Junkbox');

-- High Priestess Arlokk (14515)
UPDATE `creature_template` SET `pickpocketloot` = 14515 WHERE (`entry` = 14515);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14515);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14515, 3928, 0, 7.5, 0, 1, 0, 1, 1, 'High Priestess Arlokk - Superior Healing Potion'),
(14515, 5428, 0, 62.5, 0, 1, 0, 1, 1, 'High Priestess Arlokk - An Exotic Cookbook'),
(14515, 7910, 0, 2.5, 0, 1, 0, 1, 1, 'High Priestess Arlokk - Star Ruby'),
(14515, 8950, 0, 12.5, 0, 1, 0, 1, 1, 'High Priestess Arlokk - Homemade Cherry Pie'),
(14515, 8952, 0, 12.5, 0, 1, 0, 1, 1, 'High Priestess Arlokk - Roasted Quail'),
(14515, 16885, 0, 15.0, 0, 1, 0, 1, 1, 'High Priestess Arlokk - Heavy Junkbox'),
(14515, 27855, 0, 2.5, 0, 1, 0, 1, 1, 'High Priestess Arlokk - Mag\'har Grainbread'),
(14515, 29570, 0, 5.0, 0, 1, 0, 1, 1, 'High Priestess Arlokk - A Gnome Effigy');

-- High Priestess Jeklik (14517)
UPDATE `creature_template` SET `pickpocketloot` = 14517 WHERE (`entry` = 14517);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14517);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14517, 3928, 0, 14.29, 0, 1, 0, 1, 1, 'High Priestess Jeklik - Superior Healing Potion'),
(14517, 5428, 0, 38.1, 0, 1, 0, 1, 1, 'High Priestess Jeklik - An Exotic Cookbook'),
(14517, 8950, 0, 14.29, 0, 1, 0, 1, 1, 'High Priestess Jeklik - Homemade Cherry Pie'),
(14517, 8952, 0, 33.33, 0, 1, 0, 1, 1, 'High Priestess Jeklik - Roasted Quail'),
(14517, 16885, 0, 9.52, 0, 1, 0, 1, 1, 'High Priestess Jeklik - Heavy Junkbox');

-- Phantom Attendant (16406)
UPDATE `creature_template` SET `pickpocketloot` = 16406 WHERE (`entry` = 16406);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16406);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16406, 22829, 0, 15.79, 0, 1, 0, 1, 1, 'Phantom Attendant - Super Healing Potion'),
(16406, 27859, 0, 28.95, 0, 1, 0, 1, 1, 'Phantom Attendant - Zangar Caps'),
(16406, 29569, 0, 31.58, 0, 1, 0, 1, 1, 'Phantom Attendant - Strong Junkbox'),
(16406, 29575, 0, 39.47, 0, 1, 0, 1, 1, 'Phantom Attendant - A Jack-o\'-Lantern');

-- Spectral Retainer (16410)
UPDATE `creature_template` SET `pickpocketloot` = 16410 WHERE (`entry` = 16410);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16410);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16410, 27859, 0, 17.65, 0, 1, 0, 1, 1, 'Spectral Retainer - Zangar Caps'),
(16410, 29569, 0, 29.41, 0, 1, 0, 1, 1, 'Spectral Retainer - Strong Junkbox'),
(16410, 29575, 0, 58.82, 0, 1, 0, 1, 1, 'Spectral Retainer - A Jack-o\'-Lantern');

-- Blood Elf Scout (16521)
UPDATE `creature_template` SET `pickpocketloot` = 16521 WHERE (`entry` = 16521);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16521);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16521, 2070, 0, 20.0, 0, 1, 0, 1, 1, 'Blood Elf Scout - Darnassian Bleu'),
(16521, 4536, 0, 20.0, 0, 1, 0, 1, 1, 'Blood Elf Scout - Shiny Red Apple'),
(16521, 5363, 0, 40.0, 0, 1, 0, 1, 1, 'Blood Elf Scout - Folded Handkerchief'),
(16521, 6150, 0, 20.0, 0, 1, 0, 1, 1, 'Blood Elf Scout - A Frayed Knot');

-- Debilitated Mag'har Grunt (16847)
UPDATE `creature_template` SET `pickpocketloot` = 16847 WHERE (`entry` = 16847);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16847);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16847, 3928, 0, 6.0, 0, 1, 0, 1, 1, 'Debilitated Mag\'har Grunt - Superior Healing Potion'),
(16847, 5428, 0, 40.0, 0, 1, 0, 1, 1, 'Debilitated Mag\'har Grunt - An Exotic Cookbook'),
(16847, 8950, 0, 11.0, 0, 1, 0, 1, 1, 'Debilitated Mag\'har Grunt - Homemade Cherry Pie'),
(16847, 8952, 0, 18.0, 0, 1, 0, 1, 1, 'Debilitated Mag\'har Grunt - Roasted Quail'),
(16847, 16885, 0, 33.0, 0, 1, 0, 1, 1, 'Debilitated Mag\'har Grunt - Heavy Junkbox'),
(16847, 22829, 0, 1.0, 0, 1, 0, 1, 1, 'Debilitated Mag\'har Grunt - Super Healing Potion'),
(16847, 27855, 0, 1.0, 0, 1, 0, 1, 1, 'Debilitated Mag\'har Grunt - Mag\'har Grainbread');

-- Atal'ai Mistress (14882)
UPDATE `creature_template` SET `pickpocketloot` = 14882 WHERE (`entry` = 14882);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14882);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14882, 3928, 0, 5.26, 0, 1, 0, 1, 1, 'Atal\'ai Mistress - Superior Healing Potion'),
(14882, 5428, 0, 44.74, 0, 1, 0, 1, 1, 'Atal\'ai Mistress - An Exotic Cookbook'),
(14882, 8950, 0, 10.53, 0, 1, 0, 1, 1, 'Atal\'ai Mistress - Homemade Cherry Pie'),
(14882, 8952, 0, 13.16, 0, 1, 0, 1, 1, 'Atal\'ai Mistress - Roasted Quail'),
(14882, 16885, 0, 34.21, 0, 1, 0, 1, 1, 'Atal\'ai Mistress - Heavy Junkbox');

-- Spectral Sentry (16424)
UPDATE `creature_template` SET `pickpocketloot` = 16424 WHERE (`entry` = 16424);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16424);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16424, 27859, 0, 30.77, 0, 1, 0, 1, 1, 'Spectral Sentry - Zangar Caps'),
(16424, 29569, 0, 26.92, 0, 1, 0, 1, 1, 'Spectral Sentry - Strong Junkbox'),
(16424, 29575, 0, 53.85, 0, 1, 0, 1, 1, 'Spectral Sentry - A Jack-o\'-Lantern');

-- Phantom Guardsman (16425)
UPDATE `creature_template` SET `pickpocketloot` = 16425 WHERE (`entry` = 16425);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16425);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16425, 22829, 0, 9.26, 0, 1, 0, 1, 1, 'Phantom Guardsman - Super Healing Potion'),
(16425, 27859, 0, 25.93, 0, 1, 0, 1, 1, 'Phantom Guardsman - Zangar Caps'),
(16425, 29569, 0, 34.26, 0, 1, 0, 1, 1, 'Phantom Guardsman - Strong Junkbox'),
(16425, 29575, 0, 41.67, 0, 1, 0, 1, 1, 'Phantom Guardsman - A Jack-o\'-Lantern');

-- Unyielding Sorcerer (16905)
UPDATE `creature_template` SET `pickpocketloot` = 16905 WHERE (`entry` = 16905);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16905);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16905, 3419, 0, 33.94, 0, 1, 0, 1, 1, 'Unyielding Sorcerer - Red Rose'),
(16905, 3928, 0, 9.7, 0, 1, 0, 1, 1, 'Unyielding Sorcerer - Superior Healing Potion'),
(16905, 7910, 0, 0.61, 0, 1, 0, 1, 1, 'Unyielding Sorcerer - Star Ruby'),
(16905, 8948, 0, 32.73, 0, 1, 0, 1, 1, 'Unyielding Sorcerer - Dried King Bolete'),
(16905, 16885, 0, 40.0, 0, 1, 0, 1, 1, 'Unyielding Sorcerer - Heavy Junkbox');

-- Ghostly Philanthropist (16470)
UPDATE `creature_template` SET `pickpocketloot` = 16470 WHERE (`entry` = 16470);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16470);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16470, 22829, 0, 5.68, 0, 1, 0, 1, 1, 'Ghostly Philanthropist - Super Healing Potion'),
(16470, 23439, 0, 1.14, 0, 1, 0, 1, 1, 'Ghostly Philanthropist - Noble Topaz'),
(16470, 23440, 0, 1.14, 0, 1, 0, 1, 1, 'Ghostly Philanthropist - Dawnstone'),
(16470, 27859, 0, 26.14, 0, 1, 0, 1, 1, 'Ghostly Philanthropist - Zangar Caps'),
(16470, 29569, 0, 38.64, 0, 1, 0, 1, 1, 'Ghostly Philanthropist - Strong Junkbox'),
(16470, 29575, 0, 37.5, 0, 1, 0, 1, 1, 'Ghostly Philanthropist - A Jack-o\'-Lantern');

-- Arch Mage Xintor (16977)
UPDATE `creature_template` SET `pickpocketloot` = 16977 WHERE (`entry` = 16977);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16977);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16977, 22829, 0, 10.0, 0, 1, 0, 1, 1, 'Arch Mage Xintor - Super Healing Potion'),
(16977, 27859, 0, 60.0, 0, 1, 0, 1, 1, 'Arch Mage Xintor - Zangar Caps'),
(16977, 29569, 0, 40.0, 0, 1, 0, 1, 1, 'Arch Mage Xintor - Strong Junkbox'),
(16977, 29575, 0, 10.0, 0, 1, 0, 1, 1, 'Arch Mage Xintor - A Jack-o\'-Lantern');

-- Witch Doctor Mai'jin (17235)
UPDATE `creature_template` SET `pickpocketloot` = 17235 WHERE (`entry` = 17235);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 17235);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17235, 3928, 0, 9.09, 0, 1, 0, 1, 1, 'Witch Doctor Mai\'jin - Superior Healing Potion'),
(17235, 4599, 0, 18.18, 0, 1, 0, 1, 1, 'Witch Doctor Mai\'jin - Cured Ham Steak'),
(17235, 5428, 0, 18.18, 0, 1, 0, 1, 1, 'Witch Doctor Mai\'jin - An Exotic Cookbook'),
(17235, 16884, 0, 54.55, 0, 1, 0, 1, 1, 'Witch Doctor Mai\'jin - Sturdy Junkbox');

-- Night Mistress (16460)
UPDATE `creature_template` SET `pickpocketloot` = 16460 WHERE (`entry` = 16460);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16460);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16460, 22829, 0, 14.29, 0, 1, 0, 1, 1, 'Night Mistress - Super Healing Potion'),
(16460, 27859, 0, 28.57, 0, 1, 0, 1, 1, 'Night Mistress - Zangar Caps'),
(16460, 29569, 0, 21.43, 0, 1, 0, 1, 1, 'Night Mistress - Strong Junkbox'),
(16460, 29575, 0, 35.71, 0, 1, 0, 1, 1, 'Night Mistress - A Jack-o\'-Lantern');

-- Wanton Hostess (16459)
UPDATE `creature_template` SET `pickpocketloot` = 16459 WHERE (`entry` = 16459);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 16459);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16459, 22829, 0, 26.09, 0, 1, 0, 1, 1, 'Wanton Hostess - Super Healing Potion'),
(16459, 27859, 0, 34.78, 0, 1, 0, 1, 1, 'Wanton Hostess - Zangar Caps'),
(16459, 29569, 0, 26.09, 0, 1, 0, 1, 1, 'Wanton Hostess - Strong Junkbox'),
(16459, 29575, 0, 30.43, 0, 1, 0, 1, 1, 'Wanton Hostess - A Jack-o\'-Lantern');

-- Nazzivus Rogue (17338)
UPDATE `creature_template` SET `pickpocketloot` = 17338 WHERE (`entry` = 17338);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 17338);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17338, 2287, 0, 20.0, 0, 1, 0, 1, 1, 'Nazzivus Rogue - Haunch of Meat'),
(17338, 5369, 0, 80.0, 0, 1, 0, 1, 1, 'Nazzivus Rogue - Gnawed Bone');

-- Wrathscale Marauder (17334)
UPDATE `creature_template` SET `pickpocketloot` = 17334 WHERE (`entry` = 17334);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 17334);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17334, 5371, 0, 44.44, 0, 1, 0, 1, 1, 'Wrathscale Marauder - Piece of Coral'),
(17334, 6289, 0, 55.56, 0, 1, 0, 1, 2, 'Wrathscale Marauder - Raw Longjaw Mud Snapper');

-- Wrathscale Sorceress (17336)
UPDATE `creature_template` SET `pickpocketloot` = 17336 WHERE (`entry` = 17336);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 17336);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17336, 5371, 0, 100.0, 0, 1, 0, 1, 1, 'Wrathscale Sorceress - Piece of Coral');

-- Axxarien Shadowstalker (17340)
UPDATE `creature_template` SET `pickpocketloot` = 17340 WHERE (`entry` = 17340);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 17340);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17340, 818, 0, 20.0, 0, 1, 0, 1, 1, 'Axxarien Shadowstalker - Tigerseye'),
(17340, 2287, 0, 80.0, 0, 1, 0, 1, 1, 'Axxarien Shadowstalker - Haunch of Meat');

-- Chieftain Mummaki (19174)
UPDATE `creature_template` SET `pickpocketloot` = 19174 WHERE (`entry` = 19174);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 19174);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19174, 29569, 0, 46.67, 0, 1, 0, 1, 1, 'Chieftain Mummaki - Strong Junkbox'),
(19174, 29572, 0, 53.33, 0, 1, 0, 1, 1, 'Chieftain Mummaki - Aboriginal Carvings'),
(19174, 30610, 0, 20.0, 0, 1, 0, 1, 1, 'Chieftain Mummaki - Smoked Black Bear Meat');

-- Blacktalon the Savage (17057)
UPDATE `creature_template` SET `pickpocketloot` = 17057 WHERE (`entry` = 17057);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 17057);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17057, 22829, 0, 36.36, 0, 1, 0, 1, 1, 'Blacktalon the Savage - Super Healing Potion'),
(17057, 29569, 0, 54.55, 0, 1, 0, 1, 1, 'Blacktalon the Savage - Strong Junkbox'),
(17057, 29572, 0, 27.27, 0, 1, 0, 1, 1, 'Blacktalon the Savage - Aboriginal Carvings'),
(17057, 30610, 0, 9.09, 0, 1, 0, 1, 1, 'Blacktalon the Savage - Smoked Black Bear Meat');

-- Z'kral (18974)
UPDATE `creature_template` SET `pickpocketloot` = 18974 WHERE (`entry` = 18974);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 18974);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18974, 27854, 0, 9.09, 0, 1, 0, 1, 1, 'Z\'kral - Smoked Talbuk Venison'),
(18974, 27855, 0, 9.09, 0, 1, 0, 1, 1, 'Z\'kral - Mag\'har Grainbread'),
(18974, 29569, 0, 27.27, 0, 1, 0, 1, 1, 'Z\'kral - Strong Junkbox'),
(18974, 29570, 0, 54.55, 0, 1, 0, 1, 1, 'Z\'kral - A Gnome Effigy');

-- Infinite Saboteur (18172)
UPDATE `creature_template` SET `pickpocketloot` = 18172 WHERE (`entry` = 18172);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 18172);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(18172, 27854, 0, 20.0, 0, 1, 0, 1, 1, 'Infinite Saboteur - Smoked Talbuk Venison'),
(18172, 27855, 0, 40.0, 0, 1, 0, 1, 1, 'Infinite Saboteur - Mag\'har Grainbread'),
(18172, 29569, 0, 20.0, 0, 1, 0, 1, 1, 'Infinite Saboteur - Strong Junkbox'),
(18172, 29570, 0, 20.0, 0, 1, 0, 1, 1, 'Infinite Saboteur - A Gnome Effigy');

-- Worg Master Kruush (19442)
UPDATE `creature_template` SET `pickpocketloot` = 19442 WHERE (`entry` = 19442);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 19442);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19442, 5428, 0, 21.43, 0, 1, 0, 1, 1, 'Worg Master Kruush - An Exotic Cookbook'),
(19442, 8950, 0, 7.14, 0, 1, 0, 1, 1, 'Worg Master Kruush - Homemade Cherry Pie'),
(19442, 8952, 0, 14.29, 0, 1, 0, 1, 1, 'Worg Master Kruush - Roasted Quail'),
(19442, 16885, 0, 57.14, 0, 1, 0, 1, 1, 'Worg Master Kruush - Heavy Junkbox');

-- High Priest Thekal (14509)
UPDATE `creature_template` SET `pickpocketloot` = 14509 WHERE (`entry` = 14509);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 14509);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(14509, 5428, 0, 18.75, 0, 1, 0, 1, 1, 'High Priest Thekal - An Exotic Cookbook'),
(14509, 7910, 0, 12.5, 0, 1, 0, 1, 1, 'High Priest Thekal - Star Ruby'),
(14509, 8950, 0, 6.25, 0, 1, 0, 1, 1, 'High Priest Thekal - Homemade Cherry Pie'),
(14509, 8952, 0, 37.5, 0, 1, 0, 1, 1, 'High Priest Thekal - Roasted Quail'),
(14509, 16885, 0, 31.25, 0, 1, 0, 1, 1, 'High Priest Thekal - Heavy Junkbox'),
(14509, 29569, 0, 6.25, 0, 1, 0, 1, 1, 'High Priest Thekal - Strong Junkbox');

-- Grillok &quot;Darkeye&quot; (19457)
UPDATE `creature_template` SET `pickpocketloot` = 19457 WHERE (`entry` = 19457);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 19457);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19457, 22829, 0, 10.0, 0, 1, 0, 1, 1, 'Grillok &quot;Darkeye&quot; - Super Healing Potion'),
(19457, 27859, 0, 40.0, 0, 1, 0, 1, 1, 'Grillok &quot;Darkeye&quot; - Zangar Caps'),
(19457, 29569, 0, 40.0, 0, 1, 0, 1, 1, 'Grillok &quot;Darkeye&quot; - Strong Junkbox'),
(19457, 29575, 0, 30.0, 0, 1, 0, 1, 1, 'Grillok &quot;Darkeye&quot; - A Jack-o\'-Lantern');

-- Gronn-Priest (21350)
UPDATE `creature_template` SET `pickpocketloot` = 21350 WHERE (`entry` = 21350);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 21350);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21350, 22829, 0, 8.33, 0, 1, 0, 1, 1, 'Gronn-Priest - Super Healing Potion'),
(21350, 27854, 0, 16.67, 0, 1, 0, 1, 1, 'Gronn-Priest - Smoked Talbuk Venison'),
(21350, 27855, 0, 16.67, 0, 1, 0, 1, 1, 'Gronn-Priest - Mag\'har Grainbread'),
(21350, 29569, 0, 33.33, 0, 1, 0, 1, 1, 'Gronn-Priest - Strong Junkbox'),
(21350, 29570, 0, 33.33, 0, 1, 0, 1, 1, 'Gronn-Priest - A Gnome Effigy');

-- Gordunni Elementalist (22144)
UPDATE `creature_template` SET `pickpocketloot` = 22144 WHERE (`entry` = 22144);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 22144);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22144, 22829, 0, 13.04, 0, 1, 0, 1, 1, 'Gordunni Elementalist - Super Healing Potion'),
(22144, 27854, 0, 13.04, 0, 1, 0, 1, 1, 'Gordunni Elementalist - Smoked Talbuk Venison'),
(22144, 27855, 0, 10.87, 0, 1, 0, 1, 1, 'Gordunni Elementalist - Mag\'har Grainbread'),
(22144, 29569, 0, 41.3, 0, 1, 0, 1, 1, 'Gordunni Elementalist - Strong Junkbox'),
(22144, 29570, 0, 36.96, 0, 1, 0, 1, 1, 'Gordunni Elementalist - A Gnome Effigy');

-- Gordunni Head-Splitter (22148)
UPDATE `creature_template` SET `pickpocketloot` = 22148 WHERE (`entry` = 22148);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 22148);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22148, 22829, 0, 9.09, 0, 1, 0, 1, 1, 'Gordunni Head-Splitter - Super Healing Potion'),
(22148, 23436, 0, 6.06, 0, 1, 0, 1, 1, 'Gordunni Head-Splitter - Living Ruby'),
(22148, 27854, 0, 15.15, 0, 1, 0, 1, 1, 'Gordunni Head-Splitter - Smoked Talbuk Venison'),
(22148, 27855, 0, 3.03, 0, 1, 0, 1, 1, 'Gordunni Head-Splitter - Mag\'har Grainbread'),
(22148, 29569, 0, 51.52, 0, 1, 0, 1, 1, 'Gordunni Head-Splitter - Strong Junkbox'),
(22148, 29570, 0, 15.15, 0, 1, 0, 1, 1, 'Gordunni Head-Splitter - A Gnome Effigy');

-- Eclipsion Cavalier (22018)
UPDATE `creature_template` SET `pickpocketloot` = 22018 WHERE (`entry` = 22018);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 22018);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22018, 22829, 0, 20.0, 0, 1, 0, 1, 1, 'Eclipsion Cavalier - Super Healing Potion'),
(22018, 27855, 0, 10.0, 0, 1, 0, 1, 1, 'Eclipsion Cavalier - Mag\'har Grainbread'),
(22018, 27856, 0, 10.0, 0, 1, 0, 1, 1, 'Eclipsion Cavalier - Skethyl Berries'),
(22018, 29569, 0, 35.0, 0, 1, 0, 1, 1, 'Eclipsion Cavalier - Strong Junkbox'),
(22018, 29571, 0, 25.0, 0, 1, 0, 1, 1, 'Eclipsion Cavalier - A Steamy Romance Novel'),
(22018, 30458, 0, 10.0, 0, 1, 0, 1, 1, 'Eclipsion Cavalier - Stromgarde Muenster');

-- Crystal Flayer (21189)
UPDATE `creature_template` SET `pickpocketloot` = 21189 WHERE (`entry` = 21189);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 21189);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21189, 8952, 0, 34.29, 0, 1, 0, 1, 1, 'Crystal Flayer - Roasted Quail'),
(21189, 22829, 0, 2.86, 0, 1, 0, 1, 1, 'Crystal Flayer - Super Healing Potion'),
(21189, 29569, 0, 20.0, 0, 1, 0, 1, 1, 'Crystal Flayer - Strong Junkbox'),
(21189, 29572, 0, 48.57, 0, 1, 0, 1, 1, 'Crystal Flayer - Aboriginal Carvings');

-- Broggok (17380)
UPDATE `creature_template` SET `pickpocketloot` = 17380 WHERE (`entry` = 17380);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 17380);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(17380, 27854, 0, 37.5, 0, 1, 0, 1, 1, 'Broggok - Smoked Talbuk Venison'),
(17380, 27855, 0, 12.5, 0, 1, 0, 1, 1, 'Broggok - Mag\'har Grainbread'),
(17380, 29569, 0, 62.5, 0, 1, 0, 1, 1, 'Broggok - Strong Junkbox');

-- Gordunni Back-Breaker (22143)
UPDATE `creature_template` SET `pickpocketloot` = 22143 WHERE (`entry` = 22143);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 22143);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22143, 22829, 0, 12.73, 0, 1, 0, 1, 1, 'Gordunni Back-Breaker - Super Healing Potion'),
(22143, 27854, 0, 23.64, 0, 1, 0, 1, 1, 'Gordunni Back-Breaker - Smoked Talbuk Venison'),
(22143, 27855, 0, 5.45, 0, 1, 0, 1, 1, 'Gordunni Back-Breaker - Mag\'har Grainbread'),
(22143, 29569, 0, 41.82, 0, 1, 0, 1, 1, 'Gordunni Back-Breaker - Strong Junkbox'),
(22143, 29570, 0, 27.27, 0, 1, 0, 1, 1, 'Gordunni Back-Breaker - A Gnome Effigy');

-- Mechano-Lord Capacitus (19219)
UPDATE `creature_template` SET `pickpocketloot` = 19219 WHERE (`entry` = 19219);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 19219);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(19219, 22829, 0, 40.0, 0, 1, 0, 1, 1, 'Mechano-Lord Capacitus - Super Healing Potion'),
(19219, 27854, 0, 60.0, 0, 1, 0, 1, 1, 'Mechano-Lord Capacitus - Smoked Talbuk Venison'),
(19219, 29570, 0, 40.0, 0, 1, 0, 1, 1, 'Mechano-Lord Capacitus - A Gnome Effigy');

-- Ethereum Nullifier (22822)
UPDATE `creature_template` SET `pickpocketloot` = 22822 WHERE (`entry` = 22822);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 22822);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22822, 22829, 0, 16.67, 0, 1, 0, 1, 1, 'Ethereum Nullifier - Super Healing Potion'),
(22822, 27855, 0, 8.33, 0, 1, 0, 1, 1, 'Ethereum Nullifier - Mag\'har Grainbread'),
(22822, 27856, 0, 11.11, 0, 1, 0, 1, 1, 'Ethereum Nullifier - Skethyl Berries'),
(22822, 29569, 0, 41.67, 0, 1, 0, 1, 1, 'Ethereum Nullifier - Strong Junkbox'),
(22822, 29571, 0, 25.0, 0, 1, 0, 1, 1, 'Ethereum Nullifier - A Steamy Romance Novel'),
(22822, 30458, 0, 11.11, 0, 1, 0, 1, 1, 'Ethereum Nullifier - Stromgarde Muenster');

-- Gordunni Soulreaper (23022)
UPDATE `creature_template` SET `pickpocketloot` = 23022 WHERE (`entry` = 23022);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23022);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23022, 27854, 0, 16.67, 0, 1, 0, 1, 1, 'Gordunni Soulreaper - Smoked Talbuk Venison'),
(23022, 27855, 0, 16.67, 0, 1, 0, 1, 1, 'Gordunni Soulreaper - Mag\'har Grainbread'),
(23022, 29569, 0, 16.67, 0, 1, 0, 1, 1, 'Gordunni Soulreaper - Strong Junkbox'),
(23022, 29570, 0, 66.67, 0, 1, 0, 1, 1, 'Gordunni Soulreaper - A Gnome Effigy');

-- Tarren Mill Protector (23179)
UPDATE `creature_template` SET `pickpocketloot` = 23179 WHERE (`entry` = 23179);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23179);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23179, 22829, 0, 16.67, 0, 1, 0, 1, 1, 'Tarren Mill Protector - Super Healing Potion'),
(23179, 27855, 0, 16.67, 0, 1, 0, 1, 1, 'Tarren Mill Protector - Mag\'har Grainbread'),
(23179, 29569, 0, 50.0, 0, 1, 0, 1, 1, 'Tarren Mill Protector - Strong Junkbox'),
(23179, 29570, 0, 50.0, 0, 1, 0, 1, 1, 'Tarren Mill Protector - A Gnome Effigy');

-- Tarren Mill Guardsman (23175)
UPDATE `creature_template` SET `pickpocketloot` = 23175 WHERE (`entry` = 23175);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23175);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23175, 27855, 0, 16.67, 0, 1, 0, 1, 1, 'Tarren Mill Guardsman - Mag\'har Grainbread'),
(23175, 29569, 0, 33.33, 0, 1, 0, 1, 1, 'Tarren Mill Guardsman - Strong Junkbox'),
(23175, 29570, 0, 66.67, 0, 1, 0, 1, 1, 'Tarren Mill Guardsman - A Gnome Effigy');

-- Tarren Mill Lookout (23178)
UPDATE `creature_template` SET `pickpocketloot` = 23178 WHERE (`entry` = 23178);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23178);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23178, 27854, 0, 17.65, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - Smoked Talbuk Venison'),
(23178, 27855, 0, 11.76, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - Mag\'har Grainbread'),
(23178, 29569, 0, 35.29, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - Strong Junkbox'),
(23178, 29570, 0, 41.18, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - A Gnome Effigy');

-- Ardent Host (22959)
UPDATE `creature_template` SET `pickpocketloot` = 22959 WHERE (`entry` = 22959);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 22959);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22959, 22829, 0, 40.0, 0, 1, 0, 1, 1, 'Ardent Host - Super Healing Potion'),
(22959, 29569, 0, 40.0, 0, 1, 0, 1, 1, 'Ardent Host - Strong Junkbox'),
(22959, 29570, 0, 20.0, 0, 1, 0, 1, 1, 'Ardent Host - A Gnome Effigy');

-- Tarren Mill Lookout (23177)
UPDATE `creature_template` SET `pickpocketloot` = 23177 WHERE (`entry` = 23177);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23177);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23177, 27854, 0, 25.0, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - Smoked Talbuk Venison'),
(23177, 29569, 0, 25.0, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - Strong Junkbox'),
(23177, 29570, 0, 62.5, 0, 1, 0, 1, 1, 'Tarren Mill Lookout - A Gnome Effigy');

-- Unstable Mur'ghoul (23643)
UPDATE `creature_template` SET `pickpocketloot` = 23643 WHERE (`entry` = 23643);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23643);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23643, 38273, 0, 44.44, 0, 1, 0, 1, 1, 'Unstable Mur\'ghoul - Brain Coral'),
(23643, 38274, 0, 22.22, 0, 1, 0, 1, 1, 'Unstable Mur\'ghoul - Large Snail Shell'),
(23643, 43575, 0, 44.44, 0, 1, 0, 1, 1, 'Unstable Mur\'ghoul - Reinforced Junkbox');

-- Mur'ghoul Corrupter (23645)
UPDATE `creature_template` SET `pickpocketloot` = 23645 WHERE (`entry` = 23645);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23645);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23645, 33447, 0, 30.0, 0, 1, 0, 1, 1, 'Mur\'ghoul Corrupter - Runic Healing Potion'),
(23645, 37452, 0, 30.0, 0, 1, 0, 1, 1, 'Mur\'ghoul Corrupter - Fatty Bluefin'),
(23645, 38273, 0, 40.0, 0, 1, 0, 1, 1, 'Mur\'ghoul Corrupter - Brain Coral'),
(23645, 38274, 0, 20.0, 0, 1, 0, 1, 1, 'Mur\'ghoul Corrupter - Large Snail Shell'),
(23645, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Mur\'ghoul Corrupter - Reinforced Junkbox');

-- Mur'ghoul Flesheater (23644)
UPDATE `creature_template` SET `pickpocketloot` = 23644 WHERE (`entry` = 23644);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23644);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23644, 37452, 0, 19.05, 0, 1, 0, 1, 1, 'Mur\'ghoul Flesheater - Fatty Bluefin'),
(23644, 38273, 0, 14.29, 0, 1, 0, 1, 1, 'Mur\'ghoul Flesheater - Brain Coral'),
(23644, 38274, 0, 38.1, 0, 1, 0, 1, 1, 'Mur\'ghoul Flesheater - Large Snail Shell'),
(23644, 43575, 0, 47.62, 0, 1, 0, 1, 1, 'Mur\'ghoul Flesheater - Reinforced Junkbox');

-- Dragonmaw Transporter (23188)
UPDATE `creature_template` SET `pickpocketloot` = 23188 WHERE (`entry` = 23188);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23188);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23188, 27855, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonmaw Transporter - Mag\'har Grainbread'),
(23188, 29569, 0, 40.0, 0, 1, 0, 1, 1, 'Dragonmaw Transporter - Strong Junkbox'),
(23188, 29570, 0, 80.0, 0, 1, 0, 1, 1, 'Dragonmaw Transporter - A Gnome Effigy');

-- Ethereum Avenger (22821)
UPDATE `creature_template` SET `pickpocketloot` = 22821 WHERE (`entry` = 22821);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 22821);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22821, 22829, 0, 14.29, 0, 1, 0, 1, 1, 'Ethereum Avenger - Super Healing Potion'),
(22821, 23438, 0, 1.43, 0, 1, 0, 1, 1, 'Ethereum Avenger - Star of Elune'),
(22821, 23439, 0, 1.43, 0, 1, 0, 1, 1, 'Ethereum Avenger - Noble Topaz'),
(22821, 27855, 0, 7.14, 0, 1, 0, 1, 1, 'Ethereum Avenger - Mag\'har Grainbread'),
(22821, 27856, 0, 8.57, 0, 1, 0, 1, 1, 'Ethereum Avenger - Skethyl Berries'),
(22821, 29569, 0, 27.14, 0, 1, 0, 1, 1, 'Ethereum Avenger - Strong Junkbox'),
(22821, 29571, 0, 30.0, 0, 1, 0, 1, 1, 'Ethereum Avenger - A Steamy Romance Novel'),
(22821, 30458, 0, 18.57, 0, 1, 0, 1, 1, 'Ethereum Avenger - Stromgarde Muenster');

-- Tarren Mill Protector (23180)
UPDATE `creature_template` SET `pickpocketloot` = 23180 WHERE (`entry` = 23180);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23180);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23180, 22829, 0, 10.0, 0, 1, 0, 1, 1, 'Tarren Mill Protector - Super Healing Potion'),
(23180, 27854, 0, 30.0, 0, 1, 0, 1, 1, 'Tarren Mill Protector - Smoked Talbuk Venison'),
(23180, 29569, 0, 20.0, 0, 1, 0, 1, 1, 'Tarren Mill Protector - Strong Junkbox'),
(23180, 29570, 0, 50.0, 0, 1, 0, 1, 1, 'Tarren Mill Protector - A Gnome Effigy');

-- Winterskorn Spearman (23653)
UPDATE `creature_template` SET `pickpocketloot` = 23653 WHERE (`entry` = 23653);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23653);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23653, 33447, 0, 6.9, 0, 1, 0, 1, 1, 'Winterskorn Spearman - Runic Healing Potion'),
(23653, 33454, 0, 13.79, 0, 1, 0, 1, 1, 'Winterskorn Spearman - Salted Venison'),
(23653, 38260, 0, 44.83, 0, 1, 0, 1, 1, 'Winterskorn Spearman - Empty Tobacco Pouch'),
(23653, 38261, 0, 10.34, 0, 1, 0, 1, 1, 'Winterskorn Spearman - Bent House Key'),
(23653, 43575, 0, 37.93, 0, 1, 0, 1, 1, 'Winterskorn Spearman - Reinforced Junkbox');

-- Dragonflayer Death Weaver (23658)
UPDATE `creature_template` SET `pickpocketloot` = 23658 WHERE (`entry` = 23658);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23658);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23658, 33447, 0, 11.54, 0, 1, 0, 1, 1, 'Dragonflayer Death Weaver - Runic Healing Potion'),
(23658, 33449, 0, 7.69, 0, 1, 0, 1, 1, 'Dragonflayer Death Weaver - Crusty Flatbread'),
(23658, 33454, 0, 11.54, 0, 1, 0, 1, 1, 'Dragonflayer Death Weaver - Salted Venison'),
(23658, 36862, 0, 7.69, 0, 1, 0, 1, 1, 'Dragonflayer Death Weaver - Worn Troll Dice'),
(23658, 38260, 0, 34.62, 0, 1, 0, 1, 1, 'Dragonflayer Death Weaver - Empty Tobacco Pouch'),
(23658, 38261, 0, 3.85, 0, 1, 0, 1, 1, 'Dragonflayer Death Weaver - Bent House Key'),
(23658, 43575, 0, 26.92, 0, 1, 0, 1, 1, 'Dragonflayer Death Weaver - Reinforced Junkbox');

-- Winterskorn Bonegrinder (23655)
UPDATE `creature_template` SET `pickpocketloot` = 23655 WHERE (`entry` = 23655);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23655);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23655, 33447, 0, 4.76, 0, 1, 0, 1, 1, 'Winterskorn Bonegrinder - Runic Healing Potion'),
(23655, 33449, 0, 9.52, 0, 1, 0, 1, 1, 'Winterskorn Bonegrinder - Crusty Flatbread'),
(23655, 33454, 0, 19.05, 0, 1, 0, 1, 1, 'Winterskorn Bonegrinder - Salted Venison'),
(23655, 38260, 0, 47.62, 0, 1, 0, 1, 1, 'Winterskorn Bonegrinder - Empty Tobacco Pouch'),
(23655, 43575, 0, 38.1, 0, 1, 0, 1, 1, 'Winterskorn Bonegrinder - Reinforced Junkbox');

-- Dragonflayer Tribesman (23651)
UPDATE `creature_template` SET `pickpocketloot` = 23651 WHERE (`entry` = 23651);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23651);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23651, 33447, 0, 14.81, 0, 1, 0, 1, 1, 'Dragonflayer Tribesman - Runic Healing Potion'),
(23651, 33449, 0, 3.7, 0, 1, 0, 1, 1, 'Dragonflayer Tribesman - Crusty Flatbread'),
(23651, 33454, 0, 14.81, 0, 1, 0, 1, 1, 'Dragonflayer Tribesman - Salted Venison'),
(23651, 38260, 0, 25.93, 0, 1, 0, 1, 1, 'Dragonflayer Tribesman - Empty Tobacco Pouch'),
(23651, 38261, 0, 11.11, 0, 1, 0, 1, 1, 'Dragonflayer Tribesman - Bent House Key'),
(23651, 43575, 0, 37.04, 0, 1, 0, 1, 1, 'Dragonflayer Tribesman - Reinforced Junkbox');

-- Dragonflayer Vrykul (23652)
UPDATE `creature_template` SET `pickpocketloot` = 23652 WHERE (`entry` = 23652);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23652);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23652, 33447, 0, 9.26, 0, 1, 0, 1, 1, 'Dragonflayer Vrykul - Runic Healing Potion'),
(23652, 33449, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Vrykul - Crusty Flatbread'),
(23652, 33454, 0, 14.81, 0, 1, 0, 1, 1, 'Dragonflayer Vrykul - Salted Venison'),
(23652, 38260, 0, 22.22, 0, 1, 0, 1, 1, 'Dragonflayer Vrykul - Empty Tobacco Pouch'),
(23652, 38261, 0, 12.96, 0, 1, 0, 1, 1, 'Dragonflayer Vrykul - Bent House Key'),
(23652, 43575, 0, 29.63, 0, 1, 0, 1, 1, 'Dragonflayer Vrykul - Reinforced Junkbox');

-- Simon Unit (23385)
UPDATE `creature_template` SET `pickpocketloot` = 23385 WHERE (`entry` = 23385);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23385);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23385, 22829, 0, 6.45, 0, 1, 0, 1, 1, 'Simon Unit - Super Healing Potion'),
(23385, 27854, 0, 12.9, 0, 1, 0, 1, 1, 'Simon Unit - Smoked Talbuk Venison'),
(23385, 27855, 0, 9.68, 0, 1, 0, 1, 1, 'Simon Unit - Mag\'har Grainbread'),
(23385, 29569, 0, 32.26, 0, 1, 0, 1, 1, 'Simon Unit - Strong Junkbox'),
(23385, 29570, 0, 38.71, 0, 1, 0, 1, 1, 'Simon Unit - A Gnome Effigy'),
(23385, 29571, 0, 3.23, 0, 1, 0, 1, 1, 'Simon Unit - A Steamy Romance Novel');

-- Iron Rune Steelguard (23673)
UPDATE `creature_template` SET `pickpocketloot` = 23673 WHERE (`entry` = 23673);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23673);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23673, 29448, 0, 66.67, 0, 1, 0, 1, 1, 'Iron Rune Steelguard - Mag\'har Mild Cheese'),
(23673, 29450, 0, 16.67, 0, 1, 0, 1, 1, 'Iron Rune Steelguard - Telaari Grapes'),
(23673, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Iron Rune Steelguard - Reinforced Junkbox');

-- Winterskorn Skald (23657)
UPDATE `creature_template` SET `pickpocketloot` = 23657 WHERE (`entry` = 23657);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23657);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23657, 33454, 0, 14.29, 0, 1, 0, 1, 1, 'Winterskorn Skald - Salted Venison'),
(23657, 38260, 0, 42.86, 0, 1, 0, 1, 1, 'Winterskorn Skald - Empty Tobacco Pouch'),
(23657, 38261, 0, 28.57, 0, 1, 0, 1, 1, 'Winterskorn Skald - Bent House Key'),
(23657, 43575, 0, 14.29, 0, 1, 0, 1, 1, 'Winterskorn Skald - Reinforced Junkbox');

-- Winterskorn Tribesman (23661)
UPDATE `creature_template` SET `pickpocketloot` = 23661 WHERE (`entry` = 23661);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23661);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23661, 33449, 0, 13.64, 0, 1, 0, 1, 1, 'Winterskorn Tribesman - Crusty Flatbread'),
(23661, 33454, 0, 18.18, 0, 1, 0, 1, 1, 'Winterskorn Tribesman - Salted Venison'),
(23661, 38260, 0, 36.36, 0, 1, 0, 1, 1, 'Winterskorn Tribesman - Empty Tobacco Pouch'),
(23661, 38261, 0, 13.64, 0, 1, 0, 1, 1, 'Winterskorn Tribesman - Bent House Key'),
(23661, 43575, 0, 31.82, 0, 1, 0, 1, 1, 'Winterskorn Tribesman - Reinforced Junkbox');

-- Iron Rune Runemaster (23675)
UPDATE `creature_template` SET `pickpocketloot` = 23675 WHERE (`entry` = 23675);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23675);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23675, 29450, 0, 20.0, 0, 1, 0, 1, 1, 'Iron Rune Runemaster - Telaari Grapes'),
(23675, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Iron Rune Runemaster - Runic Healing Potion'),
(23675, 33449, 0, 20.0, 0, 1, 0, 1, 1, 'Iron Rune Runemaster - Crusty Flatbread'),
(23675, 43575, 0, 80.0, 0, 1, 0, 1, 1, 'Iron Rune Runemaster - Reinforced Junkbox');

-- Winterskorn Warrior (23664)
UPDATE `creature_template` SET `pickpocketloot` = 23664 WHERE (`entry` = 23664);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23664);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23664, 33447, 0, 13.04, 0, 1, 0, 1, 1, 'Winterskorn Warrior - Runic Healing Potion'),
(23664, 33449, 0, 21.74, 0, 1, 0, 1, 1, 'Winterskorn Warrior - Crusty Flatbread'),
(23664, 33454, 0, 17.39, 0, 1, 0, 1, 1, 'Winterskorn Warrior - Salted Venison'),
(23664, 38260, 0, 39.13, 0, 1, 0, 1, 1, 'Winterskorn Warrior - Empty Tobacco Pouch'),
(23664, 38261, 0, 4.35, 0, 1, 0, 1, 1, 'Winterskorn Warrior - Bent House Key'),
(23664, 43575, 0, 30.43, 0, 1, 0, 1, 1, 'Winterskorn Warrior - Reinforced Junkbox');

-- Dragonflayer Thane (23660)
UPDATE `creature_template` SET `pickpocketloot` = 23660 WHERE (`entry` = 23660);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23660);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23660, 33447, 0, 3.12, 0, 1, 0, 1, 1, 'Dragonflayer Thane - Runic Healing Potion'),
(23660, 33449, 0, 6.25, 0, 1, 0, 1, 1, 'Dragonflayer Thane - Crusty Flatbread'),
(23660, 33454, 0, 18.75, 0, 1, 0, 1, 1, 'Dragonflayer Thane - Salted Venison'),
(23660, 38260, 0, 50.0, 0, 1, 0, 1, 1, 'Dragonflayer Thane - Empty Tobacco Pouch'),
(23660, 38261, 0, 9.38, 0, 1, 0, 1, 1, 'Dragonflayer Thane - Bent House Key'),
(23660, 43575, 0, 25.0, 0, 1, 0, 1, 1, 'Dragonflayer Thane - Reinforced Junkbox');

-- Winterskorn Berserker (23666)
UPDATE `creature_template` SET `pickpocketloot` = 23666 WHERE (`entry` = 23666);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23666);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23666, 33447, 0, 9.09, 0, 1, 0, 1, 1, 'Winterskorn Berserker - Runic Healing Potion'),
(23666, 33454, 0, 45.45, 0, 1, 0, 1, 1, 'Winterskorn Berserker - Salted Venison'),
(23666, 38260, 0, 27.27, 0, 1, 0, 1, 1, 'Winterskorn Berserker - Empty Tobacco Pouch'),
(23666, 38261, 0, 27.27, 0, 1, 0, 1, 1, 'Winterskorn Berserker - Bent House Key'),
(23666, 43575, 0, 45.45, 0, 1, 0, 1, 1, 'Winterskorn Berserker - Reinforced Junkbox');

-- Iron Rune Worker (23672)
UPDATE `creature_template` SET `pickpocketloot` = 23672 WHERE (`entry` = 23672);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23672);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23672, 29448, 0, 16.67, 0, 1, 0, 1, 1, 'Iron Rune Worker - Mag\'har Mild Cheese'),
(23672, 29450, 0, 16.67, 0, 1, 0, 1, 1, 'Iron Rune Worker - Telaari Grapes'),
(23672, 33449, 0, 16.67, 0, 1, 0, 1, 1, 'Iron Rune Worker - Crusty Flatbread'),
(23672, 37467, 0, 33.33, 0, 1, 0, 1, 1, 'Iron Rune Worker - A Steamy Romance Novel: Forbidden Love'),
(23672, 38261, 0, 16.67, 0, 1, 0, 1, 1, 'Iron Rune Worker - Bent House Key'),
(23672, 43575, 0, 16.67, 0, 1, 0, 1, 1, 'Iron Rune Worker - Reinforced Junkbox');

-- Iron Rune Laborer (23711)
UPDATE `creature_template` SET `pickpocketloot` = 23711 WHERE (`entry` = 23711);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23711);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23711, 29448, 0, 13.33, 0, 1, 0, 1, 1, 'Iron Rune Laborer - Mag\'har Mild Cheese'),
(23711, 29450, 0, 6.67, 0, 1, 0, 1, 1, 'Iron Rune Laborer - Telaari Grapes'),
(23711, 33449, 0, 13.33, 0, 1, 0, 1, 1, 'Iron Rune Laborer - Crusty Flatbread'),
(23711, 37467, 0, 33.33, 0, 1, 0, 1, 1, 'Iron Rune Laborer - A Steamy Romance Novel: Forbidden Love'),
(23711, 38261, 0, 26.67, 0, 1, 0, 1, 1, 'Iron Rune Laborer - Bent House Key'),
(23711, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Iron Rune Laborer - Reinforced Junkbox');

-- Iron Rune Destroyer (23676)
UPDATE `creature_template` SET `pickpocketloot` = 23676 WHERE (`entry` = 23676);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23676);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23676, 29448, 0, 7.14, 0, 1, 0, 1, 1, 'Iron Rune Destroyer - Mag\'har Mild Cheese'),
(23676, 29450, 0, 3.57, 0, 1, 0, 1, 1, 'Iron Rune Destroyer - Telaari Grapes'),
(23676, 33447, 0, 7.14, 0, 1, 0, 1, 1, 'Iron Rune Destroyer - Runic Healing Potion'),
(23676, 33449, 0, 14.29, 0, 1, 0, 1, 1, 'Iron Rune Destroyer - Crusty Flatbread'),
(23676, 37467, 0, 17.86, 0, 1, 0, 1, 1, 'Iron Rune Destroyer - A Steamy Romance Novel: Forbidden Love'),
(23676, 38261, 0, 14.29, 0, 1, 0, 1, 1, 'Iron Rune Destroyer - Bent House Key'),
(23676, 43575, 0, 46.43, 0, 1, 0, 1, 1, 'Iron Rune Destroyer - Reinforced Junkbox');

-- North Fleet Soldier (23793)
UPDATE `creature_template` SET `pickpocketloot` = 23793 WHERE (`entry` = 23793);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23793);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23793, 29448, 0, 9.09, 0, 1, 0, 1, 1, 'North Fleet Soldier - Mag\'har Mild Cheese'),
(23793, 29450, 0, 9.09, 0, 1, 0, 1, 1, 'North Fleet Soldier - Telaari Grapes'),
(23793, 33447, 0, 9.09, 0, 1, 0, 1, 1, 'North Fleet Soldier - Runic Healing Potion'),
(23793, 33449, 0, 9.09, 0, 1, 0, 1, 1, 'North Fleet Soldier - Crusty Flatbread'),
(23793, 37467, 0, 36.36, 0, 1, 0, 1, 1, 'North Fleet Soldier - A Steamy Romance Novel: Forbidden Love'),
(23793, 43575, 0, 27.27, 0, 1, 0, 1, 1, 'North Fleet Soldier - Reinforced Junkbox');

-- North Fleet Medic (23794)
UPDATE `creature_template` SET `pickpocketloot` = 23794 WHERE (`entry` = 23794);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23794);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23794, 29448, 0, 12.5, 0, 1, 0, 1, 1, 'North Fleet Medic - Mag\'har Mild Cheese'),
(23794, 33449, 0, 12.5, 0, 1, 0, 1, 1, 'North Fleet Medic - Crusty Flatbread'),
(23794, 37467, 0, 37.5, 0, 1, 0, 1, 1, 'North Fleet Medic - A Steamy Romance Novel: Forbidden Love'),
(23794, 38261, 0, 12.5, 0, 1, 0, 1, 1, 'North Fleet Medic - Bent House Key'),
(23794, 43575, 0, 25.0, 0, 1, 0, 1, 1, 'North Fleet Medic - Reinforced Junkbox');

-- Lieutenant Celeyne (23964)
UPDATE `creature_template` SET `pickpocketloot` = 23964 WHERE (`entry` = 23964);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23964);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23964, 29448, 0, 10.0, 0, 1, 0, 1, 1, 'Lieutenant Celeyne - Mag\'har Mild Cheese'),
(23964, 33447, 0, 10.0, 0, 1, 0, 1, 1, 'Lieutenant Celeyne - Runic Healing Potion'),
(23964, 37467, 0, 30.0, 0, 1, 0, 1, 1, 'Lieutenant Celeyne - A Steamy Romance Novel: Forbidden Love'),
(23964, 38261, 0, 10.0, 0, 1, 0, 1, 1, 'Lieutenant Celeyne - Bent House Key'),
(23964, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Lieutenant Celeyne - Reinforced Junkbox');

-- Dragonflayer Handler (23871)
UPDATE `creature_template` SET `pickpocketloot` = 23871 WHERE (`entry` = 23871);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23871);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23871, 33447, 0, 7.14, 0, 1, 0, 1, 1, 'Dragonflayer Handler - Runic Healing Potion'),
(23871, 33449, 0, 9.52, 0, 1, 0, 1, 1, 'Dragonflayer Handler - Crusty Flatbread'),
(23871, 33454, 0, 7.14, 0, 1, 0, 1, 1, 'Dragonflayer Handler - Salted Venison'),
(23871, 36862, 0, 2.38, 0, 1, 0, 1, 1, 'Dragonflayer Handler - Worn Troll Dice'),
(23871, 38260, 0, 42.86, 0, 1, 0, 1, 1, 'Dragonflayer Handler - Empty Tobacco Pouch'),
(23871, 38261, 0, 9.52, 0, 1, 0, 1, 1, 'Dragonflayer Handler - Bent House Key'),
(23871, 43575, 0, 30.95, 0, 1, 0, 1, 1, 'Dragonflayer Handler - Reinforced Junkbox');

-- North Fleet Salvager (23934)
UPDATE `creature_template` SET `pickpocketloot` = 23934 WHERE (`entry` = 23934);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23934);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23934, 29448, 0, 11.76, 0, 1, 0, 1, 1, 'North Fleet Salvager - Mag\'har Mild Cheese'),
(23934, 33447, 0, 11.76, 0, 1, 0, 1, 1, 'North Fleet Salvager - Runic Healing Potion'),
(23934, 33449, 0, 5.88, 0, 1, 0, 1, 1, 'North Fleet Salvager - Crusty Flatbread'),
(23934, 37467, 0, 17.65, 0, 1, 0, 1, 1, 'North Fleet Salvager - A Steamy Romance Novel: Forbidden Love'),
(23934, 38261, 0, 5.88, 0, 1, 0, 1, 1, 'North Fleet Salvager - Bent House Key'),
(23934, 43575, 0, 47.06, 0, 1, 0, 1, 1, 'North Fleet Salvager - Reinforced Junkbox');

-- North Fleet Marine (23983)
UPDATE `creature_template` SET `pickpocketloot` = 23983 WHERE (`entry` = 23983);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23983);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23983, 29448, 0, 12.9, 0, 1, 0, 1, 1, 'North Fleet Marine - Mag\'har Mild Cheese'),
(23983, 29450, 0, 3.23, 0, 1, 0, 1, 1, 'North Fleet Marine - Telaari Grapes'),
(23983, 33447, 0, 12.9, 0, 1, 0, 1, 1, 'North Fleet Marine - Runic Healing Potion'),
(23983, 33449, 0, 9.68, 0, 1, 0, 1, 1, 'North Fleet Marine - Crusty Flatbread'),
(23983, 37467, 0, 35.48, 0, 1, 0, 1, 1, 'North Fleet Marine - A Steamy Romance Novel: Forbidden Love'),
(23983, 38261, 0, 3.23, 0, 1, 0, 1, 1, 'North Fleet Marine - Bent House Key'),
(23983, 43575, 0, 35.48, 0, 1, 0, 1, 1, 'North Fleet Marine - Reinforced Junkbox');

-- Putrid Wight (23992)
UPDATE `creature_template` SET `pickpocketloot` = 23992 WHERE (`entry` = 23992);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23992);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23992, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Putrid Wight - Runic Healing Potion'),
(23992, 33452, 0, 33.33, 0, 1, 0, 1, 1, 'Putrid Wight - Honey-Spiced Lichen'),
(23992, 38269, 0, 55.56, 0, 1, 0, 1, 1, 'Putrid Wight - Soggy Handkerchief'),
(23992, 43575, 0, 11.11, 0, 1, 0, 1, 1, 'Putrid Wight - Reinforced Junkbox');

-- North Fleet Sailor (23866)
UPDATE `creature_template` SET `pickpocketloot` = 23866 WHERE (`entry` = 23866);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23866);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23866, 29450, 0, 11.76, 0, 1, 0, 1, 1, 'North Fleet Sailor - Telaari Grapes'),
(23866, 33447, 0, 5.88, 0, 1, 0, 1, 1, 'North Fleet Sailor - Runic Healing Potion'),
(23866, 33449, 0, 11.76, 0, 1, 0, 1, 1, 'North Fleet Sailor - Crusty Flatbread'),
(23866, 37467, 0, 29.41, 0, 1, 0, 1, 1, 'North Fleet Sailor - A Steamy Romance Novel: Forbidden Love'),
(23866, 38261, 0, 17.65, 0, 1, 0, 1, 1, 'North Fleet Sailor - Bent House Key'),
(23866, 43575, 0, 29.41, 0, 1, 0, 1, 1, 'North Fleet Sailor - Reinforced Junkbox');

-- North Fleet Marksman (23946)
UPDATE `creature_template` SET `pickpocketloot` = 23946 WHERE (`entry` = 23946);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23946);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23946, 29450, 0, 14.29, 0, 1, 0, 1, 1, 'North Fleet Marksman - Telaari Grapes'),
(23946, 33447, 0, 14.29, 0, 1, 0, 1, 1, 'North Fleet Marksman - Runic Healing Potion'),
(23946, 37467, 0, 42.86, 0, 1, 0, 1, 1, 'North Fleet Marksman - A Steamy Romance Novel: Forbidden Love'),
(23946, 38261, 0, 28.57, 0, 1, 0, 1, 1, 'North Fleet Marksman - Bent House Key'),
(23946, 43575, 0, 42.86, 0, 1, 0, 1, 1, 'North Fleet Marksman - Reinforced Junkbox');

-- Gjalerbron Warrior (23991)
UPDATE `creature_template` SET `pickpocketloot` = 23991 WHERE (`entry` = 23991);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23991);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23991, 33447, 0, 8.7, 0, 1, 0, 1, 1, 'Gjalerbron Warrior - Runic Healing Potion'),
(23991, 33449, 0, 6.96, 0, 1, 0, 1, 1, 'Gjalerbron Warrior - Crusty Flatbread'),
(23991, 33454, 0, 13.91, 0, 1, 0, 1, 1, 'Gjalerbron Warrior - Salted Venison'),
(23991, 36862, 0, 0.87, 0, 1, 0, 1, 1, 'Gjalerbron Warrior - Worn Troll Dice'),
(23991, 38260, 0, 37.39, 0, 1, 0, 1, 1, 'Gjalerbron Warrior - Empty Tobacco Pouch'),
(23991, 38261, 0, 9.57, 0, 1, 0, 1, 1, 'Gjalerbron Warrior - Bent House Key'),
(23991, 43575, 0, 32.17, 0, 1, 0, 1, 1, 'Gjalerbron Warrior - Reinforced Junkbox');

-- Deranged Explorer (23967)
UPDATE `creature_template` SET `pickpocketloot` = 23967 WHERE (`entry` = 23967);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23967);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23967, 29448, 0, 1.82, 0, 1, 0, 1, 1, 'Deranged Explorer - Mag\'har Mild Cheese'),
(23967, 29450, 0, 9.09, 0, 1, 0, 1, 1, 'Deranged Explorer - Telaari Grapes'),
(23967, 33447, 0, 4.55, 0, 1, 0, 1, 1, 'Deranged Explorer - Runic Healing Potion'),
(23967, 33449, 0, 8.18, 0, 1, 0, 1, 1, 'Deranged Explorer - Crusty Flatbread'),
(23967, 37467, 0, 40.0, 0, 1, 0, 1, 1, 'Deranged Explorer - A Steamy Romance Novel: Forbidden Love'),
(23967, 38261, 0, 6.36, 0, 1, 0, 1, 1, 'Deranged Explorer - Bent House Key'),
(23967, 43575, 0, 37.27, 0, 1, 0, 1, 1, 'Deranged Explorer - Reinforced Junkbox');

-- Gjalerbron Sleep-Watcher (23989)
UPDATE `creature_template` SET `pickpocketloot` = 23989 WHERE (`entry` = 23989);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23989);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23989, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Gjalerbron Sleep-Watcher - Runic Healing Potion'),
(23989, 33449, 0, 7.41, 0, 1, 0, 1, 1, 'Gjalerbron Sleep-Watcher - Crusty Flatbread'),
(23989, 33454, 0, 31.48, 0, 1, 0, 1, 1, 'Gjalerbron Sleep-Watcher - Salted Venison'),
(23989, 36862, 0, 1.85, 0, 1, 0, 1, 1, 'Gjalerbron Sleep-Watcher - Worn Troll Dice'),
(23989, 38260, 0, 38.89, 0, 1, 0, 1, 1, 'Gjalerbron Sleep-Watcher - Empty Tobacco Pouch'),
(23989, 38261, 0, 3.7, 0, 1, 0, 1, 1, 'Gjalerbron Sleep-Watcher - Bent House Key'),
(23989, 43575, 0, 18.52, 0, 1, 0, 1, 1, 'Gjalerbron Sleep-Watcher - Reinforced Junkbox');

-- Winterskorn Defender (24015)
UPDATE `creature_template` SET `pickpocketloot` = 24015 WHERE (`entry` = 24015);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24015);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24015, 33447, 0, 6.67, 0, 1, 0, 1, 1, 'Winterskorn Defender - Runic Healing Potion'),
(24015, 33449, 0, 15.56, 0, 1, 0, 1, 1, 'Winterskorn Defender - Crusty Flatbread'),
(24015, 33454, 0, 11.11, 0, 1, 0, 1, 1, 'Winterskorn Defender - Salted Venison'),
(24015, 38260, 0, 53.33, 0, 1, 0, 1, 1, 'Winterskorn Defender - Empty Tobacco Pouch'),
(24015, 38261, 0, 6.67, 0, 1, 0, 1, 1, 'Winterskorn Defender - Bent House Key'),
(24015, 43575, 0, 24.44, 0, 1, 0, 1, 1, 'Winterskorn Defender - Reinforced Junkbox');

-- Gjalerbron Rune-Caster (23990)
UPDATE `creature_template` SET `pickpocketloot` = 23990 WHERE (`entry` = 23990);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23990);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23990, 33447, 0, 3.77, 0, 1, 0, 1, 1, 'Gjalerbron Rune-Caster - Runic Healing Potion'),
(23990, 33449, 0, 16.98, 0, 1, 0, 1, 1, 'Gjalerbron Rune-Caster - Crusty Flatbread'),
(23990, 33454, 0, 15.09, 0, 1, 0, 1, 1, 'Gjalerbron Rune-Caster - Salted Venison'),
(23990, 38260, 0, 24.53, 0, 1, 0, 1, 1, 'Gjalerbron Rune-Caster - Empty Tobacco Pouch'),
(23990, 38261, 0, 5.66, 0, 1, 0, 1, 1, 'Gjalerbron Rune-Caster - Bent House Key'),
(23990, 43575, 0, 47.17, 0, 1, 0, 1, 1, 'Gjalerbron Rune-Caster - Reinforced Junkbox');

-- Iron Rune Stonecaller (24030)
UPDATE `creature_template` SET `pickpocketloot` = 24030 WHERE (`entry` = 24030);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24030);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24030, 29448, 0, 8.7, 0, 1, 0, 1, 1, 'Iron Rune Stonecaller - Mag\'har Mild Cheese'),
(24030, 29450, 0, 6.52, 0, 1, 0, 1, 1, 'Iron Rune Stonecaller - Telaari Grapes'),
(24030, 33447, 0, 13.04, 0, 1, 0, 1, 1, 'Iron Rune Stonecaller - Runic Healing Potion'),
(24030, 33449, 0, 4.35, 0, 1, 0, 1, 1, 'Iron Rune Stonecaller - Crusty Flatbread'),
(24030, 37467, 0, 41.3, 0, 1, 0, 1, 1, 'Iron Rune Stonecaller - A Steamy Romance Novel: Forbidden Love'),
(24030, 38261, 0, 6.52, 0, 1, 0, 1, 1, 'Iron Rune Stonecaller - Bent House Key'),
(24030, 43575, 0, 30.43, 0, 1, 0, 1, 1, 'Iron Rune Stonecaller - Reinforced Junkbox');

-- Dragonflayer Runecaster (23960)
UPDATE `creature_template` SET `pickpocketloot` = 23960 WHERE (`entry` = 23960);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23960);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23960, 27855, 0, 4.55, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Mag\'har Grainbread'),
(23960, 29569, 0, 9.09, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Strong Junkbox'),
(23960, 29570, 0, 18.18, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - A Gnome Effigy'),
(23960, 33447, 0, 4.55, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Runic Healing Potion'),
(23960, 38260, 0, 18.18, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Empty Tobacco Pouch'),
(23960, 40202, 0, 9.09, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Sizzling Grizzly Flank'),
(23960, 43575, 0, 40.91, 0, 1, 0, 1, 1, 'Dragonflayer Runecaster - Reinforced Junkbox');

-- Fearsome Horror (24073)
UPDATE `creature_template` SET `pickpocketloot` = 24073 WHERE (`entry` = 24073);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24073);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24073, 33447, 0, 4.76, 0, 1, 0, 1, 1, 'Fearsome Horror - Runic Healing Potion'),
(24073, 33452, 0, 33.33, 0, 1, 0, 1, 1, 'Fearsome Horror - Honey-Spiced Lichen'),
(24073, 38269, 0, 33.33, 0, 1, 0, 1, 1, 'Fearsome Horror - Soggy Handkerchief'),
(24073, 43575, 0, 47.62, 0, 1, 0, 1, 1, 'Fearsome Horror - Reinforced Junkbox');

-- Dragonflayer Berserker (24216)
UPDATE `creature_template` SET `pickpocketloot` = 24216 WHERE (`entry` = 24216);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24216);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24216, 33449, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Berserker - Crusty Flatbread'),
(24216, 33454, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Berserker - Salted Venison'),
(24216, 38260, 0, 50.0, 0, 1, 0, 1, 1, 'Dragonflayer Berserker - Empty Tobacco Pouch'),
(24216, 38261, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Berserker - Bent House Key'),
(24216, 43575, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Berserker - Reinforced Junkbox');

-- Necrolord (24014)
UPDATE `creature_template` SET `pickpocketloot` = 24014 WHERE (`entry` = 24014);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24014);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24014, 33447, 0, 12.96, 0, 1, 0, 1, 1, 'Necrolord - Runic Healing Potion'),
(24014, 33452, 0, 29.63, 0, 1, 0, 1, 1, 'Necrolord - Honey-Spiced Lichen'),
(24014, 38269, 0, 29.63, 0, 1, 0, 1, 1, 'Necrolord - Soggy Handkerchief'),
(24014, 43575, 0, 48.15, 0, 1, 0, 1, 1, 'Necrolord - Reinforced Junkbox');

-- Dragonflayer Ironhelm (23961)
UPDATE `creature_template` SET `pickpocketloot` = 23961 WHERE (`entry` = 23961);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23961);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23961, 22829, 0, 9.52, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Super Healing Potion'),
(23961, 23437, 0, 4.76, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Talasite'),
(23961, 27854, 0, 4.76, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Smoked Talbuk Venison'),
(23961, 27855, 0, 9.52, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Mag\'har Grainbread'),
(23961, 29569, 0, 9.52, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Strong Junkbox'),
(23961, 29570, 0, 33.33, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - A Gnome Effigy'),
(23961, 33447, 0, 4.76, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Runic Healing Potion'),
(23961, 35953, 0, 4.76, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Mead Basted Caribou'),
(23961, 38260, 0, 19.05, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Empty Tobacco Pouch'),
(23961, 43575, 0, 19.05, 0, 1, 0, 1, 1, 'Dragonflayer Ironhelm - Reinforced Junkbox');

-- Iron Rune Guardian (24212)
UPDATE `creature_template` SET `pickpocketloot` = 24212 WHERE (`entry` = 24212);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24212);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24212, 29448, 0, 6.82, 0, 1, 0, 1, 1, 'Iron Rune Guardian - Mag\'har Mild Cheese'),
(24212, 29450, 0, 18.18, 0, 1, 0, 1, 1, 'Iron Rune Guardian - Telaari Grapes'),
(24212, 33447, 0, 2.27, 0, 1, 0, 1, 1, 'Iron Rune Guardian - Runic Healing Potion'),
(24212, 33449, 0, 18.18, 0, 1, 0, 1, 1, 'Iron Rune Guardian - Crusty Flatbread'),
(24212, 37467, 0, 36.36, 0, 1, 0, 1, 1, 'Iron Rune Guardian - A Steamy Romance Novel: Forbidden Love'),
(24212, 38261, 0, 4.55, 0, 1, 0, 1, 1, 'Iron Rune Guardian - Bent House Key'),
(24212, 43575, 0, 18.18, 0, 1, 0, 1, 1, 'Iron Rune Guardian - Reinforced Junkbox');

-- Dragonflayer Strategist (23956)
UPDATE `creature_template` SET `pickpocketloot` = 23956 WHERE (`entry` = 23956);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 23956);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(23956, 27854, 0, 5.88, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Smoked Talbuk Venison'),
(23956, 27855, 0, 5.88, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Mag\'har Grainbread'),
(23956, 29569, 0, 11.76, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Strong Junkbox'),
(23956, 29570, 0, 23.53, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - A Gnome Effigy'),
(23956, 33447, 0, 11.76, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Runic Healing Potion'),
(23956, 35953, 0, 11.76, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Mead Basted Caribou'),
(23956, 38260, 0, 11.76, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Empty Tobacco Pouch'),
(23956, 40202, 0, 11.76, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Sizzling Grizzly Flank'),
(23956, 43575, 0, 17.65, 0, 1, 0, 1, 1, 'Dragonflayer Strategist - Reinforced Junkbox');

-- Chillmere Oracle (24461)
UPDATE `creature_template` SET `pickpocketloot` = 24461 WHERE (`entry` = 24461);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24461);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24461, 37452, 0, 12.5, 0, 1, 0, 1, 1, 'Chillmere Oracle - Fatty Bluefin'),
(24461, 38273, 0, 50.0, 0, 1, 0, 1, 1, 'Chillmere Oracle - Brain Coral'),
(24461, 38274, 0, 37.5, 0, 1, 0, 1, 1, 'Chillmere Oracle - Large Snail Shell'),
(24461, 43575, 0, 12.5, 0, 1, 0, 1, 1, 'Chillmere Oracle - Reinforced Junkbox');

-- Dragonflayer Soulreaver (24249)
UPDATE `creature_template` SET `pickpocketloot` = 24249 WHERE (`entry` = 24249);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24249);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24249, 33449, 0, 12.5, 0, 1, 0, 1, 1, 'Dragonflayer Soulreaver - Crusty Flatbread'),
(24249, 38260, 0, 12.5, 0, 1, 0, 1, 1, 'Dragonflayer Soulreaver - Empty Tobacco Pouch'),
(24249, 38261, 0, 25.0, 0, 1, 0, 1, 1, 'Dragonflayer Soulreaver - Bent House Key'),
(24249, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Dragonflayer Soulreaver - Reinforced Junkbox');

-- Steel Gate Excavator (24398)
UPDATE `creature_template` SET `pickpocketloot` = 24398 WHERE (`entry` = 24398);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24398);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24398, 29448, 0, 12.2, 0, 1, 0, 1, 1, 'Steel Gate Excavator - Mag\'har Mild Cheese'),
(24398, 29450, 0, 9.76, 0, 1, 0, 1, 1, 'Steel Gate Excavator - Telaari Grapes'),
(24398, 33447, 0, 12.2, 0, 1, 0, 1, 1, 'Steel Gate Excavator - Runic Healing Potion'),
(24398, 33449, 0, 14.63, 0, 1, 0, 1, 1, 'Steel Gate Excavator - Crusty Flatbread'),
(24398, 37467, 0, 21.95, 0, 1, 0, 1, 1, 'Steel Gate Excavator - A Steamy Romance Novel: Forbidden Love'),
(24398, 38261, 0, 14.63, 0, 1, 0, 1, 1, 'Steel Gate Excavator - Bent House Key'),
(24398, 43575, 0, 19.51, 0, 1, 0, 1, 1, 'Steel Gate Excavator - Reinforced Junkbox');

-- Dragonflayer Weaponsmith (24080)
UPDATE `creature_template` SET `pickpocketloot` = 24080 WHERE (`entry` = 24080);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24080);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24080, 27854, 0, 28.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Smoked Talbuk Venison'),
(24080, 29569, 0, 12.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Strong Junkbox'),
(24080, 29570, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - A Gnome Effigy'),
(24080, 35953, 0, 12.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Mead Basted Caribou'),
(24080, 36862, 0, 4.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Worn Troll Dice'),
(24080, 38260, 0, 16.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Empty Tobacco Pouch'),
(24080, 40202, 0, 4.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Sizzling Grizzly Flank'),
(24080, 43575, 0, 16.0, 0, 1, 0, 1, 1, 'Dragonflayer Weaponsmith - Reinforced Junkbox');

-- Proto-Drake Handler (24082)
UPDATE `creature_template` SET `pickpocketloot` = 24082 WHERE (`entry` = 24082);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24082);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24082, 22829, 0, 20.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Super Healing Potion'),
(24082, 27854, 0, 10.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Smoked Talbuk Venison'),
(24082, 27855, 0, 10.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Mag\'har Grainbread'),
(24082, 29569, 0, 20.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Strong Junkbox'),
(24082, 29570, 0, 20.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - A Gnome Effigy'),
(24082, 38260, 0, 10.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Empty Tobacco Pouch'),
(24082, 40202, 0, 10.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Sizzling Grizzly Flank'),
(24082, 43575, 0, 10.0, 0, 1, 0, 1, 1, 'Proto-Drake Handler - Reinforced Junkbox');

-- Dragonflayer Metalworker (24078)
UPDATE `creature_template` SET `pickpocketloot` = 24078 WHERE (`entry` = 24078);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24078);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24078, 22829, 0, 14.29, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Super Healing Potion'),
(24078, 27854, 0, 7.14, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Smoked Talbuk Venison'),
(24078, 27855, 0, 7.14, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Mag\'har Grainbread'),
(24078, 29569, 0, 50.0, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Strong Junkbox'),
(24078, 29570, 0, 21.43, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - A Gnome Effigy'),
(24078, 35953, 0, 7.14, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Mead Basted Caribou'),
(24078, 38260, 0, 14.29, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Empty Tobacco Pouch'),
(24078, 43575, 0, 7.14, 0, 1, 0, 1, 1, 'Dragonflayer Metalworker - Reinforced Junkbox');

-- Dragonflayer Overseer (24085)
UPDATE `creature_template` SET `pickpocketloot` = 24085 WHERE (`entry` = 24085);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24085);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24085, 27854, 0, 11.11, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Smoked Talbuk Venison'),
(24085, 27855, 0, 27.78, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Mag\'har Grainbread'),
(24085, 29569, 0, 22.22, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Strong Junkbox'),
(24085, 29570, 0, 5.56, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - A Gnome Effigy'),
(24085, 33447, 0, 5.56, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Runic Healing Potion'),
(24085, 35953, 0, 5.56, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Mead Basted Caribou'),
(24085, 38260, 0, 11.11, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Empty Tobacco Pouch'),
(24085, 40202, 0, 11.11, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Sizzling Grizzly Flank'),
(24085, 43575, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Overseer - Reinforced Junkbox');

-- Rotgill (24546)
UPDATE `creature_template` SET `pickpocketloot` = 24546 WHERE (`entry` = 24546);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24546);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24546, 37452, 0, 20.0, 0, 1, 0, 1, 1, 'Rotgill - Fatty Bluefin'),
(24546, 38273, 0, 60.0, 0, 1, 0, 1, 1, 'Rotgill - Brain Coral'),
(24546, 38274, 0, 20.0, 0, 1, 0, 1, 1, 'Rotgill - Large Snail Shell');

-- Dragonflayer Fleshripper (24250)
UPDATE `creature_template` SET `pickpocketloot` = 24250 WHERE (`entry` = 24250);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24250);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24250, 33447, 0, 4.55, 0, 1, 0, 1, 1, 'Dragonflayer Fleshripper - Runic Healing Potion'),
(24250, 33449, 0, 11.36, 0, 1, 0, 1, 1, 'Dragonflayer Fleshripper - Crusty Flatbread'),
(24250, 33454, 0, 22.73, 0, 1, 0, 1, 1, 'Dragonflayer Fleshripper - Salted Venison'),
(24250, 38260, 0, 29.55, 0, 1, 0, 1, 1, 'Dragonflayer Fleshripper - Empty Tobacco Pouch'),
(24250, 38261, 0, 11.36, 0, 1, 0, 1, 1, 'Dragonflayer Fleshripper - Bent House Key'),
(24250, 43575, 0, 27.27, 0, 1, 0, 1, 1, 'Dragonflayer Fleshripper - Reinforced Junkbox');

-- Dragonflayer Harpooner (24635)
UPDATE `creature_template` SET `pickpocketloot` = 24635 WHERE (`entry` = 24635);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24635);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24635, 33447, 0, 4.0, 0, 1, 0, 1, 1, 'Dragonflayer Harpooner - Runic Healing Potion'),
(24635, 33449, 0, 4.0, 0, 1, 0, 1, 1, 'Dragonflayer Harpooner - Crusty Flatbread'),
(24635, 33454, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonflayer Harpooner - Salted Venison'),
(24635, 38260, 0, 44.0, 0, 1, 0, 1, 1, 'Dragonflayer Harpooner - Empty Tobacco Pouch'),
(24635, 38261, 0, 4.0, 0, 1, 0, 1, 1, 'Dragonflayer Harpooner - Bent House Key'),
(24635, 43575, 0, 36.0, 0, 1, 0, 1, 1, 'Dragonflayer Harpooner - Reinforced Junkbox');

-- Dragonflayer Heartsplitter (24071)
UPDATE `creature_template` SET `pickpocketloot` = 24071 WHERE (`entry` = 24071);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24071);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24071, 27855, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Mag\'har Grainbread'),
(24071, 35953, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Mead Basted Caribou'),
(24071, 38260, 0, 40.0, 0, 1, 0, 1, 1, 'Dragonflayer Heartsplitter - Empty Tobacco Pouch');

-- Servitor Shade (24485)
UPDATE `creature_template` SET `pickpocketloot` = 24485 WHERE (`entry` = 24485);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24485);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24485, 33447, 0, 15.79, 0, 1, 0, 1, 1, 'Servitor Shade - Runic Healing Potion'),
(24485, 33452, 0, 31.58, 0, 1, 0, 1, 1, 'Servitor Shade - Honey-Spiced Lichen'),
(24485, 38269, 0, 63.16, 0, 1, 0, 1, 1, 'Servitor Shade - Soggy Handkerchief'),
(24485, 43575, 0, 21.05, 0, 1, 0, 1, 1, 'Servitor Shade - Reinforced Junkbox');

-- Crazed Northsea Slaver (24676)
UPDATE `creature_template` SET `pickpocketloot` = 24676 WHERE (`entry` = 24676);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24676);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24676, 29448, 0, 11.11, 0, 1, 0, 1, 1, 'Crazed Northsea Slaver - Mag\'har Mild Cheese'),
(24676, 29450, 0, 11.11, 0, 1, 0, 1, 1, 'Crazed Northsea Slaver - Telaari Grapes'),
(24676, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Crazed Northsea Slaver - Runic Healing Potion'),
(24676, 33449, 0, 5.56, 0, 1, 0, 1, 1, 'Crazed Northsea Slaver - Crusty Flatbread'),
(24676, 37467, 0, 38.89, 0, 1, 0, 1, 1, 'Crazed Northsea Slaver - A Steamy Romance Novel: Forbidden Love'),
(24676, 38261, 0, 8.33, 0, 1, 0, 1, 1, 'Crazed Northsea Slaver - Bent House Key'),
(24676, 43575, 0, 25.0, 0, 1, 0, 1, 1, 'Crazed Northsea Slaver - Reinforced Junkbox');

-- Risen Vrykul Ancestor (24871)
UPDATE `creature_template` SET `pickpocketloot` = 24871 WHERE (`entry` = 24871);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24871);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24871, 33447, 0, 7.14, 0, 1, 0, 1, 1, 'Risen Vrykul Ancestor - Runic Healing Potion'),
(24871, 33452, 0, 21.43, 0, 1, 0, 1, 1, 'Risen Vrykul Ancestor - Honey-Spiced Lichen'),
(24871, 38269, 0, 28.57, 0, 1, 0, 1, 1, 'Risen Vrykul Ancestor - Soggy Handkerchief'),
(24871, 43575, 0, 42.86, 0, 1, 0, 1, 1, 'Risen Vrykul Ancestor - Reinforced Junkbox');

-- Dragonflayer Forge Master (24079)
UPDATE `creature_template` SET `pickpocketloot` = 24079 WHERE (`entry` = 24079);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24079);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24079, 23437, 0, 10.0, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Talasite'),
(24079, 29569, 0, 30.0, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Strong Junkbox'),
(24079, 29570, 0, 10.0, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - A Gnome Effigy'),
(24079, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Runic Healing Potion'),
(24079, 35953, 0, 10.0, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Mead Basted Caribou'),
(24079, 38260, 0, 10.0, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Empty Tobacco Pouch'),
(24079, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonflayer Forge Master - Reinforced Junkbox');

-- Coilskar Witch (24696)
UPDATE `creature_template` SET `pickpocketloot` = 24696 WHERE (`entry` = 24696);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24696);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24696, 27858, 0, 33.33, 0, 1, 0, 1, 1, 'Coilskar Witch - Sunspring Carp'),
(24696, 29569, 0, 33.33, 0, 1, 0, 1, 1, 'Coilskar Witch - Strong Junkbox'),
(24696, 29576, 0, 33.33, 0, 1, 0, 1, 1, 'Coilskar Witch - Shark Bait');

-- Blood Shade (24872)
UPDATE `creature_template` SET `pickpocketloot` = 24872 WHERE (`entry` = 24872);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24872);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24872, 33447, 0, 40.0, 0, 1, 0, 1, 1, 'Blood Shade - Runic Healing Potion'),
(24872, 38269, 0, 40.0, 0, 1, 0, 1, 1, 'Blood Shade - Soggy Handkerchief'),
(24872, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Blood Shade - Reinforced Junkbox');

-- Wretched Devourer (24960)
UPDATE `creature_template` SET `pickpocketloot` = 24960 WHERE (`entry` = 24960);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24960);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24960, 22829, 0, 7.14, 0, 1, 0, 1, 1, 'Wretched Devourer - Super Healing Potion'),
(24960, 27859, 0, 28.57, 0, 1, 0, 1, 1, 'Wretched Devourer - Zangar Caps'),
(24960, 29569, 0, 35.71, 0, 1, 0, 1, 1, 'Wretched Devourer - Strong Junkbox'),
(24960, 29575, 0, 28.57, 0, 1, 0, 1, 1, 'Wretched Devourer - A Jack-o\'-Lantern');

-- Stonevault Pillager (24830)
UPDATE `creature_template` SET `pickpocketloot` = 24830 WHERE (`entry` = 24830);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24830);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24830, 1710, 0, 4.0, 0, 1, 0, 1, 1, 'Stonevault Pillager - Greater Healing Potion'),
(24830, 3771, 0, 4.0, 0, 1, 0, 1, 1, 'Stonevault Pillager - Wild Hog Shank'),
(24830, 4544, 0, 12.0, 0, 1, 0, 1, 1, 'Stonevault Pillager - Mulgore Spice Bread'),
(24830, 5427, 0, 36.0, 0, 1, 0, 1, 1, 'Stonevault Pillager - Crude Pocket Watch'),
(24830, 16883, 0, 48.0, 0, 1, 0, 1, 1, 'Stonevault Pillager - Worn Junkbox');

-- Wretched Fiend (24966)
UPDATE `creature_template` SET `pickpocketloot` = 24966 WHERE (`entry` = 24966);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24966);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24966, 22829, 0, 4.35, 0, 1, 0, 1, 1, 'Wretched Fiend - Super Healing Potion'),
(24966, 23439, 0, 4.35, 0, 1, 0, 1, 1, 'Wretched Fiend - Noble Topaz'),
(24966, 27859, 0, 21.74, 0, 1, 0, 1, 1, 'Wretched Fiend - Zangar Caps'),
(24966, 29569, 0, 21.74, 0, 1, 0, 1, 1, 'Wretched Fiend - Strong Junkbox'),
(24966, 29575, 0, 52.17, 0, 1, 0, 1, 1, 'Wretched Fiend - A Jack-o\'-Lantern');

-- Dawnblade Marksman (24979)
UPDATE `creature_template` SET `pickpocketloot` = 24979 WHERE (`entry` = 24979);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24979);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24979, 22829, 0, 5.88, 0, 1, 0, 1, 1, 'Dawnblade Marksman - Super Healing Potion'),
(24979, 27856, 0, 5.88, 0, 1, 0, 1, 1, 'Dawnblade Marksman - Skethyl Berries'),
(24979, 29569, 0, 29.41, 0, 1, 0, 1, 1, 'Dawnblade Marksman - Strong Junkbox'),
(24979, 29571, 0, 47.06, 0, 1, 0, 1, 1, 'Dawnblade Marksman - A Steamy Romance Novel'),
(24979, 30458, 0, 17.65, 0, 1, 0, 1, 1, 'Dawnblade Marksman - Stromgarde Muenster');

-- Cult Plaguebringer (24957)
UPDATE `creature_template` SET `pickpocketloot` = 24957 WHERE (`entry` = 24957);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24957);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24957, 29448, 0, 2.38, 0, 1, 0, 1, 1, 'Cult Plaguebringer - Mag\'har Mild Cheese'),
(24957, 33447, 0, 2.38, 0, 1, 0, 1, 1, 'Cult Plaguebringer - Runic Healing Potion'),
(24957, 33449, 0, 14.29, 0, 1, 0, 1, 1, 'Cult Plaguebringer - Crusty Flatbread'),
(24957, 36863, 0, 2.38, 0, 1, 0, 1, 1, 'Cult Plaguebringer - Decahedral Dwarven Dice'),
(24957, 37467, 0, 19.05, 0, 1, 0, 1, 1, 'Cult Plaguebringer - A Steamy Romance Novel: Forbidden Love'),
(24957, 38261, 0, 19.05, 0, 1, 0, 1, 1, 'Cult Plaguebringer - Bent House Key'),
(24957, 43575, 0, 52.38, 0, 1, 0, 1, 1, 'Cult Plaguebringer - Reinforced Junkbox');

-- Sister of Torment (24697)
UPDATE `creature_template` SET `pickpocketloot` = 24697 WHERE (`entry` = 24697);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24697);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24697, 27855, 0, 50.0, 0, 1, 0, 1, 1, 'Sister of Torment - Mag\'har Grainbread'),
(24697, 29569, 0, 25.0, 0, 1, 0, 1, 1, 'Sister of Torment - Strong Junkbox'),
(24697, 29570, 0, 25.0, 0, 1, 0, 1, 1, 'Sister of Torment - A Gnome Effigy');

-- Tunneling Ghoul (24084)
UPDATE `creature_template` SET `pickpocketloot` = 24084 WHERE (`entry` = 24084);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24084);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24084, 22829, 0, 7.41, 0, 1, 0, 1, 1, 'Tunneling Ghoul - Super Healing Potion'),
(24084, 27859, 0, 25.93, 0, 1, 0, 1, 1, 'Tunneling Ghoul - Zangar Caps'),
(24084, 29569, 0, 40.74, 0, 1, 0, 1, 1, 'Tunneling Ghoul - Strong Junkbox'),
(24084, 29575, 0, 40.74, 0, 1, 0, 1, 1, 'Tunneling Ghoul - A Jack-o\'-Lantern');

-- Unleashed Hellion (25002)
UPDATE `creature_template` SET `pickpocketloot` = 25002 WHERE (`entry` = 25002);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25002);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25002, 22829, 0, 16.67, 0, 1, 0, 1, 1, 'Unleashed Hellion - Super Healing Potion'),
(25002, 23440, 0, 16.67, 0, 1, 0, 1, 1, 'Unleashed Hellion - Dawnstone'),
(25002, 27854, 0, 16.67, 0, 1, 0, 1, 1, 'Unleashed Hellion - Smoked Talbuk Venison'),
(25002, 29569, 0, 50.0, 0, 1, 0, 1, 1, 'Unleashed Hellion - Strong Junkbox'),
(25002, 29570, 0, 33.33, 0, 1, 0, 1, 1, 'Unleashed Hellion - A Gnome Effigy');

-- Dawnblade Blood Knight (24976)
UPDATE `creature_template` SET `pickpocketloot` = 24976 WHERE (`entry` = 24976);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24976);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24976, 27855, 0, 6.67, 0, 1, 0, 1, 1, 'Dawnblade Blood Knight - Mag\'har Grainbread'),
(24976, 27856, 0, 20.0, 0, 1, 0, 1, 1, 'Dawnblade Blood Knight - Skethyl Berries'),
(24976, 29569, 0, 20.0, 0, 1, 0, 1, 1, 'Dawnblade Blood Knight - Strong Junkbox'),
(24976, 29571, 0, 53.33, 0, 1, 0, 1, 1, 'Dawnblade Blood Knight - A Steamy Romance Novel'),
(24976, 30458, 0, 6.67, 0, 1, 0, 1, 1, 'Dawnblade Blood Knight - Stromgarde Muenster');

-- Irespeaker (24999)
UPDATE `creature_template` SET `pickpocketloot` = 24999 WHERE (`entry` = 24999);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24999);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24999, 22829, 0, 14.29, 0, 1, 0, 1, 1, 'Irespeaker - Super Healing Potion'),
(24999, 27854, 0, 42.86, 0, 1, 0, 1, 1, 'Irespeaker - Smoked Talbuk Venison'),
(24999, 27855, 0, 14.29, 0, 1, 0, 1, 1, 'Irespeaker - Mag\'har Grainbread'),
(24999, 29569, 0, 28.57, 0, 1, 0, 1, 1, 'Irespeaker - Strong Junkbox');

-- Mutinous Sea Dog (25026)
UPDATE `creature_template` SET `pickpocketloot` = 25026 WHERE (`entry` = 25026);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25026);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25026, 29448, 0, 57.14, 0, 1, 0, 1, 1, 'Mutinous Sea Dog - Mag\'har Mild Cheese'),
(25026, 38261, 0, 28.57, 0, 1, 0, 1, 1, 'Mutinous Sea Dog - Bent House Key'),
(25026, 43575, 0, 42.86, 0, 1, 0, 1, 1, 'Mutinous Sea Dog - Reinforced Junkbox');

-- Dawnblade Summoner (24978)
UPDATE `creature_template` SET `pickpocketloot` = 24978 WHERE (`entry` = 24978);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 24978);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(24978, 22829, 0, 16.67, 0, 1, 0, 1, 1, 'Dawnblade Summoner - Super Healing Potion'),
(24978, 27855, 0, 12.5, 0, 1, 0, 1, 1, 'Dawnblade Summoner - Mag\'har Grainbread'),
(24978, 27856, 0, 4.17, 0, 1, 0, 1, 1, 'Dawnblade Summoner - Skethyl Berries'),
(24978, 29569, 0, 33.33, 0, 1, 0, 1, 1, 'Dawnblade Summoner - Strong Junkbox'),
(24978, 29571, 0, 29.17, 0, 1, 0, 1, 1, 'Dawnblade Summoner - A Steamy Romance Novel'),
(24978, 30458, 0, 4.17, 0, 1, 0, 1, 1, 'Dawnblade Summoner - Stromgarde Muenster');

-- Darkspine Siren (25073)
UPDATE `creature_template` SET `pickpocketloot` = 25073 WHERE (`entry` = 25073);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25073);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25073, 22829, 0, 14.29, 0, 1, 0, 1, 1, 'Darkspine Siren - Super Healing Potion'),
(25073, 27858, 0, 33.33, 0, 1, 0, 1, 1, 'Darkspine Siren - Sunspring Carp'),
(25073, 29569, 0, 42.86, 0, 1, 0, 1, 1, 'Darkspine Siren - Strong Junkbox'),
(25073, 29576, 0, 28.57, 0, 1, 0, 1, 1, 'Darkspine Siren - Shark Bait');

-- Crypt Crawler (25227)
UPDATE `creature_template` SET `pickpocketloot` = 25227 WHERE (`entry` = 25227);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25227);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25227, 27859, 0, 20.0, 0, 1, 0, 1, 1, 'Crypt Crawler - Zangar Caps'),
(25227, 29569, 0, 40.0, 0, 1, 0, 1, 1, 'Crypt Crawler - Strong Junkbox'),
(25227, 29575, 0, 40.0, 0, 1, 0, 1, 1, 'Crypt Crawler - A Jack-o\'-Lantern');

-- Greengill Slave (25084)
UPDATE `creature_template` SET `pickpocketloot` = 25084 WHERE (`entry` = 25084);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25084);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25084, 3928, 0, 14.58, 0, 1, 0, 1, 1, 'Greengill Slave - Superior Healing Potion'),
(25084, 5435, 0, 33.33, 0, 1, 0, 1, 1, 'Greengill Slave - Shiny Dinglehopper'),
(25084, 7910, 0, 2.08, 0, 1, 0, 1, 1, 'Greengill Slave - Star Ruby'),
(25084, 8959, 0, 33.33, 0, 1, 0, 1, 1, 'Greengill Slave - Raw Spinefin Halibut'),
(25084, 16885, 0, 29.17, 0, 1, 0, 1, 1, 'Greengill Slave - Heavy Junkbox');

-- En'kilah Crypt Fiend (25386)
UPDATE `creature_template` SET `pickpocketloot` = 25386 WHERE (`entry` = 25386);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25386);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25386, 27859, 0, 20.0, 0, 1, 0, 1, 1, 'En\'kilah Crypt Fiend - Zangar Caps'),
(25386, 29569, 0, 53.33, 0, 1, 0, 1, 1, 'En\'kilah Crypt Fiend - Strong Junkbox'),
(25386, 29575, 0, 53.33, 0, 1, 0, 1, 1, 'En\'kilah Crypt Fiend - A Jack-o\'-Lantern');

-- Darkspine Myrmidon (25060)
UPDATE `creature_template` SET `pickpocketloot` = 25060 WHERE (`entry` = 25060);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25060);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25060, 22829, 0, 15.79, 0, 1, 0, 1, 1, 'Darkspine Myrmidon - Super Healing Potion'),
(25060, 27858, 0, 26.32, 0, 1, 0, 1, 1, 'Darkspine Myrmidon - Sunspring Carp'),
(25060, 29569, 0, 36.84, 0, 1, 0, 1, 1, 'Darkspine Myrmidon - Strong Junkbox'),
(25060, 29576, 0, 26.32, 0, 1, 0, 1, 1, 'Darkspine Myrmidon - Shark Bait');

-- Dawnblade Reservist (25087)
UPDATE `creature_template` SET `pickpocketloot` = 25087 WHERE (`entry` = 25087);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25087);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25087, 27855, 0, 8.33, 0, 1, 0, 1, 1, 'Dawnblade Reservist - Mag\'har Grainbread'),
(25087, 27856, 0, 8.33, 0, 1, 0, 1, 1, 'Dawnblade Reservist - Skethyl Berries'),
(25087, 29569, 0, 41.67, 0, 1, 0, 1, 1, 'Dawnblade Reservist - Strong Junkbox'),
(25087, 29571, 0, 25.0, 0, 1, 0, 1, 1, 'Dawnblade Reservist - A Steamy Romance Novel'),
(25087, 30458, 0, 16.67, 0, 1, 0, 1, 1, 'Dawnblade Reservist - Stromgarde Muenster');

-- Naxxanar Skeletal Mage (25396)
UPDATE `creature_template` SET `pickpocketloot` = 25396 WHERE (`entry` = 25396);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25396);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25396, 33452, 0, 57.14, 0, 1, 0, 1, 1, 'Naxxanar Skeletal Mage - Honey-Spiced Lichen'),
(25396, 38269, 0, 14.29, 0, 1, 0, 1, 1, 'Naxxanar Skeletal Mage - Soggy Handkerchief'),
(25396, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Naxxanar Skeletal Mage - Reinforced Junkbox');

-- En'kilah Ghoul (25393)
UPDATE `creature_template` SET `pickpocketloot` = 25393 WHERE (`entry` = 25393);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25393);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25393, 22829, 0, 9.3, 0, 1, 0, 1, 1, 'En\'kilah Ghoul - Super Healing Potion'),
(25393, 27859, 0, 20.93, 0, 1, 0, 1, 1, 'En\'kilah Ghoul - Zangar Caps'),
(25393, 29569, 0, 30.23, 0, 1, 0, 1, 1, 'En\'kilah Ghoul - Strong Junkbox'),
(25393, 29575, 0, 41.86, 0, 1, 0, 1, 1, 'En\'kilah Ghoul - A Jack-o\'-Lantern');

-- Talramas Abomination (25684)
UPDATE `creature_template` SET `pickpocketloot` = 25684 WHERE (`entry` = 25684);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25684);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25684, 33447, 0, 5.0, 0, 1, 0, 1, 1, 'Talramas Abomination - Runic Healing Potion'),
(25684, 33452, 0, 20.0, 0, 1, 0, 1, 1, 'Talramas Abomination - Honey-Spiced Lichen'),
(25684, 38269, 0, 45.0, 0, 1, 0, 1, 1, 'Talramas Abomination - Soggy Handkerchief'),
(25684, 43575, 0, 35.0, 0, 1, 0, 1, 1, 'Talramas Abomination - Reinforced Junkbox');

-- Festering Ghoul (25660)
UPDATE `creature_template` SET `pickpocketloot` = 25660 WHERE (`entry` = 25660);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25660);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25660, 33447, 0, 4.17, 0, 1, 0, 1, 1, 'Festering Ghoul - Runic Healing Potion'),
(25660, 33452, 0, 25.0, 0, 1, 0, 1, 1, 'Festering Ghoul - Honey-Spiced Lichen'),
(25660, 38269, 0, 45.83, 0, 1, 0, 1, 1, 'Festering Ghoul - Soggy Handkerchief'),
(25660, 43575, 0, 29.17, 0, 1, 0, 1, 1, 'Festering Ghoul - Reinforced Junkbox');

-- Scourged Footman (25981)
UPDATE `creature_template` SET `pickpocketloot` = 25981 WHERE (`entry` = 25981);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25981);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25981, 22829, 0, 12.5, 0, 1, 0, 1, 1, 'Scourged Footman - Super Healing Potion'),
(25981, 27859, 0, 21.88, 0, 1, 0, 1, 1, 'Scourged Footman - Zangar Caps'),
(25981, 29569, 0, 46.88, 0, 1, 0, 1, 1, 'Scourged Footman - Strong Junkbox'),
(25981, 29575, 0, 46.88, 0, 1, 0, 1, 1, 'Scourged Footman - A Jack-o\'-Lantern');

-- Risen Longrunner (25350)
UPDATE `creature_template` SET `pickpocketloot` = 25350 WHERE (`entry` = 25350);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25350);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25350, 33447, 0, 7.69, 0, 1, 0, 1, 1, 'Risen Longrunner - Runic Healing Potion'),
(25350, 33452, 0, 46.15, 0, 1, 0, 1, 1, 'Risen Longrunner - Honey-Spiced Lichen'),
(25350, 38269, 0, 46.15, 0, 1, 0, 1, 1, 'Risen Longrunner - Soggy Handkerchief'),
(25350, 43575, 0, 15.38, 0, 1, 0, 1, 1, 'Risen Longrunner - Reinforced Junkbox');

-- Plagued Scavenger (25650)
UPDATE `creature_template` SET `pickpocketloot` = 25650 WHERE (`entry` = 25650);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 25650);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(25650, 22829, 0, 8.89, 0, 1, 0, 1, 1, 'Plagued Scavenger - Super Healing Potion'),
(25650, 23440, 0, 2.22, 0, 1, 0, 1, 1, 'Plagued Scavenger - Dawnstone'),
(25650, 27859, 0, 33.33, 0, 1, 0, 1, 1, 'Plagued Scavenger - Zangar Caps'),
(25650, 29569, 0, 31.11, 0, 1, 0, 1, 1, 'Plagued Scavenger - Strong Junkbox'),
(25650, 29575, 0, 26.67, 0, 1, 0, 1, 1, 'Plagued Scavenger - A Jack-o\'-Lantern');

-- Snowfall Glade Shaman (26201)
UPDATE `creature_template` SET `pickpocketloot` = 26201 WHERE (`entry` = 26201);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26201);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26201, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Snowfall Glade Shaman - Runic Healing Potion'),
(26201, 33454, 0, 40.0, 0, 1, 0, 1, 1, 'Snowfall Glade Shaman - Salted Venison'),
(26201, 38263, 0, 40.0, 0, 1, 0, 1, 1, 'Snowfall Glade Shaman - Too-Small Armband');

-- Bone Warrior (26126)
UPDATE `creature_template` SET `pickpocketloot` = 26126 WHERE (`entry` = 26126);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26126);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26126, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Bone Warrior - Runic Healing Potion'),
(26126, 33452, 0, 25.0, 0, 1, 0, 1, 1, 'Bone Warrior - Honey-Spiced Lichen'),
(26126, 38269, 0, 41.67, 0, 1, 0, 1, 1, 'Bone Warrior - Soggy Handkerchief'),
(26126, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Bone Warrior - Reinforced Junkbox');

-- Rune Reaver (26268)
UPDATE `creature_template` SET `pickpocketloot` = 26268 WHERE (`entry` = 26268);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26268);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26268, 29448, 0, 8.0, 0, 1, 0, 1, 1, 'Rune Reaver - Mag\'har Mild Cheese'),
(26268, 29450, 0, 6.0, 0, 1, 0, 1, 1, 'Rune Reaver - Telaari Grapes'),
(26268, 33447, 0, 10.0, 0, 1, 0, 1, 1, 'Rune Reaver - Runic Healing Potion'),
(26268, 33449, 0, 6.0, 0, 1, 0, 1, 1, 'Rune Reaver - Crusty Flatbread'),
(26268, 36863, 0, 2.0, 0, 1, 0, 1, 1, 'Rune Reaver - Decahedral Dwarven Dice'),
(26268, 37467, 0, 44.0, 0, 1, 0, 1, 1, 'Rune Reaver - A Steamy Romance Novel: Forbidden Love'),
(26268, 38261, 0, 8.0, 0, 1, 0, 1, 1, 'Rune Reaver - Bent House Key'),
(26268, 43575, 0, 28.0, 0, 1, 0, 1, 1, 'Rune Reaver - Reinforced Junkbox');

-- Snowfall Glade Wolvar (26198)
UPDATE `creature_template` SET `pickpocketloot` = 26198 WHERE (`entry` = 26198);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26198);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26198, 33447, 0, 5.0, 0, 1, 0, 1, 1, 'Snowfall Glade Wolvar - Runic Healing Potion'),
(26198, 33454, 0, 31.67, 0, 1, 0, 1, 1, 'Snowfall Glade Wolvar - Salted Venison'),
(26198, 38263, 0, 18.33, 0, 1, 0, 1, 1, 'Snowfall Glade Wolvar - Too-Small Armband'),
(26198, 38264, 0, 13.33, 0, 1, 0, 1, 1, 'Snowfall Glade Wolvar - A Very Pretty Rock'),
(26198, 43575, 0, 38.33, 0, 1, 0, 1, 1, 'Snowfall Glade Wolvar - Reinforced Junkbox');

-- Iron Rune-Shaper (26270)
UPDATE `creature_template` SET `pickpocketloot` = 26270 WHERE (`entry` = 26270);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26270);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26270, 29448, 0, 6.82, 0, 1, 0, 1, 1, 'Iron Rune-Shaper - Mag\'har Mild Cheese'),
(26270, 29450, 0, 4.55, 0, 1, 0, 1, 1, 'Iron Rune-Shaper - Telaari Grapes'),
(26270, 33447, 0, 11.36, 0, 1, 0, 1, 1, 'Iron Rune-Shaper - Runic Healing Potion'),
(26270, 33449, 0, 11.36, 0, 1, 0, 1, 1, 'Iron Rune-Shaper - Crusty Flatbread'),
(26270, 37467, 0, 22.73, 0, 1, 0, 1, 1, 'Iron Rune-Shaper - A Steamy Romance Novel: Forbidden Love'),
(26270, 38261, 0, 18.18, 0, 1, 0, 1, 1, 'Iron Rune-Shaper - Bent House Key'),
(26270, 43575, 0, 27.27, 0, 1, 0, 1, 1, 'Iron Rune-Shaper - Reinforced Junkbox');

-- Snowfall Glade Reaver (26197)
UPDATE `creature_template` SET `pickpocketloot` = 26197 WHERE (`entry` = 26197);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26197);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26197, 33447, 0, 15.38, 0, 1, 0, 1, 1, 'Snowfall Glade Reaver - Runic Healing Potion'),
(26197, 33454, 0, 30.77, 0, 1, 0, 1, 1, 'Snowfall Glade Reaver - Salted Venison'),
(26197, 38263, 0, 23.08, 0, 1, 0, 1, 1, 'Snowfall Glade Reaver - Too-Small Armband'),
(26197, 38264, 0, 26.92, 0, 1, 0, 1, 1, 'Snowfall Glade Reaver - A Very Pretty Rock'),
(26197, 43575, 0, 11.54, 0, 1, 0, 1, 1, 'Snowfall Glade Reaver - Reinforced Junkbox');

-- Indu'le Mystic (26336)
UPDATE `creature_template` SET `pickpocketloot` = 26336 WHERE (`entry` = 26336);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26336);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26336, 33452, 0, 20.0, 0, 1, 0, 1, 1, 'Indu\'le Mystic - Honey-Spiced Lichen'),
(26336, 38269, 0, 66.67, 0, 1, 0, 1, 1, 'Indu\'le Mystic - Soggy Handkerchief'),
(26336, 43575, 0, 46.67, 0, 1, 0, 1, 1, 'Indu\'le Mystic - Reinforced Junkbox');

-- Loguhn (26196)
UPDATE `creature_template` SET `pickpocketloot` = 26196 WHERE (`entry` = 26196);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26196);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26196, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Loguhn - Runic Healing Potion'),
(26196, 33449, 0, 20.0, 0, 1, 0, 1, 1, 'Loguhn - Crusty Flatbread'),
(26196, 33454, 0, 40.0, 0, 1, 0, 1, 1, 'Loguhn - Salted Venison'),
(26196, 38260, 0, 20.0, 0, 1, 0, 1, 1, 'Loguhn - Empty Tobacco Pouch'),
(26196, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Loguhn - Reinforced Junkbox');

-- Snowfall Glade Den Mother (26199)
UPDATE `creature_template` SET `pickpocketloot` = 26199 WHERE (`entry` = 26199);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26199);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26199, 33447, 0, 3.33, 0, 1, 0, 1, 1, 'Snowfall Glade Den Mother - Runic Healing Potion'),
(26199, 33454, 0, 21.67, 0, 1, 0, 1, 1, 'Snowfall Glade Den Mother - Salted Venison'),
(26199, 38263, 0, 25.0, 0, 1, 0, 1, 1, 'Snowfall Glade Den Mother - Too-Small Armband'),
(26199, 38264, 0, 13.33, 0, 1, 0, 1, 1, 'Snowfall Glade Den Mother - A Very Pretty Rock'),
(26199, 43575, 0, 43.33, 0, 1, 0, 1, 1, 'Snowfall Glade Den Mother - Reinforced Junkbox');

-- Magnataur Patriarch (26295)
UPDATE `creature_template` SET `pickpocketloot` = 26295 WHERE (`entry` = 26295);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26295);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26295, 33449, 0, 16.67, 0, 1, 0, 1, 1, 'Magnataur Patriarch - Crusty Flatbread'),
(26295, 33454, 0, 50.0, 0, 1, 0, 1, 1, 'Magnataur Patriarch - Salted Venison'),
(26295, 38260, 0, 33.33, 0, 1, 0, 1, 1, 'Magnataur Patriarch - Empty Tobacco Pouch');

-- Surge Needle Sorcerer (26257)
UPDATE `creature_template` SET `pickpocketloot` = 26257 WHERE (`entry` = 26257);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26257);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26257, 29448, 0, 12.12, 0, 1, 0, 1, 1, 'Surge Needle Sorcerer - Mag\'har Mild Cheese'),
(26257, 29450, 0, 12.12, 0, 1, 0, 1, 1, 'Surge Needle Sorcerer - Telaari Grapes'),
(26257, 33447, 0, 15.15, 0, 1, 0, 1, 1, 'Surge Needle Sorcerer - Runic Healing Potion'),
(26257, 33449, 0, 3.03, 0, 1, 0, 1, 1, 'Surge Needle Sorcerer - Crusty Flatbread'),
(26257, 37467, 0, 39.39, 0, 1, 0, 1, 1, 'Surge Needle Sorcerer - A Steamy Romance Novel: Forbidden Love'),
(26257, 38261, 0, 12.12, 0, 1, 0, 1, 1, 'Surge Needle Sorcerer - Bent House Key'),
(26257, 43575, 0, 42.42, 0, 1, 0, 1, 1, 'Surge Needle Sorcerer - Reinforced Junkbox');

-- Redfang Hunter (26356)
UPDATE `creature_template` SET `pickpocketloot` = 26356 WHERE (`entry` = 26356);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26356);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26356, 33447, 0, 15.0, 0, 1, 0, 1, 1, 'Redfang Hunter - Runic Healing Potion'),
(26356, 33454, 0, 25.0, 0, 1, 0, 1, 1, 'Redfang Hunter - Salted Venison'),
(26356, 38263, 0, 20.0, 0, 1, 0, 1, 1, 'Redfang Hunter - Too-Small Armband'),
(26356, 38264, 0, 22.5, 0, 1, 0, 1, 1, 'Redfang Hunter - A Very Pretty Rock'),
(26356, 43575, 0, 35.0, 0, 1, 0, 1, 1, 'Redfang Hunter - Reinforced Junkbox');

-- Anub'ar Cultist (26319)
UPDATE `creature_template` SET `pickpocketloot` = 26319 WHERE (`entry` = 26319);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26319);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26319, 33447, 0, 8.0, 0, 1, 0, 1, 1, 'Anub\'ar Cultist - Runic Healing Potion'),
(26319, 33449, 0, 8.0, 0, 1, 0, 1, 1, 'Anub\'ar Cultist - Crusty Flatbread'),
(26319, 38260, 0, 40.0, 0, 1, 0, 1, 1, 'Anub\'ar Cultist - Empty Tobacco Pouch'),
(26319, 38261, 0, 20.0, 0, 1, 0, 1, 1, 'Anub\'ar Cultist - Bent House Key'),
(26319, 43575, 0, 56.0, 0, 1, 0, 1, 1, 'Anub\'ar Cultist - Reinforced Junkbox');

-- Solstice Hunter (26389)
UPDATE `creature_template` SET `pickpocketloot` = 26389 WHERE (`entry` = 26389);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26389);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26389, 29448, 0, 3.12, 0, 1, 0, 1, 1, 'Solstice Hunter - Mag\'har Mild Cheese'),
(26389, 29450, 0, 12.5, 0, 1, 0, 1, 1, 'Solstice Hunter - Telaari Grapes'),
(26389, 33447, 0, 3.12, 0, 1, 0, 1, 1, 'Solstice Hunter - Runic Healing Potion'),
(26389, 33449, 0, 9.38, 0, 1, 0, 1, 1, 'Solstice Hunter - Crusty Flatbread'),
(26389, 37467, 0, 34.38, 0, 1, 0, 1, 1, 'Solstice Hunter - A Steamy Romance Novel: Forbidden Love'),
(26389, 43575, 0, 46.88, 0, 1, 0, 1, 1, 'Solstice Hunter - Reinforced Junkbox');

-- Dragonblight Mage Hunter (26280)
UPDATE `creature_template` SET `pickpocketloot` = 26280 WHERE (`entry` = 26280);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26280);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26280, 33447, 0, 17.91, 0, 1, 0, 1, 1, 'Dragonblight Mage Hunter - Runic Healing Potion'),
(26280, 33449, 0, 8.96, 0, 1, 0, 1, 1, 'Dragonblight Mage Hunter - Crusty Flatbread'),
(26280, 33454, 0, 13.43, 0, 1, 0, 1, 1, 'Dragonblight Mage Hunter - Salted Venison'),
(26280, 38260, 0, 29.85, 0, 1, 0, 1, 1, 'Dragonblight Mage Hunter - Empty Tobacco Pouch'),
(26280, 38261, 0, 10.45, 0, 1, 0, 1, 1, 'Dragonblight Mage Hunter - Bent House Key'),
(26280, 43575, 0, 26.87, 0, 1, 0, 1, 1, 'Dragonblight Mage Hunter - Reinforced Junkbox');

-- Rune-Smith Durar (26409)
UPDATE `creature_template` SET `pickpocketloot` = 26409 WHERE (`entry` = 26409);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26409);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26409, 29450, 0, 20.0, 0, 1, 0, 1, 1, 'Rune-Smith Durar - Telaari Grapes'),
(26409, 38261, 0, 20.0, 0, 1, 0, 1, 1, 'Rune-Smith Durar - Bent House Key'),
(26409, 43575, 0, 80.0, 0, 1, 0, 1, 1, 'Rune-Smith Durar - Reinforced Junkbox');

-- Runic Lightning Gunner (26414)
UPDATE `creature_template` SET `pickpocketloot` = 26414 WHERE (`entry` = 26414);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26414);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26414, 29448, 0, 12.5, 0, 1, 0, 1, 1, 'Runic Lightning Gunner - Mag\'har Mild Cheese'),
(26414, 29450, 0, 25.0, 0, 1, 0, 1, 1, 'Runic Lightning Gunner - Telaari Grapes'),
(26414, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Runic Lightning Gunner - Runic Healing Potion'),
(26414, 37467, 0, 37.5, 0, 1, 0, 1, 1, 'Runic Lightning Gunner - A Steamy Romance Novel: Forbidden Love'),
(26414, 43575, 0, 25.0, 0, 1, 0, 1, 1, 'Runic Lightning Gunner - Reinforced Junkbox');

-- Frostpaw Warrior (26357)
UPDATE `creature_template` SET `pickpocketloot` = 26357 WHERE (`entry` = 26357);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26357);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26357, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Frostpaw Warrior - Runic Healing Potion'),
(26357, 33454, 0, 29.17, 0, 1, 0, 1, 1, 'Frostpaw Warrior - Salted Venison'),
(26357, 38263, 0, 20.83, 0, 1, 0, 1, 1, 'Frostpaw Warrior - Too-Small Armband'),
(26357, 38264, 0, 16.67, 0, 1, 0, 1, 1, 'Frostpaw Warrior - A Very Pretty Rock'),
(26357, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Frostpaw Warrior - Reinforced Junkbox');

-- Indu'le Warrior (26344)
UPDATE `creature_template` SET `pickpocketloot` = 26344 WHERE (`entry` = 26344);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26344);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26344, 33447, 0, 6.67, 0, 1, 0, 1, 1, 'Indu\'le Warrior - Runic Healing Potion'),
(26344, 33452, 0, 24.44, 0, 1, 0, 1, 1, 'Indu\'le Warrior - Honey-Spiced Lichen'),
(26344, 38269, 0, 44.44, 0, 1, 0, 1, 1, 'Indu\'le Warrior - Soggy Handkerchief'),
(26344, 43575, 0, 44.44, 0, 1, 0, 1, 1, 'Indu\'le Warrior - Reinforced Junkbox');

-- Deranged Indu'le Villager (26411)
UPDATE `creature_template` SET `pickpocketloot` = 26411 WHERE (`entry` = 26411);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26411);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26411, 33447, 0, 5.56, 0, 1, 0, 1, 1, 'Deranged Indu\'le Villager - Runic Healing Potion'),
(26411, 33449, 0, 16.67, 0, 1, 0, 1, 1, 'Deranged Indu\'le Villager - Crusty Flatbread'),
(26411, 33454, 0, 22.22, 0, 1, 0, 1, 1, 'Deranged Indu\'le Villager - Salted Venison'),
(26411, 38260, 0, 44.44, 0, 1, 0, 1, 1, 'Deranged Indu\'le Villager - Empty Tobacco Pouch'),
(26411, 38261, 0, 5.56, 0, 1, 0, 1, 1, 'Deranged Indu\'le Villager - Bent House Key'),
(26411, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Deranged Indu\'le Villager - Reinforced Junkbox');

-- Frostpaw Shaman (26428)
UPDATE `creature_template` SET `pickpocketloot` = 26428 WHERE (`entry` = 26428);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26428);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26428, 33454, 0, 66.67, 0, 1, 0, 1, 1, 'Frostpaw Shaman - Salted Venison'),
(26428, 38264, 0, 33.33, 0, 1, 0, 1, 1, 'Frostpaw Shaman - A Very Pretty Rock');

-- Iron Rune-Smith (26408)
UPDATE `creature_template` SET `pickpocketloot` = 26408 WHERE (`entry` = 26408);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26408);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26408, 29448, 0, 10.11, 0, 1, 0, 1, 1, 'Iron Rune-Smith - Mag\'har Mild Cheese'),
(26408, 29450, 0, 8.99, 0, 1, 0, 1, 1, 'Iron Rune-Smith - Telaari Grapes'),
(26408, 33447, 0, 4.49, 0, 1, 0, 1, 1, 'Iron Rune-Smith - Runic Healing Potion'),
(26408, 33449, 0, 4.49, 0, 1, 0, 1, 1, 'Iron Rune-Smith - Crusty Flatbread'),
(26408, 37467, 0, 31.46, 0, 1, 0, 1, 1, 'Iron Rune-Smith - A Steamy Romance Novel: Forbidden Love'),
(26408, 38261, 0, 17.98, 0, 1, 0, 1, 1, 'Iron Rune-Smith - Bent House Key'),
(26408, 43575, 0, 31.46, 0, 1, 0, 1, 1, 'Iron Rune-Smith - Reinforced Junkbox');

-- Drakkari Warrior (26425)
UPDATE `creature_template` SET `pickpocketloot` = 26425 WHERE (`entry` = 26425);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26425);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26425, 33447, 0, 38.1, 0, 1, 0, 1, 1, 'Drakkari Warrior - Runic Healing Potion'),
(26425, 33449, 0, 4.76, 0, 1, 0, 1, 1, 'Drakkari Warrior - Crusty Flatbread'),
(26425, 33454, 0, 4.76, 0, 1, 0, 1, 1, 'Drakkari Warrior - Salted Venison'),
(26425, 36862, 0, 4.76, 0, 1, 0, 1, 1, 'Drakkari Warrior - Worn Troll Dice'),
(26425, 38260, 0, 14.29, 0, 1, 0, 1, 1, 'Drakkari Warrior - Empty Tobacco Pouch'),
(26425, 38261, 0, 9.52, 0, 1, 0, 1, 1, 'Drakkari Warrior - Bent House Key'),
(26425, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Drakkari Warrior - Reinforced Junkbox');

-- Warlord Zim'bo (26544)
UPDATE `creature_template` SET `pickpocketloot` = 26544 WHERE (`entry` = 26544);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26544);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26544, 33447, 0, 25.0, 0, 1, 0, 1, 1, 'Warlord Zim\'bo - Runic Healing Potion'),
(26544, 33454, 0, 12.5, 0, 1, 0, 1, 1, 'Warlord Zim\'bo - Salted Venison'),
(26544, 38261, 0, 12.5, 0, 1, 0, 1, 1, 'Warlord Zim\'bo - Bent House Key'),
(26544, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Warlord Zim\'bo - Reinforced Junkbox');

-- Wind Trader Mu'fah (26496)
UPDATE `creature_template` SET `pickpocketloot` = 26496 WHERE (`entry` = 26496);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26496);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26496, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Wind Trader Mu\'fah - Runic Healing Potion'),
(26496, 33449, 0, 20.0, 0, 1, 0, 1, 1, 'Wind Trader Mu\'fah - Crusty Flatbread'),
(26496, 38260, 0, 40.0, 0, 1, 0, 1, 1, 'Wind Trader Mu\'fah - Empty Tobacco Pouch'),
(26496, 38261, 0, 60.0, 0, 1, 0, 1, 1, 'Wind Trader Mu\'fah - Bent House Key'),
(26496, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Wind Trader Mu\'fah - Reinforced Junkbox');

-- Redfang Elder (26436)
UPDATE `creature_template` SET `pickpocketloot` = 26436 WHERE (`entry` = 26436);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26436);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26436, 33447, 0, 28.57, 0, 1, 0, 1, 1, 'Redfang Elder - Runic Healing Potion'),
(26436, 38263, 0, 14.29, 0, 1, 0, 1, 1, 'Redfang Elder - Too-Small Armband'),
(26436, 38266, 0, 14.29, 0, 1, 0, 1, 1, 'Redfang Elder - Rotund Relic'),
(26436, 43575, 0, 42.86, 0, 1, 0, 1, 1, 'Redfang Elder - Reinforced Junkbox');

-- Gamel the Cruel (26449)
UPDATE `creature_template` SET `pickpocketloot` = 26449 WHERE (`entry` = 26449);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26449);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26449, 22829, 0, 14.29, 0, 1, 0, 1, 1, 'Gamel the Cruel - Super Healing Potion'),
(26449, 27855, 0, 14.29, 0, 1, 0, 1, 1, 'Gamel the Cruel - Mag\'har Grainbread'),
(26449, 29569, 0, 57.14, 0, 1, 0, 1, 1, 'Gamel the Cruel - Strong Junkbox'),
(26449, 29570, 0, 28.57, 0, 1, 0, 1, 1, 'Gamel the Cruel - A Gnome Effigy');

-- Diseased Drakkari (26457)
UPDATE `creature_template` SET `pickpocketloot` = 26457 WHERE (`entry` = 26457);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26457);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26457, 33452, 0, 16.67, 0, 1, 0, 1, 1, 'Diseased Drakkari - Honey-Spiced Lichen'),
(26457, 38269, 0, 33.33, 0, 1, 0, 1, 1, 'Diseased Drakkari - Soggy Handkerchief'),
(26457, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Diseased Drakkari - Reinforced Junkbox');

-- Dragonflayer Deathseeker (26550)
UPDATE `creature_template` SET `pickpocketloot` = 26550 WHERE (`entry` = 26550);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26550);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26550, 35953, 0, 50.0, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Mead Basted Caribou'),
(26550, 38260, 0, 60.0, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Empty Tobacco Pouch'),
(26550, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Dragonflayer Deathseeker - Reinforced Junkbox');

-- Dragonflayer Fanatic (26553)
UPDATE `creature_template` SET `pickpocketloot` = 26553 WHERE (`entry` = 26553);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26553);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26553, 35953, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Mead Basted Caribou'),
(26553, 38260, 0, 66.67, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Empty Tobacco Pouch'),
(26553, 40202, 0, 16.67, 0, 1, 0, 1, 1, 'Dragonflayer Fanatic - Sizzling Grizzly Flank');

-- Captain Emmy Malin (26762)
UPDATE `creature_template` SET `pickpocketloot` = 26762 WHERE (`entry` = 26762);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26762);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26762, 29448, 0, 8.51, 0, 1, 0, 1, 1, 'Captain Emmy Malin - Mag\'har Mild Cheese'),
(26762, 29450, 0, 6.38, 0, 1, 0, 1, 1, 'Captain Emmy Malin - Telaari Grapes'),
(26762, 33447, 0, 12.77, 0, 1, 0, 1, 1, 'Captain Emmy Malin - Runic Healing Potion'),
(26762, 33449, 0, 4.26, 0, 1, 0, 1, 1, 'Captain Emmy Malin - Crusty Flatbread'),
(26762, 36863, 0, 2.13, 0, 1, 0, 1, 1, 'Captain Emmy Malin - Decahedral Dwarven Dice'),
(26762, 37467, 0, 29.79, 0, 1, 0, 1, 1, 'Captain Emmy Malin - A Steamy Romance Novel: Forbidden Love'),
(26762, 38261, 0, 27.66, 0, 1, 0, 1, 1, 'Captain Emmy Malin - Bent House Key'),
(26762, 43575, 0, 42.55, 0, 1, 0, 1, 1, 'Captain Emmy Malin - Reinforced Junkbox');

-- Anub'ar Slayer (26606)
UPDATE `creature_template` SET `pickpocketloot` = 26606 WHERE (`entry` = 26606);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26606);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26606, 33447, 0, 9.09, 0, 1, 0, 1, 1, 'Anub\'ar Slayer - Runic Healing Potion'),
(26606, 33452, 0, 27.27, 0, 1, 0, 1, 1, 'Anub\'ar Slayer - Honey-Spiced Lichen'),
(26606, 43575, 0, 9.09, 0, 1, 0, 1, 1, 'Anub\'ar Slayer - Reinforced Junkbox'),
(26606, 43576, 0, 36.36, 0, 1, 0, 1, 1, 'Anub\'ar Slayer - Chitin Polish'),
(26606, 43577, 0, 18.18, 0, 1, 0, 1, 1, 'Anub\'ar Slayer - Carapace Cleanser');

-- Drakkari Oracle (26795)
UPDATE `creature_template` SET `pickpocketloot` = 26795 WHERE (`entry` = 26795);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26795);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26795, 33447, 0, 8.06, 0, 1, 0, 1, 1, 'Drakkari Oracle - Runic Healing Potion'),
(26795, 33449, 0, 14.52, 0, 1, 0, 1, 1, 'Drakkari Oracle - Crusty Flatbread'),
(26795, 33454, 0, 11.29, 0, 1, 0, 1, 1, 'Drakkari Oracle - Salted Venison'),
(26795, 36862, 0, 3.23, 0, 1, 0, 1, 1, 'Drakkari Oracle - Worn Troll Dice'),
(26795, 38260, 0, 45.16, 0, 1, 0, 1, 1, 'Drakkari Oracle - Empty Tobacco Pouch'),
(26795, 38261, 0, 9.68, 0, 1, 0, 1, 1, 'Drakkari Oracle - Bent House Key'),
(26795, 43575, 0, 22.58, 0, 1, 0, 1, 1, 'Drakkari Oracle - Reinforced Junkbox');

-- Drakkari Defender (26704)
UPDATE `creature_template` SET `pickpocketloot` = 26704 WHERE (`entry` = 26704);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26704);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26704, 33449, 0, 6.25, 0, 1, 0, 1, 1, 'Drakkari Defender - Crusty Flatbread'),
(26704, 33454, 0, 6.25, 0, 1, 0, 1, 1, 'Drakkari Defender - Salted Venison'),
(26704, 36862, 0, 6.25, 0, 1, 0, 1, 1, 'Drakkari Defender - Worn Troll Dice'),
(26704, 38260, 0, 50.0, 0, 1, 0, 1, 1, 'Drakkari Defender - Empty Tobacco Pouch'),
(26704, 38261, 0, 25.0, 0, 1, 0, 1, 1, 'Drakkari Defender - Bent House Key'),
(26704, 43575, 0, 31.25, 0, 1, 0, 1, 1, 'Drakkari Defender - Reinforced Junkbox');

-- Drakkari Protector (26797)
UPDATE `creature_template` SET `pickpocketloot` = 26797 WHERE (`entry` = 26797);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26797);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26797, 33447, 0, 5.56, 0, 1, 0, 1, 1, 'Drakkari Protector - Runic Healing Potion'),
(26797, 33449, 0, 5.56, 0, 1, 0, 1, 1, 'Drakkari Protector - Crusty Flatbread'),
(26797, 33454, 0, 14.81, 0, 1, 0, 1, 1, 'Drakkari Protector - Salted Venison'),
(26797, 38260, 0, 40.74, 0, 1, 0, 1, 1, 'Drakkari Protector - Empty Tobacco Pouch'),
(26797, 38261, 0, 11.11, 0, 1, 0, 1, 1, 'Drakkari Protector - Bent House Key'),
(26797, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Drakkari Protector - Reinforced Junkbox');

-- Ancient Drakkari Warmonger (26811)
UPDATE `creature_template` SET `pickpocketloot` = 26811 WHERE (`entry` = 26811);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26811);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26811, 33447, 0, 11.76, 0, 1, 0, 1, 1, 'Ancient Drakkari Warmonger - Runic Healing Potion'),
(26811, 33449, 0, 5.88, 0, 1, 0, 1, 1, 'Ancient Drakkari Warmonger - Crusty Flatbread'),
(26811, 33454, 0, 17.65, 0, 1, 0, 1, 1, 'Ancient Drakkari Warmonger - Salted Venison'),
(26811, 36862, 0, 5.88, 0, 1, 0, 1, 1, 'Ancient Drakkari Warmonger - Worn Troll Dice'),
(26811, 38260, 0, 29.41, 0, 1, 0, 1, 1, 'Ancient Drakkari Warmonger - Empty Tobacco Pouch'),
(26811, 38261, 0, 5.88, 0, 1, 0, 1, 1, 'Ancient Drakkari Warmonger - Bent House Key'),
(26811, 43575, 0, 35.29, 0, 1, 0, 1, 1, 'Ancient Drakkari Warmonger - Reinforced Junkbox');

-- Horde Berserker (26799)
UPDATE `creature_template` SET `pickpocketloot` = 26799 WHERE (`entry` = 26799);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26799);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26799, 29450, 0, 14.29, 0, 1, 0, 1, 1, 'Horde Berserker - Telaari Grapes'),
(26799, 33447, 0, 28.57, 0, 1, 0, 1, 1, 'Horde Berserker - Runic Healing Potion'),
(26799, 37467, 0, 57.14, 0, 1, 0, 1, 1, 'Horde Berserker - A Steamy Romance Novel: Forbidden Love'),
(26799, 38261, 0, 28.57, 0, 1, 0, 1, 1, 'Horde Berserker - Bent House Key');

-- Lieutenant Ta'zinni (26815)
UPDATE `creature_template` SET `pickpocketloot` = 26815 WHERE (`entry` = 26815);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26815);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26815, 33447, 0, 14.29, 0, 1, 0, 1, 1, 'Lieutenant Ta\'zinni - Runic Healing Potion'),
(26815, 38261, 0, 14.29, 0, 1, 0, 1, 1, 'Lieutenant Ta\'zinni - Bent House Key'),
(26815, 43575, 0, 71.43, 0, 1, 0, 1, 1, 'Lieutenant Ta\'zinni - Reinforced Junkbox');

-- Dragonflayer Seer (26554)
UPDATE `creature_template` SET `pickpocketloot` = 26554 WHERE (`entry` = 26554);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26554);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26554, 33447, 0, 25.0, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Runic Healing Potion'),
(26554, 35953, 0, 25.0, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Mead Basted Caribou'),
(26554, 38260, 0, 25.0, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Empty Tobacco Pouch'),
(26554, 40202, 0, 10.0, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Sizzling Grizzly Flank'),
(26554, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Dragonflayer Seer - Reinforced Junkbox');

-- Ancient Drakkari Soothsayer (26812)
UPDATE `creature_template` SET `pickpocketloot` = 26812 WHERE (`entry` = 26812);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26812);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26812, 33447, 0, 30.0, 0, 1, 0, 1, 1, 'Ancient Drakkari Soothsayer - Runic Healing Potion'),
(26812, 33449, 0, 10.0, 0, 1, 0, 1, 1, 'Ancient Drakkari Soothsayer - Crusty Flatbread'),
(26812, 33454, 0, 10.0, 0, 1, 0, 1, 1, 'Ancient Drakkari Soothsayer - Salted Venison'),
(26812, 38260, 0, 10.0, 0, 1, 0, 1, 1, 'Ancient Drakkari Soothsayer - Empty Tobacco Pouch'),
(26812, 38261, 0, 20.0, 0, 1, 0, 1, 1, 'Ancient Drakkari Soothsayer - Bent House Key'),
(26812, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Ancient Drakkari Soothsayer - Reinforced Junkbox');

-- Alliance Berserker (26800)
UPDATE `creature_template` SET `pickpocketloot` = 26800 WHERE (`entry` = 26800);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26800);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26800, 29448, 0, 14.29, 0, 1, 0, 1, 1, 'Alliance Berserker - Mag\'har Mild Cheese'),
(26800, 33447, 0, 28.57, 0, 1, 0, 1, 1, 'Alliance Berserker - Runic Healing Potion'),
(26800, 37467, 0, 57.14, 0, 1, 0, 1, 1, 'Alliance Berserker - A Steamy Romance Novel: Forbidden Love'),
(26800, 38261, 0, 14.29, 0, 1, 0, 1, 1, 'Alliance Berserker - Bent House Key');

-- Horde Cleric (26803)
UPDATE `creature_template` SET `pickpocketloot` = 26803 WHERE (`entry` = 26803);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26803);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26803, 33447, 0, 27.27, 0, 1, 0, 1, 1, 'Horde Cleric - Runic Healing Potion'),
(26803, 33454, 0, 18.18, 0, 1, 0, 1, 1, 'Horde Cleric - Salted Venison'),
(26803, 38260, 0, 36.36, 0, 1, 0, 1, 1, 'Horde Cleric - Empty Tobacco Pouch'),
(26803, 38261, 0, 9.09, 0, 1, 0, 1, 1, 'Horde Cleric - Bent House Key'),
(26803, 43575, 0, 18.18, 0, 1, 0, 1, 1, 'Horde Cleric - Reinforced Junkbox');

-- Anub'ar Underlord (26605)
UPDATE `creature_template` SET `pickpocketloot` = 26605 WHERE (`entry` = 26605);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26605);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26605, 33447, 0, 7.14, 0, 1, 0, 1, 1, 'Anub\'ar Underlord - Runic Healing Potion'),
(26605, 33452, 0, 35.71, 0, 1, 0, 1, 1, 'Anub\'ar Underlord - Honey-Spiced Lichen'),
(26605, 43575, 0, 35.71, 0, 1, 0, 1, 1, 'Anub\'ar Underlord - Reinforced Junkbox'),
(26605, 43576, 0, 21.43, 0, 1, 0, 1, 1, 'Anub\'ar Underlord - Chitin Polish'),
(26605, 43577, 0, 14.29, 0, 1, 0, 1, 1, 'Anub\'ar Underlord - Carapace Cleanser');

-- Iron Rune Overseer (27177)
UPDATE `creature_template` SET `pickpocketloot` = 27177 WHERE (`entry` = 27177);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27177);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27177, 29448, 0, 20.0, 0, 1, 0, 1, 1, 'Iron Rune Overseer - Mag\'har Mild Cheese'),
(27177, 29450, 0, 10.0, 0, 1, 0, 1, 1, 'Iron Rune Overseer - Telaari Grapes'),
(27177, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Iron Rune Overseer - Runic Healing Potion'),
(27177, 37467, 0, 40.0, 0, 1, 0, 1, 1, 'Iron Rune Overseer - A Steamy Romance Novel: Forbidden Love'),
(27177, 38261, 0, 10.0, 0, 1, 0, 1, 1, 'Iron Rune Overseer - Bent House Key'),
(27177, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Iron Rune Overseer - Reinforced Junkbox');

-- Decrepit Necromancer (26942)
UPDATE `creature_template` SET `pickpocketloot` = 26942 WHERE (`entry` = 26942);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26942);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26942, 33447, 0, 7.69, 0, 1, 0, 1, 1, 'Decrepit Necromancer - Runic Healing Potion'),
(26942, 33452, 0, 30.77, 0, 1, 0, 1, 1, 'Decrepit Necromancer - Honey-Spiced Lichen'),
(26942, 38269, 0, 42.31, 0, 1, 0, 1, 1, 'Decrepit Necromancer - Soggy Handkerchief'),
(26942, 43575, 0, 38.46, 0, 1, 0, 1, 1, 'Decrepit Necromancer - Reinforced Junkbox');

-- Tormented Drakkari (26965)
UPDATE `creature_template` SET `pickpocketloot` = 26965 WHERE (`entry` = 26965);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26965);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26965, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Tormented Drakkari - Runic Healing Potion'),
(26965, 33449, 0, 33.33, 0, 1, 0, 1, 1, 'Tormented Drakkari - Crusty Flatbread'),
(26965, 33454, 0, 25.0, 0, 1, 0, 1, 1, 'Tormented Drakkari - Salted Venison'),
(26965, 38260, 0, 8.33, 0, 1, 0, 1, 1, 'Tormented Drakkari - Empty Tobacco Pouch'),
(26965, 38261, 0, 8.33, 0, 1, 0, 1, 1, 'Tormented Drakkari - Bent House Key'),
(26965, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Tormented Drakkari - Reinforced Junkbox');

-- Alliance Ranger (26802)
UPDATE `creature_template` SET `pickpocketloot` = 26802 WHERE (`entry` = 26802);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26802);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26802, 29448, 0, 11.11, 0, 1, 0, 1, 1, 'Alliance Ranger - Mag\'har Mild Cheese'),
(26802, 29450, 0, 22.22, 0, 1, 0, 1, 1, 'Alliance Ranger - Telaari Grapes'),
(26802, 37467, 0, 22.22, 0, 1, 0, 1, 1, 'Alliance Ranger - A Steamy Romance Novel: Forbidden Love'),
(26802, 38261, 0, 22.22, 0, 1, 0, 1, 1, 'Alliance Ranger - Bent House Key'),
(26802, 43575, 0, 22.22, 0, 1, 0, 1, 1, 'Alliance Ranger - Reinforced Junkbox');

-- Horde Ranger (26801)
UPDATE `creature_template` SET `pickpocketloot` = 26801 WHERE (`entry` = 26801);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26801);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26801, 29448, 0, 16.67, 0, 1, 0, 1, 1, 'Horde Ranger - Mag\'har Mild Cheese'),
(26801, 29450, 0, 16.67, 0, 1, 0, 1, 1, 'Horde Ranger - Telaari Grapes'),
(26801, 33449, 0, 33.33, 0, 1, 0, 1, 1, 'Horde Ranger - Crusty Flatbread'),
(26801, 37467, 0, 33.33, 0, 1, 0, 1, 1, 'Horde Ranger - A Steamy Romance Novel: Forbidden Love'),
(26801, 38261, 0, 33.33, 0, 1, 0, 1, 1, 'Horde Ranger - Bent House Key');

-- Bloodmoon Cultist (27024)
UPDATE `creature_template` SET `pickpocketloot` = 27024 WHERE (`entry` = 27024);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27024);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27024, 33454, 0, 12.5, 0, 1, 0, 1, 1, 'Bloodmoon Cultist - Salted Venison'),
(27024, 38260, 0, 37.5, 0, 1, 0, 1, 1, 'Bloodmoon Cultist - Empty Tobacco Pouch'),
(27024, 38261, 0, 12.5, 0, 1, 0, 1, 1, 'Bloodmoon Cultist - Bent House Key'),
(27024, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Bloodmoon Cultist - Reinforced Junkbox');

-- Onslaught Footman (27203)
UPDATE `creature_template` SET `pickpocketloot` = 27203 WHERE (`entry` = 27203);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27203);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27203, 29448, 0, 9.14, 0, 1, 0, 1, 1, 'Onslaught Footman - Mag\'har Mild Cheese'),
(27203, 29450, 0, 9.05, 0, 1, 0, 1, 1, 'Onslaught Footman - Telaari Grapes'),
(27203, 33447, 0, 9.05, 0, 1, 0, 1, 1, 'Onslaught Footman - Runic Healing Potion'),
(27203, 33449, 0, 9.53, 0, 1, 0, 1, 1, 'Onslaught Footman - Crusty Flatbread'),
(27203, 36863, 0, 0.38, 0, 1, 0, 1, 1, 'Onslaught Footman - Decahedral Dwarven Dice'),
(27203, 37467, 0, 35.71, 0, 1, 0, 1, 1, 'Onslaught Footman - A Steamy Romance Novel: Forbidden Love'),
(27203, 38261, 0, 13.47, 0, 1, 0, 1, 1, 'Onslaught Footman - Bent House Key'),
(27203, 43575, 0, 29.16, 0, 1, 0, 1, 1, 'Onslaught Footman - Reinforced Junkbox');

-- Forgotten Footman (27229)
UPDATE `creature_template` SET `pickpocketloot` = 27229 WHERE (`entry` = 27229);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27229);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27229, 33447, 0, 6.25, 0, 1, 0, 1, 1, 'Forgotten Footman - Runic Healing Potion'),
(27229, 33452, 0, 37.5, 0, 1, 0, 1, 1, 'Forgotten Footman - Honey-Spiced Lichen'),
(27229, 38269, 0, 62.5, 0, 1, 0, 1, 1, 'Forgotten Footman - Soggy Handkerchief'),
(27229, 43575, 0, 6.25, 0, 1, 0, 1, 1, 'Forgotten Footman - Reinforced Junkbox');

-- Conquest Hold Raider (27118)
UPDATE `creature_template` SET `pickpocketloot` = 27118 WHERE (`entry` = 27118);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27118);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27118, 33454, 0, 20.0, 0, 1, 0, 1, 1, 'Conquest Hold Raider - Salted Venison'),
(27118, 38261, 0, 40.0, 0, 1, 0, 1, 1, 'Conquest Hold Raider - Bent House Key'),
(27118, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Conquest Hold Raider - Reinforced Junkbox');

-- Onslaught Knight (27206)
UPDATE `creature_template` SET `pickpocketloot` = 27206 WHERE (`entry` = 27206);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27206);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27206, 29448, 0, 7.96, 0, 1, 0, 1, 1, 'Onslaught Knight - Mag\'har Mild Cheese'),
(27206, 29450, 0, 8.85, 0, 1, 0, 1, 1, 'Onslaught Knight - Telaari Grapes'),
(27206, 33447, 0, 7.96, 0, 1, 0, 1, 1, 'Onslaught Knight - Runic Healing Potion'),
(27206, 33449, 0, 9.73, 0, 1, 0, 1, 1, 'Onslaught Knight - Crusty Flatbread'),
(27206, 36863, 0, 3.54, 0, 1, 0, 1, 1, 'Onslaught Knight - Decahedral Dwarven Dice'),
(27206, 37467, 0, 25.66, 0, 1, 0, 1, 1, 'Onslaught Knight - A Steamy Romance Novel: Forbidden Love'),
(27206, 38261, 0, 7.96, 0, 1, 0, 1, 1, 'Onslaught Knight - Bent House Key'),
(27206, 43575, 0, 38.05, 0, 1, 0, 1, 1, 'Onslaught Knight - Reinforced Junkbox');

-- Iron Rune-Weaver (26820)
UPDATE `creature_template` SET `pickpocketloot` = 26820 WHERE (`entry` = 26820);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26820);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26820, 29448, 0, 8.96, 0, 1, 0, 1, 1, 'Iron Rune-Weaver - Mag\'har Mild Cheese'),
(26820, 29450, 0, 13.43, 0, 1, 0, 1, 1, 'Iron Rune-Weaver - Telaari Grapes'),
(26820, 33447, 0, 7.46, 0, 1, 0, 1, 1, 'Iron Rune-Weaver - Runic Healing Potion'),
(26820, 33449, 0, 7.46, 0, 1, 0, 1, 1, 'Iron Rune-Weaver - Crusty Flatbread'),
(26820, 37467, 0, 29.85, 0, 1, 0, 1, 1, 'Iron Rune-Weaver - A Steamy Romance Novel: Forbidden Love'),
(26820, 38261, 0, 10.45, 0, 1, 0, 1, 1, 'Iron Rune-Weaver - Bent House Key'),
(26820, 43575, 0, 26.87, 0, 1, 0, 1, 1, 'Iron Rune-Weaver - Reinforced Junkbox');

-- Forgotten Rifleman (27225)
UPDATE `creature_template` SET `pickpocketloot` = 27225 WHERE (`entry` = 27225);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27225);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27225, 33447, 0, 10.34, 0, 1, 0, 1, 1, 'Forgotten Rifleman - Runic Healing Potion'),
(27225, 33452, 0, 41.38, 0, 1, 0, 1, 1, 'Forgotten Rifleman - Honey-Spiced Lichen'),
(27225, 38269, 0, 34.48, 0, 1, 0, 1, 1, 'Forgotten Rifleman - Soggy Handkerchief'),
(27225, 43575, 0, 34.48, 0, 1, 0, 1, 1, 'Forgotten Rifleman - Reinforced Junkbox');

-- Onslaught Raven Priest (27202)
UPDATE `creature_template` SET `pickpocketloot` = 27202 WHERE (`entry` = 27202);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27202);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27202, 29448, 0, 4.07, 0, 1, 0, 1, 1, 'Onslaught Raven Priest - Mag\'har Mild Cheese'),
(27202, 29450, 0, 10.16, 0, 1, 0, 1, 1, 'Onslaught Raven Priest - Telaari Grapes'),
(27202, 33447, 0, 13.01, 0, 1, 0, 1, 1, 'Onslaught Raven Priest - Runic Healing Potion'),
(27202, 33449, 0, 6.91, 0, 1, 0, 1, 1, 'Onslaught Raven Priest - Crusty Flatbread'),
(27202, 37467, 0, 36.59, 0, 1, 0, 1, 1, 'Onslaught Raven Priest - A Steamy Romance Novel: Forbidden Love'),
(27202, 38261, 0, 21.54, 0, 1, 0, 1, 1, 'Onslaught Raven Priest - Bent House Key'),
(27202, 43575, 0, 24.8, 0, 1, 0, 1, 1, 'Onslaught Raven Priest - Reinforced Junkbox');

-- Bishop Street (27246)
UPDATE `creature_template` SET `pickpocketloot` = 27246 WHERE (`entry` = 27246);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27246);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27246, 27855, 0, 5.26, 0, 1, 0, 1, 1, 'Bishop Street - Mag\'har Grainbread'),
(27246, 29569, 0, 15.79, 0, 1, 0, 1, 1, 'Bishop Street - Strong Junkbox'),
(27246, 29571, 0, 47.37, 0, 1, 0, 1, 1, 'Bishop Street - A Steamy Romance Novel'),
(27246, 37350, 0, 36.84, 0, 1, 0, 1, 1, 'Bishop Street - Bishop Street\'s Prayer Book');

-- Stable Master Mercer (27236)
UPDATE `creature_template` SET `pickpocketloot` = 27236 WHERE (`entry` = 27236);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27236);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27236, 29450, 0, 25.0, 0, 1, 0, 1, 1, 'Stable Master Mercer - Telaari Grapes'),
(27236, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Stable Master Mercer - Runic Healing Potion'),
(27236, 37467, 0, 50.0, 0, 1, 0, 1, 1, 'Stable Master Mercer - A Steamy Romance Novel: Forbidden Love'),
(27236, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Stable Master Mercer - Reinforced Junkbox');

-- Onslaught Workman (27207)
UPDATE `creature_template` SET `pickpocketloot` = 27207 WHERE (`entry` = 27207);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27207);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27207, 29448, 0, 17.02, 0, 1, 0, 1, 1, 'Onslaught Workman - Mag\'har Mild Cheese'),
(27207, 29450, 0, 10.64, 0, 1, 0, 1, 1, 'Onslaught Workman - Telaari Grapes'),
(27207, 33447, 0, 2.13, 0, 1, 0, 1, 1, 'Onslaught Workman - Runic Healing Potion'),
(27207, 33449, 0, 12.77, 0, 1, 0, 1, 1, 'Onslaught Workman - Crusty Flatbread'),
(27207, 37467, 0, 23.4, 0, 1, 0, 1, 1, 'Onslaught Workman - A Steamy Romance Novel: Forbidden Love'),
(27207, 38261, 0, 10.64, 0, 1, 0, 1, 1, 'Onslaught Workman - Bent House Key'),
(27207, 43575, 0, 45.74, 0, 1, 0, 1, 1, 'Onslaught Workman - Reinforced Junkbox');

-- Dragonflayer Flamebinder (27259)
UPDATE `creature_template` SET `pickpocketloot` = 27259 WHERE (`entry` = 27259);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27259);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27259, 33447, 0, 5.45, 0, 1, 0, 1, 1, 'Dragonflayer Flamebinder - Runic Healing Potion'),
(27259, 33449, 0, 10.91, 0, 1, 0, 1, 1, 'Dragonflayer Flamebinder - Crusty Flatbread'),
(27259, 33454, 0, 12.73, 0, 1, 0, 1, 1, 'Dragonflayer Flamebinder - Salted Venison'),
(27259, 38260, 0, 41.82, 0, 1, 0, 1, 1, 'Dragonflayer Flamebinder - Empty Tobacco Pouch'),
(27259, 38261, 0, 9.09, 0, 1, 0, 1, 1, 'Dragonflayer Flamebinder - Bent House Key'),
(27259, 43575, 0, 36.36, 0, 1, 0, 1, 1, 'Dragonflayer Flamebinder - Reinforced Junkbox');

-- Bloodpaw Shaman (27343)
UPDATE `creature_template` SET `pickpocketloot` = 27343 WHERE (`entry` = 27343);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27343);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27343, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Bloodpaw Shaman - Runic Healing Potion'),
(27343, 33454, 0, 33.33, 0, 1, 0, 1, 1, 'Bloodpaw Shaman - Salted Venison'),
(27343, 38263, 0, 44.44, 0, 1, 0, 1, 1, 'Bloodpaw Shaman - Too-Small Armband'),
(27343, 43575, 0, 22.22, 0, 1, 0, 1, 1, 'Bloodpaw Shaman - Reinforced Junkbox');

-- Snowplain Shaman (27279)
UPDATE `creature_template` SET `pickpocketloot` = 27279 WHERE (`entry` = 27279);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27279);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27279, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Snowplain Shaman - Runic Healing Potion'),
(27279, 33454, 0, 37.5, 0, 1, 0, 1, 1, 'Snowplain Shaman - Salted Venison'),
(27279, 38263, 0, 37.5, 0, 1, 0, 1, 1, 'Snowplain Shaman - Too-Small Armband'),
(27279, 38264, 0, 12.5, 0, 1, 0, 1, 1, 'Snowplain Shaman - A Very Pretty Rock'),
(27279, 43575, 0, 12.5, 0, 1, 0, 1, 1, 'Snowplain Shaman - Reinforced Junkbox');

-- Mindless Wight (27287)
UPDATE `creature_template` SET `pickpocketloot` = 27287 WHERE (`entry` = 27287);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27287);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27287, 33452, 0, 42.86, 0, 1, 0, 1, 1, 'Mindless Wight - Honey-Spiced Lichen'),
(27287, 38269, 0, 28.57, 0, 1, 0, 1, 1, 'Mindless Wight - Soggy Handkerchief'),
(27287, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Mindless Wight - Reinforced Junkbox');

-- Onslaught Mason (27333)
UPDATE `creature_template` SET `pickpocketloot` = 27333 WHERE (`entry` = 27333);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27333);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27333, 29448, 0, 8.33, 0, 1, 0, 1, 1, 'Onslaught Mason - Mag\'har Mild Cheese'),
(27333, 29450, 0, 14.58, 0, 1, 0, 1, 1, 'Onslaught Mason - Telaari Grapes'),
(27333, 33447, 0, 10.42, 0, 1, 0, 1, 1, 'Onslaught Mason - Runic Healing Potion'),
(27333, 33449, 0, 2.08, 0, 1, 0, 1, 1, 'Onslaught Mason - Crusty Flatbread'),
(27333, 37467, 0, 27.08, 0, 1, 0, 1, 1, 'Onslaught Mason - A Steamy Romance Novel: Forbidden Love'),
(27333, 38261, 0, 12.5, 0, 1, 0, 1, 1, 'Onslaught Mason - Bent House Key'),
(27333, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Onslaught Mason - Reinforced Junkbox');

-- Onslaught Deckhand (27233)
UPDATE `creature_template` SET `pickpocketloot` = 27233 WHERE (`entry` = 27233);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27233);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27233, 29448, 0, 1.32, 0, 1, 0, 1, 1, 'Onslaught Deckhand - Mag\'har Mild Cheese'),
(27233, 29450, 0, 13.16, 0, 1, 0, 1, 1, 'Onslaught Deckhand - Telaari Grapes'),
(27233, 33447, 0, 3.95, 0, 1, 0, 1, 1, 'Onslaught Deckhand - Runic Healing Potion'),
(27233, 33449, 0, 3.95, 0, 1, 0, 1, 1, 'Onslaught Deckhand - Crusty Flatbread'),
(27233, 37467, 0, 28.95, 0, 1, 0, 1, 1, 'Onslaught Deckhand - A Steamy Romance Novel: Forbidden Love'),
(27233, 38261, 0, 14.47, 0, 1, 0, 1, 1, 'Onslaught Deckhand - Bent House Key'),
(27233, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Onslaught Deckhand - Reinforced Junkbox');

-- Onslaught Scout (27332)
UPDATE `creature_template` SET `pickpocketloot` = 27332 WHERE (`entry` = 27332);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27332);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27332, 29448, 0, 8.33, 0, 1, 0, 1, 1, 'Onslaught Scout - Mag\'har Mild Cheese'),
(27332, 29450, 0, 8.33, 0, 1, 0, 1, 1, 'Onslaught Scout - Telaari Grapes'),
(27332, 33449, 0, 8.33, 0, 1, 0, 1, 1, 'Onslaught Scout - Crusty Flatbread'),
(27332, 37467, 0, 58.33, 0, 1, 0, 1, 1, 'Onslaught Scout - A Steamy Romance Novel: Forbidden Love'),
(27332, 38261, 0, 8.33, 0, 1, 0, 1, 1, 'Onslaught Scout - Bent House Key'),
(27332, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Onslaught Scout - Reinforced Junkbox');

-- Onslaught Infantry (27330)
UPDATE `creature_template` SET `pickpocketloot` = 27330 WHERE (`entry` = 27330);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27330);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27330, 29448, 0, 5.88, 0, 1, 0, 1, 1, 'Onslaught Infantry - Mag\'har Mild Cheese'),
(27330, 29450, 0, 6.72, 0, 1, 0, 1, 1, 'Onslaught Infantry - Telaari Grapes'),
(27330, 33447, 0, 12.61, 0, 1, 0, 1, 1, 'Onslaught Infantry - Runic Healing Potion'),
(27330, 33449, 0, 6.72, 0, 1, 0, 1, 1, 'Onslaught Infantry - Crusty Flatbread'),
(27330, 36863, 0, 0.84, 0, 1, 0, 1, 1, 'Onslaught Infantry - Decahedral Dwarven Dice'),
(27330, 37467, 0, 33.61, 0, 1, 0, 1, 1, 'Onslaught Infantry - A Steamy Romance Novel: Forbidden Love'),
(27330, 38261, 0, 15.13, 0, 1, 0, 1, 1, 'Onslaught Infantry - Bent House Key'),
(27330, 43575, 0, 29.41, 0, 1, 0, 1, 1, 'Onslaught Infantry - Reinforced Junkbox');

-- Risen Wintergarde Defender (27284)
UPDATE `creature_template` SET `pickpocketloot` = 27284 WHERE (`entry` = 27284);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27284);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27284, 33447, 0, 13.33, 0, 1, 0, 1, 1, 'Risen Wintergarde Defender - Runic Healing Potion'),
(27284, 33452, 0, 46.67, 0, 1, 0, 1, 1, 'Risen Wintergarde Defender - Honey-Spiced Lichen'),
(27284, 38269, 0, 26.67, 0, 1, 0, 1, 1, 'Risen Wintergarde Defender - Soggy Handkerchief'),
(27284, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Risen Wintergarde Defender - Reinforced Junkbox');

-- Onslaught Death Knight (27367)
UPDATE `creature_template` SET `pickpocketloot` = 27367 WHERE (`entry` = 27367);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27367);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27367, 37467, 0, 20.0, 0, 1, 0, 1, 1, 'Onslaught Death Knight - A Steamy Romance Novel: Forbidden Love'),
(27367, 43575, 0, 80.0, 0, 1, 0, 1, 1, 'Onslaught Death Knight - Reinforced Junkbox');

-- Smoldering Construct (27362)
UPDATE `creature_template` SET `pickpocketloot` = 27362 WHERE (`entry` = 27362);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27362);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27362, 33447, 0, 30.77, 0, 1, 0, 1, 1, 'Smoldering Construct - Runic Healing Potion'),
(27362, 33452, 0, 23.08, 0, 1, 0, 1, 1, 'Smoldering Construct - Honey-Spiced Lichen'),
(27362, 38269, 0, 53.85, 0, 1, 0, 1, 1, 'Smoldering Construct - Soggy Handkerchief'),
(27362, 43575, 0, 7.69, 0, 1, 0, 1, 1, 'Smoldering Construct - Reinforced Junkbox');

-- Burning Depths Necrolyte (27356)
UPDATE `creature_template` SET `pickpocketloot` = 27356 WHERE (`entry` = 27356);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27356);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27356, 29448, 0, 9.8, 0, 1, 0, 1, 1, 'Burning Depths Necrolyte - Mag\'har Mild Cheese'),
(27356, 29450, 0, 7.84, 0, 1, 0, 1, 1, 'Burning Depths Necrolyte - Telaari Grapes'),
(27356, 33447, 0, 11.76, 0, 1, 0, 1, 1, 'Burning Depths Necrolyte - Runic Healing Potion'),
(27356, 33449, 0, 7.84, 0, 1, 0, 1, 1, 'Burning Depths Necrolyte - Crusty Flatbread'),
(27356, 37467, 0, 33.33, 0, 1, 0, 1, 1, 'Burning Depths Necrolyte - A Steamy Romance Novel: Forbidden Love'),
(27356, 38261, 0, 15.69, 0, 1, 0, 1, 1, 'Burning Depths Necrolyte - Bent House Key'),
(27356, 43575, 0, 29.41, 0, 1, 0, 1, 1, 'Burning Depths Necrolyte - Reinforced Junkbox');

-- Burning Depths Necromancer (27358)
UPDATE `creature_template` SET `pickpocketloot` = 27358 WHERE (`entry` = 27358);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27358);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27358, 29448, 0, 4.35, 0, 1, 0, 1, 1, 'Burning Depths Necromancer - Mag\'har Mild Cheese'),
(27358, 29450, 0, 8.7, 0, 1, 0, 1, 1, 'Burning Depths Necromancer - Telaari Grapes'),
(27358, 33447, 0, 17.39, 0, 1, 0, 1, 1, 'Burning Depths Necromancer - Runic Healing Potion'),
(27358, 33449, 0, 4.35, 0, 1, 0, 1, 1, 'Burning Depths Necromancer - Crusty Flatbread'),
(27358, 37467, 0, 34.78, 0, 1, 0, 1, 1, 'Burning Depths Necromancer - A Steamy Romance Novel: Forbidden Love'),
(27358, 38261, 0, 21.74, 0, 1, 0, 1, 1, 'Burning Depths Necromancer - Bent House Key'),
(27358, 43575, 0, 43.48, 0, 1, 0, 1, 1, 'Burning Depths Necromancer - Reinforced Junkbox');

-- Smoldering Geist (27363)
UPDATE `creature_template` SET `pickpocketloot` = 27363 WHERE (`entry` = 27363);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27363);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27363, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Smoldering Geist - Runic Healing Potion'),
(27363, 33452, 0, 25.0, 0, 1, 0, 1, 1, 'Smoldering Geist - Honey-Spiced Lichen'),
(27363, 38269, 0, 50.0, 0, 1, 0, 1, 1, 'Smoldering Geist - Soggy Handkerchief'),
(27363, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Smoldering Geist - Reinforced Junkbox');

-- Scourge Siegesmith (27410)
UPDATE `creature_template` SET `pickpocketloot` = 27410 WHERE (`entry` = 27410);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27410);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27410, 33447, 0, 15.38, 0, 1, 0, 1, 1, 'Scourge Siegesmith - Runic Healing Potion'),
(27410, 33452, 0, 23.08, 0, 1, 0, 1, 1, 'Scourge Siegesmith - Honey-Spiced Lichen'),
(27410, 38269, 0, 30.77, 0, 1, 0, 1, 1, 'Scourge Siegesmith - Soggy Handkerchief'),
(27410, 43575, 0, 46.15, 0, 1, 0, 1, 1, 'Scourge Siegesmith - Reinforced Junkbox');

-- Vengeful Geist (27370)
UPDATE `creature_template` SET `pickpocketloot` = 27370 WHERE (`entry` = 27370);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27370);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27370, 33447, 0, 18.6, 0, 1, 0, 1, 1, 'Vengeful Geist - Runic Healing Potion'),
(27370, 33452, 0, 9.3, 0, 1, 0, 1, 1, 'Vengeful Geist - Honey-Spiced Lichen'),
(27370, 38269, 0, 41.86, 0, 1, 0, 1, 1, 'Vengeful Geist - Soggy Handkerchief'),
(27370, 43575, 0, 39.53, 0, 1, 0, 1, 1, 'Vengeful Geist - Reinforced Junkbox');

-- Conquest Hold Marauder (27424)
UPDATE `creature_template` SET `pickpocketloot` = 27424 WHERE (`entry` = 27424);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27424);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27424, 33447, 0, 15.0, 0, 1, 0, 1, 1, 'Conquest Hold Marauder - Runic Healing Potion'),
(27424, 33449, 0, 15.0, 0, 1, 0, 1, 1, 'Conquest Hold Marauder - Crusty Flatbread'),
(27424, 33454, 0, 5.0, 0, 1, 0, 1, 1, 'Conquest Hold Marauder - Salted Venison'),
(27424, 38260, 0, 45.0, 0, 1, 0, 1, 1, 'Conquest Hold Marauder - Empty Tobacco Pouch'),
(27424, 38261, 0, 10.0, 0, 1, 0, 1, 1, 'Conquest Hold Marauder - Bent House Key'),
(27424, 43575, 0, 25.0, 0, 1, 0, 1, 1, 'Conquest Hold Marauder - Reinforced Junkbox');

-- Frigid Necromancer (27539)
UPDATE `creature_template` SET `pickpocketloot` = 27539 WHERE (`entry` = 27539);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27539);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27539, 29448, 0, 13.64, 0, 1, 0, 1, 1, 'Frigid Necromancer - Mag\'har Mild Cheese'),
(27539, 29450, 0, 2.27, 0, 1, 0, 1, 1, 'Frigid Necromancer - Telaari Grapes'),
(27539, 33447, 0, 6.82, 0, 1, 0, 1, 1, 'Frigid Necromancer - Runic Healing Potion'),
(27539, 33449, 0, 2.27, 0, 1, 0, 1, 1, 'Frigid Necromancer - Crusty Flatbread'),
(27539, 37467, 0, 54.55, 0, 1, 0, 1, 1, 'Frigid Necromancer - A Steamy Romance Novel: Forbidden Love'),
(27539, 38261, 0, 11.36, 0, 1, 0, 1, 1, 'Frigid Necromancer - Bent House Key'),
(27539, 43575, 0, 31.82, 0, 1, 0, 1, 1, 'Frigid Necromancer - Reinforced Junkbox');

-- Scourge Deathspeaker (27615)
UPDATE `creature_template` SET `pickpocketloot` = 27615 WHERE (`entry` = 27615);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27615);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27615, 33452, 0, 28.57, 0, 1, 0, 1, 1, 'Scourge Deathspeaker - Honey-Spiced Lichen'),
(27615, 38269, 0, 42.86, 0, 1, 0, 1, 1, 'Scourge Deathspeaker - Soggy Handkerchief'),
(27615, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Scourge Deathspeaker - Reinforced Junkbox');

-- Risen Wintergarde Miner (27401)
UPDATE `creature_template` SET `pickpocketloot` = 27401 WHERE (`entry` = 27401);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27401);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27401, 33447, 0, 9.62, 0, 1, 0, 1, 1, 'Risen Wintergarde Miner - Runic Healing Potion'),
(27401, 33452, 0, 33.65, 0, 1, 0, 1, 1, 'Risen Wintergarde Miner - Honey-Spiced Lichen'),
(27401, 38269, 0, 28.85, 0, 1, 0, 1, 1, 'Risen Wintergarde Miner - Soggy Handkerchief'),
(27401, 43575, 0, 38.46, 0, 1, 0, 1, 1, 'Risen Wintergarde Miner - Reinforced Junkbox');

-- Drakkari Witch Doctor (27555)
UPDATE `creature_template` SET `pickpocketloot` = 27555 WHERE (`entry` = 27555);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27555);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27555, 33454, 0, 42.86, 0, 1, 0, 1, 1, 'Drakkari Witch Doctor - Salted Venison'),
(27555, 38260, 0, 57.14, 0, 1, 0, 1, 1, 'Drakkari Witch Doctor - Empty Tobacco Pouch'),
(27555, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Drakkari Witch Doctor - Reinforced Junkbox');

-- Silverbrook Hunter (27546)
UPDATE `creature_template` SET `pickpocketloot` = 27546 WHERE (`entry` = 27546);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27546);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27546, 29448, 0, 14.58, 0, 1, 0, 1, 1, 'Silverbrook Hunter - Mag\'har Mild Cheese'),
(27546, 29450, 0, 10.42, 0, 1, 0, 1, 1, 'Silverbrook Hunter - Telaari Grapes'),
(27546, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Silverbrook Hunter - Runic Healing Potion'),
(27546, 33449, 0, 6.25, 0, 1, 0, 1, 1, 'Silverbrook Hunter - Crusty Flatbread'),
(27546, 36863, 0, 2.08, 0, 1, 0, 1, 1, 'Silverbrook Hunter - Decahedral Dwarven Dice'),
(27546, 37467, 0, 31.25, 0, 1, 0, 1, 1, 'Silverbrook Hunter - A Steamy Romance Novel: Forbidden Love'),
(27546, 38261, 0, 20.83, 0, 1, 0, 1, 1, 'Silverbrook Hunter - Bent House Key'),
(27546, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Silverbrook Hunter - Reinforced Junkbox');

-- Tattered Abomination (27797)
UPDATE `creature_template` SET `pickpocketloot` = 27797 WHERE (`entry` = 27797);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27797);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27797, 33452, 0, 62.5, 0, 1, 0, 1, 1, 'Tattered Abomination - Honey-Spiced Lichen'),
(27797, 38269, 0, 12.5, 0, 1, 0, 1, 1, 'Tattered Abomination - Soggy Handkerchief'),
(27797, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Tattered Abomination - Reinforced Junkbox');

-- Venture Co. Evacuee (27830)
UPDATE `creature_template` SET `pickpocketloot` = 27830 WHERE (`entry` = 27830);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27830);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27830, 29448, 0, 16.67, 0, 1, 0, 1, 1, 'Venture Co. Evacuee - Mag\'har Mild Cheese'),
(27830, 37467, 0, 50.0, 0, 1, 0, 1, 1, 'Venture Co. Evacuee - A Steamy Romance Novel: Forbidden Love'),
(27830, 38261, 0, 16.67, 0, 1, 0, 1, 1, 'Venture Co. Evacuee - Bent House Key'),
(27830, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Venture Co. Evacuee - Reinforced Junkbox');

-- Rampaging Geist (28026)
UPDATE `creature_template` SET `pickpocketloot` = 28026 WHERE (`entry` = 28026);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28026);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28026, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Rampaging Geist - Runic Healing Potion'),
(28026, 35947, 0, 44.44, 0, 1, 0, 1, 1, 'Rampaging Geist - Sparkling Frostcap'),
(28026, 38269, 0, 22.22, 0, 1, 0, 1, 1, 'Rampaging Geist - Soggy Handkerchief'),
(28026, 43575, 0, 44.44, 0, 1, 0, 1, 1, 'Rampaging Geist - Reinforced Junkbox');

-- Dark Rune Theurgist (27963)
UPDATE `creature_template` SET `pickpocketloot` = 27963 WHERE (`entry` = 27963);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27963);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27963, 33447, 0, 14.29, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Runic Healing Potion'),
(27963, 35953, 0, 19.05, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Mead Basted Caribou'),
(27963, 38260, 0, 38.1, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Empty Tobacco Pouch'),
(27963, 40202, 0, 9.52, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Sizzling Grizzly Flank'),
(27963, 43575, 0, 23.81, 0, 1, 0, 1, 1, 'Dark Rune Theurgist - Reinforced Junkbox');

-- Blighted Corpse (28101)
UPDATE `creature_template` SET `pickpocketloot` = 28101 WHERE (`entry` = 28101);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28101);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28101, 33447, 0, 16.67, 0, 1, 0, 1, 1, 'Blighted Corpse - Runic Healing Potion'),
(28101, 35947, 0, 16.67, 0, 1, 0, 1, 1, 'Blighted Corpse - Sparkling Frostcap'),
(28101, 38269, 0, 33.33, 0, 1, 0, 1, 1, 'Blighted Corpse - Soggy Handkerchief'),
(28101, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Blighted Corpse - Reinforced Junkbox');

-- Frenzyheart Hunter (28079)
UPDATE `creature_template` SET `pickpocketloot` = 28079 WHERE (`entry` = 28079);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28079);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28079, 33447, 0, 9.38, 0, 1, 0, 1, 1, 'Frenzyheart Hunter - Runic Healing Potion'),
(28079, 35953, 0, 18.75, 0, 1, 0, 1, 1, 'Frenzyheart Hunter - Mead Basted Caribou'),
(28079, 38260, 0, 34.38, 0, 1, 0, 1, 1, 'Frenzyheart Hunter - Empty Tobacco Pouch'),
(28079, 40202, 0, 9.38, 0, 1, 0, 1, 1, 'Frenzyheart Hunter - Sizzling Grizzly Flank'),
(28079, 43575, 0, 34.38, 0, 1, 0, 1, 1, 'Frenzyheart Hunter - Reinforced Junkbox');

-- Priest of Sseratus (28035)
UPDATE `creature_template` SET `pickpocketloot` = 28035 WHERE (`entry` = 28035);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28035);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28035, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Priest of Sseratus - Runic Healing Potion'),
(28035, 35953, 0, 33.33, 0, 1, 0, 1, 1, 'Priest of Sseratus - Mead Basted Caribou'),
(28035, 38260, 0, 38.89, 0, 1, 0, 1, 1, 'Priest of Sseratus - Empty Tobacco Pouch'),
(28035, 43575, 0, 16.67, 0, 1, 0, 1, 1, 'Priest of Sseratus - Reinforced Junkbox');

-- Champion of Sseratus (28036)
UPDATE `creature_template` SET `pickpocketloot` = 28036 WHERE (`entry` = 28036);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28036);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28036, 33447, 0, 9.09, 0, 1, 0, 1, 1, 'Champion of Sseratus - Runic Healing Potion'),
(28036, 35953, 0, 27.27, 0, 1, 0, 1, 1, 'Champion of Sseratus - Mead Basted Caribou'),
(28036, 36862, 0, 9.09, 0, 1, 0, 1, 1, 'Champion of Sseratus - Worn Troll Dice'),
(28036, 38260, 0, 27.27, 0, 1, 0, 1, 1, 'Champion of Sseratus - Empty Tobacco Pouch'),
(28036, 43575, 0, 27.27, 0, 1, 0, 1, 1, 'Champion of Sseratus - Reinforced Junkbox');

-- Dragonflayer Guardian (27927)
UPDATE `creature_template` SET `pickpocketloot` = 27927 WHERE (`entry` = 27927);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27927);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27927, 33449, 0, 14.29, 0, 1, 0, 1, 1, 'Dragonflayer Guardian - Crusty Flatbread'),
(27927, 33454, 0, 14.29, 0, 1, 0, 1, 1, 'Dragonflayer Guardian - Salted Venison'),
(27927, 38260, 0, 57.14, 0, 1, 0, 1, 1, 'Dragonflayer Guardian - Empty Tobacco Pouch'),
(27927, 38261, 0, 14.29, 0, 1, 0, 1, 1, 'Dragonflayer Guardian - Bent House Key');

-- Frenzyheart Spearbearer (28080)
UPDATE `creature_template` SET `pickpocketloot` = 28080 WHERE (`entry` = 28080);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28080);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28080, 35953, 0, 7.69, 0, 1, 0, 1, 1, 'Frenzyheart Spearbearer - Mead Basted Caribou'),
(28080, 36862, 0, 7.69, 0, 1, 0, 1, 1, 'Frenzyheart Spearbearer - Worn Troll Dice'),
(28080, 38260, 0, 46.15, 0, 1, 0, 1, 1, 'Frenzyheart Spearbearer - Empty Tobacco Pouch'),
(28080, 40202, 0, 7.69, 0, 1, 0, 1, 1, 'Frenzyheart Spearbearer - Sizzling Grizzly Flank'),
(28080, 43575, 0, 30.77, 0, 1, 0, 1, 1, 'Frenzyheart Spearbearer - Reinforced Junkbox');

-- Sparktouched Oracle (28112)
UPDATE `creature_template` SET `pickpocketloot` = 28112 WHERE (`entry` = 28112);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28112);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28112, 37452, 0, 33.33, 0, 1, 0, 1, 1, 'Sparktouched Oracle - Fatty Bluefin'),
(28112, 38273, 0, 22.22, 0, 1, 0, 1, 1, 'Sparktouched Oracle - Brain Coral'),
(28112, 38274, 0, 22.22, 0, 1, 0, 1, 1, 'Sparktouched Oracle - Large Snail Shell'),
(28112, 43575, 0, 22.22, 0, 1, 0, 1, 1, 'Sparktouched Oracle - Reinforced Junkbox');

-- Mistwhisper Warrior (28109)
UPDATE `creature_template` SET `pickpocketloot` = 28109 WHERE (`entry` = 28109);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28109);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28109, 37452, 0, 16.67, 0, 1, 0, 1, 1, 'Mistwhisper Warrior - Fatty Bluefin'),
(28109, 38273, 0, 58.33, 0, 1, 0, 1, 1, 'Mistwhisper Warrior - Brain Coral'),
(28109, 38274, 0, 25.0, 0, 1, 0, 1, 1, 'Mistwhisper Warrior - Large Snail Shell');

-- Dark Rune Warrior (27960)
UPDATE `creature_template` SET `pickpocketloot` = 27960 WHERE (`entry` = 27960);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27960);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27960, 33447, 0, 10.53, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Runic Healing Potion'),
(27960, 35953, 0, 36.84, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Mead Basted Caribou'),
(27960, 38260, 0, 15.79, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Empty Tobacco Pouch'),
(27960, 40202, 0, 5.26, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Sizzling Grizzly Flank'),
(27960, 43575, 0, 42.11, 0, 1, 0, 1, 1, 'Dark Rune Warrior - Reinforced Junkbox');

-- Frenzyheart Ravager (28078)
UPDATE `creature_template` SET `pickpocketloot` = 28078 WHERE (`entry` = 28078);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28078);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28078, 33447, 0, 8.89, 0, 1, 0, 1, 1, 'Frenzyheart Ravager - Runic Healing Potion'),
(28078, 35953, 0, 20.0, 0, 1, 0, 1, 1, 'Frenzyheart Ravager - Mead Basted Caribou'),
(28078, 38260, 0, 35.56, 0, 1, 0, 1, 1, 'Frenzyheart Ravager - Empty Tobacco Pouch'),
(28078, 40202, 0, 13.33, 0, 1, 0, 1, 1, 'Frenzyheart Ravager - Sizzling Grizzly Flank'),
(28078, 43575, 0, 26.67, 0, 1, 0, 1, 1, 'Frenzyheart Ravager - Reinforced Junkbox');

-- Dark Rune Elementalist (27962)
UPDATE `creature_template` SET `pickpocketloot` = 27962 WHERE (`entry` = 27962);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27962);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27962, 33447, 0, 37.5, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Runic Healing Potion'),
(27962, 38260, 0, 50.0, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Empty Tobacco Pouch'),
(27962, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Dark Rune Elementalist - Reinforced Junkbox');

-- Snowblind Ghoul (28218)
UPDATE `creature_template` SET `pickpocketloot` = 28218 WHERE (`entry` = 28218);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28218);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28218, 33447, 0, 15.14, 0, 1, 0, 1, 1, 'Snowblind Ghoul - Runic Healing Potion'),
(28218, 35947, 0, 27.29, 0, 1, 0, 1, 1, 'Snowblind Ghoul - Sparkling Frostcap'),
(28218, 38269, 0, 37.05, 0, 1, 0, 1, 1, 'Snowblind Ghoul - Soggy Handkerchief'),
(28218, 43575, 0, 31.47, 0, 1, 0, 1, 1, 'Snowblind Ghoul - Reinforced Junkbox');

-- Frostbitten Corpse (28220)
UPDATE `creature_template` SET `pickpocketloot` = 28220 WHERE (`entry` = 28220);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28220);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28220, 33447, 0, 12.02, 0, 1, 0, 1, 1, 'Frostbitten Corpse - Runic Healing Potion'),
(28220, 35947, 0, 25.4, 0, 1, 0, 1, 1, 'Frostbitten Corpse - Sparkling Frostcap'),
(28220, 38269, 0, 34.92, 0, 1, 0, 1, 1, 'Frostbitten Corpse - Soggy Handkerchief'),
(28220, 43575, 0, 36.96, 0, 1, 0, 1, 1, 'Frostbitten Corpse - Reinforced Junkbox');

-- Venture Co. Ruffian (28124)
UPDATE `creature_template` SET `pickpocketloot` = 28124 WHERE (`entry` = 28124);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28124);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28124, 33447, 0, 18.75, 0, 1, 0, 1, 1, 'Venture Co. Ruffian - Runic Healing Potion'),
(28124, 35953, 0, 21.88, 0, 1, 0, 1, 1, 'Venture Co. Ruffian - Mead Basted Caribou'),
(28124, 38260, 0, 28.12, 0, 1, 0, 1, 1, 'Venture Co. Ruffian - Empty Tobacco Pouch'),
(28124, 40202, 0, 9.38, 0, 1, 0, 1, 1, 'Venture Co. Ruffian - Sizzling Grizzly Flank'),
(28124, 43575, 0, 34.38, 0, 1, 0, 1, 1, 'Venture Co. Ruffian - Reinforced Junkbox');

-- Drakkari Water Binder (28303)
UPDATE `creature_template` SET `pickpocketloot` = 28303 WHERE (`entry` = 28303);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28303);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28303, 33447, 0, 15.91, 0, 1, 0, 1, 1, 'Drakkari Water Binder - Runic Healing Potion'),
(28303, 35953, 0, 9.09, 0, 1, 0, 1, 1, 'Drakkari Water Binder - Mead Basted Caribou'),
(28303, 36862, 0, 2.27, 0, 1, 0, 1, 1, 'Drakkari Water Binder - Worn Troll Dice'),
(28303, 38260, 0, 40.91, 0, 1, 0, 1, 1, 'Drakkari Water Binder - Empty Tobacco Pouch'),
(28303, 40202, 0, 15.91, 0, 1, 0, 1, 1, 'Drakkari Water Binder - Sizzling Grizzly Flank'),
(28303, 43575, 0, 34.09, 0, 1, 0, 1, 1, 'Drakkari Water Binder - Reinforced Junkbox');

-- Venture Co. Excavator (28123)
UPDATE `creature_template` SET `pickpocketloot` = 28123 WHERE (`entry` = 28123);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28123);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28123, 33447, 0, 13.51, 0, 1, 0, 1, 1, 'Venture Co. Excavator - Runic Healing Potion'),
(28123, 35953, 0, 8.11, 0, 1, 0, 1, 1, 'Venture Co. Excavator - Mead Basted Caribou'),
(28123, 38260, 0, 29.73, 0, 1, 0, 1, 1, 'Venture Co. Excavator - Empty Tobacco Pouch'),
(28123, 40202, 0, 14.86, 0, 1, 0, 1, 1, 'Venture Co. Excavator - Sizzling Grizzly Flank'),
(28123, 43575, 0, 44.59, 0, 1, 0, 1, 1, 'Venture Co. Excavator - Reinforced Junkbox');

-- Frenzyheart Scavenger (28081)
UPDATE `creature_template` SET `pickpocketloot` = 28081 WHERE (`entry` = 28081);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28081);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28081, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Frenzyheart Scavenger - Runic Healing Potion'),
(28081, 35953, 0, 16.67, 0, 1, 0, 1, 1, 'Frenzyheart Scavenger - Mead Basted Caribou'),
(28081, 38260, 0, 25.0, 0, 1, 0, 1, 1, 'Frenzyheart Scavenger - Empty Tobacco Pouch'),
(28081, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Frenzyheart Scavenger - Reinforced Junkbox');

-- Mistwhisper Oracle (28110)
UPDATE `creature_template` SET `pickpocketloot` = 28110 WHERE (`entry` = 28110);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28110);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28110, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Mistwhisper Oracle - Runic Healing Potion'),
(28110, 37452, 0, 12.5, 0, 1, 0, 1, 1, 'Mistwhisper Oracle - Fatty Bluefin'),
(28110, 38273, 0, 12.5, 0, 1, 0, 1, 1, 'Mistwhisper Oracle - Brain Coral'),
(28110, 38274, 0, 25.0, 0, 1, 0, 1, 1, 'Mistwhisper Oracle - Large Snail Shell'),
(28110, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Mistwhisper Oracle - Reinforced Junkbox');

-- Jin'Alai Warrior (28388)
UPDATE `creature_template` SET `pickpocketloot` = 28388 WHERE (`entry` = 28388);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28388);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28388, 33447, 0, 21.31, 0, 1, 0, 1, 1, 'Jin\'Alai Warrior - Runic Healing Potion'),
(28388, 35953, 0, 11.48, 0, 1, 0, 1, 1, 'Jin\'Alai Warrior - Mead Basted Caribou'),
(28388, 36862, 0, 9.84, 0, 1, 0, 1, 1, 'Jin\'Alai Warrior - Worn Troll Dice'),
(28388, 38260, 0, 32.79, 0, 1, 0, 1, 1, 'Jin\'Alai Warrior - Empty Tobacco Pouch'),
(28388, 40202, 0, 11.48, 0, 1, 0, 1, 1, 'Jin\'Alai Warrior - Sizzling Grizzly Flank'),
(28388, 43575, 0, 18.03, 0, 1, 0, 1, 1, 'Jin\'Alai Warrior - Reinforced Junkbox');

-- Hath'ar Necromagus (28257)
UPDATE `creature_template` SET `pickpocketloot` = 28257 WHERE (`entry` = 28257);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28257);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28257, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Hath\'ar Necromagus - Runic Healing Potion'),
(28257, 35947, 0, 11.11, 0, 1, 0, 1, 1, 'Hath\'ar Necromagus - Sparkling Frostcap'),
(28257, 43575, 0, 22.22, 0, 1, 0, 1, 1, 'Hath\'ar Necromagus - Reinforced Junkbox'),
(28257, 43576, 0, 33.33, 0, 1, 0, 1, 1, 'Hath\'ar Necromagus - Chitin Polish'),
(28257, 43577, 0, 33.33, 0, 1, 0, 1, 1, 'Hath\'ar Necromagus - Carapace Cleanser');

-- Har'koan Subduer (28403)
UPDATE `creature_template` SET `pickpocketloot` = 28403 WHERE (`entry` = 28403);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28403);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28403, 33447, 0, 9.38, 0, 1, 0, 1, 1, 'Har\'koan Subduer - Runic Healing Potion'),
(28403, 35953, 0, 20.31, 0, 1, 0, 1, 1, 'Har\'koan Subduer - Mead Basted Caribou'),
(28403, 36862, 0, 1.56, 0, 1, 0, 1, 1, 'Har\'koan Subduer - Worn Troll Dice'),
(28403, 38260, 0, 40.62, 0, 1, 0, 1, 1, 'Har\'koan Subduer - Empty Tobacco Pouch'),
(28403, 40202, 0, 9.38, 0, 1, 0, 1, 1, 'Har\'koan Subduer - Sizzling Grizzly Flank'),
(28403, 43575, 0, 32.81, 0, 1, 0, 1, 1, 'Har\'koan Subduer - Reinforced Junkbox');

-- Cultist Infiltrator (28373)
UPDATE `creature_template` SET `pickpocketloot` = 28373 WHERE (`entry` = 28373);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28373);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28373, 33447, 0, 14.63, 0, 1, 0, 1, 1, 'Cultist Infiltrator - Runic Healing Potion'),
(28373, 35948, 0, 4.88, 0, 1, 0, 1, 1, 'Cultist Infiltrator - Savory Snowplum'),
(28373, 35950, 0, 9.76, 0, 1, 0, 1, 1, 'Cultist Infiltrator - Sweet Potato Bread'),
(28373, 35952, 0, 7.32, 0, 1, 0, 1, 1, 'Cultist Infiltrator - Briny Hardcheese'),
(28373, 37467, 0, 34.15, 0, 1, 0, 1, 1, 'Cultist Infiltrator - A Steamy Romance Novel: Forbidden Love'),
(28373, 38261, 0, 12.2, 0, 1, 0, 1, 1, 'Cultist Infiltrator - Bent House Key'),
(28373, 43575, 0, 26.83, 0, 1, 0, 1, 1, 'Cultist Infiltrator - Reinforced Junkbox');

-- Cultist Saboteur (28538)
UPDATE `creature_template` SET `pickpocketloot` = 28538 WHERE (`entry` = 28538);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28538);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28538, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Cultist Saboteur - Runic Healing Potion'),
(28538, 35948, 0, 12.5, 0, 1, 0, 1, 1, 'Cultist Saboteur - Savory Snowplum'),
(28538, 37467, 0, 37.5, 0, 1, 0, 1, 1, 'Cultist Saboteur - A Steamy Romance Novel: Forbidden Love'),
(28538, 38261, 0, 12.5, 0, 1, 0, 1, 1, 'Cultist Saboteur - Bent House Key'),
(28538, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Cultist Saboteur - Reinforced Junkbox');

-- Ymirjar Necromancer (28368)
UPDATE `creature_template` SET `pickpocketloot` = 28368 WHERE (`entry` = 28368);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28368);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28368, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Runic Healing Potion'),
(28368, 35953, 0, 16.67, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Mead Basted Caribou'),
(28368, 38260, 0, 25.0, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Empty Tobacco Pouch'),
(28368, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Ymirjar Necromancer - Reinforced Junkbox');

-- Priest of Rhunok (28417)
UPDATE `creature_template` SET `pickpocketloot` = 28417 WHERE (`entry` = 28417);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28417);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28417, 33447, 0, 34.88, 0, 1, 0, 1, 1, 'Priest of Rhunok - Runic Healing Potion'),
(28417, 35953, 0, 6.98, 0, 1, 0, 1, 1, 'Priest of Rhunok - Mead Basted Caribou'),
(28417, 36862, 0, 4.65, 0, 1, 0, 1, 1, 'Priest of Rhunok - Worn Troll Dice'),
(28417, 38260, 0, 23.26, 0, 1, 0, 1, 1, 'Priest of Rhunok - Empty Tobacco Pouch'),
(28417, 40202, 0, 16.28, 0, 1, 0, 1, 1, 'Priest of Rhunok - Sizzling Grizzly Flank'),
(28417, 43575, 0, 25.58, 0, 1, 0, 1, 1, 'Priest of Rhunok - Reinforced Junkbox');

-- Drakkari Bear Trapper (28418)
UPDATE `creature_template` SET `pickpocketloot` = 28418 WHERE (`entry` = 28418);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28418);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28418, 33447, 0, 5.88, 0, 1, 0, 1, 1, 'Drakkari Bear Trapper - Runic Healing Potion'),
(28418, 35953, 0, 11.76, 0, 1, 0, 1, 1, 'Drakkari Bear Trapper - Mead Basted Caribou'),
(28418, 38260, 0, 52.94, 0, 1, 0, 1, 1, 'Drakkari Bear Trapper - Empty Tobacco Pouch'),
(28418, 40202, 0, 17.65, 0, 1, 0, 1, 1, 'Drakkari Bear Trapper - Sizzling Grizzly Flank'),
(28418, 43575, 0, 23.53, 0, 1, 0, 1, 1, 'Drakkari Bear Trapper - Reinforced Junkbox');

-- Withered Troll (28519)
UPDATE `creature_template` SET `pickpocketloot` = 28519 WHERE (`entry` = 28519);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28519);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28519, 33447, 0, 6.45, 0, 1, 0, 1, 1, 'Withered Troll - Runic Healing Potion'),
(28519, 33452, 0, 32.26, 0, 1, 0, 1, 1, 'Withered Troll - Honey-Spiced Lichen'),
(28519, 38269, 0, 35.48, 0, 1, 0, 1, 1, 'Withered Troll - Soggy Handkerchief'),
(28519, 43575, 0, 29.03, 0, 1, 0, 1, 1, 'Withered Troll - Reinforced Junkbox');

-- Jin'Alai Medicine Man (28504)
UPDATE `creature_template` SET `pickpocketloot` = 28504 WHERE (`entry` = 28504);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28504);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28504, 33447, 0, 11.9, 0, 1, 0, 1, 1, 'Jin\'Alai Medicine Man - Runic Healing Potion'),
(28504, 35953, 0, 23.81, 0, 1, 0, 1, 1, 'Jin\'Alai Medicine Man - Mead Basted Caribou'),
(28504, 38260, 0, 16.67, 0, 1, 0, 1, 1, 'Jin\'Alai Medicine Man - Empty Tobacco Pouch'),
(28504, 40202, 0, 21.43, 0, 1, 0, 1, 1, 'Jin\'Alai Medicine Man - Sizzling Grizzly Flank'),
(28504, 43575, 0, 35.71, 0, 1, 0, 1, 1, 'Jin\'Alai Medicine Man - Reinforced Junkbox');

-- Rhunok's Tormentor (28575)
UPDATE `creature_template` SET `pickpocketloot` = 28575 WHERE (`entry` = 28575);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28575);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28575, 38260, 0, 40.0, 0, 1, 0, 1, 1, 'Rhunok\'s Tormentor - Empty Tobacco Pouch'),
(28575, 40202, 0, 20.0, 0, 1, 0, 1, 1, 'Rhunok\'s Tormentor - Sizzling Grizzly Flank'),
(28575, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Rhunok\'s Tormentor - Reinforced Junkbox');

-- Hardened Steel Berserker (28579)
UPDATE `creature_template` SET `pickpocketloot` = 28579 WHERE (`entry` = 28579);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28579);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28579, 38260, 0, 25.0, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Empty Tobacco Pouch'),
(28579, 40202, 0, 12.5, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Sizzling Grizzly Flank'),
(28579, 43575, 0, 75.0, 0, 1, 0, 1, 1, 'Hardened Steel Berserker - Reinforced Junkbox');

-- Heb'Drakkar Headhunter (28600)
UPDATE `creature_template` SET `pickpocketloot` = 28600 WHERE (`entry` = 28600);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28600);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28600, 33447, 0, 13.79, 0, 1, 0, 1, 1, 'Heb\'Drakkar Headhunter - Runic Healing Potion'),
(28600, 35953, 0, 13.79, 0, 1, 0, 1, 1, 'Heb\'Drakkar Headhunter - Mead Basted Caribou'),
(28600, 38260, 0, 37.93, 0, 1, 0, 1, 1, 'Heb\'Drakkar Headhunter - Empty Tobacco Pouch'),
(28600, 40202, 0, 13.79, 0, 1, 0, 1, 1, 'Heb\'Drakkar Headhunter - Sizzling Grizzly Flank'),
(28600, 43575, 0, 31.03, 0, 1, 0, 1, 1, 'Heb\'Drakkar Headhunter - Reinforced Junkbox');

-- Hardened Steel Skycaller (28580)
UPDATE `creature_template` SET `pickpocketloot` = 28580 WHERE (`entry` = 28580);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28580);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28580, 33447, 0, 10.0, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Runic Healing Potion'),
(28580, 35953, 0, 40.0, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Mead Basted Caribou'),
(28580, 38260, 0, 60.0, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Empty Tobacco Pouch'),
(28580, 43575, 0, 10.0, 0, 1, 0, 1, 1, 'Hardened Steel Skycaller - Reinforced Junkbox');

-- Hardened Steel Reaver (28578)
UPDATE `creature_template` SET `pickpocketloot` = 28578 WHERE (`entry` = 28578);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28578);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28578, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Runic Healing Potion'),
(28578, 35953, 0, 33.33, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Mead Basted Caribou'),
(28578, 38260, 0, 41.67, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Empty Tobacco Pouch'),
(28578, 40202, 0, 8.33, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Sizzling Grizzly Flank'),
(28578, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Hardened Steel Reaver - Reinforced Junkbox');

-- Stormforged Mender (28582)
UPDATE `creature_template` SET `pickpocketloot` = 28582 WHERE (`entry` = 28582);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28582);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28582, 33447, 0, 7.69, 0, 1, 0, 1, 1, 'Stormforged Mender - Runic Healing Potion'),
(28582, 38260, 0, 46.15, 0, 1, 0, 1, 1, 'Stormforged Mender - Empty Tobacco Pouch'),
(28582, 40202, 0, 11.54, 0, 1, 0, 1, 1, 'Stormforged Mender - Sizzling Grizzly Flank'),
(28582, 43575, 0, 42.31, 0, 1, 0, 1, 1, 'Stormforged Mender - Reinforced Junkbox');

-- Quetz'lun Worshipper (28747)
UPDATE `creature_template` SET `pickpocketloot` = 28747 WHERE (`entry` = 28747);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28747);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28747, 33447, 0, 50.0, 0, 1, 0, 1, 1, 'Quetz\'lun Worshipper - Runic Healing Potion'),
(28747, 38260, 0, 37.5, 0, 1, 0, 1, 1, 'Quetz\'lun Worshipper - Empty Tobacco Pouch'),
(28747, 40202, 0, 12.5, 0, 1, 0, 1, 1, 'Quetz\'lun Worshipper - Sizzling Grizzly Flank'),
(28747, 43575, 0, 12.5, 0, 1, 0, 1, 1, 'Quetz\'lun Worshipper - Reinforced Junkbox');

-- Artruis the Heartless (28659)
UPDATE `creature_template` SET `pickpocketloot` = 28659 WHERE (`entry` = 28659);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28659);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28659, 33447, 0, 33.33, 0, 1, 0, 1, 1, 'Artruis the Heartless - Runic Healing Potion'),
(28659, 38269, 0, 66.67, 0, 1, 0, 1, 1, 'Artruis the Heartless - Soggy Handkerchief');

-- Akali Subduer (28988)
UPDATE `creature_template` SET `pickpocketloot` = 28988 WHERE (`entry` = 28988);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28988);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28988, 35953, 0, 21.43, 0, 1, 0, 1, 1, 'Akali Subduer - Mead Basted Caribou'),
(28988, 36862, 0, 7.14, 0, 1, 0, 1, 1, 'Akali Subduer - Worn Troll Dice'),
(28988, 38260, 0, 28.57, 0, 1, 0, 1, 1, 'Akali Subduer - Empty Tobacco Pouch'),
(28988, 40202, 0, 14.29, 0, 1, 0, 1, 1, 'Akali Subduer - Sizzling Grizzly Flank'),
(28988, 43575, 0, 42.86, 0, 1, 0, 1, 1, 'Akali Subduer - Reinforced Junkbox');

-- Onslaught Harbor Guard (29330)
UPDATE `creature_template` SET `pickpocketloot` = 29330 WHERE (`entry` = 29330);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29330);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29330, 33447, 0, 10.57, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - Runic Healing Potion'),
(29330, 35948, 0, 6.39, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - Savory Snowplum'),
(29330, 35950, 0, 7.86, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - Sweet Potato Bread'),
(29330, 35952, 0, 6.14, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - Briny Hardcheese'),
(29330, 36863, 0, 0.25, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - Decahedral Dwarven Dice'),
(29330, 37467, 0, 31.7, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - A Steamy Romance Novel: Forbidden Love'),
(29330, 38261, 0, 13.51, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - Bent House Key'),
(29330, 43575, 0, 39.56, 0, 1, 0, 1, 1, 'Onslaught Harbor Guard - Reinforced Junkbox');

-- Lost Drakkari Spirit (29129)
UPDATE `creature_template` SET `pickpocketloot` = 29129 WHERE (`entry` = 29129);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29129);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29129, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Lost Drakkari Spirit - Runic Healing Potion'),
(29129, 35947, 0, 50.0, 0, 1, 0, 1, 1, 'Lost Drakkari Spirit - Sparkling Frostcap'),
(29129, 38269, 0, 38.89, 0, 1, 0, 1, 1, 'Lost Drakkari Spirit - Soggy Handkerchief'),
(29129, 43575, 0, 5.56, 0, 1, 0, 1, 1, 'Lost Drakkari Spirit - Reinforced Junkbox');

-- Drakkari Native (29211)
UPDATE `creature_template` SET `pickpocketloot` = 29211 WHERE (`entry` = 29211);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29211);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29211, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Drakkari Native - Runic Healing Potion'),
(29211, 35953, 0, 8.33, 0, 1, 0, 1, 1, 'Drakkari Native - Mead Basted Caribou'),
(29211, 36862, 0, 8.33, 0, 1, 0, 1, 1, 'Drakkari Native - Worn Troll Dice'),
(29211, 38260, 0, 50.0, 0, 1, 0, 1, 1, 'Drakkari Native - Empty Tobacco Pouch'),
(29211, 40202, 0, 16.67, 0, 1, 0, 1, 1, 'Drakkari Native - Sizzling Grizzly Flank'),
(29211, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Drakkari Native - Reinforced Junkbox');

-- Stormforged Tactician (28581)
UPDATE `creature_template` SET `pickpocketloot` = 28581 WHERE (`entry` = 28581);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28581);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28581, 33447, 0, 13.64, 0, 1, 0, 1, 1, 'Stormforged Tactician - Runic Healing Potion'),
(28581, 35953, 0, 18.18, 0, 1, 0, 1, 1, 'Stormforged Tactician - Mead Basted Caribou'),
(28581, 38260, 0, 36.36, 0, 1, 0, 1, 1, 'Stormforged Tactician - Empty Tobacco Pouch'),
(28581, 40202, 0, 13.64, 0, 1, 0, 1, 1, 'Stormforged Tactician - Sizzling Grizzly Flank'),
(28581, 43575, 0, 18.18, 0, 1, 0, 1, 1, 'Stormforged Tactician - Reinforced Junkbox');

-- Sifreldar Runekeeper (29331)
UPDATE `creature_template` SET `pickpocketloot` = 29331 WHERE (`entry` = 29331);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29331);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29331, 35953, 0, 12.5, 0, 1, 0, 1, 1, 'Sifreldar Runekeeper - Mead Basted Caribou'),
(29331, 40202, 0, 37.5, 0, 1, 0, 1, 1, 'Sifreldar Runekeeper - Sizzling Grizzly Flank'),
(29331, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Sifreldar Runekeeper - Reinforced Junkbox');

-- Sifreldar Storm Maiden (29323)
UPDATE `creature_template` SET `pickpocketloot` = 29323 WHERE (`entry` = 29323);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29323);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29323, 33447, 0, 10.34, 0, 1, 0, 1, 1, 'Sifreldar Storm Maiden - Runic Healing Potion'),
(29323, 35953, 0, 10.34, 0, 1, 0, 1, 1, 'Sifreldar Storm Maiden - Mead Basted Caribou'),
(29323, 38260, 0, 39.66, 0, 1, 0, 1, 1, 'Sifreldar Storm Maiden - Empty Tobacco Pouch'),
(29323, 40202, 0, 12.07, 0, 1, 0, 1, 1, 'Sifreldar Storm Maiden - Sizzling Grizzly Flank'),
(29323, 43575, 0, 37.93, 0, 1, 0, 1, 1, 'Sifreldar Storm Maiden - Reinforced Junkbox');

-- Stormforged Runeshaper (28836)
UPDATE `creature_template` SET `pickpocketloot` = 28836 WHERE (`entry` = 28836);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28836);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28836, 33447, 0, 5.26, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Runic Healing Potion'),
(28836, 35953, 0, 15.79, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Mead Basted Caribou'),
(28836, 38260, 0, 31.58, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Empty Tobacco Pouch'),
(28836, 40202, 0, 5.26, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Sizzling Grizzly Flank'),
(28836, 43575, 0, 57.89, 0, 1, 0, 1, 1, 'Stormforged Runeshaper - Reinforced Junkbox');

-- Onslaught Paladin (29329)
UPDATE `creature_template` SET `pickpocketloot` = 29329 WHERE (`entry` = 29329);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29329);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29329, 33447, 0, 7.69, 0, 1, 0, 1, 1, 'Onslaught Paladin - Runic Healing Potion'),
(29329, 35948, 0, 9.62, 0, 1, 0, 1, 1, 'Onslaught Paladin - Savory Snowplum'),
(29329, 35950, 0, 9.62, 0, 1, 0, 1, 1, 'Onslaught Paladin - Sweet Potato Bread'),
(29329, 35952, 0, 17.31, 0, 1, 0, 1, 1, 'Onslaught Paladin - Briny Hardcheese'),
(29329, 37467, 0, 34.62, 0, 1, 0, 1, 1, 'Onslaught Paladin - A Steamy Romance Novel: Forbidden Love'),
(29329, 38261, 0, 13.46, 0, 1, 0, 1, 1, 'Onslaught Paladin - Bent House Key'),
(29329, 43575, 0, 23.08, 0, 1, 0, 1, 1, 'Onslaught Paladin - Reinforced Junkbox');

-- Claw of Har'koa (28402)
UPDATE `creature_template` SET `pickpocketloot` = 28402 WHERE (`entry` = 28402);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28402);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28402, 33447, 0, 18.75, 0, 1, 0, 1, 1, 'Claw of Har\'koa - Runic Healing Potion'),
(28402, 35953, 0, 17.19, 0, 1, 0, 1, 1, 'Claw of Har\'koa - Mead Basted Caribou'),
(28402, 36862, 0, 1.56, 0, 1, 0, 1, 1, 'Claw of Har\'koa - Worn Troll Dice'),
(28402, 38260, 0, 31.25, 0, 1, 0, 1, 1, 'Claw of Har\'koa - Empty Tobacco Pouch'),
(28402, 40202, 0, 4.69, 0, 1, 0, 1, 1, 'Claw of Har\'koa - Sizzling Grizzly Flank'),
(28402, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Claw of Har\'koa - Reinforced Junkbox');

-- Hath'ar Broodmaster (28412)
UPDATE `creature_template` SET `pickpocketloot` = 28412 WHERE (`entry` = 28412);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28412);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28412, 33447, 0, 37.5, 0, 1, 0, 1, 1, 'Hath\'ar Broodmaster - Runic Healing Potion'),
(28412, 35947, 0, 12.5, 0, 1, 0, 1, 1, 'Hath\'ar Broodmaster - Sparkling Frostcap'),
(28412, 43575, 0, 12.5, 0, 1, 0, 1, 1, 'Hath\'ar Broodmaster - Reinforced Junkbox'),
(28412, 43576, 0, 12.5, 0, 1, 0, 1, 1, 'Hath\'ar Broodmaster - Chitin Polish'),
(28412, 43577, 0, 50.0, 0, 1, 0, 1, 1, 'Hath\'ar Broodmaster - Carapace Cleanser');

-- Stormforged Champion (29370)
UPDATE `creature_template` SET `pickpocketloot` = 29370 WHERE (`entry` = 29370);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29370);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29370, 33447, 0, 8.0, 0, 1, 0, 1, 1, 'Stormforged Champion - Runic Healing Potion'),
(29370, 35948, 0, 4.0, 0, 1, 0, 1, 1, 'Stormforged Champion - Savory Snowplum'),
(29370, 35952, 0, 12.0, 0, 1, 0, 1, 1, 'Stormforged Champion - Briny Hardcheese'),
(29370, 37467, 0, 40.0, 0, 1, 0, 1, 1, 'Stormforged Champion - A Steamy Romance Novel: Forbidden Love'),
(29370, 38261, 0, 12.0, 0, 1, 0, 1, 1, 'Stormforged Champion - Bent House Key'),
(29370, 43575, 0, 24.0, 0, 1, 0, 1, 1, 'Stormforged Champion - Reinforced Junkbox');

-- Stormforged Raider (29377)
UPDATE `creature_template` SET `pickpocketloot` = 29377 WHERE (`entry` = 29377);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29377);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29377, 37467, 0, 50.0, 0, 1, 0, 1, 1, 'Stormforged Raider - A Steamy Romance Novel: Forbidden Love'),
(29377, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Stormforged Raider - Reinforced Junkbox');

-- Onslaught Raven Bishop (29338)
UPDATE `creature_template` SET `pickpocketloot` = 29338 WHERE (`entry` = 29338);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29338);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29338, 33447, 0, 10.0, 0, 1, 0, 1, 1, 'Onslaught Raven Bishop - Runic Healing Potion'),
(29338, 35948, 0, 9.0, 0, 1, 0, 1, 1, 'Onslaught Raven Bishop - Savory Snowplum'),
(29338, 35950, 0, 9.0, 0, 1, 0, 1, 1, 'Onslaught Raven Bishop - Sweet Potato Bread'),
(29338, 35952, 0, 7.0, 0, 1, 0, 1, 1, 'Onslaught Raven Bishop - Briny Hardcheese'),
(29338, 37467, 0, 29.0, 0, 1, 0, 1, 1, 'Onslaught Raven Bishop - A Steamy Romance Novel: Forbidden Love'),
(29338, 38261, 0, 15.0, 0, 1, 0, 1, 1, 'Onslaught Raven Bishop - Bent House Key'),
(29338, 43575, 0, 34.0, 0, 1, 0, 1, 1, 'Onslaught Raven Bishop - Reinforced Junkbox');

-- Savage Hill Scavenger (29404)
UPDATE `creature_template` SET `pickpocketloot` = 29404 WHERE (`entry` = 29404);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29404);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29404, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Savage Hill Scavenger - Runic Healing Potion'),
(29404, 38263, 0, 21.88, 0, 1, 0, 1, 1, 'Savage Hill Scavenger - Too-Small Armband'),
(29404, 38264, 0, 18.75, 0, 1, 0, 1, 1, 'Savage Hill Scavenger - A Very Pretty Rock'),
(29404, 40202, 0, 34.38, 0, 1, 0, 1, 1, 'Savage Hill Scavenger - Sizzling Grizzly Flank'),
(29404, 43575, 0, 15.62, 0, 1, 0, 1, 1, 'Savage Hill Scavenger - Reinforced Junkbox');

-- Captive Vrykul (29427)
UPDATE `creature_template` SET `pickpocketloot` = 29427 WHERE (`entry` = 29427);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29427);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29427, 33447, 0, 13.33, 0, 1, 0, 1, 1, 'Captive Vrykul - Runic Healing Potion'),
(29427, 35953, 0, 14.67, 0, 1, 0, 1, 1, 'Captive Vrykul - Mead Basted Caribou'),
(29427, 36862, 0, 4.0, 0, 1, 0, 1, 1, 'Captive Vrykul - Worn Troll Dice'),
(29427, 38260, 0, 36.0, 0, 1, 0, 1, 1, 'Captive Vrykul - Empty Tobacco Pouch'),
(29427, 40202, 0, 5.33, 0, 1, 0, 1, 1, 'Captive Vrykul - Sizzling Grizzly Flank'),
(29427, 43575, 0, 49.33, 0, 1, 0, 1, 1, 'Captive Vrykul - Reinforced Junkbox');

-- Vargul Slayer (29451)
UPDATE `creature_template` SET `pickpocketloot` = 29451 WHERE (`entry` = 29451);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29451);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29451, 33447, 0, 8.89, 0, 1, 0, 1, 1, 'Vargul Slayer - Runic Healing Potion'),
(29451, 35947, 0, 35.56, 0, 1, 0, 1, 1, 'Vargul Slayer - Sparkling Frostcap'),
(29451, 38269, 0, 37.78, 0, 1, 0, 1, 1, 'Vargul Slayer - Soggy Handkerchief'),
(29451, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Vargul Slayer - Reinforced Junkbox');

-- Hyldnir Overseer (29426)
UPDATE `creature_template` SET `pickpocketloot` = 29426 WHERE (`entry` = 29426);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29426);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29426, 35953, 0, 16.67, 0, 1, 0, 1, 1, 'Hyldnir Overseer - Mead Basted Caribou'),
(29426, 38260, 0, 16.67, 0, 1, 0, 1, 1, 'Hyldnir Overseer - Empty Tobacco Pouch'),
(29426, 40202, 0, 33.33, 0, 1, 0, 1, 1, 'Hyldnir Overseer - Sizzling Grizzly Flank'),
(29426, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Hyldnir Overseer - Reinforced Junkbox');

-- Snowblind Digger (29413)
UPDATE `creature_template` SET `pickpocketloot` = 29413 WHERE (`entry` = 29413);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29413);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29413, 33447, 0, 8.33, 0, 1, 0, 1, 1, 'Snowblind Digger - Runic Healing Potion'),
(29413, 38263, 0, 16.67, 0, 1, 0, 1, 1, 'Snowblind Digger - Too-Small Armband'),
(29413, 38264, 0, 27.78, 0, 1, 0, 1, 1, 'Snowblind Digger - A Very Pretty Rock'),
(29413, 40202, 0, 36.11, 0, 1, 0, 1, 1, 'Snowblind Digger - Sizzling Grizzly Flank'),
(29413, 43575, 0, 30.56, 0, 1, 0, 1, 1, 'Snowblind Digger - Reinforced Junkbox');

-- Heb'Drakkar Striker (28465)
UPDATE `creature_template` SET `pickpocketloot` = 28465 WHERE (`entry` = 28465);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 28465);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(28465, 33447, 0, 9.09, 0, 1, 0, 1, 1, 'Heb\'Drakkar Striker - Runic Healing Potion'),
(28465, 35953, 0, 36.36, 0, 1, 0, 1, 1, 'Heb\'Drakkar Striker - Mead Basted Caribou'),
(28465, 36862, 0, 9.09, 0, 1, 0, 1, 1, 'Heb\'Drakkar Striker - Worn Troll Dice'),
(28465, 38260, 0, 27.27, 0, 1, 0, 1, 1, 'Heb\'Drakkar Striker - Empty Tobacco Pouch'),
(28465, 43575, 0, 27.27, 0, 1, 0, 1, 1, 'Heb\'Drakkar Striker - Reinforced Junkbox');

-- Vargul Deathwaker (29449)
UPDATE `creature_template` SET `pickpocketloot` = 29449 WHERE (`entry` = 29449);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29449);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29449, 33447, 0, 10.53, 0, 1, 0, 1, 1, 'Vargul Deathwaker - Runic Healing Potion'),
(29449, 35947, 0, 31.58, 0, 1, 0, 1, 1, 'Vargul Deathwaker - Sparkling Frostcap'),
(29449, 38269, 0, 31.58, 0, 1, 0, 1, 1, 'Vargul Deathwaker - Soggy Handkerchief'),
(29449, 43575, 0, 42.11, 0, 1, 0, 1, 1, 'Vargul Deathwaker - Reinforced Junkbox');

-- Vargul Runelord (29450)
UPDATE `creature_template` SET `pickpocketloot` = 29450 WHERE (`entry` = 29450);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29450);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29450, 33447, 0, 14.29, 0, 1, 0, 1, 1, 'Vargul Runelord - Runic Healing Potion'),
(29450, 35947, 0, 28.57, 0, 1, 0, 1, 1, 'Vargul Runelord - Sparkling Frostcap'),
(29450, 38269, 0, 50.0, 0, 1, 0, 1, 1, 'Vargul Runelord - Soggy Handkerchief'),
(29450, 43575, 0, 35.71, 0, 1, 0, 1, 1, 'Vargul Runelord - Reinforced Junkbox');

-- Savage Hill Mystic (29622)
UPDATE `creature_template` SET `pickpocketloot` = 29622 WHERE (`entry` = 29622);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29622);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29622, 33447, 0, 4.76, 0, 1, 0, 1, 1, 'Savage Hill Mystic - Runic Healing Potion'),
(29622, 38263, 0, 28.57, 0, 1, 0, 1, 1, 'Savage Hill Mystic - Too-Small Armband'),
(29622, 38264, 0, 23.81, 0, 1, 0, 1, 1, 'Savage Hill Mystic - A Very Pretty Rock'),
(29622, 38266, 0, 4.76, 0, 1, 0, 1, 1, 'Savage Hill Mystic - Rotund Relic'),
(29622, 40202, 0, 42.86, 0, 1, 0, 1, 1, 'Savage Hill Mystic - Sizzling Grizzly Flank'),
(29622, 43575, 0, 9.52, 0, 1, 0, 1, 1, 'Savage Hill Mystic - Reinforced Junkbox');

-- Stormforged Tracker (29652)
UPDATE `creature_template` SET `pickpocketloot` = 29652 WHERE (`entry` = 29652);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29652);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29652, 35948, 0, 14.29, 0, 1, 0, 1, 1, 'Stormforged Tracker - Savory Snowplum'),
(29652, 35950, 0, 28.57, 0, 1, 0, 1, 1, 'Stormforged Tracker - Sweet Potato Bread'),
(29652, 37467, 0, 28.57, 0, 1, 0, 1, 1, 'Stormforged Tracker - A Steamy Romance Novel: Forbidden Love'),
(29652, 43575, 0, 57.14, 0, 1, 0, 1, 1, 'Stormforged Tracker - Reinforced Junkbox');

-- Valkyrion Aspirant (29569)
UPDATE `creature_template` SET `pickpocketloot` = 29569 WHERE (`entry` = 29569);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29569);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29569, 33447, 0, 14.14, 0, 1, 0, 1, 1, 'Valkyrion Aspirant - Runic Healing Potion'),
(29569, 35953, 0, 23.23, 0, 1, 0, 1, 1, 'Valkyrion Aspirant - Mead Basted Caribou'),
(29569, 36862, 0, 2.02, 0, 1, 0, 1, 1, 'Valkyrion Aspirant - Worn Troll Dice'),
(29569, 38260, 0, 21.21, 0, 1, 0, 1, 1, 'Valkyrion Aspirant - Empty Tobacco Pouch'),
(29569, 40202, 0, 10.1, 0, 1, 0, 1, 1, 'Valkyrion Aspirant - Sizzling Grizzly Flank'),
(29569, 43575, 0, 42.42, 0, 1, 0, 1, 1, 'Valkyrion Aspirant - Reinforced Junkbox');

-- Stormforged Pillager (29586)
UPDATE `creature_template` SET `pickpocketloot` = 29586 WHERE (`entry` = 29586);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29586);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29586, 33447, 0, 7.14, 0, 1, 0, 1, 1, 'Stormforged Pillager - Runic Healing Potion'),
(29586, 35948, 0, 7.14, 0, 1, 0, 1, 1, 'Stormforged Pillager - Savory Snowplum'),
(29586, 35950, 0, 7.14, 0, 1, 0, 1, 1, 'Stormforged Pillager - Sweet Potato Bread'),
(29586, 35952, 0, 7.14, 0, 1, 0, 1, 1, 'Stormforged Pillager - Briny Hardcheese'),
(29586, 37467, 0, 42.86, 0, 1, 0, 1, 1, 'Stormforged Pillager - A Steamy Romance Novel: Forbidden Love'),
(29586, 38261, 0, 17.86, 0, 1, 0, 1, 1, 'Stormforged Pillager - Bent House Key'),
(29586, 43575, 0, 25.0, 0, 1, 0, 1, 1, 'Stormforged Pillager - Reinforced Junkbox');

-- Savage Hill Brute (29623)
UPDATE `creature_template` SET `pickpocketloot` = 29623 WHERE (`entry` = 29623);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29623);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29623, 33447, 0, 7.69, 0, 1, 0, 1, 1, 'Savage Hill Brute - Runic Healing Potion'),
(29623, 38263, 0, 25.64, 0, 1, 0, 1, 1, 'Savage Hill Brute - Too-Small Armband'),
(29623, 38264, 0, 23.08, 0, 1, 0, 1, 1, 'Savage Hill Brute - A Very Pretty Rock'),
(29623, 40202, 0, 17.95, 0, 1, 0, 1, 1, 'Savage Hill Brute - Sizzling Grizzly Flank'),
(29623, 43575, 0, 38.46, 0, 1, 0, 1, 1, 'Savage Hill Brute - Reinforced Junkbox');

-- Vault Geist (29720)
UPDATE `creature_template` SET `pickpocketloot` = 29720 WHERE (`entry` = 29720);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29720);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29720, 35947, 0, 20.0, 0, 1, 0, 1, 1, 'Vault Geist - Sparkling Frostcap'),
(29720, 38269, 0, 40.0, 0, 1, 0, 1, 1, 'Vault Geist - Soggy Handkerchief'),
(29720, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Vault Geist - Reinforced Junkbox');

-- Drakuru Blood Drinker (29654)
UPDATE `creature_template` SET `pickpocketloot` = 29654 WHERE (`entry` = 29654);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29654);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29654, 33447, 0, 25.0, 0, 1, 0, 1, 1, 'Drakuru Blood Drinker - Runic Healing Potion'),
(29654, 33449, 0, 12.5, 0, 1, 0, 1, 1, 'Drakuru Blood Drinker - Crusty Flatbread'),
(29654, 38260, 0, 25.0, 0, 1, 0, 1, 1, 'Drakuru Blood Drinker - Empty Tobacco Pouch'),
(29654, 43575, 0, 62.5, 0, 1, 0, 1, 1, 'Drakuru Blood Drinker - Reinforced Junkbox');

-- Shadow Cultist (29717)
UPDATE `creature_template` SET `pickpocketloot` = 29717 WHERE (`entry` = 29717);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29717);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29717, 33447, 0, 10.0, 0, 1, 0, 1, 1, 'Shadow Cultist - Runic Healing Potion'),
(29717, 35948, 0, 20.0, 0, 1, 0, 1, 1, 'Shadow Cultist - Savory Snowplum'),
(29717, 35950, 0, 10.0, 0, 1, 0, 1, 1, 'Shadow Cultist - Sweet Potato Bread'),
(29717, 38261, 0, 70.0, 0, 1, 0, 1, 1, 'Shadow Cultist - Bent House Key'),
(29717, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Shadow Cultist - Reinforced Junkbox');

-- Onslaught Darkweaver (29614)
UPDATE `creature_template` SET `pickpocketloot` = 29614 WHERE (`entry` = 29614);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29614);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29614, 33447, 0, 14.29, 0, 1, 0, 1, 1, 'Onslaught Darkweaver - Runic Healing Potion'),
(29614, 35948, 0, 14.29, 0, 1, 0, 1, 1, 'Onslaught Darkweaver - Savory Snowplum'),
(29614, 35952, 0, 14.29, 0, 1, 0, 1, 1, 'Onslaught Darkweaver - Briny Hardcheese'),
(29614, 37467, 0, 28.57, 0, 1, 0, 1, 1, 'Onslaught Darkweaver - A Steamy Romance Novel: Forbidden Love'),
(29614, 38261, 0, 14.29, 0, 1, 0, 1, 1, 'Onslaught Darkweaver - Bent House Key'),
(29614, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Onslaught Darkweaver - Reinforced Junkbox');

-- Stormforged Loreseeker (29843)
UPDATE `creature_template` SET `pickpocketloot` = 29843 WHERE (`entry` = 29843);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29843);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29843, 33447, 0, 14.04, 0, 1, 0, 1, 1, 'Stormforged Loreseeker - Runic Healing Potion'),
(29843, 35948, 0, 12.28, 0, 1, 0, 1, 1, 'Stormforged Loreseeker - Savory Snowplum'),
(29843, 35950, 0, 5.26, 0, 1, 0, 1, 1, 'Stormforged Loreseeker - Sweet Potato Bread'),
(29843, 35952, 0, 8.77, 0, 1, 0, 1, 1, 'Stormforged Loreseeker - Briny Hardcheese'),
(29843, 37467, 0, 33.33, 0, 1, 0, 1, 1, 'Stormforged Loreseeker - A Steamy Romance Novel: Forbidden Love'),
(29843, 38261, 0, 12.28, 0, 1, 0, 1, 1, 'Stormforged Loreseeker - Bent House Key'),
(29843, 43575, 0, 24.56, 0, 1, 0, 1, 1, 'Stormforged Loreseeker - Reinforced Junkbox');

-- Stormforged Artificer (29376)
UPDATE `creature_template` SET `pickpocketloot` = 29376 WHERE (`entry` = 29376);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29376);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29376, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Stormforged Artificer - Runic Healing Potion'),
(29376, 35948, 0, 7.5, 0, 1, 0, 1, 1, 'Stormforged Artificer - Savory Snowplum'),
(29376, 35950, 0, 12.5, 0, 1, 0, 1, 1, 'Stormforged Artificer - Sweet Potato Bread'),
(29376, 35952, 0, 5.0, 0, 1, 0, 1, 1, 'Stormforged Artificer - Briny Hardcheese'),
(29376, 37467, 0, 35.0, 0, 1, 0, 1, 1, 'Stormforged Artificer - A Steamy Romance Novel: Forbidden Love'),
(29376, 38261, 0, 7.5, 0, 1, 0, 1, 1, 'Stormforged Artificer - Bent House Key'),
(29376, 43575, 0, 35.0, 0, 1, 0, 1, 1, 'Stormforged Artificer - Reinforced Junkbox');

-- Ruins Dweller (29920)
UPDATE `creature_template` SET `pickpocketloot` = 29920 WHERE (`entry` = 29920);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29920);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29920, 37452, 0, 33.33, 0, 1, 0, 1, 1, 'Ruins Dweller - Fatty Bluefin'),
(29920, 38273, 0, 41.67, 0, 1, 0, 1, 1, 'Ruins Dweller - Brain Coral'),
(29920, 38274, 0, 25.0, 0, 1, 0, 1, 1, 'Ruins Dweller - Large Snail Shell'),
(29920, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Ruins Dweller - Reinforced Junkbox');

-- Drakkari Earthshaker (29829)
UPDATE `creature_template` SET `pickpocketloot` = 29829 WHERE (`entry` = 29829);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29829);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29829, 33447, 0, 14.29, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Runic Healing Potion'),
(29829, 35953, 0, 14.29, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Mead Basted Caribou'),
(29829, 38260, 0, 42.86, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Empty Tobacco Pouch'),
(29829, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Drakkari Earthshaker - Reinforced Junkbox');

-- Stormforged Magus (29374)
UPDATE `creature_template` SET `pickpocketloot` = 29374 WHERE (`entry` = 29374);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29374);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29374, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Stormforged Magus - Runic Healing Potion'),
(29374, 35948, 0, 12.5, 0, 1, 0, 1, 1, 'Stormforged Magus - Savory Snowplum'),
(29374, 35950, 0, 25.0, 0, 1, 0, 1, 1, 'Stormforged Magus - Sweet Potato Bread'),
(29374, 37467, 0, 37.5, 0, 1, 0, 1, 1, 'Stormforged Magus - A Steamy Romance Novel: Forbidden Love'),
(29374, 38261, 0, 12.5, 0, 1, 0, 1, 1, 'Stormforged Magus - Bent House Key'),
(29374, 43575, 0, 12.5, 0, 1, 0, 1, 1, 'Stormforged Magus - Reinforced Junkbox');

-- Mjordin Combatant (30037)
UPDATE `creature_template` SET `pickpocketloot` = 30037 WHERE (`entry` = 30037);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30037);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30037, 33447, 0, 7.5, 0, 1, 0, 1, 1, 'Mjordin Combatant - Runic Healing Potion'),
(30037, 35953, 0, 17.5, 0, 1, 0, 1, 1, 'Mjordin Combatant - Mead Basted Caribou'),
(30037, 38260, 0, 60.0, 0, 1, 0, 1, 1, 'Mjordin Combatant - Empty Tobacco Pouch'),
(30037, 40202, 0, 7.5, 0, 1, 0, 1, 1, 'Mjordin Combatant - Sizzling Grizzly Flank'),
(30037, 43575, 0, 20.0, 0, 1, 0, 1, 1, 'Mjordin Combatant - Reinforced Junkbox');

-- Restless Frostborn Warrior (30135)
UPDATE `creature_template` SET `pickpocketloot` = 30135 WHERE (`entry` = 30135);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30135);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30135, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Restless Frostborn Warrior - Runic Healing Potion'),
(30135, 35947, 0, 25.93, 0, 1, 0, 1, 1, 'Restless Frostborn Warrior - Sparkling Frostcap'),
(30135, 38269, 0, 40.74, 0, 1, 0, 1, 1, 'Restless Frostborn Warrior - Soggy Handkerchief'),
(30135, 43575, 0, 25.93, 0, 1, 0, 1, 1, 'Restless Frostborn Warrior - Reinforced Junkbox');

-- Valhalas Vargul (30250)
UPDATE `creature_template` SET `pickpocketloot` = 30250 WHERE (`entry` = 30250);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30250);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30250, 33447, 0, 14.29, 0, 1, 0, 1, 1, 'Valhalas Vargul - Runic Healing Potion'),
(30250, 35947, 0, 30.61, 0, 1, 0, 1, 1, 'Valhalas Vargul - Sparkling Frostcap'),
(30250, 38269, 0, 36.73, 0, 1, 0, 1, 1, 'Valhalas Vargul - Soggy Handkerchief'),
(30250, 43575, 0, 24.49, 0, 1, 0, 1, 1, 'Valhalas Vargul - Reinforced Junkbox');

-- Exhausted Vrykul (30146)
UPDATE `creature_template` SET `pickpocketloot` = 30146 WHERE (`entry` = 30146);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30146);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30146, 33447, 0, 16.67, 0, 1, 0, 1, 1, 'Exhausted Vrykul - Runic Healing Potion'),
(30146, 35953, 0, 16.67, 0, 1, 0, 1, 1, 'Exhausted Vrykul - Mead Basted Caribou'),
(30146, 38260, 0, 28.57, 0, 1, 0, 1, 1, 'Exhausted Vrykul - Empty Tobacco Pouch'),
(30146, 40202, 0, 11.9, 0, 1, 0, 1, 1, 'Exhausted Vrykul - Sizzling Grizzly Flank'),
(30146, 43575, 0, 42.86, 0, 1, 0, 1, 1, 'Exhausted Vrykul - Reinforced Junkbox');

-- Apprentice Osterkilgr (30409)
UPDATE `creature_template` SET `pickpocketloot` = 30409 WHERE (`entry` = 30409);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30409);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30409, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Apprentice Osterkilgr - Runic Healing Potion'),
(30409, 35953, 0, 11.11, 0, 1, 0, 1, 1, 'Apprentice Osterkilgr - Mead Basted Caribou'),
(30409, 38260, 0, 55.56, 0, 1, 0, 1, 1, 'Apprentice Osterkilgr - Empty Tobacco Pouch'),
(30409, 43575, 0, 22.22, 0, 1, 0, 1, 1, 'Apprentice Osterkilgr - Reinforced Junkbox');

-- Njorndar Spear-Sister (30243)
UPDATE `creature_template` SET `pickpocketloot` = 30243 WHERE (`entry` = 30243);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30243);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30243, 33447, 0, 13.04, 0, 1, 0, 1, 1, 'Njorndar Spear-Sister - Runic Healing Potion'),
(30243, 35953, 0, 10.87, 0, 1, 0, 1, 1, 'Njorndar Spear-Sister - Mead Basted Caribou'),
(30243, 36862, 0, 2.17, 0, 1, 0, 1, 1, 'Njorndar Spear-Sister - Worn Troll Dice'),
(30243, 38260, 0, 30.43, 0, 1, 0, 1, 1, 'Njorndar Spear-Sister - Empty Tobacco Pouch'),
(30243, 40202, 0, 10.87, 0, 1, 0, 1, 1, 'Njorndar Spear-Sister - Sizzling Grizzly Flank'),
(30243, 43575, 0, 41.3, 0, 1, 0, 1, 1, 'Njorndar Spear-Sister - Reinforced Junkbox');

-- Forgotten Depths Underking (30541)
UPDATE `creature_template` SET `pickpocketloot` = 30541 WHERE (`entry` = 30541);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30541);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30541, 35947, 0, 33.33, 0, 1, 0, 1, 1, 'Forgotten Depths Underking - Sparkling Frostcap'),
(30541, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Forgotten Depths Underking - Reinforced Junkbox'),
(30541, 43576, 0, 33.33, 0, 1, 0, 1, 1, 'Forgotten Depths Underking - Chitin Polish'),
(30541, 43577, 0, 16.67, 0, 1, 0, 1, 1, 'Forgotten Depths Underking - Carapace Cleanser');

-- Restless Frostborn Ghost (30144)
UPDATE `creature_template` SET `pickpocketloot` = 30144 WHERE (`entry` = 30144);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30144);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30144, 33447, 0, 10.34, 0, 1, 0, 1, 1, 'Restless Frostborn Ghost - Runic Healing Potion'),
(30144, 35947, 0, 13.79, 0, 1, 0, 1, 1, 'Restless Frostborn Ghost - Sparkling Frostcap'),
(30144, 38269, 0, 58.62, 0, 1, 0, 1, 1, 'Restless Frostborn Ghost - Soggy Handkerchief'),
(30144, 43575, 0, 37.93, 0, 1, 0, 1, 1, 'Restless Frostborn Ghost - Reinforced Junkbox');

-- Banshee Soulclaimer (29646)
UPDATE `creature_template` SET `pickpocketloot` = 29646 WHERE (`entry` = 29646);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29646);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29646, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Banshee Soulclaimer - Runic Healing Potion'),
(29646, 35947, 0, 20.0, 0, 1, 0, 1, 1, 'Banshee Soulclaimer - Sparkling Frostcap'),
(29646, 38269, 0, 60.0, 0, 1, 0, 1, 1, 'Banshee Soulclaimer - Soggy Handkerchief'),
(29646, 43575, 0, 60.0, 0, 1, 0, 1, 1, 'Banshee Soulclaimer - Reinforced Junkbox');

-- Forgotten Depths High Priest (30543)
UPDATE `creature_template` SET `pickpocketloot` = 30543 WHERE (`entry` = 30543);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30543);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30543, 33447, 0, 27.78, 0, 1, 0, 1, 1, 'Forgotten Depths High Priest - Runic Healing Potion'),
(30543, 35947, 0, 11.11, 0, 1, 0, 1, 1, 'Forgotten Depths High Priest - Sparkling Frostcap'),
(30543, 43575, 0, 22.22, 0, 1, 0, 1, 1, 'Forgotten Depths High Priest - Reinforced Junkbox'),
(30543, 43576, 0, 38.89, 0, 1, 0, 1, 1, 'Forgotten Depths High Priest - Chitin Polish'),
(30543, 43577, 0, 16.67, 0, 1, 0, 1, 1, 'Forgotten Depths High Priest - Carapace Cleanser');

-- Shandaral Druid Spirit (30863)
UPDATE `creature_template` SET `pickpocketloot` = 30863 WHERE (`entry` = 30863);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30863);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30863, 33447, 0, 40.0, 0, 1, 0, 1, 1, 'Shandaral Druid Spirit - Runic Healing Potion'),
(30863, 38269, 0, 20.0, 0, 1, 0, 1, 1, 'Shandaral Druid Spirit - Soggy Handkerchief'),
(30863, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Shandaral Druid Spirit - Reinforced Junkbox');

-- Skeletal Constructor (30687)
UPDATE `creature_template` SET `pickpocketloot` = 30687 WHERE (`entry` = 30687);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30687);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30687, 33447, 0, 10.0, 0, 1, 0, 1, 1, 'Skeletal Constructor - Runic Healing Potion'),
(30687, 35947, 0, 20.0, 0, 1, 0, 1, 1, 'Skeletal Constructor - Sparkling Frostcap'),
(30687, 38269, 0, 40.0, 0, 1, 0, 1, 1, 'Skeletal Constructor - Soggy Handkerchief'),
(30687, 43575, 0, 30.0, 0, 1, 0, 1, 1, 'Skeletal Constructor - Reinforced Junkbox');

-- Salranax the Flesh Render (30829)
UPDATE `creature_template` SET `pickpocketloot` = 30829 WHERE (`entry` = 30829);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30829);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30829, 33447, 0, 40.0, 0, 1, 0, 1, 1, 'Salranax the Flesh Render - Runic Healing Potion'),
(30829, 35947, 0, 60.0, 0, 1, 0, 1, 1, 'Salranax the Flesh Render - Sparkling Frostcap'),
(30829, 38269, 0, 40.0, 0, 1, 0, 1, 1, 'Salranax the Flesh Render - Soggy Handkerchief');

-- Kul'galar Oracle (30751)
UPDATE `creature_template` SET `pickpocketloot` = 30751 WHERE (`entry` = 30751);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30751);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30751, 38260, 0, 66.67, 0, 1, 0, 1, 1, 'Kul\'galar Oracle - Empty Tobacco Pouch'),
(30751, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Kul\'galar Oracle - Reinforced Junkbox');

-- Corpulent Horror (30696)
UPDATE `creature_template` SET `pickpocketloot` = 30696 WHERE (`entry` = 30696);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30696);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30696, 33447, 0, 16.67, 0, 1, 0, 1, 1, 'Corpulent Horror - Runic Healing Potion'),
(30696, 35947, 0, 33.33, 0, 1, 0, 1, 1, 'Corpulent Horror - Sparkling Frostcap'),
(30696, 38269, 0, 16.67, 0, 1, 0, 1, 1, 'Corpulent Horror - Soggy Handkerchief'),
(30696, 43575, 0, 66.67, 0, 1, 0, 1, 1, 'Corpulent Horror - Reinforced Junkbox');

-- Spiked Ghoul (30597)
UPDATE `creature_template` SET `pickpocketloot` = 30597 WHERE (`entry` = 30597);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30597);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30597, 33447, 0, 23.08, 0, 1, 0, 1, 1, 'Spiked Ghoul - Runic Healing Potion'),
(30597, 35947, 0, 30.77, 0, 1, 0, 1, 1, 'Spiked Ghoul - Sparkling Frostcap'),
(30597, 38269, 0, 7.69, 0, 1, 0, 1, 1, 'Spiked Ghoul - Soggy Handkerchief'),
(30597, 43575, 0, 53.85, 0, 1, 0, 1, 1, 'Spiked Ghoul - Reinforced Junkbox');

-- Focus Wizard (26816)
UPDATE `creature_template` SET `pickpocketloot` = 26816 WHERE (`entry` = 26816);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 26816);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26816, 29448, 0, 10.26, 0, 1, 0, 1, 1, 'Focus Wizard - Mag\'har Mild Cheese'),
(26816, 29450, 0, 7.69, 0, 1, 0, 1, 1, 'Focus Wizard - Telaari Grapes'),
(26816, 33447, 0, 12.82, 0, 1, 0, 1, 1, 'Focus Wizard - Runic Healing Potion'),
(26816, 33449, 0, 12.82, 0, 1, 0, 1, 1, 'Focus Wizard - Crusty Flatbread'),
(26816, 37467, 0, 30.77, 0, 1, 0, 1, 1, 'Focus Wizard - A Steamy Romance Novel: Forbidden Love'),
(26816, 38261, 0, 2.56, 0, 1, 0, 1, 1, 'Focus Wizard - Bent House Key'),
(26816, 43575, 0, 38.46, 0, 1, 0, 1, 1, 'Focus Wizard - Reinforced Junkbox');

-- Intrepid Ghoul (31015)
UPDATE `creature_template` SET `pickpocketloot` = 31015 WHERE (`entry` = 31015);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31015);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31015, 35947, 0, 16.67, 0, 1, 0, 1, 1, 'Intrepid Ghoul - Sparkling Frostcap'),
(31015, 38269, 0, 33.33, 0, 1, 0, 1, 1, 'Intrepid Ghoul - Soggy Handkerchief'),
(31015, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Intrepid Ghoul - Reinforced Junkbox');

-- Skeletal Runesmith (30921)
UPDATE `creature_template` SET `pickpocketloot` = 30921 WHERE (`entry` = 30921);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30921);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30921, 35947, 0, 40.0, 0, 1, 0, 1, 1, 'Skeletal Runesmith - Sparkling Frostcap'),
(30921, 43575, 0, 60.0, 0, 1, 0, 1, 1, 'Skeletal Runesmith - Reinforced Junkbox');

-- Shandaral Warrior Spirit (30865)
UPDATE `creature_template` SET `pickpocketloot` = 30865 WHERE (`entry` = 30865);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30865);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30865, 33447, 0, 25.0, 0, 1, 0, 1, 1, 'Shandaral Warrior Spirit - Runic Healing Potion'),
(30865, 35947, 0, 25.0, 0, 1, 0, 1, 1, 'Shandaral Warrior Spirit - Sparkling Frostcap'),
(30865, 38269, 0, 37.5, 0, 1, 0, 1, 1, 'Shandaral Warrior Spirit - Soggy Handkerchief'),
(30865, 43575, 0, 12.5, 0, 1, 0, 1, 1, 'Shandaral Warrior Spirit - Reinforced Junkbox');

-- Unbound Dryad (30860)
UPDATE `creature_template` SET `pickpocketloot` = 30860 WHERE (`entry` = 30860);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30860);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30860, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Unbound Dryad - Runic Healing Potion'),
(30860, 38264, 0, 44.44, 0, 1, 0, 1, 1, 'Unbound Dryad - A Very Pretty Rock'),
(30860, 40202, 0, 33.33, 0, 1, 0, 1, 1, 'Unbound Dryad - Sizzling Grizzly Flank'),
(30860, 43575, 0, 22.22, 0, 1, 0, 1, 1, 'Unbound Dryad - Reinforced Junkbox');

-- Ymirheim Chosen Warrior (31258)
UPDATE `creature_template` SET `pickpocketloot` = 31258 WHERE (`entry` = 31258);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31258);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31258, 33447, 0, 6.06, 0, 1, 0, 1, 1, 'Ymirheim Chosen Warrior - Runic Healing Potion'),
(31258, 35953, 0, 3.03, 0, 1, 0, 1, 1, 'Ymirheim Chosen Warrior - Mead Basted Caribou'),
(31258, 36862, 0, 3.03, 0, 1, 0, 1, 1, 'Ymirheim Chosen Warrior - Worn Troll Dice'),
(31258, 38260, 0, 45.45, 0, 1, 0, 1, 1, 'Ymirheim Chosen Warrior - Empty Tobacco Pouch'),
(31258, 40202, 0, 9.09, 0, 1, 0, 1, 1, 'Ymirheim Chosen Warrior - Sizzling Grizzly Flank'),
(31258, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Ymirheim Chosen Warrior - Reinforced Junkbox');

-- Shadow Adept (31145)
UPDATE `creature_template` SET `pickpocketloot` = 31145 WHERE (`entry` = 31145);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31145);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31145, 33447, 0, 15.38, 0, 1, 0, 1, 1, 'Shadow Adept - Runic Healing Potion'),
(31145, 35948, 0, 7.69, 0, 1, 0, 1, 1, 'Shadow Adept - Savory Snowplum'),
(31145, 35950, 0, 7.69, 0, 1, 0, 1, 1, 'Shadow Adept - Sweet Potato Bread'),
(31145, 35952, 0, 3.85, 0, 1, 0, 1, 1, 'Shadow Adept - Briny Hardcheese'),
(31145, 37467, 0, 42.31, 0, 1, 0, 1, 1, 'Shadow Adept - A Steamy Romance Novel: Forbidden Love'),
(31145, 38261, 0, 3.85, 0, 1, 0, 1, 1, 'Shadow Adept - Bent House Key'),
(31145, 43575, 0, 46.15, 0, 1, 0, 1, 1, 'Shadow Adept - Reinforced Junkbox');

-- Dragonflayer Huscarl (27260)
UPDATE `creature_template` SET `pickpocketloot` = 27260 WHERE (`entry` = 27260);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 27260);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(27260, 33447, 0, 11.43, 0, 1, 0, 1, 1, 'Dragonflayer Huscarl - Runic Healing Potion'),
(27260, 33449, 0, 12.86, 0, 1, 0, 1, 1, 'Dragonflayer Huscarl - Crusty Flatbread'),
(27260, 33454, 0, 12.86, 0, 1, 0, 1, 1, 'Dragonflayer Huscarl - Salted Venison'),
(27260, 38260, 0, 37.14, 0, 1, 0, 1, 1, 'Dragonflayer Huscarl - Empty Tobacco Pouch'),
(27260, 38261, 0, 11.43, 0, 1, 0, 1, 1, 'Dragonflayer Huscarl - Bent House Key'),
(27260, 43575, 0, 24.29, 0, 1, 0, 1, 1, 'Dragonflayer Huscarl - Reinforced Junkbox');

-- Ymirjar Element Shaper (31267)
UPDATE `creature_template` SET `pickpocketloot` = 31267 WHERE (`entry` = 31267);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31267);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31267, 33447, 0, 6.9, 0, 1, 0, 1, 1, 'Ymirjar Element Shaper - Runic Healing Potion'),
(31267, 35953, 0, 13.79, 0, 1, 0, 1, 1, 'Ymirjar Element Shaper - Mead Basted Caribou'),
(31267, 38260, 0, 31.03, 0, 1, 0, 1, 1, 'Ymirjar Element Shaper - Empty Tobacco Pouch'),
(31267, 40202, 0, 20.69, 0, 1, 0, 1, 1, 'Ymirjar Element Shaper - Sizzling Grizzly Flank'),
(31267, 43575, 0, 41.38, 0, 1, 0, 1, 1, 'Ymirjar Element Shaper - Reinforced Junkbox');

-- Yulda the Stormspeaker (30046)
UPDATE `creature_template` SET `pickpocketloot` = 30046 WHERE (`entry` = 30046);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30046);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30046, 38260, 0, 57.14, 0, 1, 0, 1, 1, 'Yulda the Stormspeaker - Empty Tobacco Pouch'),
(30046, 40202, 0, 14.29, 0, 1, 0, 1, 1, 'Yulda the Stormspeaker - Sizzling Grizzly Flank'),
(30046, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Yulda the Stormspeaker - Reinforced Junkbox');

-- Death Knight Initiate (31327)
UPDATE `creature_template` SET `pickpocketloot` = 31327 WHERE (`entry` = 31327);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31327);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31327, 35947, 0, 20.0, 0, 1, 0, 1, 1, 'Death Knight Initiate - Sparkling Frostcap'),
(31327, 38269, 0, 80.0, 0, 1, 0, 1, 1, 'Death Knight Initiate - Soggy Handkerchief');

-- Shandaral Hunter Spirit (30864)
UPDATE `creature_template` SET `pickpocketloot` = 30864 WHERE (`entry` = 30864);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30864);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30864, 33447, 0, 10.0, 0, 1, 0, 1, 1, 'Shandaral Hunter Spirit - Runic Healing Potion'),
(30864, 35947, 0, 30.0, 0, 1, 0, 1, 1, 'Shandaral Hunter Spirit - Sparkling Frostcap'),
(30864, 38269, 0, 30.0, 0, 1, 0, 1, 1, 'Shandaral Hunter Spirit - Soggy Handkerchief'),
(30864, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Shandaral Hunter Spirit - Reinforced Junkbox');

-- Frostfeather Screecher (29792)
UPDATE `creature_template` SET `pickpocketloot` = 29792 WHERE (`entry` = 29792);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29792);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29792, 33447, 0, 12.5, 0, 1, 0, 1, 1, 'Frostfeather Screecher - Runic Healing Potion'),
(29792, 38263, 0, 12.5, 0, 1, 0, 1, 1, 'Frostfeather Screecher - Too-Small Armband'),
(29792, 38264, 0, 12.5, 0, 1, 0, 1, 1, 'Frostfeather Screecher - A Very Pretty Rock'),
(29792, 40202, 0, 25.0, 0, 1, 0, 1, 1, 'Frostfeather Screecher - Sizzling Grizzly Flank'),
(29792, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Frostfeather Screecher - Reinforced Junkbox');

-- Hulking Horror (31411)
UPDATE `creature_template` SET `pickpocketloot` = 31411 WHERE (`entry` = 31411);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31411);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31411, 33447, 0, 28.57, 0, 1, 0, 1, 1, 'Hulking Horror - Runic Healing Potion'),
(31411, 38269, 0, 28.57, 0, 1, 0, 1, 1, 'Hulking Horror - Soggy Handkerchief'),
(31411, 43575, 0, 57.14, 0, 1, 0, 1, 1, 'Hulking Horror - Reinforced Junkbox');

-- Hulking Horror (31413)
UPDATE `creature_template` SET `pickpocketloot` = 31413 WHERE (`entry` = 31413);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31413);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31413, 33447, 0, 25.0, 0, 1, 0, 1, 1, 'Hulking Horror - Runic Healing Potion'),
(31413, 38269, 0, 75.0, 0, 1, 0, 1, 1, 'Hulking Horror - Soggy Handkerchief');

-- Jotunheim Warrior (29880)
UPDATE `creature_template` SET `pickpocketloot` = 29880 WHERE (`entry` = 29880);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 29880);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(29880, 33447, 0, 7.94, 0, 1, 0, 1, 1, 'Jotunheim Warrior - Runic Healing Potion'),
(29880, 35953, 0, 12.7, 0, 1, 0, 1, 1, 'Jotunheim Warrior - Mead Basted Caribou'),
(29880, 38260, 0, 39.68, 0, 1, 0, 1, 1, 'Jotunheim Warrior - Empty Tobacco Pouch'),
(29880, 40202, 0, 9.52, 0, 1, 0, 1, 1, 'Jotunheim Warrior - Sizzling Grizzly Flank'),
(29880, 43575, 0, 46.03, 0, 1, 0, 1, 1, 'Jotunheim Warrior - Reinforced Junkbox');

-- Wyrm Reanimator (31731)
UPDATE `creature_template` SET `pickpocketloot` = 31731 WHERE (`entry` = 31731);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31731);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31731, 35948, 0, 9.52, 0, 1, 0, 1, 1, 'Wyrm Reanimator - Savory Snowplum'),
(31731, 35950, 0, 19.05, 0, 1, 0, 1, 1, 'Wyrm Reanimator - Sweet Potato Bread'),
(31731, 35952, 0, 9.52, 0, 1, 0, 1, 1, 'Wyrm Reanimator - Briny Hardcheese'),
(31731, 36863, 0, 4.76, 0, 1, 0, 1, 1, 'Wyrm Reanimator - Decahedral Dwarven Dice'),
(31731, 37467, 0, 42.86, 0, 1, 0, 1, 1, 'Wyrm Reanimator - A Steamy Romance Novel: Forbidden Love'),
(31731, 38261, 0, 9.52, 0, 1, 0, 1, 1, 'Wyrm Reanimator - Bent House Key'),
(31731, 43575, 0, 28.57, 0, 1, 0, 1, 1, 'Wyrm Reanimator - Reinforced Junkbox');

-- Fallen Hero's Spirit (32149)
UPDATE `creature_template` SET `pickpocketloot` = 32149 WHERE (`entry` = 32149);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32149);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32149, 37467, 0, 66.67, 0, 1, 0, 1, 1, 'Fallen Hero\'s Spirit - A Steamy Romance Novel: Forbidden Love'),
(32149, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Fallen Hero\'s Spirit - Reinforced Junkbox');

-- Cultist Corrupter (31738)
UPDATE `creature_template` SET `pickpocketloot` = 31738 WHERE (`entry` = 31738);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31738);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31738, 33447, 0, 19.44, 0, 1, 0, 1, 1, 'Cultist Corrupter - Runic Healing Potion'),
(31738, 35948, 0, 2.78, 0, 1, 0, 1, 1, 'Cultist Corrupter - Savory Snowplum'),
(31738, 35950, 0, 5.56, 0, 1, 0, 1, 1, 'Cultist Corrupter - Sweet Potato Bread'),
(31738, 35952, 0, 5.56, 0, 1, 0, 1, 1, 'Cultist Corrupter - Briny Hardcheese'),
(31738, 37467, 0, 13.89, 0, 1, 0, 1, 1, 'Cultist Corrupter - A Steamy Romance Novel: Forbidden Love'),
(31738, 38261, 0, 19.44, 0, 1, 0, 1, 1, 'Cultist Corrupter - Bent House Key'),
(31738, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Cultist Corrupter - Reinforced Junkbox');

-- Damned Apothecary (32289)
UPDATE `creature_template` SET `pickpocketloot` = 32289 WHERE (`entry` = 32289);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32289);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32289, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Damned Apothecary - Runic Healing Potion'),
(32289, 35948, 0, 16.67, 0, 1, 0, 1, 1, 'Damned Apothecary - Savory Snowplum'),
(32289, 35950, 0, 22.22, 0, 1, 0, 1, 1, 'Damned Apothecary - Sweet Potato Bread'),
(32289, 35952, 0, 11.11, 0, 1, 0, 1, 1, 'Damned Apothecary - Briny Hardcheese'),
(32289, 37467, 0, 27.78, 0, 1, 0, 1, 1, 'Damned Apothecary - A Steamy Romance Novel: Forbidden Love'),
(32289, 38261, 0, 5.56, 0, 1, 0, 1, 1, 'Damned Apothecary - Bent House Key'),
(32289, 43575, 0, 27.78, 0, 1, 0, 1, 1, 'Damned Apothecary - Reinforced Junkbox');

-- Scourge Converter (32257)
UPDATE `creature_template` SET `pickpocketloot` = 32257 WHERE (`entry` = 32257);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32257);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32257, 33447, 0, 16.67, 0, 1, 0, 1, 1, 'Scourge Converter - Runic Healing Potion'),
(32257, 35947, 0, 33.33, 0, 1, 0, 1, 1, 'Scourge Converter - Sparkling Frostcap'),
(32257, 38269, 0, 33.33, 0, 1, 0, 1, 1, 'Scourge Converter - Soggy Handkerchief'),
(32257, 43575, 0, 16.67, 0, 1, 0, 1, 1, 'Scourge Converter - Reinforced Junkbox');

-- Chosen Zealot (32175)
UPDATE `creature_template` SET `pickpocketloot` = 32175 WHERE (`entry` = 32175);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32175);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32175, 33447, 0, 15.62, 0, 1, 0, 1, 1, 'Chosen Zealot - Runic Healing Potion'),
(32175, 35948, 0, 6.25, 0, 1, 0, 1, 1, 'Chosen Zealot - Savory Snowplum'),
(32175, 35950, 0, 9.38, 0, 1, 0, 1, 1, 'Chosen Zealot - Sweet Potato Bread'),
(32175, 35952, 0, 3.12, 0, 1, 0, 1, 1, 'Chosen Zealot - Briny Hardcheese'),
(32175, 37467, 0, 21.88, 0, 1, 0, 1, 1, 'Chosen Zealot - A Steamy Romance Novel: Forbidden Love'),
(32175, 38261, 0, 6.25, 0, 1, 0, 1, 1, 'Chosen Zealot - Bent House Key'),
(32175, 43575, 0, 46.88, 0, 1, 0, 1, 1, 'Chosen Zealot - Reinforced Junkbox');

-- Void Summoner (32259)
UPDATE `creature_template` SET `pickpocketloot` = 32259 WHERE (`entry` = 32259);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32259);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32259, 35950, 0, 18.18, 0, 1, 0, 1, 1, 'Void Summoner - Sweet Potato Bread'),
(32259, 37467, 0, 27.27, 0, 1, 0, 1, 1, 'Void Summoner - A Steamy Romance Novel: Forbidden Love'),
(32259, 38261, 0, 9.09, 0, 1, 0, 1, 1, 'Void Summoner - Bent House Key'),
(32259, 43575, 0, 54.55, 0, 1, 0, 1, 1, 'Void Summoner - Reinforced Junkbox');

-- Vrykul Necrolord (31783)
UPDATE `creature_template` SET `pickpocketloot` = 31783 WHERE (`entry` = 31783);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31783);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31783, 33447, 0, 20.0, 0, 1, 0, 1, 1, 'Vrykul Necrolord - Runic Healing Potion'),
(31783, 35947, 0, 10.0, 0, 1, 0, 1, 1, 'Vrykul Necrolord - Sparkling Frostcap'),
(31783, 38269, 0, 50.0, 0, 1, 0, 1, 1, 'Vrykul Necrolord - Soggy Handkerchief'),
(31783, 43575, 0, 50.0, 0, 1, 0, 1, 1, 'Vrykul Necrolord - Reinforced Junkbox');

-- Shadow Channeler (32262)
UPDATE `creature_template` SET `pickpocketloot` = 32262 WHERE (`entry` = 32262);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32262);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32262, 35948, 0, 16.67, 0, 1, 0, 1, 1, 'Shadow Channeler - Savory Snowplum'),
(32262, 35950, 0, 16.67, 0, 1, 0, 1, 1, 'Shadow Channeler - Sweet Potato Bread'),
(32262, 35952, 0, 8.33, 0, 1, 0, 1, 1, 'Shadow Channeler - Briny Hardcheese'),
(32262, 37467, 0, 16.67, 0, 1, 0, 1, 1, 'Shadow Channeler - A Steamy Romance Novel: Forbidden Love'),
(32262, 38261, 0, 8.33, 0, 1, 0, 1, 1, 'Shadow Channeler - Bent House Key'),
(32262, 43575, 0, 41.67, 0, 1, 0, 1, 1, 'Shadow Channeler - Reinforced Junkbox');

-- Converted Hero (32255)
UPDATE `creature_template` SET `pickpocketloot` = 32255 WHERE (`entry` = 32255);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32255);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32255, 33447, 0, 19.05, 0, 1, 0, 1, 1, 'Converted Hero - Runic Healing Potion'),
(32255, 35947, 0, 28.57, 0, 1, 0, 1, 1, 'Converted Hero - Sparkling Frostcap'),
(32255, 38269, 0, 36.51, 0, 1, 0, 1, 1, 'Converted Hero - Soggy Handkerchief'),
(32255, 43575, 0, 31.75, 0, 1, 0, 1, 1, 'Converted Hero - Reinforced Junkbox');

-- Vile Torturer (32279)
UPDATE `creature_template` SET `pickpocketloot` = 32279 WHERE (`entry` = 32279);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32279);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32279, 35952, 0, 28.57, 0, 1, 0, 1, 1, 'Vile Torturer - Briny Hardcheese'),
(32279, 37467, 0, 28.57, 0, 1, 0, 1, 1, 'Vile Torturer - A Steamy Romance Novel: Forbidden Love'),
(32279, 38261, 0, 28.57, 0, 1, 0, 1, 1, 'Vile Torturer - Bent House Key'),
(32279, 43575, 0, 57.14, 0, 1, 0, 1, 1, 'Vile Torturer - Reinforced Junkbox');

-- Cult Blackguard (32276)
UPDATE `creature_template` SET `pickpocketloot` = 32276 WHERE (`entry` = 32276);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32276);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32276, 33447, 0, 11.76, 0, 1, 0, 1, 1, 'Cult Blackguard - Runic Healing Potion'),
(32276, 35948, 0, 29.41, 0, 1, 0, 1, 1, 'Cult Blackguard - Savory Snowplum'),
(32276, 37467, 0, 23.53, 0, 1, 0, 1, 1, 'Cult Blackguard - A Steamy Romance Novel: Forbidden Love'),
(32276, 38261, 0, 23.53, 0, 1, 0, 1, 1, 'Cult Blackguard - Bent House Key'),
(32276, 43575, 0, 29.41, 0, 1, 0, 1, 1, 'Cult Blackguard - Reinforced Junkbox');

-- Cult Alchemist (32290)
UPDATE `creature_template` SET `pickpocketloot` = 32290 WHERE (`entry` = 32290);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32290);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32290, 33447, 0, 4.76, 0, 1, 0, 1, 1, 'Cult Alchemist - Runic Healing Potion'),
(32290, 35948, 0, 9.52, 0, 1, 0, 1, 1, 'Cult Alchemist - Savory Snowplum'),
(32290, 35950, 0, 14.29, 0, 1, 0, 1, 1, 'Cult Alchemist - Sweet Potato Bread'),
(32290, 35952, 0, 9.52, 0, 1, 0, 1, 1, 'Cult Alchemist - Briny Hardcheese'),
(32290, 37467, 0, 23.81, 0, 1, 0, 1, 1, 'Cult Alchemist - A Steamy Romance Novel: Forbidden Love'),
(32290, 38261, 0, 23.81, 0, 1, 0, 1, 1, 'Cult Alchemist - Bent House Key'),
(32290, 43575, 0, 19.05, 0, 1, 0, 1, 1, 'Cult Alchemist - Reinforced Junkbox');

-- Cultist Acolyte (32507)
UPDATE `creature_template` SET `pickpocketloot` = 32507 WHERE (`entry` = 32507);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32507);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32507, 35948, 0, 28.57, 0, 1, 0, 1, 1, 'Cultist Acolyte - Savory Snowplum'),
(32507, 35950, 0, 14.29, 0, 1, 0, 1, 1, 'Cultist Acolyte - Sweet Potato Bread'),
(32507, 37467, 0, 28.57, 0, 1, 0, 1, 1, 'Cultist Acolyte - A Steamy Romance Novel: Forbidden Love'),
(32507, 43575, 0, 42.86, 0, 1, 0, 1, 1, 'Cultist Acolyte - Reinforced Junkbox');

-- Dark Zealot (34728)
UPDATE `creature_template` SET `pickpocketloot` = 34728 WHERE (`entry` = 34728);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 34728);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34728, 33447, 0, 23.08, 0, 1, 0, 1, 1, 'Dark Zealot - Runic Healing Potion'),
(34728, 35953, 0, 11.54, 0, 1, 0, 1, 1, 'Dark Zealot - Mead Basted Caribou'),
(34728, 36862, 0, 3.85, 0, 1, 0, 1, 1, 'Dark Zealot - Worn Troll Dice'),
(34728, 38260, 0, 19.23, 0, 1, 0, 1, 1, 'Dark Zealot - Empty Tobacco Pouch'),
(34728, 40202, 0, 26.92, 0, 1, 0, 1, 1, 'Dark Zealot - Sizzling Grizzly Flank'),
(34728, 43575, 0, 23.08, 0, 1, 0, 1, 1, 'Dark Zealot - Reinforced Junkbox');

-- Cult Researcher (32297)
UPDATE `creature_template` SET `pickpocketloot` = 32297 WHERE (`entry` = 32297);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32297);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32297, 33447, 0, 17.24, 0, 1, 0, 1, 1, 'Cult Researcher - Runic Healing Potion'),
(32297, 35948, 0, 13.79, 0, 1, 0, 1, 1, 'Cult Researcher - Savory Snowplum'),
(32297, 35950, 0, 6.9, 0, 1, 0, 1, 1, 'Cult Researcher - Sweet Potato Bread'),
(32297, 35952, 0, 6.9, 0, 1, 0, 1, 1, 'Cult Researcher - Briny Hardcheese'),
(32297, 37467, 0, 37.93, 0, 1, 0, 1, 1, 'Cult Researcher - A Steamy Romance Novel: Forbidden Love'),
(32297, 38261, 0, 10.34, 0, 1, 0, 1, 1, 'Cult Researcher - Bent House Key'),
(32297, 43575, 0, 20.69, 0, 1, 0, 1, 1, 'Cult Researcher - Reinforced Junkbox');

-- Cultist Shard Watcher (32349)
UPDATE `creature_template` SET `pickpocketloot` = 32349 WHERE (`entry` = 32349);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32349);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32349, 33447, 0, 40.0, 0, 1, 0, 1, 1, 'Cultist Shard Watcher - Runic Healing Potion'),
(32349, 35950, 0, 20.0, 0, 1, 0, 1, 1, 'Cultist Shard Watcher - Sweet Potato Bread'),
(32349, 38261, 0, 20.0, 0, 1, 0, 1, 1, 'Cultist Shard Watcher - Bent House Key'),
(32349, 43575, 0, 40.0, 0, 1, 0, 1, 1, 'Cultist Shard Watcher - Reinforced Junkbox');

-- Crown Sprinkler (38023)
UPDATE `creature_template` SET `pickpocketloot` = 38023 WHERE (`entry` = 38023);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 38023);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(38023, 3419, 0, 30.86, 0, 1, 0, 1, 1, 'Crown Sprinkler - Red Rose'),
(38023, 3928, 0, 7.41, 0, 1, 0, 1, 1, 'Crown Sprinkler - Superior Healing Potion'),
(38023, 8948, 0, 33.33, 0, 1, 0, 1, 1, 'Crown Sprinkler - Dried King Bolete'),
(38023, 16885, 0, 37.04, 0, 1, 0, 1, 1, 'Crown Sprinkler - Heavy Junkbox');

-- Kvaldir Reaver (34838)
UPDATE `creature_template` SET `pickpocketloot` = 34838 WHERE (`entry` = 34838);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 34838);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34838, 33447, 0, 11.11, 0, 1, 0, 1, 1, 'Kvaldir Reaver - Runic Healing Potion'),
(34838, 35953, 0, 33.33, 0, 1, 0, 1, 1, 'Kvaldir Reaver - Mead Basted Caribou'),
(34838, 38260, 0, 22.22, 0, 1, 0, 1, 1, 'Kvaldir Reaver - Empty Tobacco Pouch'),
(34838, 43575, 0, 44.44, 0, 1, 0, 1, 1, 'Kvaldir Reaver - Reinforced Junkbox');

-- Crown Underling (38030)
UPDATE `creature_template` SET `pickpocketloot` = 38030 WHERE (`entry` = 38030);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 38030);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(38030, 22829, 0, 5.56, 0, 1, 0, 1, 1, 'Crown Underling - Super Healing Potion'),
(38030, 23441, 0, 5.56, 0, 1, 0, 1, 1, 'Crown Underling - Nightseye'),
(38030, 27859, 0, 27.78, 0, 1, 0, 1, 1, 'Crown Underling - Zangar Caps'),
(38030, 29569, 0, 44.44, 0, 1, 0, 1, 1, 'Crown Underling - Strong Junkbox'),
(38030, 29575, 0, 33.33, 0, 1, 0, 1, 1, 'Crown Underling - A Jack-o\'-Lantern');

-- Dark Ritualist (34734)
UPDATE `creature_template` SET `pickpocketloot` = 34734 WHERE (`entry` = 34734);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 34734);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34734, 35953, 0, 8.33, 0, 1, 0, 1, 1, 'Dark Ritualist - Mead Basted Caribou'),
(34734, 36862, 0, 8.33, 0, 1, 0, 1, 1, 'Dark Ritualist - Worn Troll Dice'),
(34734, 38260, 0, 41.67, 0, 1, 0, 1, 1, 'Dark Ritualist - Empty Tobacco Pouch'),
(34734, 40202, 0, 8.33, 0, 1, 0, 1, 1, 'Dark Ritualist - Sizzling Grizzly Flank'),
(34734, 43575, 0, 33.33, 0, 1, 0, 1, 1, 'Dark Ritualist - Reinforced Junkbox');

-- Hulking Abomination (31140)
UPDATE `creature_template` SET `pickpocketloot` = 31140 WHERE (`entry` = 31140);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31140);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31140, 33447, 0, 4.55, 0, 1, 0, 1, 1, 'Hulking Abomination - Runic Healing Potion'),
(31140, 35947, 0, 31.82, 0, 1, 0, 1, 1, 'Hulking Abomination - Sparkling Frostcap'),
(31140, 38269, 0, 54.55, 0, 1, 0, 1, 1, 'Hulking Abomination - Soggy Handkerchief'),
(31140, 43575, 0, 22.73, 0, 1, 0, 1, 1, 'Hulking Abomination - Reinforced Junkbox');

-- Mjordin Water Magus (30632)
UPDATE `creature_template` SET `pickpocketloot` = 30632 WHERE (`entry` = 30632);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 30632);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30632, 33447, 0, 16.67, 0, 1, 0, 1, 1, 'Mjordin Water Magus - Runic Healing Potion'),
(30632, 35953, 0, 33.33, 0, 1, 0, 1, 1, 'Mjordin Water Magus - Mead Basted Caribou'),
(30632, 38260, 0, 33.33, 0, 1, 0, 1, 1, 'Mjordin Water Magus - Empty Tobacco Pouch'),
(30632, 40202, 0, 25.0, 0, 1, 0, 1, 1, 'Mjordin Water Magus - Sizzling Grizzly Flank'),
(30632, 43575, 0, 8.33, 0, 1, 0, 1, 1, 'Mjordin Water Magus - Reinforced Junkbox');

-- Malefic Necromancer (31155)
UPDATE `creature_template` SET `pickpocketloot` = 31155 WHERE (`entry` = 31155);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31155);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31155, 33447, 0, 6.67, 0, 1, 0, 1, 1, 'Malefic Necromancer - Runic Healing Potion'),
(31155, 35947, 0, 33.33, 0, 1, 0, 1, 1, 'Malefic Necromancer - Sparkling Frostcap'),
(31155, 38269, 0, 20.0, 0, 1, 0, 1, 1, 'Malefic Necromancer - Soggy Handkerchief'),
(31155, 43575, 0, 46.67, 0, 1, 0, 1, 1, 'Malefic Necromancer - Reinforced Junkbox');

-- Crown Sprayer (38032)
UPDATE `creature_template` SET `pickpocketloot` = 38032 WHERE (`entry` = 38032);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 38032);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(38032, 33447, 0, 9.62, 0, 1, 0, 1, 1, 'Crown Sprayer - Runic Healing Potion'),
(38032, 33452, 0, 25.0, 0, 1, 0, 1, 1, 'Crown Sprayer - Honey-Spiced Lichen'),
(38032, 38269, 0, 30.77, 0, 1, 0, 1, 1, 'Crown Sprayer - Soggy Handkerchief'),
(38032, 43575, 0, 42.31, 0, 1, 0, 1, 1, 'Crown Sprayer - Reinforced Junkbox');

-- Faceless Lurker (31691)
UPDATE `creature_template` SET `pickpocketloot` = 31691 WHERE (`entry` = 31691);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 31691);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(31691, 35947, 0, 35.29, 0, 1, 0, 1, 1, 'Faceless Lurker - Sparkling Frostcap'),
(31691, 38269, 0, 29.41, 0, 1, 0, 1, 1, 'Faceless Lurker - Soggy Handkerchief'),
(31691, 43575, 0, 47.06, 0, 1, 0, 1, 1, 'Faceless Lurker - Reinforced Junkbox');

-- Bitter Initiate (32238)
UPDATE `creature_template` SET `pickpocketloot` = 32238 WHERE (`entry` = 32238);
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 32238);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32238, 35950, 0, 25.0, 0, 1, 0, 1, 1, 'Bitter Initiate - Sweet Potato Bread'),
(32238, 35952, 0, 12.5, 0, 1, 0, 1, 1, 'Bitter Initiate - Briny Hardcheese'),
(32238, 37467, 0, 37.5, 0, 1, 0, 1, 1, 'Bitter Initiate - A Steamy Romance Novel: Forbidden Love'),
(32238, 38261, 0, 12.5, 0, 1, 0, 1, 1, 'Bitter Initiate - Bent House Key'),
(32238, 43575, 0, 37.5, 0, 1, 0, 1, 1, 'Bitter Initiate - Reinforced Junkbox');

