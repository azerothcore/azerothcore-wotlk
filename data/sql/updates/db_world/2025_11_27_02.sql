-- DB update 2025_11_27_01 -> 2025_11_27_02
-- Fix Plagued Proto-Drake Egg not despawning after being frozen
-- https://github.com/azerothcore/azerothcore-wotlk/issues/23851
-- Quests: Aberrations (12925), The Aberrations Must Die (13425)

-- Set SmartGameObjectAI for Plagued Proto-Drake Egg
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 191840;

-- Add SmartAI script: On spell hit by Vial of Frost Oil (55647), despawn immediately
DELETE FROM `smart_scripts` WHERE `entryorguid` = 191840 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(191840, 1, 0, 0, 8, 0, 100, 0, 55647, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Plagued Proto-Drake Egg - On Spell Hit (Vial of Frost Oil) - Despawn');
