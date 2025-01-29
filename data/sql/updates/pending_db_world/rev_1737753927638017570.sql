-- Add pure energy immune script for Vex
DELETE FROM `creature_template` WHERE `ScriptName` = 'npc_pure_energy' AND entry = 24745;
UPDATE `creature_template` SET `ScriptName` = 'npc_pure_energy' WHERE (`entry` = 24745);

-- AOE_IMMUNE Flag for pure energy
UPDATE `creature_template` SET `flags_extra` = (`flags_extra` | 4194304) WHERE (`entry` = 24745);

-- Vexallus (Entry: 24744) Overload Emote with broadcasttextid 77866
DELETE FROM `creature_text` WHERE `CreatureID` = 24744 AND `GroupID` = 5 AND `ID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24744, 5, 0, 'Vexallus overloads!', 41, 0, 100, 0, 0, 0, 77866, 0, 'Vexallus - EMOTE_OVERLOAD');

-- Add to broadcast_text used SELECT MAX(ID) + 1 FROM broadcast_text; for next ID
DELETE FROM `broadcast_text` WHERE `ID` = 77866;
INSERT INTO `broadcast_text`(`ID`, `LanguageID`, `MaleText`, `FemaleText`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesId`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES
(77866, 0, 'Vexallus overloads!', 'Vexallus overloads!', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
