-- DB update 2025_08_27_01 -> 2025_08_27_02
--
UPDATE `creature_template` SET `ScriptName` = '', `AIName` = 'SmartAI' WHERE (`entry` = 16143);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16143) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16143, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5000, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - On Just Summoned - Say Line 0'),
(16143, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 10389, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - On Just Summoned - Cast \'Spawn Smoke\''),
(16143, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - On Just Summoned - Set Flags Immune To Players'),
(16143, 0, 3, 0, 52, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - On Text 0 Over - Remove Flags Immune To Players'),
(16143, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 28056, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - On Just Died - Cast \'Zap Crystal Corpse\''),
(16143, 0, 5, 0, 8, 0, 100, 0, 17680, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - On Spellhit \'Spirit Spawn-out\' - Despawn In 3000 ms'),
(16143, 0, 6, 0, 0, 0, 100, 0, 2000, 2000, 6500, 13000, 0, 0, 11, 16568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - In Combat - Cast \'Mind Flay\''),
(16143, 0, 7, 0, 0, 0, 100, 0, 2000, 2000, 14500, 14500, 0, 0, 11, 12542, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadow of Doom - In Combat - Cast \'Fear\'');
