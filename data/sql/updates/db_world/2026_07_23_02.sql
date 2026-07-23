-- DB update 2026_07_23_01 -> 2026_07_23_02
DELETE FROM `spell_script_names` WHERE (`spell_id` = 50051);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(50051, 'spell_gen_ethereal_pet_aura');
