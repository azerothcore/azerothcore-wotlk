-- DB update 2023_04_22_00 -> 2023_04_22_01
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_dru_insect_swarm', 'spell_dru_idol_lifebloom');
