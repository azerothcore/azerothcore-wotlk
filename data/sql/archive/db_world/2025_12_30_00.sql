-- DB update 2025_12_29_19 -> 2025_12_30_00
--
DELETE FROM `creature_text` WHERE (`CreatureID` = 29306);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29306, 0, 0, 'I\'m gonna spill your guts, mon!', 14, 0, 100, 0, 0, 14430, 32534, 0, 'Gal\'darah - Aggro'),
(29306, 1, 0, 'What a rush!', 14, 0, 100, 0, 0, 14436, 32540, 0, 'Gal\'darah - Slay 1'),
(29306, 1, 1, 'Who needs gods when we ARE gods?', 14, 0, 100, 0, 0, 14437, 32541, 0, 'Gal\'darah - Slay 2'),
(29306, 1, 2, 'I told ya so!', 14, 0, 100, 0, 0, 14438, 32542, 0, 'Gal\'darah - Slay 3'),
(29306, 2, 0, 'Even the mighty... can fall.', 14, 0, 100, 0, 0, 14439, 32543, 0, 'Gal\'darah - Death'),
(29306, 3, 0, 'Gut them! Impale them!', 14, 0, 100, 0, 0, 14433, 32537, 0, 'Gal\'darah - Summon Rhino 1'),
(29306, 3, 1, 'KILL THEM ALL!', 14, 0, 100, 0, 0, 14434, 32538, 0, 'Gal\'darah - Summon Rhino 2'),
(29306, 3, 2, 'Say hello to my BIG friend!', 14, 0, 100, 0, 0, 14435, 32539, 0, 'Gal\'darah - Summon Rhino 3'),
(29306, 4, 0, 'Ain\'t gonna be nothin\' left after this!', 14, 0, 100, 0, 0, 14431, 32535, 0, 'Gal\'darah - Transform 1'),
(29306, 4, 1, 'You wanna see power? I\'m gonna show you power!', 14, 0, 100, 0, 0, 14432, 32536, 0, 'Gal\'darah - Transform 2'),
(29306, 5, 0, '$n is impaled!', 41, 0, 100, 0, 0, 0, 30718, 0, 'Gal\'darah - Impale');
