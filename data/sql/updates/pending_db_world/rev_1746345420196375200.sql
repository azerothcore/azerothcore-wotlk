-- HoL - Static Overload
DELETE FROM `spell_script_names` WHERE `spell_id` IN (52658,59795) AND `ScriptName`='spell_ionar_static_overload';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(52658, 'spell_ionar_static_overload'),
(59795, 'spell_ionar_static_overload');
