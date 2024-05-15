--
-- Rocket Booster
UPDATE `gameobject` SET `position_x`=2307.000003, `position_y`=265.6011, `position_z`=424.287993  WHERE (`id` = 194904) AND (`guid` IN (35524));
-- Delete 2nd Activate Tram gameobject
DELETE FROM `gameobject` WHERE `id` = 194438;
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE `entry` = 194438;
-- Call Tram objects start as non-selectable
UPDATE `gameobject_template_addon` SET `flags` = `flags` | 16  WHERE `entry` IN (194912, 194914);
-- Buttons
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` IN (194437,194912,194914);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (194437,194912,194914)) AND (`source_type` = 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(194437, 1, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Activate Tram - On Respawn - Set Event Phase 1'),
(194437, 1, 1, 2, 64, 1, 100, 0, 0, 0, 0, 0, 0, 0, 34, 710, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Activate Tram - On Gossip Hello - Set Instance Data 710 to 1 (Phase 1)'),
(194437, 1, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Activate Tram - On Gossip Hello - Set Event Phase 2 (Phase 1)'),
(194437, 1, 3, 4, 64, 2, 100, 0, 0, 0, 0, 0, 0, 0, 34, 710, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Activate Tram - On Gossip Hello - Set Instance Data 710 to 0 (Phase 2)'),
(194437, 1, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Activate Tram - On Gossip Hello - Set Event Phase 1 (Phase 2)'),
(194912, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 710, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Call Tram - On Gossip Hello - Set Instance Data 710 to 1'),
(194914, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 0, 0, 34, 710, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Call Tram - On Gossip Hello - Set Instance Data 710 to 0');
