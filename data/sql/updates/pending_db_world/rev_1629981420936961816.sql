INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629981420936961816');

-- Change the allowed race to this quest (Flags: Human 1, Dwarf 4, Night elf 8, Gnome 64, Draenei 1024)

-- Only human Grimand Elmore (1700)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(4|8|64|1024) WHERE (`ID` = 1700);
-- Only dwarfs and gnomes Klockmort Spannerspan (1704)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(1|8|1024) WHERE (`ID` = 1704);
-- Only night elves Mathiel (1703)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`&~(1|4|64|1024) WHERE (`ID` = 1703);

