INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648400638105454700');

DELETE FROM `spell_proc_event` WHERE `entry`=71756;
INSERT INTO `spell_proc_event` (`entry`, `procEx`, `procPhase`) VALUES
(71756,1027,2);
