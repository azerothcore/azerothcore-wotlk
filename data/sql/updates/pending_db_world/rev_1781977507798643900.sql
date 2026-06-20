-- Wright Williams (28355) banter fix: groups 0-3 had Text/BroadcastTextId scrambled,
-- making the Miles Sidney <-> Wright Williams conversations nonsensical, and group 3
-- pointed at BroadcastTextId 27809 ("Skadi the Ruthless is within range...").
-- Realign with correct broadcast lines so the scripted conversations read coherently.
DELETE FROM `creature_text` WHERE `CreatureID` = 28355 AND `GroupID` IN (0,1,2,3);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28355,0,0,'Sir, our customers are complaining that there\'s not enough Maiden\'s Anguish in our Deadly Poisons.',12,0,100,0,0,0,27801,0,'Wright Williams'),
(28355,1,0,'Sir, I think we were close with the Lethargy Root in that last poison recipe.',12,0,100,0,0,0,27803,0,'Wright Williams'),
(28355,2,0,'I\'m working on it, I just don\'t want to sell it until I\'m happy with it. It shouldn\'t be long.',12,0,100,0,0,0,27808,0,'Wright Williams'),
(28355,3,0,'Sir, our customers are complaining that there\'s too much Deathweed in our Anesthetics.',12,0,100,0,0,0,27802,0,'Wright Williams');
