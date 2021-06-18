INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623249558553944112');

DELETE FROM `creature_loot_template` WHERE `Item` = 9484 AND `Entry` IN (8127, 7267);
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8127, 9484, 0, 0.01, 0, 1, 0, 1, 1, 'Antu\'Sul - Spellshock Leggings'),
(7267, 9484, 0, 0.01, 0, 1, 0, 1, 1, 'Cfieg Ukorz Sandscalp - Spellshock Leggings');
