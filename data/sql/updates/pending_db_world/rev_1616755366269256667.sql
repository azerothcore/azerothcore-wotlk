INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616755366269256667');

-- This quest is for all races, not just undeads
UPDATE `quest_template` SET `AllowableRaces`=`AllowableRaces` &~16 WHERE `id`=367;
