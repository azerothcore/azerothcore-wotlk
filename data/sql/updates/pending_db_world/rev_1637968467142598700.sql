INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637968467142598700');

DELETE FROM `creature_text` WHERE `CreatureID` = 16097;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16097, 0, 0, 'My torture is ended and now I can join the Goddess. Thank you so very much!', 14, 0, 100, 0, 0, 0, 11860, 0, 'Isalien - ON DEATH');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_isalien' WHERE `entry` = 16097;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 16097 AND `source_type` = 0;
