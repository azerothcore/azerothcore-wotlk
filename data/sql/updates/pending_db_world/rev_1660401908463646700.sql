--
DELETE FROM `creature_text` WHERE `CreatureID`=15264;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(15264,0,0,'%s becomes enraged!',16,0,100,0,0,0,24144,0,'Anubisath Sentinel');
