-- DB update 2025_02_18_00 -> 2025_02_19_00
--
UPDATE `creature_template_addon` SET `auras` = '28305 8273 57989' WHERE (`entry` = 19668);
DELETE FROM `spell_script_names` WHERE `spell_id` = 57989 AND `ScriptName` = 'spell_pri_shadowfiend_death';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(57989, 'spell_pri_shadowfiend_death');
UPDATE `creature_template` SET `ScriptName` = '' WHERE (`entry` = 19668);
