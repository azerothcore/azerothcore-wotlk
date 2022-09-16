-- DB update 2022_09_08_01 -> 2022_09_08_02
--
DELETE FROM `reference_loot_template` WHERE `Entry`=34024 AND `Item` BETWEEN 21281 AND 21283;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Chance`, `GroupId`, `Comment`) VALUES
(34024, 21281, 0, 3, 'Grimoire of Shadow Bolt X'),
(34024, 21282, 0, 3, 'Grimoire of Immolate VIII'),
(34024, 21283, 0, 3, 'Grimoire of Corruption VII');
