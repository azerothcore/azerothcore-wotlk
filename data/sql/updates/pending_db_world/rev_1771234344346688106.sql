-- DRAKURU Replace Elixir

-- Fix Replace Drakuru's Elixir gossip to triggered spell to allow casting while mounted
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26423) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26423, 0, 2, 3, 62, 0, 100, 0, 9615, 1, 0, 0, 0, 0, 134, 50021, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Drakuru - On Gossip Option 1 Selected - Invoker Cast ''Replace Drakuru\'s Elixir''');
