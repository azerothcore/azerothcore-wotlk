--
UPDATE `creature_template_addon` SET `auras` = '18943' WHERE (`entry` = 20040);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20040);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20040, 0, 0, 0, 0, 0, 100, 0, 20950, 25000, 17000, 29900, 0, 0, 11, 37102, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Cast \'Knock Away\''),
(20040, 0, 1, 0, 0, 0, 100, 0, 20000, 30000, 30000, 40000, 0, 0, 11, 35035, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - In Combat - Cast \'Countercharge\''),
(20040, 0, 2, 5, 105, 0, 33, 0, 3600, 3600, 3600, 3600, 0, 50, 11, 35039, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Hostile Casting in Range - Cast \'Countercharge\' if Crystalcore Devastator has Countercharge aura'),
(20040, 0, 3, 4, 8, 0, 100, 512, 34946, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spellhit \'Golem Repair\' - Store Targetlist'),
(20040, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2004000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Spellhit \'Golem Repair\' - Run Script'),
(20040, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 35039, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crystalcore Devastator - On Hostile Casting in Range - Remove Aura \'Countercharge\'');
