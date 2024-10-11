-- DB update 2023_03_04_00 -> 2023_03_04_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 34799 AND `ScriptName` = 'spell_commander_sarannis_arcane_devastation';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(34799,'spell_commander_sarannis_arcane_devastation');

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64 WHERE `ID` IN (34810, 34817, 34818, 34819);

UPDATE `creature_addon` SET `auras` = '34792 19818' WHERE `guid` = 147001;
