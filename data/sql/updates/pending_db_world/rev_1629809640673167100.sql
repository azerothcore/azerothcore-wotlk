INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629809640673167100');

# Restrict quest Report to Splintertree Post(ID 9428), Delivery to the Sepulcher(ID 9189) and Report to Tarren Mill(ID 9425) to only allow blood elfs
UPDATE `quest_template` SET `AllowableRaces` = 512 WHERE `ID` IN (9189, 9425, 9428);
