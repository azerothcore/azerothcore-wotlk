--
DELETE FROM `creature_text` WHERE `CreatureID` IN (34496, 34497) AND `GroupID` = 11;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(34496, 11, 0, 'You have Touch of |cFF9932CDDarkness.|r  Switch to |cFF9932CDDark|r Essence!', 42, 0, 100, 0, 0, 0, 35804, 0, 'Eydis Darkbane - Touch of Darkness whisper'),
(34497, 11, 0, 'You have Touch of |cFFFFFFFFLight.|r  Switch to |cFFFFFFFFLight|r Essence!', 42, 0, 100, 0, 0, 0, 35798, 0, 'Fjola Lightbane - Touch of Light whisper');
