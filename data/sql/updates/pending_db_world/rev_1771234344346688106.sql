-- DRAKURU Replace Elixir

-- Fix Replace Drakuru's Elixir gossip to triggered spell to allow casting while mounted
UPDATE `smart_scripts` SET  `action_param2` = 2 WHERE (`entryorguid` = 26423) AND (`source_type` = 0) AND (`id` IN (2));
