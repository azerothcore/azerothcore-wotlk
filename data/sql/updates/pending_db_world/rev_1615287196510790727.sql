INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615287196510790727');

-- Delete spell_linked_spell  for Shadowmeld
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (58984);

-- Fix Shadowmeld
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_shadowmeld';
INSERT INTO `spell_script_names` VALUES (58984, 'spell_gen_shadowmeld');
INSERT INTO `spell_script_names` VALUES (59646, 'spell_gen_shadowmeld');