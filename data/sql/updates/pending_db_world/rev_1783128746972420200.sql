-- SPELL_TRANSFORM_GHOST and SPELL_FORGIVENESS

DELETE FROM `spell_script_names`
WHERE `spell_id` IN (28443, 28697);

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(28443, 'spell_transform_ghost_visual'),
(28697, 'spell_forgiveess_dummy_visual');

-- Smartscript
-- Deleted  28 due to SPELL_FORGIVENESS attack death
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3976) AND (`source_type` = 0) AND (`id` IN (24, 28, 29));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3976, 0, 24, 28, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Start Attacking'),--Change link 29 to 28
(3976, 0, 28, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Commander Mograine - On Reached Point 1 - Enable Evade');-- Change id 29 to 28
