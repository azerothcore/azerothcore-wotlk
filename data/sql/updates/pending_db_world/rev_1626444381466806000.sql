INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626444381466806000');

DELETE FROM `creature_loot_template` WHERE `Entry` IN (193, 6130, 6129, 6131) AND `Item` = 21949;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(193, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Blue Dragonspawn - Design: Ruby Serpent'),
(6130, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Blue Scalebane - Design: Ruby Serpent'),
(6129, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Draconic Magelord - Design: Ruby Serpent'),
(6131, 21949, 0, 0.5, 0, 1, 1, 1, 1, 'Draconic Mageweaver - Design: Ruby Serpent');
