-- DB update 2026_04_30_00 -> 2026_04_30_01
--
-- BRD: Hurley Blackbreath (9537) and Blackbreath Cronies (per-spawn
-- overrides -71997/-71998/-71999) start with UNIT_FLAG_UNK_6 |
-- UNIT_FLAG_IMMUNE_TO_PC (320) and only clear it via "OnReachedWP 3".
-- The encounter propagates aggro: any mob entering combat fires
-- OnAggro -> SetData 1=2 on every member, which triggers OnDataSet 1=2
-- -> Attack on the rest. If a peer is still walking its WP path when
-- this happens, its movement is interrupted, WP 3 is never reached,
-- and the immunity flag is never cleared -> the mob stays in combat
-- but cannot be damaged or targeted.
--
-- Failsafe: any combat-entry path also clears flag 320 on the unit.
-- Two new rows per entity: one on OnAggro, one on OnDataSet 1=2.
--

-- Hurley Blackbreath
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 9537) AND (`id` IN (19, 20));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9537, 0, 19, 0,  4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hurley Blackbreath - On Aggro - Remove Unit Flags Immune To PC (failsafe if pulled before reaching WP 3)'),
(9537, 0, 20, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hurley Blackbreath - On Data Set 1=2 - Remove Unit Flags Immune To PC (failsafe if pulled before reaching WP 3)');

-- Blackbreath Crony spawn 71997
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = -71997) AND (`id` IN (14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-71997, 0, 14, 0,  4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackbreath Crony - On Aggro - Remove Unit Flags Immune To PC (failsafe)'),
(-71997, 0, 15, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackbreath Crony - On Data Set 1=2 - Remove Unit Flags Immune To PC (failsafe)');

-- Blackbreath Crony spawn 71998
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = -71998) AND (`id` IN (14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-71998, 0, 14, 0,  4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackbreath Crony - On Aggro - Remove Unit Flags Immune To PC (failsafe)'),
(-71998, 0, 15, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackbreath Crony - On Data Set 1=2 - Remove Unit Flags Immune To PC (failsafe)');

-- Blackbreath Crony spawn 71999
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = -71999) AND (`id` IN (14, 15));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-71999, 0, 14, 0,  4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackbreath Crony - On Aggro - Remove Unit Flags Immune To PC (failsafe)'),
(-71999, 0, 15, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 19, 320, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blackbreath Crony - On Data Set 1=2 - Remove Unit Flags Immune To PC (failsafe)');
