INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630612914773827858');

-- Set Nessa Shadowsong Quest Chain To Night Elf Only
UPDATE `quest_template` SET `AllowableRaces` = 8 WHERE `ID` IN (6344, 6341, 6342, 6343);
