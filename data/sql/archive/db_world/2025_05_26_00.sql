-- DB update 2025_05_24_02 -> 2025_05_26_00
-- Eye of Acherus
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 28511);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(28511, 0, 51859, 0),
(28511, 1, 51904, 0),
(28511, 2, 52006, 0),
(28511, 4, 52694, 0);

DELETE FROM `spell_script_names` WHERE `spell_id`=52694 AND `ScriptName`='spell_q12641_death_comes_from_on_high_recall_eye';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (52694, 'spell_q12641_death_comes_from_on_high_recall_eye');
