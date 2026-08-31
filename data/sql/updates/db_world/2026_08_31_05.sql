-- DB update 2026_08_31_04 -> 2026_08_31_05
-- Trapdoor Crawler (28221): stop Poison cast from ignoring caster CC (remove SMARTCAST_TRIGGERED)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28221);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28221, 0, 0, 0, 1, 0, 100, 0, 20000, 30000, 20000, 30000, 0, 0, 11, 50981, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - Out of Combat - Cast \'Burrow\''),
(28221, 0, 1, 0, 23, 0, 100, 0, 50981, 1, 40000, 50000, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - On Aura \'Burrow\' - Remove Aura \'null\''),
(28221, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 50981, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - On Aggro - Remove Aura \'Burrow\''),
(28221, 0, 3, 0, 0, 0, 100, 0, 2000, 5000, 4000, 8000, 0, 0, 11, 11918, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Trapdoor Crawler - In Combat - Cast \'Poison\'');
