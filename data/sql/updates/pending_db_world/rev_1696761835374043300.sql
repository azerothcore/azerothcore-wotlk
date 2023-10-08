-- Venomhide Hatchling feed items
DELETE FROM `spell_script_names` WHERE `spell_id` IN (65200,65258,65265,68359,68358,68360);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(65200, 'spell_item_venomhide_feed'),
(65258, 'spell_item_venomhide_feed'),
(65265, 'spell_item_venomhide_feed'),
(68359, 'spell_item_venomhide_feed'),
(68358, 'spell_item_venomhide_feed'),
(68360, 'spell_item_venomhide_feed');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` IN (65200,65258,65265);

-- Mor'vek
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11701;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11701, 0, 0, 0, 20, 0, 100, 0, 13906, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 34320, 10, 0, 0, 0, 0, 0, 0, 'Mor\'vek - On Quest \'They Grow Up So Fast\' Finished - Despawn Closest Venomhide Hatchling');
