UPDATE `gameobject_loot_template` SET `MaxCount` = 6 WHERE `Entry` = 22070 AND `Item` IN (22573, 22574); -- Mote of Fire/Earth
UPDATE `gameobject_loot_template` SET `MaxCount` = 4 WHERE `Entry` = 22070 AND `Item` = 32464; -- Nethercite Ore
UPDATE `item_loot_template` SET `Chance` = 60, `MaxCount` = 3 WHERE `Entry` = 32724 AND `Item` = 32728; -- Sludge
UPDATE `item_loot_template` SET `Chance` = 10 WHERE `Entry` = 32724 AND `Item` = 32727; -- Vial of Tears
UPDATE `item_loot_template` SET `Chance` = 2 WHERE `Entry` = 32724 AND `Item` = 32726; -- Murkblood Escape Plans
UPDATE `item_loot_template` SET `Chance` = 5 WHERE `Entry` = 32724 AND `Item` IN (32464, 32468, 32470); -- Ore, Pollen, Hide
UPDATE `creature_loot_template` SET `Chance` = 50 WHERE `Item` = 32427; -- Netherwing Crystal
UPDATE `creature_loot_template` SET `Chance` = 100 WHERE `Item` = 32502; -- Fel Gland
UPDATE `creature_loot_template` SET `Chance` = 1 WHERE `Item` = 32506; -- Netherwing Egg

INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22070, 32506, 0, 1, 0, 1, 0, 1, 1, 'Nethercite Deposit - Netherwing Egg');
INSERT INTO `item_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(32724, 32506, 0, 1, 0, 1, 0, 1, 1, 'Sludge-covered Object - Netherwing Egg'),
(32724, 32725, 0, 10, 0, 1, 0, 1, 1, 'Sludge-covered Object - Murkblood Miner''s Pick');
