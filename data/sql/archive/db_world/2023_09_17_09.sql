-- DB update 2023_09_17_08 -> 2023_09_17_09
--
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q10190_battery_recharging_blaster';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(34219, 'spell_q10190_battery_recharging_blaster');
