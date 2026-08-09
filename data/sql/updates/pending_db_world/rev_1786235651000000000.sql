-- Leviroth is IMMUNE_TO_PC, so it cannot be pulled before the trident and the 7.5
-- DamageModifier on its template was never meant to be there. Fixing the template
-- and moving the self-impale to SmartAI makes the spell script unnecessary.
UPDATE `creature_template` SET `DamageModifier` = 1, `flags_extra` = `flags_extra`|2097152, `RegenHealth` = 0 WHERE (`entry` = 26452);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26452;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26452);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26452, 0, 0, 1, 8, 0, 100, 0, 47170, 0, 0, 0, 0, 0, 11, 49882, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Spellhit \'Impale Leviroth\' - Cast \'Leviroth Self-Impale\''),
(26452, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 46767, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Spellhit \'Impale Leviroth\' - Cast \'Cosmetic - Underwater Blood\''),
(26452, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Spellhit \'Impale Leviroth\' - Remove Flags Immune To Players'),
(26452, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Spellhit \'Impale Leviroth\' - Start Attacking'),
(26452, 0, 4, 0, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 30, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Leviroth - On Evade - Despawn Instant');

DELETE FROM `spell_script_names` WHERE `spell_id` = 47170 AND `ScriptName` = 'spell_item_impale_leviroth';
UPDATE `conditions` SET `Comment` = 'SpellID - 47170 Impale Leviroth only targets Leviroth (26452)' WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 47170) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 26452) AND (`ConditionValue3` = 0);
