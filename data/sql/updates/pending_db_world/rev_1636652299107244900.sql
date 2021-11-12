INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636652299107244900');

DELETE FROM `creature_text` WHERE `CreatureID` = 10316;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10316, 0, 0, '%s attempts to run away in fear!', 16, 0, 100, 0, 0, 0, 1150, 0, 'Blackhand Incarcerator - EMOTE_FLEE');
