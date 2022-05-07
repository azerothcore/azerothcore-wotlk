--
DELETE FROM `creature_text` WHERE `CreatureID` = 25740 AND `GroupID` = 0
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES (25740, 0, 0, "Ahune Retreats. His defenses diminish.", 41, 0, 100, 0, 0, 0, 0, 0, "ahune EMOTE_RETREAT");

DELETE FROM `creature_text` WHERE `CreatureID` = 25740 AND `GroupID` = 1
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES (25740, 1, 0, "Ahune will soon resurface.", 41, 0, 100, 0, 0, 0, 0, 0, "ahune EMOTE_RESURFACE");