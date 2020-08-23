INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595118810076078406');

UPDATE `creature_loot_template` SET `Chance` = 40 WHERE `Entry` = 3672 AND `Item` = 5423;
UPDATE `creature_loot_template` SET `Chance` = 60, `GroupId` = 1 WHERE `Entry` = 3672 AND `Item` = 5422;

