INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648383353183302321');
-- This updates the existing proc to allow trinket to pop on any melee damage including melee spells
UPDATE `spell_proc_event` SET `SchoolMask`='1' AND `ProcFlags`='20' WHERE `entry`='15600';
