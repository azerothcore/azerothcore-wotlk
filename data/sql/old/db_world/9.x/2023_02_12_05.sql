-- DB update 2023_02_12_04 -> 2023_02_12_05
--
DELETE FROM `spell_script_names` WHERE `spell_id`=33496;
INSERT INTO `spell_script_names` VALUES
(33496,'spell_tractor_beam_creator');

UPDATE `spell_dbc` SET `Effect_1`=28, `EffectMiscValueB_1`=64 WHERE `ID` IN (33495,33514,33515,33516,33517,33518,33519,33520);

UPDATE `creature_template` SET `ScriptName`='npc_invisible_tractor_beam_source' WHERE `entry`=19198;
