INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624687532594694252');

-- Removes quest requirement from Belamoore's Research Journal junk drop
DELETE FROM `creature_loot_template` WHERE `Entry` = 2415 AND `Item` = 3711;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2415, 3711, 0, 100, 0, 1, 0, 1, 1, 'Warden Belamoore - Belamoore\'s Research Journal');
