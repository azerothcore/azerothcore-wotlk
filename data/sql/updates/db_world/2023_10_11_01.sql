-- DB update 2023_10_11_00 -> 2023_10_11_01
-- Call of the Wild
DELETE FROM `spell_script_names` WHERE `spell_id` IN (-24604,53434);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-24604, 'spell_hun_target_self_and_pet'),
(53434, 'spell_hun_target_self_and_pet');
