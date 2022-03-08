INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646700419097300800');

DELETE FROM `areatrigger_scripts` WHERE `entry` = 3960;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(3960, 'at_zulgurub_temple_speech');
