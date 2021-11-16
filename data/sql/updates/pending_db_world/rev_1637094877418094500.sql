INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637094877418094500');

-- Correct drop chance: [A Letter to Yvette] https://classic.wowhead.com/item=2839/a-letter-to-yvette

-- Darkeye Bonecaster
UPDATE `creature_loot_template` SET `Chance`=4 WHERE `Item`=2839 AND `Entry`=1522;

-- Rattlecage Soldier, Cracked Skull Soldier
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=2839 AND `Entry` IN (1520,1523);

-- Captain Vachon
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1664,2839,0,0.12,0,1,0,1,1,'Captain Vachon - A Letter to Yvette');

-- Moonrage Darkrunner
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1770,2839,0,0.05,0,1,0,1,1,'Moonrage Darkrunner - A Letter to Yvette');

-- Cursed Darkhound
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1548,2839,0,0.01,0,1,0,1,1,'Cursed Darkhound - A Letter to Yvette');

-- Scarlet Zealot
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1537,2839,0,0.01,0,1,0,1,1,'Scarlet Zealot - A Letter to Yvette');

-- Rotting Ancestor
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1530,2839,0,0.01,0,1,0,1,1,'Rotting Ancestor - A Letter to Yvette');

-- Wandering Spirit
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1532,2839,0,0.01,0,1,0,1,1,'Wandering Spirit - A Letter to Yvette');

