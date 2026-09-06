-- DB update 2025_05_23_02 -> 2025_05_23_03
-- Crashing Wave
DELETE FROM `spell_script_names` WHERE `spell_id`=57652 AND `ScriptName`='spell_crashing_wave';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (57652, 'spell_crashing_wave');

-- Water Terror
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30645;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30645);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30645, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 108, 3, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Water Terror - On Just Summoned - Set Energy To 100');

DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 30645);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(30645, 3, 57668, 0),
(30645, 1, 57652, 0),
(30645, 0, 57665, 0),
(30645, 2, 57643, 0);
