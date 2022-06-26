--Midsummer Juggling Torch Spellfix

DELETE FROM `spell_script_names` WHERE `spell_id` = '45644';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45644, "spell_midsummer_torch_catch");
