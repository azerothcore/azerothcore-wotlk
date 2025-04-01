-- DB update 2024_12_10_00 -> 2024_12_10_01
SET @TOKENENTRY := 1276883;

DELETE FROM `creature_loot_template` WHERE (`Entry` = 22917);

DELETE FROM `reference_loot_template` WHERE (`Entry` = 34077 AND `Item` IN (31089,31090,31091)) OR `Entry` = @TOKENENTRY;

INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@TOKENENTRY, 31089, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Forgotten Conqueror'),
(@TOKENENTRY, 31090, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Forgotten Vanquisher'),
(@TOKENENTRY, 31091, 0, 0, 0, 1, 1, 1, 1, 'Chestguard of the Forgotten Protector');

UPDATE `reference_loot_template` SET `GroupId` = 1 WHERE `Entry` = 34077;

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(22917, 29434, 0, 100, 0, 1, 0, 2, 2, 'Illidan Stormrage - Badge of Justice'),
(22917, 32837, 0, 5, 0, 1, 1, 1, 1, 'Illidan Stormrage - Warglaive of Azzinoth'),
(22917, 32838, 0, 5, 0, 1, 2, 1, 1, 'Illidan Stormrage - Warglaive of Azzinoth'),
(22917, 34069, 34069, 2, 0, 1, 2, 1, 1, 'Illidan Stormrage - (Patterns)'),
(22917, 34077, 34077, 100, 0, 1, 1, 2, 2, 'Illidan Stormrage - (Items)'),
(22917, 90069, 34069, 10, 0, 1, 1, 1, 1, 'Illidan Stormrage - (Patterns)'),
(22917, 90077, @TOKENENTRY, 100, 0, 1, 1, 3, 3, 'Illidan Stormrage - (Tokens)');
