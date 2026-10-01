--
-- Let Them Not Rise! (12211): Container of Rats (48268) corpse sequence
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 48268 AND `spell_effect` = 48272;

DELETE FROM `spell_script_names` WHERE `spell_id` = 48268;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48268, 'spell_q12211_container_of_rats');

-- Let Them Not Rise!: Skeletal Transform, transform into Skeleton (6412)
UPDATE `spell_dbc` SET `Effect_1` = 6, `ImplicitTargetA_1` = 1, `EffectAura_1` = 56, `EffectMiscValue_1` = 6412 WHERE `ID` = 48255;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 48268 AND `ConditionTypeOrReference` IN (1, 104);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 48268, 0, 0, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (AI data 1 = 1)'),
(17, 0, 48268, 0, 1, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (AI data 1 = 1)'),
(17, 0, 48268, 0, 2, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (AI data 1 = 1)'),
(17, 0, 48268, 0, 3, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (AI data 1 = 1)'),
(17, 0, 48268, 0, 4, 104, 1, 1, 1, 0, 1, 0, 0, '', 'Target must not have been eaten by rats yet (AI data 1 = 1)');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags` = 33554688, `VerifiedBuild` = 52237 WHERE `entry` = 27276;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 27276 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27276,0,0,0,54,0,100,0,0,0,0,0,0,0,69,1,0,0,1,0,0,23,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Just Summoned - Move To Summoner'),
(27276,0,1,2,34,0,100,0,8,1,0,0,0,0,66,0,0,0,0,0,0,23,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Reached Point 1 - Set Orientation Summoner'),
(27276,0,2,0,61,0,100,0,0,0,0,0,0,0,80,2727600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - On Reached Point 1 - Run Script');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2727600 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2727600,9,0,0,0,0,100,0,0,0,0,0,0,0,5,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - Actionlist - Play Emote \'Attack Unarmed\''),
(2727600,9,1,0,0,0,100,0,1600,3300,0,0,0,0,5,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - Actionlist - Play Emote \'Attack Unarmed\''),
(2727600,9,2,0,0,0,100,0,1600,3300,0,0,0,0,5,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - Actionlist - Play Emote \'Attack Unarmed\''),
(2727600,9,3,0,0,0,100,0,1600,3200,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Let Them Not Rise! Rat - Actionlist - Despawn Instant');

-- Drop the On Spellhit 'Container of Rats' - Despawn rows, the corpse now stays until normal decay
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27203, 27206, 27207, 27211) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27203,0,1,0,4,0,30,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Footman - On Agro - Say'),
(27206,0,0,0,6,0,100,512,0,0,0,0,0,0,203,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Knight - On Death - Exit Vehicle'),
(27206,0,2,0,7,0,100,512,0,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Onslaught Knight - On Evade - Despawn Instant'),
(27207,0,0,0,0,0,100,0,7000,12000,7000,12000,0,0,11,43410,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Onslaught Workman - In Combat - Cast \'Chop\' (No Repeat)'),
(27211,0,0,0,9,0,100,0,0,0,9000,13000,0,5,11,9080,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Onslaught Executioner - Within 0-5 Range - Cast \'Hamstring\' (No Repeat)'),
(27211,0,1,0,0,0,100,0,5000,8000,12000,15000,0,0,11,43673,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Onslaught Executioner - In Combat - Cast \'Mighty Blow\' (No Repeat)');
