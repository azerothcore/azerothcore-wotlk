-- DB update 2025_04_02_01 -> 2025_04_02_02
--
SET @SPELL_ATTR3_IGNORE_CASTER_AND_TARGET_RESTRICTIONS := 268435456;
SET @SPELL_ATTR5_ALLOW_WHILE_STUNNED := 8;
SET @SPELL_ATTR2_IGNORE_LINE_OF_SIGHT := 4;
-- Update server-side spell 43360 - model after 41295 Fixate
UPDATE `spell_dbc` SET
`AttributesEx2`= `AttributesEx2` & ~(@SPELL_ATTR2_IGNORE_LINE_OF_SIGHT),
`AttributesEx3`= `AttributesEx3` | @SPELL_ATTR3_IGNORE_CASTER_AND_TARGET_RESTRICTIONS,
`AttributesEx5`= `AttributesEx5` | @SPELL_ATTR5_ALLOW_WHILE_STUNNED,
`RangeIndex` = 36,
`Effect_1` = 6,
`EffectRadiusIndex_1` = 27,
`EffectAura_1` = 11,
`SpellIconID` = 1,
`ImplicitTargetA_1` = 7,
`Description_Lang_enUS` = 'The target is fixated upon the caster.',
`Name_Lang_enUS`='Fixate'
WHERE `ID` = 43360;

DELETE FROM `spell_script_names` WHERE `spell_id` = 43359 AND `ScriptName` = 'spell_call_of_the_beast';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(43359, 'spell_call_of_the_beast');

-- Amani'shi Beast Tamer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24059;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24059);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24059, 0, 0, 0, 0, 0, 100, 0, 8000, 12000, 10000, 15000, 0, 0, 11, 43359, 0, 0, 0, 0, 0, 5, 100, 1, 0, 43359, 0, 0, 0, 0, 'Amani\'shi Beast Tamer - In Combat - Cast \'Call of the Beast\''),
(24059, 0, 1, 0, 0, 0, 100, 0, 6000, 12000, 9000, 18000, 0, 0, 11, 43361, 0, 0, 0, 0, 0, 5, 100, 1, 0, 0, 0, 0, 0, 0, 'Amani\'shi Beast Tamer - In Combat - Cast \'Domesticate\'');
