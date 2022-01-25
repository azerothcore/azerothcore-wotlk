INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643146344280033400');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN('spell_item_mirrens_drinking_hat','spell_q1846_bending_shinbone','spell_item_decahedral_dwarven_dice','spell_item_worn_troll_dice','spell_death_knight_initiate_visual','spell_q12611_deathbolt','spell_item_brittle_armor','spell_item_mercurial_shield','spell_gen_remove_impairing_auras','spell_nag_plant_warmaul_ogre_banner');
DELETE FROM `spell_script_names` WHERE `spell_id` IN (22539,22972,22975,22976,22977,22978,22979,22980,22981,22982,22983,22984,22985) AND `ScriptName` = 'spell_bwl_shadowflame';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(29830, 'spell_item_mirrens_drinking_hat'),
(8856, 'spell_q1846_bending_shinbone'),
(47770, 'spell_item_decahedral_dwarven_dice'),
(47776, 'spell_item_worn_troll_dice'),
(51519, 'spell_death_knight_initiate_visual'),
(51854, 'spell_q12611_deathbolt'),
(24590, 'spell_item_brittle_armor'),
(26465, 'spell_item_mercurial_shield'),
(22539, 'spell_bwl_shadowflame'),
(22972, 'spell_bwl_shadowflame'),
(22975, 'spell_bwl_shadowflame'),
(22976, 'spell_bwl_shadowflame'),
(22977, 'spell_bwl_shadowflame'),
(22978, 'spell_bwl_shadowflame'),
(22979, 'spell_bwl_shadowflame'),
(22980, 'spell_bwl_shadowflame'),
(22981, 'spell_bwl_shadowflame'),
(22982, 'spell_bwl_shadowflame'),
(22983, 'spell_bwl_shadowflame'),
(22984, 'spell_bwl_shadowflame'),
(22985, 'spell_bwl_shadowflame'),
(20589, 'spell_gen_remove_impairing_auras'),
(30918, 'spell_gen_remove_impairing_auras'),
(32307, 'spell_nag_plant_warmaul_ogre_banner');
