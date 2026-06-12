-- DB update 2026_02_27_02 -> 2026_02_27_03
-- Cobra Strikes spell script bindings
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-53256, 53257);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-53256, 'spell_hun_cobra_strikes'),
(53257, 'spell_hun_cobra_strikes_triggered');
