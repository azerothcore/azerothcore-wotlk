INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629919057423789312');

-- Change the race to blood elf for this quests on Sunstrider isle
UPDATE `quest_template` SET `AllowableRaces` = 512 WHERE (`ID` IN (8325, 9393, 9676, 8328, 8563, 8564, 9392, 8326, 8327, 8334, 8335, 8347, 8338, 8336, 8330, 8345, 0069, 10070, 10071, 10072, 10073));

