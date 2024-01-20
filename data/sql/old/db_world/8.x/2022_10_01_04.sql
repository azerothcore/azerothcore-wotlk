-- DB update 2022_10_01_03 -> 2022_10_01_04
--
-- Yougotta 00001-00005 Sunstider Isle Part 1-5
-- ITEM Tainted Arcane Silver (20483) should be 100% drop rate off NPC Tainted Arcane Wraith (15298) for QUEST Tainted Arcane Sliver (8338) (ALREADY CORRECT)

-- ITEM Lynx Collar (20797) should be 100% drop rate off NPCs Springpaw Cub (15366), Springpaw Lynx (15372) for QUEST Unfortunate Measures (8326)

UPDATE `creature_loot_template` SET `Chance`='100' WHERE  `Entry`=15366 AND `Item`=20797 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`='100' WHERE  `Entry`=15372 AND `Item`=20797 AND `Reference`=0 AND `GroupId`=0;

-- ITEM Arcane Silver (20482) "0.6777893639207508" over 959 repetitions rounded to 2/3rds (70% is also in likely margin of error, but 66.67% is closer to seen and given as second opinion so it will be the standard I go by) drop rate off NPCs Mana Wyrm (15274), Feral Tender (15294), Arcane Wraith (15273), Tainted Arcane Wraith (15298) for QUEST A Fistful of Silvers (8336)

UPDATE `creature_loot_template` SET `Chance`='66.67' WHERE  `Entry`=15274 AND `Item`=20482 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`='66.67' WHERE  `Entry`=15294 AND `Item`=20482 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`='66.67' WHERE  `Entry`=15273 AND `Item`=20482 AND `Reference`=0 AND `GroupId`=0;
UPDATE `creature_loot_template` SET `Chance`='66.67' WHERE  `Entry`=15298 AND `Item`=20482 AND `Reference`=0 AND `GroupId`=0;
