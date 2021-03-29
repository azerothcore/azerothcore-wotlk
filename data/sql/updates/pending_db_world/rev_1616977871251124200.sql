INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616977871251124200');

-- Add IA
UPDATE `creature_template` SET `ScriptName`='boss_yoggsaron_immortal_guardian' WHERE `entry`=36064;
-- Match "Immortal Guardian" values with "Marked immortal guardian"
UPDATE `creature_template` SET `speed_walk`=1.6, `speed_run`=1.71429, `DamageModifier`=7.5, `mechanic_immune_mask`=617299839, `flags_extra`=1073741824 WHERE `entry` IN (36064, 36067);

