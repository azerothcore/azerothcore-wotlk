-- DB update 2025_08_13_00 -> 2025_08_14_00
-- Allow Anub'ar warrior to use Strike ability. (Set the event_type 0 to "incombat update" instead of "out of combat update")
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28732;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28732) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28732, 0, 0, 0, 0, 0, 100, 0, 2000, 5000, 6000, 8000, 0, 0, 11, 52532, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, "Anub'ar Warrior - In Combat - Cast Strike");

-- Fix misplaced spell IDs in spelldifficulty for Skittering Infector's Acid Splash
UPDATE `spelldifficulty_dbc` SET `DifficultySpellID_1` = 52446 WHERE `ID` = 59363;
UPDATE `spelldifficulty_dbc` SET `DifficultySpellID_2` = 59363 WHERE `ID` = 59363;
