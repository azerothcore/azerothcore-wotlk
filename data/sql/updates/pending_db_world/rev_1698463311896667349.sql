-- Thekal (14509)
-- Update SAY_AGGRO to include emote ONESHOT_ROAR
-- Update comments
DELETE FROM `creature_text` WHERE `CreatureID`=14509;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14509, 0, 0, 'Shirvallah, fill me with your RAGE!', 14, 0, 100, 15, 0, 8419, 10455, 0, 'High Priest Thekal - BOSS_SAY_AGGRO'),
(14509, 1, 0, 'Hakkar binds me no more!  Peace at last!', 14, 0, 100, 0, 0, 8424, 10451, 0, 'High Priest Thekal - BOSS_SAY_DEATH'),
(14509, 2, 0, '%s dies.', 16, 0, 100, 0, 0, 0, 8251, 3, 'High Priest Thekal - BOSS_EMOTE_DIES');

-- Thekal (14509)
-- Remove static idle (talking) emote
DELETE FROM `creature_addon` WHERE (`guid` IN (49310));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(49310, 0, 0, 0, 0, 0, 0, '');

-- Zealot Lor'Khan (11347)
-- Update comments
DELETE FROM `creature_text` WHERE `CreatureID`=11347;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11347, 0, 0, '%s dies.', 16, 0, 100, 0, 0, 0, 8251, 3, 'Zealot Lor\'Khan - ZEALOT_EMOTE_DIES');

-- Zealot Zath (11348)
-- Update comments
DELETE FROM `creature_text` WHERE `CreatureID`=11348;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(11348, 0, 0, '%s dies.', 16, 0, 100, 0, 0, 0, 8251, 3, 'Zealot Zath - ZEALOT_EMOTE_DIES');
