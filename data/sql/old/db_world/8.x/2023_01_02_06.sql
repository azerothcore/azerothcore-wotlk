-- DB update 2023_01_02_05 -> 2023_01_02_06
--
UPDATE `creature_template` SET `ScriptName` = 'boss_hungarfen', `AIName` = '' WHERE `entry` = 17770;
UPDATE `creature_template` SET `ScriptName` = 'npc_underbog_mushroom', `AIName` = '', `scale` = 1, `faction` = 14, `speed_walk` = 1 WHERE `entry` = 17990;
UPDATE `creature_template` SET `scale` = 1, `faction` = 14, `speed_walk` = 1 WHERE `entry` = 20189;
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|33554432, `speed_walk` = 1, `speed_run` = 1.57143 WHERE `entry` IN (17770, 20169);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17770 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17990 AND `source_type` = 0;

DELETE FROM `creature_template_addon` WHERE `entry` IN (17990, 20189);
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES
(17990, '31690'),
(20189, '31690');

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (17990, 20189);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES
(17990, 0, 0, 0, 1, 0, 0),
(20189, 0, 0, 0, 1, 0, 0);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64 WHERE `ID` = 31692;

DELETE FROM `spell_script_names` WHERE `spell_id` = 34168 AND `ScriptName` = 'spell_spore_cloud';
DELETE FROM `spell_script_names` WHERE `spell_id` = 34874 AND `ScriptName` = 'spell_despawn_underbog_mushrooms';
INSERT INTO `spell_script_names` VALUES
(34168, 'spell_spore_cloud'),
(34874, 'spell_despawn_underbog_mushrooms');

DELETE FROM `creature_text` WHERE `CreatureID` = 17770;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(17770, 0, 0, 'Hungarfen roars in pain.', 16, 0, 100, 0, 0, 0, 16594, 0, 'Hungarfen - On 20% EMOTE');
