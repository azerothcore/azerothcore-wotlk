INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629809640673167100');

# Restrict quest Report to Splintertree Post(ID 9428) to only allow blood elfs
UPDATE `quest_template` SET `AllowableRaces` = 512 WHERE (`ID` = 9428);