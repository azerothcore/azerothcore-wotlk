-- DB update 2024_03_06_00 -> 2024_03_08_00
--
DELETE FROM `creature_text` WHERE `CreatureID` = 18805;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18805, 0, 0, 'Tal anu\'men no sin\'dorei!', 14, 0, 100, 0, 0, 11134, 20849, 0, 'solarian SAY_AGGRO'),
(18805, 1, 0, 'You are hopelessly outmatched!', 14, 0, 100, 0, 0, 11139, 20854, 0, 'solarian SAY_SUMMON1'),
(18805, 1, 1, 'I will crush your delusions of grandeur!', 14, 0, 100, 0, 0, 11140, 20855, 0, 'solarian SAY_SUMMON2'),
(18805, 2, 0, 'Your soul belongs to the abyss!', 14, 0, 100, 0, 0, 11136, 20851, 0, 'solarian SAY_KILL1'),
(18805, 2, 1, 'By the blood of the Highborne!', 14, 0, 100, 0, 0, 11137, 20852, 0, 'solarian SAY_KILL2'),
(18805, 2, 2, 'For the Sunwell!', 14, 0, 100, 0, 0, 11138, 20853, 0, 'solarian SAY_KILL3'),
(18805, 3, 0, 'The warmth of the sun... awaits.', 14, 0, 100, 0, 0, 11135, 20850, 0, 'solarian SAY_DEATH'),
(18805, 4, 0, 'Enough of this!  Now I call upon the fury of the cosmos itself.', 14, 0, 100, 0, 0, 0, 20372, 0, 'solarian SAY_VOID1'),
(18805, 4, 1, 'I become ONE... with the VOID!', 14, 0, 100, 0, 0, 0, 20373, 0, 'solarian SAY_VOID2');
