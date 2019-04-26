INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556310961403630000');

UPDATE quest_template SET RewardFactionOverride1 = 2500 WHERE ID = 13662;
UPDATE quest_template SET flags = 1 WHERE ID = 13662;
