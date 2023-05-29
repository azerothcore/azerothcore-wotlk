-- DB update 2023_03_22_01 -> 2023_03_22_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_item_goblin_weather_machine';
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_item_goblin_weather_machine_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(46203, 'spell_item_goblin_weather_machine'),
(46736, 'spell_item_goblin_weather_machine_aura'),
(46738, 'spell_item_goblin_weather_machine_aura'),
(46739, 'spell_item_goblin_weather_machine_aura'),
(46740, 'spell_item_goblin_weather_machine_aura');
