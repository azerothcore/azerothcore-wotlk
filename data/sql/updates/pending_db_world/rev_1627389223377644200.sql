INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627389223377644200');

-- Changed the side to be alliance only so it cant be shareable between horde
UPDATE `quest_template` SET `AllowableRaces` = 1101 WHERE (`ID` = 1142);

