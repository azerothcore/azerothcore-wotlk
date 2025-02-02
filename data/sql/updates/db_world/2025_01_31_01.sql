-- DB update 2025_01_31_00 -> 2025_01_31_01
-- Add pure energy immune script for Vex
UPDATE `creature_template` SET `ScriptName` = 'npc_pure_energy' WHERE (`entry` = 24745);

-- AOE_IMMUNE Flag for pure energy
UPDATE `creature_template` SET `flags_extra` = (`flags_extra` | 4194304) WHERE (`entry` = 24745);

-- Vexallus (Entry: 24744) Overload Emote with broadcasttextid 77866
DELETE FROM `creature_text` WHERE `CreatureID` = 24744 AND `GroupID` = 5 AND `ID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24744, 5, 0, 'Vexallus overloads!', 41, 0, 100, 0, 0, 0, 23781, 0, 'Vexallus - EMOTE_OVERLOAD');
