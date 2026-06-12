-- DB update 2026_02_08_01 -> 2026_02_08_02
--
DELETE FROM `spell_script_names` WHERE `spell_id`=18153 AND `ScriptName`='spell_q5561_kodo_roundup_kodo_kombobulator';
DELETE FROM `spell_script_names` WHERE `spell_id`=18269 AND `ScriptName`='spell_q5561_kodo_roundup_kodo_kombobulator_despawn';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(18153, 'spell_q5561_kodo_roundup_kodo_kombobulator'),
(18269, 'spell_q5561_kodo_roundup_kodo_kombobulator_despawn');
