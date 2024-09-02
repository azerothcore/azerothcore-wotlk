-- DB update 2024_07_13_01 -> 2024_07_13_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (53646, 54909);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(53646, 'spell_warl_demonic_pact_aura'),
(54909, 'spell_warl_demonic_pact_aura');
