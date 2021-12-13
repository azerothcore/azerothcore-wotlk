INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639428645054557700');

UPDATE `quest_template` SET `RewardNextQuest` = 1518 WHERE `ID` = 1517;
UPDATE `quest_template` SET `RewardNextQuest` = 1521 WHERE `ID` = 1520;
UPDATE `quest_template` SET `RewardNextQuest` = 1517 WHERE `ID` = 1516;
UPDATE `quest_template` SET `RewardNextQuest` = 1520 WHERE `ID` = 1519;
UPDATE `quest_template` SET `Flags`='65536' WHERE `ID` IN (1463, 1462);
