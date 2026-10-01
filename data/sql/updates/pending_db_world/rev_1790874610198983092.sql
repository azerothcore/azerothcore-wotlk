-- Hadronox: a single 5s periodic aura per door trigger summons a weighted random Anub'ar
DELETE FROM `spell_script_names` WHERE `spell_id` IN (53035, 53036, 53037);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(53037, 'spell_hadronox_summon_periodic_aura');
