-- DB update 2026_07_02_04 -> 2026_07_03_00
-- Register Freya Unstable Sun Beam spell script (targets up to 3 random players)
DELETE FROM `spell_script_names` WHERE `spell_id` = 62450;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62450, 'spell_freya_unstable_sun_beam');

-- Unstable Sun Beam NPC (33170) applies its own visual + Unstable Energy via SmartAI, since it is now
-- summoned on players by 62449 rather than by Freya (whose JustSummoned used to apply these).
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 33170;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 33170;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33170, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Just Summoned - Set React Passive'),
(33170, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 62216, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Link - Cast Unstable Sun Beam Visual'),
(33170, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 62451, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Link - Cast Unstable Energy');
