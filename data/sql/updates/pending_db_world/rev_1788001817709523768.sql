-- Kirtonos the Herald should always drop two equipment items.
DELETE FROM `creature_loot_template` WHERE `Entry` = 10506 AND (`Item` IN (13955, 13956, 13957, 13960, 13967, 13969, 13983, 14024, 16734) OR (`Item` = 1 AND `Reference` = 1025963));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(10506, 13956, 0, 18.44, 0, 1, 1, 1, 1, 'Kirtonos the Herald - Clutch of Andros'),
(10506, 13957, 0, 18.72, 0, 1, 1, 1, 1, 'Kirtonos the Herald - Gargoyle Slashers'),
(10506, 13960, 0, 18.71, 0, 1, 1, 1, 1, 'Kirtonos the Herald - Heart of the Fiend'),
(10506, 13967, 0, 18.69, 0, 1, 1, 1, 1, 'Kirtonos the Herald - Windreaver Greaves'),
(10506, 13969, 0, 18.70, 0, 1, 1, 1, 1, 'Kirtonos the Herald - Loomguard Armbraces'),
(10506, 1, 1025963, 0, 0, 1, 1, 1, 1, 'Kirtonos the Herald - Vanilla Greens 59-63 Level Range'),
(10506, 13955, 0, 18.30, 0, 1, 2, 1, 1, 'Kirtonos the Herald - Stoneform Shoulders'),
(10506, 13983, 0, 14.05, 0, 1, 2, 1, 1, 'Kirtonos the Herald - Gravestone War Axe'),
(10506, 14024, 0, 18.52, 0, 1, 2, 1, 1, 'Kirtonos the Herald - Frightalon'),
(10506, 16734, 0, 18.63, 0, 1, 2, 1, 1, 'Kirtonos the Herald - Boots of Valor'),
(10506, 1, 1025963, 0, 0, 1, 2, 1, 1, 'Kirtonos the Herald - Vanilla Greens 59-63 Level Range');
