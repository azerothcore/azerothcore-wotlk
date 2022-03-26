INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648306734434273023');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 12459) AND (`Item` IN (19362, 19434, 19435));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12459, 19362, 0, 2, 0, 1, 0, 1, 1, 'Blackwing Warlock - Doom\'s Edge'),
(12459, 19434, 0, 2, 0, 1, 0, 1, 1, 'Blackwing Warlock - Band of Dark Dominion'),
(12459, 19435, 0, 2, 0, 1, 0, 1, 1, 'Blackwing Warlock - Essence Gatherer');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 12457) AND (`Item` IN (19362, 19434, 19435));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12457, 19362, 0, 2, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Doom\'s Edge'),
(12457, 19434, 0, 2, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Band of Dark Dominion'),
(12457, 19435, 0, 2, 0, 1, 0, 1, 1, 'Blackwing Spellbinder - Essence Gatherer');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 12461) AND (`Item` IN (19362, 19434, 19435));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12461, 19362, 0, 2, 0, 1, 0, 1, 1, 'Death Talon Overseer - Doom\'s Edge'),
(12461, 19434, 0, 2, 0, 1, 0, 1, 1, 'Death Talon Overseer - Band of Dark Dominion'),
(12461, 19435, 0, 2, 0, 1, 0, 1, 1, 'Death Talon Overseer - Essence Gatherer');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 12460) AND (`Item` IN (19354, 19438, 19439));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(12460, 19354, 0, 5, 0, 1, 0, 1, 1, 'Death Talon Wyrmguard - Draconic Avenger'),
(12460, 19438, 0, 5, 0, 1, 0, 1, 1, 'Death Talon Wyrmguard - Ringo\'s Blizzard Boots'),
(12460, 19439, 0, 5, 0, 1, 0, 1, 1, 'Death Talon Wyrmguard - Interlaced Shadow Jerkin');
