-- DB update 2025_01_05_04 -> 2025_01_05_05
--
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23586) AND (`source_type` = 0);
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_amanishi_scout' WHERE (`entry` = 23586);
DELETE FROM `spell_script_names` WHERE `spell_id`=42177 AND `ScriptName`='spell_alert_drums';
DELETE FROM `spell_script_names` WHERE `spell_id`=42179 AND `ScriptName`='spell_summon_amanishi_sentries';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(42177, 'spell_alert_drums'),
(42179, 'spell_summon_amanishi_sentries');

-- Reinforcement
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23587) AND (`source_type` = 0) AND (`id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23587, 0, 2, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Reinforcement - On Just Summoned - Set In Combat With Zone'),
(23587, 0, 3, 0, 1, 0, 100, 1, 10000, 10000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Reinforcement - Out of Combat - Despawn Instant (No Repeat)');
