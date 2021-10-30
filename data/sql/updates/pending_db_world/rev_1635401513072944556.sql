INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635401513072944556');

-- Updates quest 5057 (Past Endeavors) to be available to both factions
UPDATE `quest_template` SET `AllowableRaces` = 0 WHERE (`ID` = 5057);
