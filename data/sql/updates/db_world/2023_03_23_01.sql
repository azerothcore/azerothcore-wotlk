-- DB update 2023_03_23_00 -> 2023_03_23_01
-- Prince Keleseth (Utgarde Keep)
DELETE FROM `creature_text` WHERE `CreatureID`=23953 AND `GroupID`=6;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23953, 6, 0, 'Darkness waits.', 14, 0, 0, 0, 0, 13223, 29591, 0, 'Prince Keleseth - SAY_KILL');

DELETE FROM `creature_text_locale` WHERE `CreatureID`=23953 AND `GroupID`=6 AND `Locale`='zhCN';
INSERT INTO `creature_text_locale` (`CreatureID`, `GroupID`, `ID`, `Locale`, `Text`) VALUES
(23953, 6, 0, 'zhCN', '黑暗在等着你呢。');
