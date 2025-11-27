-- Fix Aces High! quest issues (https://github.com/azerothcore/azerothcore-wotlk/issues/23834)

-- 1. Add missing Blazing Speed (57092) to Wyrmrest Skytalon (32535)
-- Move Flight aura (57403) from index 5 to index 6 to match EoE version (30161)
DELETE FROM `creature_template_spell` WHERE `CreatureID` = 32535 AND `Index` IN (5, 6);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(32535, 5, 57092, 12340), -- Blazing Speed
(32535, 6, 57403, 12340); -- Flight (aura)

-- 2. Set Scalesworn Elite (32534) to use SmartAI for combat abilities
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32534;

-- 3. Add SmartAI scripts for Scalesworn Elite to cast Ice Shard (61269) and Arcane Surge (61272)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 32534 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(32534, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 2000, 3000, 0, 0, 11, 61269, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalesworn Elite - In Combat - Cast Ice Shard'),
(32534, 0, 1, 0, 0, 0, 100, 0, 8000, 12000, 15000, 20000, 0, 0, 11, 61272, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalesworn Elite - In Combat - Cast Arcane Surge');
