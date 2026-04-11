-- DB update 2026_04_03_02 -> 2026_04_03_03
-- Fix Skadi Poisoned Spear not applying periodic DOT in Heroic mode.
-- Spell 59331 is the heroic variant of 50255 (mapped via spelldifficulty_dbc),
-- but the spell script was only registered for the normal version.
DELETE FROM `spell_script_names` WHERE `spell_id` = 59331 AND `ScriptName` = 'spell_skadi_poisoned_spear';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (59331, 'spell_skadi_poisoned_spear');
