-- DB update 2026_05_02_01 -> 2026_05_02_02

-- Set Probability to 0 for Mine Car and Iron Dwarf Relic second model.
UPDATE `creature_template_model` SET `Probability` = 0 WHERE (`CreatureID` IN (28817, 24824)) AND (`Idx` IN (1));

-- Edit Mine Car SAI (Row 0 Removed).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28817;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28817);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28817, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 28841, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 2382.17, -5899.67, 107.745, 0, 'Mine Car - On Just Summoned - Summon Creature \'Scarlet Miner\''),
(28817, 0, 1, 0, 8, 0, 100, 0, 52465, 0, 0, 0, 0, 0, 29, 3, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mine Car - On Spellhit \'Drag Mine Cart\' - Start Follow Invoker');
