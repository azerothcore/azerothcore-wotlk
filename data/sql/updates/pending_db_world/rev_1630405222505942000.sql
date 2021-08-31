INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630405222505942000');

UPDATE `gameobject_loot_template` SET `QuestRequired`=1 WHERE `item`=45328;
UPDATE `reference_loot_template` SET `QuestRequired`=1 WHERE `item`=45328;
