--
-- Stoned (10255) is used by statue creatures in both Uldaman and Blackrock Depths,
-- so its aura script moves from instance_uldaman.cpp to spell_generic.cpp.
DELETE FROM `spell_script_names` WHERE `spell_id` = 10255;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(10255, 'spell_gen_stoned');
