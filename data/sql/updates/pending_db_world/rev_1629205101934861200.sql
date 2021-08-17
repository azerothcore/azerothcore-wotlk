INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629205101934861200');

DELETE FROM `creature_loot_template` WHERE (`Entry` = 9736) AND (`Item` IN (12835, 13252, 13253, 16716));
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9736, 12835, 0, 13, 0, 1, 0, 1, 1, 'Quartermaster Zigris - Plans: Annihilator'),
(9736, 13252, 0, 19, 0, 1, 1, 1, 1, 'Quartermaster Zigris - Cloudrunner Girdle'),
(9736, 13253, 0, 18, 0, 1, 1, 1, 1, 'Quartermaster Zigris - Hands of Power'),
(9736, 16716, 0, 1.1, 0, 1, 1, 1, 1, 'Quartermaster Zigris - Wildheart Belt');
