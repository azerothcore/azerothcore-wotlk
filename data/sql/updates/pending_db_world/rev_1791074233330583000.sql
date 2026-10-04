-- Acidmaw and Dreadscale have no submerge or emerge emotes
DELETE FROM `creature_text_locale` WHERE `CreatureID` = 34799 AND `GroupID` IN (1, 2);
DELETE FROM `creature_text_locale` WHERE `CreatureID` = 35144 AND `GroupID` = 2;
DELETE FROM `creature_text` WHERE `CreatureID` = 34799 AND `GroupID` IN (1, 2);
DELETE FROM `creature_text` WHERE `CreatureID` = 35144 AND `GroupID` = 2;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (66823, 67618, 67619, 67620) AND `ScriptName` = 'spell_jormungars_paralytic_toxin_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66823, 'spell_jormungars_paralytic_toxin_aura'),
(67618, 'spell_jormungars_paralytic_toxin_aura'),
(67619, 'spell_jormungars_paralytic_toxin_aura'),
(67620, 'spell_jormungars_paralytic_toxin_aura');
