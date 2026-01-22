-- DB update for fixing Priest spell Prayer of Healing spell, spell script to ignore LOS of AoE heal
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_pri_prayer_of_healing';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-596,'spell_pri_prayer_of_healing');
