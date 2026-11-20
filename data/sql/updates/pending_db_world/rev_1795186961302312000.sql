--
-- 59555 Daze Immunity (serverside): self-applied mechanic immunity to Daze, dropped on leaving the map
UPDATE `spell_dbc` SET `AuraInterruptFlags` = 0x80000, `Effect_1` = 6, `ImplicitTargetA_1` = 1, `EffectAura_1` = 77, `EffectMiscValue_1` = 27 WHERE `ID` = 59555;

DELETE FROM `spell_script_names` WHERE `spell_id` = 66508;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66508, 'spell_anubarak_reset_cleanup');
