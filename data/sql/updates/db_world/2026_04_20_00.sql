-- DB update 2026_04_17_02 -> 2026_04_20_00
DELETE FROM `spell_script_names` WHERE `spell_id` IN (45057, 52420, 71634, 71640, 75475, 75481) OR `ScriptName` IN ('spell_item_commendation_of_kaelthas', 'spell_item_corpse_tongue_coin', 'spell_item_corpse_tongue_coin_heroic', 'spell_item_petrified_twilight_scale', 'spell_item_petrified_twilight_scale_heroic', 'spell_item_soul_harvesters_charm');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45057, 'spell_item_proc_below_pct_damaged'),
(52420, 'spell_item_proc_below_pct_damaged'),
(71634, 'spell_item_proc_below_pct_damaged'),
(71640, 'spell_item_proc_below_pct_damaged'),
(75475, 'spell_item_proc_below_pct_damaged'),
(75481, 'spell_item_proc_below_pct_damaged');
