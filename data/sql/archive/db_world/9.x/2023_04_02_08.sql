-- DB update 2023_04_02_07 -> 2023_04_02_08
--
-- Warlord Kalithresh Normal Loot Repairs
UPDATE `creature_loot_template` SET `GroupId`=0 WHERE `Entry`=17798 AND `Item`=23572 AND `Reference`=0 AND `GroupId`=3;
UPDATE `creature_loot_template` SET `MaxCount`=1 WHERE `Entry`=17798 AND `Item`=35001 AND `Reference`=35001 AND `GroupId`=2;
UPDATE `reference_loot_template` SET `GroupId`=3 WHERE `Entry`=35001 AND `Item` IN (27475, 27510, 27804, 27805, 27806, 27874);
DELETE FROM `creature_loot_template` WHERE `Entry`=17798 AND `Item`=24313;
DELETE FROM `creature_loot_template` WHERE `Entry`=17798 AND `Item`=35001 AND `Reference`=35001 AND `GroupId`=3;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(17798, 24313, 0, 3.25, 0, 1, 0, 1, 1, 'Warlord Kalithresh - Pattern: Battlecast Hood'),
(17798, 35001, 35001, 100, 0, 1, 3, 1, 1, 'Warlord Kalithresh Table B - (ReferenceTable)');
