INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621659447273280925');

DELETE FROM `reference_loot_template` WHERE `Entry` = 24062 AND `Item` = 880;

DELETE FROM `creature_loot_template` WHERE `Entry` = 202 AND `Item` = 880;

INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(202, 880, 0, 1.6, 0, 1, 0, 1, 1, "Skeletal Horror - Staff of Horrors");

