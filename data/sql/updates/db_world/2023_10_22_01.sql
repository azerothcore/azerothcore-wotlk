-- DB update 2023_10_22_00 -> 2023_10_22_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (30004, 29946);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(30004, 'spell_flamewreath'),
(29946, 'spell_flamewreath_aura');
