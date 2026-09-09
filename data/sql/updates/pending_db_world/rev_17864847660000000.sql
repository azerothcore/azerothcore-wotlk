-- Blood Tap (45529) is now handled by a spell/aura script pair, so that the rune the spell
-- brings back is the same one its aura converts into a death rune.
DELETE FROM `spell_script_names` WHERE `spell_id` = 45529 AND `ScriptName` = 'spell_dk_blood_tap';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(45529, 'spell_dk_blood_tap');
