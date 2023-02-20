-- Yogg Saron Vision -- Add missing text
DELETE FROM `creature_text` WHERE `CreatureID`=33552;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33552, 0, 0, 'A thousand deaths....', 12, 0, 100, 0, 0, 15762, 33616, 0, 'Yogg-Saron'),
(33552, 1, 0, 'Or one murder.', 12, 0, 100, 0, 0, 15763, 33617, 0, 'Yogg-Saron'),
(33552, 2, 0, 'Your petty quarrels only make me stronger.', 12, 0, 100, 0, 0, 15764, 34188, 0, 'Yogg-Saron'),
(33552, 3, 0, 'Yrr n\'lyeth... shuul anagg!', 12, 0, 100, 0, 0, 15766, 33628, 0, 'Yogg-Saron'),
(33552, 4, 0, 'He will learn... no king rules forever; only death is eternal!', 12, 0, 100, 0, 0, 15767, 33629, 0, 'Yogg-Saron'),
(33552, 5, 0, 'His brood learned their lesson before too long. You will soon learn yours!', 12, 0, 100, 0, 0, 15765, 33663, 0, 'Yogg-Saron');
