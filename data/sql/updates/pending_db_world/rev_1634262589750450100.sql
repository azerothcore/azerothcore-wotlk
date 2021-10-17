INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634262589750450100');

INSERT IGNORE INTO `spell_dbc` VALUES
(19244, 88, 0, 0, 262144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 24000, 8, 0, 0, 0, 101, 0, 0, 36, 36, 28, 0, 120, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 68, 64, 0, 1, 1, 0, 0, 0, 0, -1, -1, 0, 26, 9, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24259, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5282, 0, 77, 0, 50, 'Spell Lock', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'Rank 1', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'Silences the enemy for $24259d.  If used on a casting target, it will counter the enemy\'s spellcast, preventing any spell from that school of magic from being cast for $d.', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712188, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 32, 0, 0, 0, 0, 1, 0, 0, 0);

UPDATE `spell_dbc` SET `EffectTriggerSpell_2` = 0 WHERE (`ID` = 19244);

INSERT IGNORE INTO `spell_dbc` VALUES
(19647, 88, 0, 0, 262144, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 24000, 8, 0, 0, 0, 101, 0, 0, 52, 52, 32, 0, 200, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 68, 64, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 26, 9, 0, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24259, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5282, 0, 77, 0, 50, 'Spell Lock', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'Rank 2', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, 'Silences the enemy for $24259d.  If used on a casting target, it will counter the enemy\'s spellcast, preventing any spell from that school of magic from being cast for $d.', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712190, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 16712188, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 32, 0, 0, 0, 0, 0, 0, 0, 0);

UPDATE `spell_dbc` SET `EffectTriggerSpell_2` = 0 WHERE (`ID` = 19647);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_warl_luck';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(19244, 'spell_warl_luck'),
(19647, 'spell_warl_luck');
