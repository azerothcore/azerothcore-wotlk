-- DB update 2023_04_12_00 -> 2023_04_12_01
-- Add spell script to database for 63471 - Spawn Blood Pool
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_spawn_blood_pool';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(63471, 'spell_spawn_blood_pool');

