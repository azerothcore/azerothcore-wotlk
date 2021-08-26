INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629981420936961816');

-- Change the allowed race to this quest

-- Only human Grimand Elmore (1700)
UPDATE `quest_template` SET `AllowableRaces` = 1 WHERE (`ID` = 1700);
-- Only dwarfs and gnomes Klockmort Spannerspan (1704)
UPDATE `quest_template` SET `AllowableRaces` = 68 WHERE (`ID` = 1704);
-- Only night elves Mathiel (1703)
UPDATE `quest_template` SET `AllowableRaces` = 8 WHERE (`ID` = 1703);

