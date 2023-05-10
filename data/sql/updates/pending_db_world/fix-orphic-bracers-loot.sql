DELETE FROM `reference_loot_template` WHERE `Item` = 18337;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(11480, 18337, 0, 0.7, 0, 1, 0, 1, 1, 'Arcane Aberration - Orphic Bracers'),
(14399, 18337, 0, 0.9, 0, 1, 0, 1, 1, 'Arcane Torrent - Orphic Bracers'),
(11483, 18337, 0, 0.8, 0, 1, 0, 1, 1, 'Mana Remnant - Orphic Bracers'),
(11484, 18337, 0, 0.9, 0, 1, 0, 1, 1, 'Residual Monstrosity - Orphic Bracers');
