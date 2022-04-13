INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649799370491572700');

DELETE FROM `areatrigger_scripts` WHERE `entry` = 3847;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(3847, 'at_orb_of_command');
