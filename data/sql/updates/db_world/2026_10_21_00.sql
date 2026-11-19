-- DB update 2026_10_19_00 -> 2026_10_21_00
-- Hive'Regal, Hive'Ashi and Hive'Zora Glyphed Crystals never respawn, so a not-repeatable rubbing cast only ever fires once per grid load
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (180453, 180454, 180455) AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(180453, 1, 0, 1, 62, 0, 100, 0, 6561, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Regal Glyphed Crystal - On Gossip Option 0 Selected - Close Gossip'),
(180453, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 24807, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Regal Glyphed Crystal - On Gossip Option 0 Selected - Cast Create Hive\'Regal Rubbing DND'),
(180454, 1, 0, 1, 62, 0, 100, 0, 6560, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Ashi Glyphed Crystal - On Gossip Option 0 Selected - Close Gossip'),
(180454, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 24806, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Ashi Glyphed Crystal - On Gossip Option 0 Selected - Cast Create Hive\'Ashi Rubbing DND'),
(180455, 1, 0, 1, 62, 0, 100, 0, 6559, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zora Glyphed Crystal - On Gossip Option 0 Selected - Close Gossip'),
(180455, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 134, 24805, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hive\'Zora Glyphed Crystal - On Gossip Option 0 Selected - Cast Create Hive\'Zora Rubbing DND');
