-- DB update 2026_09_12_03 -> 2026_09_12_04
--
-- Ulduar boss loot: keep 10-man and 25-man items in their own pools

-- Hodir 10-man cache: Cowl of Icy Breaths instead of the 25-man bracers
DELETE FROM `reference_loot_template` WHERE `Entry` = 34367 AND `Item` IN (45454, 45464);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34367, 45464, 0, 0, 0, 1, 1, 1, 1, 'Cowl of Icy Breaths');

-- Hodir 25-man cache: two tier tokens like every other 25-man keeper cache
UPDATE `gameobject_loot_template` SET `MinCount` = 2, `MaxCount` = 2 WHERE `Entry` = 26946 AND `Item` = 2 AND `Reference` = 12029;

-- General Vezax 25-man: normal-mode weapons were in the hard-mode group
DELETE FROM `creature_loot_template` WHERE `Entry` = 33449 AND `Item` IN (45498, 45511);
DELETE FROM `reference_loot_template` WHERE `Entry` = 34374 AND `Item` IN (45498, 45511);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34374, 45498, 0, 0, 0, 1, 1, 1, 1, 'Lotrafen, Spear of the Damned'),
(34374, 45511, 0, 0, 0, 1, 1, 1, 1, 'Scepter of Lost Souls');

-- Flame Leviathan 25-man: normal-mode weapons were in the four-tower group
DELETE FROM `creature_loot_template` WHERE `Entry` = 34003 AND `Item` IN (45086, 45110);
DELETE FROM `reference_loot_template` WHERE `Entry` = 34352 AND `Item` IN (45086, 45110);
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(34352, 45086, 0, 0, 0, 1, 1, 1, 1, 'Rising Sun'),
(34352, 45110, 0, 0, 0, 1, 1, 1, 1, 'Titanguard');

-- Hodir 25-man hard-mode cache: Fragment of Val'anyr, Runed Orb and recipes like the other 25-man hard-mode caches
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 26950 AND `Item` IN (1, 45038, 45087);
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(26950, 1, 34154, 10, 0, 1, 0, 1, 1, 'Rare Cache of Winter - (ReferenceTable)'),
(26950, 45038, 0, 18, 0, 1, 0, 1, 1, 'Rare Cache of Winter - Fragment of Val\'anyr'),
(26950, 45087, 0, 10, 0, 1, 0, 1, 1, 'Rare Cache of Winter - Runed Orb');
