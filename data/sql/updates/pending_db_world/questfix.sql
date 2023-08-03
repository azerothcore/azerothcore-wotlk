
 -- Sir Wendell's Grave smart ai
SET @ENTRY := 194537;
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryOrGuid` = @ENTRY;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 1, 0, 0, 71, 0, 100, 0, 21077, 0, 0, 0, 12, 33439, 3, 19000, 0, 0, 0, 8, 0, 0, 0, 8461.727, 468.7472, 596.2335, 4.729842, 'On game object event 21077 triggered - Self: Summon creature Sir Wendell Balfour (33439) at (8461.727, 468.7472, 596.2335, 4.729842) as summon type timed despawn with duration 19 seconds');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 194537 AND `SourceId` = 1;

 -- Sir Wendell Balfour smart ai
SET @ENTRY := 33439;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 11, 51195, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell Cosmetic - Low Poly Fire (51195) with flags triggered on Self'),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 75, 29266, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Add aura Permanent Feign Death (29266)'),
(@ENTRY, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 67, 1, 200, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Trigger timed event timedEvent[1] in 200 - 200 ms // -meta_wait'),
(@ENTRY, 0, 3, 0, 59, 0, 100, 0, 1, 0, 0, 0, 11, 10389, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On timed event timedEvent[1] triggered - Self: Cast spell Spawn Smoke (10389) with flags triggered on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 33439 AND `SourceId` = 0;

 -- Lorien's Grave smart ai
SET @ENTRY := 194539;
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryOrGuid` = @ENTRY;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 1, 0, 0, 71, 0, 100, 0, 21075, 0, 0, 0, 12, 33455, 3, 19000, 0, 0, 0, 8, 0, 0, 0, 8441.864, 452.88184, 596.1657, 1.850049, 'On game object event 21075 triggered - Self: Summon creature Lorien Sunblaze (33455) at (8441.864, 452.88184, 596.1657, 1.850049) as summon type timed despawn with duration 19 seconds');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 194539 AND `SourceId` = 1;

 -- Lorien Sunblaze smart ai
SET @ENTRY := 33455;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 11, 41290, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell Disease Cloud (41290) with flags triggered on Self'),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 11, 29266, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell Permanent Feign Death (29266) with flags triggered on Self'),
(@ENTRY, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 61894, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell Spirit Particles (green - Base) (61894) with flags triggered on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 33455 AND `SourceId` = 0;

 -- Connall's Grave smart ai
SET @ENTRY := 194538;
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryOrGuid` = @ENTRY;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 1, 0, 0, 71, 0, 100, 0, 21076, 0, 0, 0, 12, 33457, 3, 19000, 0, 0, 0, 8, 0, 0, 0, 8471.436, 452.21744, 596.1551, 4.7822022, 'On game object event 21076 triggered - Self: Summon creature Conall Irongrip (33457) at (8471.436, 452.21744, 596.1551, 4.7822022) as summon type timed despawn with duration 19 seconds');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 194538 AND `SourceId` = 1;

 -- Conall Irongrip smart ai
SET @ENTRY := 33457;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 11, 29266, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On just summoned - Self: Cast spell Permanent Feign Death (29266) with flags triggered on Self');


DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 33457 AND `SourceId` = 0;


