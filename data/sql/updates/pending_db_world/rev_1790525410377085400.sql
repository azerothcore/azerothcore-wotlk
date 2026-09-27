-- Onyxia's Lair, Bellowing Roar and Eruption
DELETE FROM `spell_script_names` WHERE `spell_id` IN (18431, 17731, 69294) AND `ScriptName` = 'spell_onyxia_disturb_lava_fissure';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(18431, 'spell_onyxia_disturb_lava_fissure'),
(17731, 'spell_onyxia_disturb_lava_fissure'),
(69294, 'spell_onyxia_disturb_lava_fissure');
