-- DB update 2023_10_10_10 -> 2023_10_10_11
-- Venomhide Hatchling feed items
DELETE FROM `spell_script_names` WHERE `spell_id` IN (65200,65258,65265,68359,68358,68360);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(65200, 'spell_item_venomhide_feed'),
(65258, 'spell_item_venomhide_feed'),
(65265, 'spell_item_venomhide_feed'),
(68359, 'spell_item_venomhide_feed'),
(68358, 'spell_item_venomhide_feed'),
(68360, 'spell_item_venomhide_feed');

-- Mor'vek
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 11701;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11701);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(11701, 0, 0, 0, 20, 0, 100, 0, 13906, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 34320, 10, 0, 0, 0, 0, 0, 0, 'Mor\'vek - On Quest \'They Grow Up So Fast\' Finished - Despawn Closest Venomhide Hatchling');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` IN (65200,65258,65265);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceGroup` = 0 AND `ConditionTypeOrReference` = 9 AND `ConditionValue1` = 13906;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 13903, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Gorishi Grub\' only if on quest \'They Grow Up So Fast\''),
(19, 0, 13917, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Gorishi Grub\' only if on quest \'They Grow Up So Fast\''),
(19, 0, 13889, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Hungry, Hungry Hatchling\' only if on quest \'They Grow Up So Fast\''),
(19, 0, 13915, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Hungry, Hungry Hatchling\' only if on quest \'They Grow Up So Fast\''),
(19, 0, 13904, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Poached, Scrambled, Or Raw?\' only if on quest \'They Grow Up So Fast\''),
(19, 0, 13916, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Poached, Scrambled, Or Raw?\' only if on quest \'They Grow Up So Fast\''),
(19, 0, 13905, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Searing Roc Feathers\' only if on quest \'They Grow Up So Fast\''),
(19, 0, 13914, 0, 0, 9, 0, 13906, 0, 0, 0, 0, 0, '', 'Show quest \'Searing Roc Feathers\' only if on quest \'They Grow Up So Fast\'');
