-- DB update 2026_04_12_05 -> 2026_04_12_06

-- Shadron
UPDATE `creature_template` SET `lootid` = 30451 WHERE (`entry` = 30451);
UPDATE `creature_template` SET `lootid` = 31520 WHERE (`entry` = 31520);

DELETE FROM `creature_loot_template` WHERE (`Entry` IN (30451, 31520)) AND (`Item` IN (47241));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30451, 47241, 0, 100, 0, 1, 0, 1, 1, 'Emblem of Triumph'),
(31520, 47241, 0, 100, 0, 1, 0, 1, 1, 'Emblem of Triumph');

-- Vesperon
UPDATE `creature_template` SET `lootid` = 30449 WHERE (`entry` = 30449);
UPDATE `creature_template` SET `lootid` = 31535 WHERE (`entry` = 31535);

DELETE FROM `creature_loot_template` WHERE (`Entry` IN (30449, 31535)) AND (`Item` IN (47241));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30449, 47241, 0, 100, 0, 1, 0, 1, 1, 'Emblem of Triumph'),
(31535, 47241, 0, 100, 0, 1, 0, 1, 1, 'Emblem of Triumph');

-- Tenebron
UPDATE `creature_template` SET `lootid` = 30452 WHERE (`entry` = 30452);
UPDATE `creature_template` SET `lootid` = 31534 WHERE (`entry` = 31534);

DELETE FROM `creature_loot_template` WHERE (`Entry` IN (30452, 31534)) AND (`Item` IN (47241));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(30452, 47241, 0, 100, 0, 1, 0, 1, 1, 'Emblem of Triumph'),
(31534, 47241, 0, 100, 0, 1, 0, 1, 1, 'Emblem of Triumph');

-- Reduce Emblem of Triump (Sartharion 10M).
UPDATE `creature_loot_template` SET `MinCount` = 1, `MaxCount` = 1 WHERE (`Entry` = 28860) AND (`Item` IN (47241));
