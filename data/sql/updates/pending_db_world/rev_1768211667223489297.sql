-- Link C++ SpellScript to Surveyor's Fireball
DELETE FROM `spell_script_names` WHERE `spell_id` = 9487;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (9487, 'spell_surveyor_candress_fireball');

-- Reduce Surveyor Candress Fireball cast chance to 8% to prevent spamming
UPDATE `smart_scripts` SET `event_chance` = 8 WHERE `entryorguid` = 16522 AND `id` = 5 AND `source_type` = 0;
