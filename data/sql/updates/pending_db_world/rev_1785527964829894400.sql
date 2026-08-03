--
UPDATE `spell_dbc` SET `ProcChance` = 101, `Effect_1` = 6, `EffectDieSides_1` = 1, `ImplicitTargetA_1` = 1,  `EffectAura_1` = 23, `EffectAuraPeriod_1` = 1000, `EffectTriggerSpell_1`  = 64208, `EffectBonusMultiplier_1` = 1 WHERE `ID` = 64209;

DELETE FROM `spell_script_names` WHERE `spell_id` = 64208 AND `ScriptName` = 'spell_gen_consumption';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (64208, 'spell_gen_consumption');
