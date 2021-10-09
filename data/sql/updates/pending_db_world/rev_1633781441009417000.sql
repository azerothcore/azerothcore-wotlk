INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633781441009417000');

-- Target: Felstone Field
UPDATE `quest_template` SET `RewardFactionOverride2`='50000' WHERE `ID`=5229;
-- Dead Man's Plea
UPDATE `quest_template` SET `RewardFactionOverride1`='100000' WHERE `ID`=8945;
-- Above and Beyond
UPDATE `quest_template` SET `RewardFactionOverride1`='100000' WHERE  `ID`=5263;
