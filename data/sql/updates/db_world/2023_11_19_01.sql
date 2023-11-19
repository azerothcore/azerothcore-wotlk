-- DB update 2023_11_19_00 -> 2023_11_19_01
-- Doomguard Commander
DELETE FROM `spell_script_names` WHERE `spell_id`=23019;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 12396);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12396, 0, 0, 0, 0, 0, 100, 0, 5000, 8000, 18000, 24000, 0, 0, 11, 16005, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - In Combat - Cast \'Rain of Fire\''),
(12396, 0, 1, 0, 0, 0, 100, 0, 12000, 15000, 20000, 25000, 0, 0, 11, 16727, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - In Combat - Cast \'War Stomp\''),
(12396, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 25000, 32000, 0, 0, 11, 20812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - In Combat - Cast \'Cripple\''),
(12396, 0, 3, 0, 0, 0, 100, 0, 7000, 14000, 17000, 22000, 0, 0, 11, 15090, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - In Combat - Cast \'Dispel Magic\''),
(12396, 0, 4, 5, 8, 0, 100, 0, 23019, 0, 0, 0, 0, 0, 50, 179644, 180, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - On Spellhit \'Crystal Prison Dummy DND\' - Summon Gameobject \'Imprisoned Doomguard\''),
(12396, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - On Spellhit \'Crystal Prison Dummy DND\' - Despawn Instant');
