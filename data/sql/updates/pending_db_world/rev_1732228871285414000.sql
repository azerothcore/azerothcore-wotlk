--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 11625);


INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11625, 0, 0, 1, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 11564, 6, 10000, 0, 0, 0, 1, 0, 0, 0, 0, -10, 0, 5, 0, 'Cork Gizelton - On Initialize - Summon Creature \'Gizelton Caravan Kodo\''),
(11625, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 11626, 6, 10000, 0, 0, 0, 1, 0, 0, 0, 0, -20, 0, 5, 0, 'Cork Gizelton - On Initialize - Summon Creature \'Rigger Gizelton\''),
(11625, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 11564, 6, 10000, 0, 0, 0, 1, 0, 0, 0, 0, -30, 0, 5, 0, 'Cork Gizelton - On Initialize - Summon Creature \'Gizelton Caravan Kodo\''),
(11625, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Cork Gizelton - On Initialize - Remove Npc Flags Questgiver'),
(11625, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 9, 11626, 0, 200, 0, 0, 0, 0, 0, 'Cork Gizelton - On Initialize - Remove Npc Flags Questgiver');
