-- DB update 2026_08_09_05 -> 2026_08_09_06
--
DELETE FROM `creature_text` WHERE (`CreatureID` IN (32916, 32919, 33202, 33398, 33400, 33401));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(32916, 0, 0, 'The %s withers into the earth and begins to regenerate.', 16, 0, 100, 0, 0, 0, 33463, 0, 'Snaplasher EMOTE_TRIO_WITHERS'),
(32916, 1, 0, 'With the help of its allies the %s regenerates back to life.', 16, 0, 100, 0, 0, 0, 33464, 0, 'Snaplasher EMOTE_TRIO_REGENERATES'),
(33400, 0, 0, 'The %s withers into the earth and begins to regenerate.', 16, 0, 100, 0, 0, 0, 33463, 0, 'Snaplasher EMOTE_TRIO_WITHERS'),
(33400, 1, 0, 'With the help of its allies the %s regenerates back to life.', 16, 0, 100, 0, 0, 0, 33464, 0, 'Snaplasher EMOTE_TRIO_REGENERATES'),
(32919, 0, 0, 'The %s withers into the earth and begins to regenerate.', 16, 0, 100, 0, 0, 0, 33463, 0, 'Storm Lasher EMOTE_TRIO_WITHERS'),
(32919, 1, 0, 'With the help of its allies the %s regenerates back to life.', 16, 0, 100, 0, 0, 0, 33464, 0, 'Storm Lasher EMOTE_TRIO_REGENERATES'),
(33401, 0, 0, 'The %s withers into the earth and begins to regenerate.', 16, 0, 100, 0, 0, 0, 33463, 0, 'Storm Lasher EMOTE_TRIO_WITHERS'),
(33401, 1, 0, 'With the help of its allies the %s regenerates back to life.', 16, 0, 100, 0, 0, 0, 33464, 0, 'Storm Lasher EMOTE_TRIO_REGENERATES'),
(33202, 0, 0, 'The %s withers into the earth and begins to regenerate.', 16, 0, 100, 0, 0, 0, 33463, 0, 'Ancient Water Spirit EMOTE_TRIO_WITHERS'),
(33202, 1, 0, 'With the help of its allies the %s regenerates back to life.', 16, 0, 100, 0, 0, 0, 33464, 0, 'Ancient Water Spirit EMOTE_TRIO_REGENERATES'),
(33398, 0, 0, 'The %s withers into the earth and begins to regenerate.', 16, 0, 100, 0, 0, 0, 33463, 0, 'Ancient Water Spirit EMOTE_TRIO_WITHERS'),
(33398, 1, 0, 'With the help of its allies the %s regenerates back to life.', 16, 0, 100, 0, 0, 0, 33464, 0, 'Ancient Water Spirit EMOTE_TRIO_REGENERATES');
