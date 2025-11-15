DELETE FROM smart_scripts WHERE entryorguid = 27598 AND source_type = 0;
UPDATE creature_template SET scriptname = 'npc_fetid_troll_corpse', AIName = '' WHERE entry = 27598;
