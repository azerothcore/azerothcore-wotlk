INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616977871251124200');

-- Add IA for 'Marked immortal guardian'
UPDATE `creature_template` SET `ScriptName`='boss_yoggsaron_immortal_guardian' WHERE `entry`=36064;
-- Match "Immortal Guardian" values with "Marked immortal guardian"
UPDATE `creature_template` SET `speed_walk`=1.6, `speed_run`=1.71429, `DamageModifier`=7.5, `mechanic_immune_mask`=617299839, `flags_extra`=1073741824 WHERE `entry` IN (36064, 36067);
UPDATE `creature_template` SET `DamageModifier`=8 WHERE `entry` IN (33989, 36067);
-- Add script into DB
DELETE FROM `spell_script_names` WHERE  `spell_id`=64465 AND `ScriptName`='spell_yogg_saron_shadow_beacon';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (64465, 'spell_yogg_saron_shadow_beacon');

