INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622599423158947800');

SET @DINOSAUR_BONE = 11114;
UPDATE `creature_loot_template` SET `QuestRequired` = 1 WHERE `ITEM` = @DINOSAUR_BONE;
