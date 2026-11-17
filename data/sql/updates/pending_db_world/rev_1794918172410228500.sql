--
-- The pilot's attack command reaches AttackStart; the script adds the melee VehicleAI lacks.
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_warbear_matriarch' WHERE `entry` = 29918;

-- Kirgaraak: the bear's swings can skip the 0-5% health window, so keep him alive until it runs.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29352);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29352, 0, 0, 0, 2, 0, 100, 512, 0, 5, 0, 0, 0, 0, 80, 2935200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirgaraak - Between 0-5% Health - Run Script'),
(29352, 0, 1, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 11, 24921, 200, 0, 0, 0, 0, 0, 0, 'Kirgaraak - On Reset - Set Data Cosmetic Trigger'),
(29352, 0, 2, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kirgaraak - On Reset - Set Invincibility Hp 1%');
