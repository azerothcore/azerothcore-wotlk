--
UPDATE `creature_template` SET `ScriptName`='npc_wintergarde_gryphon' WHERE `entry`=27258;

-- fly speed 200%
UPDATE `creature_template_addon` SET `bytes1` = 50331648, `auras` = '60534' WHERE (`entry` = 27258);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q12237_rescue_villager';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q12237_drop_off_villager';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_call_wintergarde_gryphon';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(48363, 'spell_q12237_rescue_villager'),
(48397, 'spell_q12237_drop_off_villager'),
(48388, 'spell_call_wintergarde_gryphon');

-- Not needed anymore (script)
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 48397) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 188679) AND (`ConditionValue2` = 15) AND (`ConditionValue3` = 0);

-- Not needed anymore (despawn)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27315) AND (`source_type` = 0) AND (`id` IN (4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27315, 0, 4, 0, 23, 2, 100, 1, 43671, 0, 1000, 1000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Aura Missing - say text');

-- Not needed anymore (despawn)
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27336) AND (`source_type` = 0) AND (`id` IN (4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27336, 0, 4, 0, 23, 2, 100, 1, 43671, 0, 1000, 1000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Aura Missing - say text');
