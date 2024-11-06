-- Unstable Power
UPDATE `spell_dbc` SET `Effect_1` = 64, `EffectTriggerSpell_1` = 24659 WHERE (`ID` = 29275);
UPDATE `spell_proc_event` SET `procEx`=7 WHERE `entry`=24658;

DELETE FROM `spell_script_names` WHERE `spell_id`=24659 AND `ScriptName`='spell_item_unstable_power';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (24659, 'spell_item_unstable_power');
