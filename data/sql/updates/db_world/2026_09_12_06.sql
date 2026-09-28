-- DB update 2026_09_12_05 -> 2026_09_12_06
--
-- Unstable Sun Beam (33050) now owns its own lifetime instead of relying on Elder Brightleaf's
-- event map, which stops running the moment he dies and left the beams up forever.
-- AIName/ScriptName resolve from the base entry, so this covers the 25-man template (33395) too.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 33050;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 33050);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(33050, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Just Summoned - Set React Passive'),
(33050, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 62211, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Link - Cast Unstable Sun Beam'),
(33050, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 62209, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Link - Cast Photosynthesis'),
(33050, 0, 3, 4, 60, 0, 100, 1, 18000, 25000, 0, 0, 0, 0, 11, 62217, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Update - Cast Unstable Energy'),
(33050, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Unstable Sun Beam - On Link - Despawn');
