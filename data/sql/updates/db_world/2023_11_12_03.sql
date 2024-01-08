-- DB update 2023_11_12_02 -> 2023_11_12_03
--
DELETE FROM `creature_loot_template` WHERE `item` = 32897 AND `entry` IN (21218, 21220, 21221, 21229, 21230, 21231, 21232, 21251, 21263, 21298, 21299, 21301, 21339, 21863);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21218, 32897, 0, 11, 0, 1, 0, 1, 1, 'Vashj\'ir Honor Guard - Mark of the Illidari'),
(21220, 32897, 0, 12, 0, 1, 0, 1, 1, 'Coilfang Priestess - Mark of the Illidari'),
(21221, 32897, 0, 10, 0, 1, 0, 1, 1, 'Coilfang Beast-Tamer - Mark of the Illidari'),
(21229, 32897, 0, 13, 0, 1, 0, 1, 1, 'Greyheart Tidecaller - Mark of the Illidari'),
(21230, 32897, 0, 14, 0, 1, 0, 1, 1, 'Greyheart Nether-Mage - Mark of the Illidari'),
(21231, 32897, 0, 13, 0, 1, 0, 1, 1, 'Greyheart Shield-Bearer - Mark of the Illidari'),
(21232, 32897, 0, 12, 0, 1, 0, 1, 1, 'Greyheart Skulker - Mark of the Illidari'),
(21251, 32897, 0, 15, 0, 1, 0, 1, 1, 'Underbog Colossus - Mark of the Illidari'),
(21263, 32897, 0, 11, 0, 1, 0, 1, 1, 'Greyheart Technician - Mark of the Illidari'),
(21298, 32897, 0, 12, 0, 1, 0, 1, 1, 'Coilfang Serpentguard - Mark of the Illidari'),
(21299, 32897, 0, 10, 0, 1, 0, 1, 1, 'Coilfang Fathom-Witch - Mark of the Illidari'),
(21301, 32897, 0, 11, 0, 1, 0, 1, 1, 'Coilfang Shatterer - Mark of the Illidari'),
(21339, 32897, 0, 11, 0, 1, 0, 1, 1, 'Coilfang Hate-Screamer - Mark of the Illidari'),
(21863, 32897, 0, 8, 0, 1, 0, 1, 1, 'Serpentshrine Lurker - Mark of the Illidari');
