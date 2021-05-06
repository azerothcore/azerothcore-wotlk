INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620244782542375889');

-- Added missing aura for Magmadar
UPDATE `creature_template_addon` SET `auras`='19449' WHERE `entry`=11982;

-- 19411 Lava Bomb (used by Magmadar)
DELETE FROM `spell_script_names` WHERE `spell_id` IN (19411, 20474) AND `ScriptName`='spell_magmadar_lava_bomb';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(19411, 'spell_magmadar_lava_bomb'),
(20474, 'spell_magmadar_lava_bomb');

-- Renamed Core Hound script
update creature_template set `ScriptName`='npc_mc_core_hound' WHERE entry=11671;


