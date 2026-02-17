-- Add creature_text for Stephanie Sindree (31019)
DELETE FROM `creature_text` WHERE `CreatureID` = 31019;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31019, 0, 0, 'It wasn''t my food!', 12, 0, 100, 6, 0, 0, 31838, 0, 'Stephanie Sindree - Stephanie Crowd'),
(31019, 1, 0, 'Please, it''s not my fault! If... if I give you a refund, maybe you can speak to a healer? I don''t know what you expect me to do!', 12, 0, 100, 20, 0, 0, 31840, 0, 'Stephanie Sindree - Stephanie Crowd');

-- Add creature_text for Agitated Stratholme Citizen (31126) - Stephanie Crowd
DELETE FROM `creature_text` WHERE `CreatureID` = 31126 AND `GroupID` IN (4, 5, 6);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31126, 4, 0, 'My wife and children are sick in bed because of the poison you sold me!', 12, 0, 100, 5, 0, 0, 31837, 0, 'Agitated Stratholme Citizen - Stephanie Crowd'),
(31126, 5, 0, 'Don''t try to weasel out of this!', 12, 0, 100, 25, 0, 0, 31839, 0, 'Agitated Stratholme Citizen - Stephanie Crowd'),
(31126, 6, 0, 'That... no, keep your filthy money! It won''t help my family!', 12, 0, 100, 5, 0, 0, 31842, 0, 'Agitated Stratholme Citizen - Stephanie Crowd');
