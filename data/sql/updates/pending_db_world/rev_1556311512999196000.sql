INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1556311512999196000');

UPDATE quest_template SET `RewardFactionOverride1` = 2500 WHERE `ID` = 13662;
UPDATE quest_template SET `flags` = 1 WHERE ID = 13662;
