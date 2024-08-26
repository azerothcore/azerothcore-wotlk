-- Removes creature reference to broadcast text
/*
https://www.azerothcore.org/wiki states that broadcast text table contains only confirmed retail data.
So to avoid polluting the table issue #19480 is being fixed in creature_text table instead.
More info in issue #19480 and PR #19542
*/
DELETE FROM `creature_text` WHERE `CreatureID` IN (16325, 16326);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(16325, 0, 0, '%s shimmers and becomes intangible!', 16, 0, 100, 0, 0, 0, 0, 0, 'Quel\'dorei Ghost'),
(16326, 0, 0, '%s shimmers and becomes intangible!', 16, 0, 100, 0, 0, 0, 0, 0, 'Quel\'dorei Wraith');
