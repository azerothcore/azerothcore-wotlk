INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635649346761519900');

DELETE FROM `areatrigger_scripts` WHERE `entry` = 3957;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(3957, 'at_zulgurub_entrance_speech');

UPDATE `creature_text` SET `TextRange` = 3 WHERE `CreatureID` = 14834 AND `GroupID` = 3 AND `ID` = 0;
