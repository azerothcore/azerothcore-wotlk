INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616756103204132721');

-- This quest is only for Draenei
UPDATE `quest_template` SET `AllowableRaces`=`AllowableRaces`|1024 WHERE `id`=9429;
