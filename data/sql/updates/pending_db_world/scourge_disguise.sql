-- Fix double cast of Scourge Disguise
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28669);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(28669, 0, 0, 1, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 28, 51966, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Just Summoned - Remove \'Scourge Disguise[51966]\''),
(28669, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 52191, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Just Summoned - Cast \'Scourge Disguise[52191]\''),
(28669, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 2866900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Just Summoned - Run Script'),
(28669, 0, 3, 0, 40, 0, 100, 512, 62, 28669, 0, 0, 0, 0, 11, 52220, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 62 Reached - Cast \'Kill Credit\''),
(28669, 0, 4, 5, 40, 0, 100, 512, 63, 28669, 0, 0, 0, 0, 28, 52191, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Remove \'Scourge Disguise[52191]\''),
(28669, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 75, 52192, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Cast \'Scourge Disguise[52192]\''),
(28669, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 75, 51971, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Cast \'Scourge Disguise Instability[51971]\''),
(28669, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 50630, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Flying Fiend - On Waypoint 63 Reached - Cast \'Eject All Passengers\'');

-- Add or Remove linked to Scourge Disguise  spells
DELETE FROM `spell_linked_spell` WHERE (`spell_trigger` IN ( -52010, -52192, -51966, 51966, 52192));
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-52010, -52192, 0, 'Remove Scourge Disguise [52192]'),
(-52010, -51966, 0, 'Remove Scourge Disguise [51966]'),
(-52192, -51971, 0, 'Remove Scourge Disguise Instability [51971]'),
(-51966, -51971, 0, 'Remove Scourge Disguise Instability [51971]'),
(51966, -52192, 0, 'Remove Scourge Disguise [52192]'),
(51966, 51971, 0, 'Add Scourge Disguise Instability [51971]'),
(52192, -51966, 0, 'Remove Scourge Disguise [51966]'),
(52192, 51971, 0, 'Add Scourge Disguise Instability [51971]');

-- Attach script to Scourge Disguise Instability
DELETE FROM `spell_script_names` WHERE (`spell_id` = 51971);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(51971, 'spell_scourge_disguise_instability');