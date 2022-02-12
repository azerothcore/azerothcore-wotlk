INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643577681911100000');

UPDATE `creature_template_addon` SET `auras`='19818' WHERE `entry`=12460;
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry`=12461;

DELETE FROM `spell_script_names` WHERE `spell_id` IN (22276,22282);
INSERT INTO `spell_script_names` VALUES
(22276,'spell_gen_elemental_shield'),
(22282,'spell_gen_brood_power');

DELETE FROM `smart_scripts` WHERE `entryorguid`=12460 AND `source_type`=0 AND `id` IN (1,2);
INSERT INTO `smart_scripts` VALUES
(12460,0,1,0,25,0,100,0,0,0,0,0,0,11,22282,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Death Talon Wyrmguard - On Reset - Cast Brood Power'),
(12460,0,2,0,0,0,100,1,4000,4000,0,0,0,11,22276,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Death Talon Wyrmguard - In Combat (4 sec) - Cast Elemental Shield');

DELETE FROM `smart_scripts` WHERE `entryorguid`=12461 AND `source_type`=0 AND `id`=2;
INSERT INTO `smart_scripts` VALUES
(12461,0,2,0,0,0,100,1,4000,4000,0,0,0,11,22276,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Death Talon Overseer - In Combat (4 sec) - Cast Elemental Shield');
