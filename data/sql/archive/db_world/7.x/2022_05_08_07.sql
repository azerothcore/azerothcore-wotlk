-- DB update 2022_05_08_06 -> 2022_05_08_07

-- Quest You'll Need a Gryphon
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29403;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29403);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29403, 0, 0, 1, 25, 0, 100, 257, 0, 0, 0, 0, 0, 11, 61646, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon - On Reset - Cast \'Loaner Vehicle Speed\' (No Repeat)'),
(29403, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 60, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon - On Reset - Set Fly On (No Repeat)'),
(29403, 0, 2, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 11, 45472, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Onslaught Gryphon - On Passenger Removed - Cast \'Parachute\'');

-- Not necessary
UPDATE `creature_template` SET `npcflag` = 0 WHERE (`entry` = 29403);
DELETE FROM `npc_spellclick_spells` WHERE  `npc_entry`=29403 AND `spell_id`=49641;

-- Rename update
UPDATE `spell_script_names` SET `ScriptName`='spell_deliver_gryphon' WHERE  `spell_id`=54420 AND `ScriptName`='spell_gen_despawn_self';

DELETE FROM `spell_script_names` WHERE `spell_id`=49642 AND `ScriptName`='spell_onslaught_or_call_bone_gryphon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (49642, 'spell_onslaught_or_call_bone_gryphon');

-- An additional + (animation)
-- Is not part of quest!
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29648;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29648);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29648, 0, 0, 0, 1, 0, 100, 0, 13000, 13000, 13000, 13000, 0, 70, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bone Gryphon - Out of Combat - Respawn Self'),
(29648, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 11, 54476, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bone Gryphon - On Reset - Cast \'Blood Presence\'');

-- Npc Captured Onslaught Gryphon (animation)
DELETE FROM `creature_template_addon` WHERE (`entry` = 29415);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(29415, 0, 0, 50331648, 1, 0, 0, '57764');

-- Observation: TARGET_UNIT_NEARBY_ENTRY (not target)
-- That's why the condition was necessary
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=10727;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,10727,0,0,31,0,3,29415,0,0,0,0,"","Uzo's Ritual of Blood Triggered Transform.");

-- Continuing the event after the end
SET @NPC_UZO_DEATHCALLER := 29405;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @NPC_UZO_DEATHCALLER;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @NPC_UZO_DEATHCALLER);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = @NPC_UZO_DEATHCALLER*100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@NPC_UZO_DEATHCALLER, 0, 0, 0, 20, 0, 100, 0, 12814, 0, 0, 0, 0, 80, @NPC_UZO_DEATHCALLER*100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Uzo Deathcaller - On Quest \'You\'ll Need a Gryphon\' Finished - Run Script'),
(@NPC_UZO_DEATHCALLER*100, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 11, 10727, 0, 0, 0, 0, 0, 19, 29415, 0, 0, 0, 0, 0, 0, 0, 'Uzo Deathcaller - Actionlist - Cast \'Uzo`s Ritual of Blood\''),
(@NPC_UZO_DEATHCALLER*100, 9, 1, 0, 0, 0, 100, 0, 8300, 8300, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Uzo Deathcaller - Actionlist - Say Line 0'),
(@NPC_UZO_DEATHCALLER*100, 9, 2, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 29415, 0, 0, 0, 0, 0, 0, 0, 'Uzo Deathcaller - Actionlist - Despawn Instant'), 
(@NPC_UZO_DEATHCALLER*100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 70, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Uzo Deathcaller - Actionlist - Respawn Self'); -- in the transformation process there is a visual bug (I mean for magic who use), so it was added 

-- End event
DELETE FROM `creature_text` WHERE `CreatureID`=@NPC_UZO_DEATHCALLER;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`, `TextRange`, `comment`) VALUES
(@NPC_UZO_DEATHCALLER, 0, 0, 'There you go, mon. Your very own bone gryphon Now let\'s talk about you takin\' it out to fight the Onslaught!', 12	, 0, 100, 0, 0, 0, 30116, 1, '');
