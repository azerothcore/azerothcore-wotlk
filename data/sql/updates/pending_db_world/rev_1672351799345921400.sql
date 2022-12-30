--
UPDATE `creature_template` SET `ScriptName` = 'boss_hungarfen', `AIName` = '' WHERE `entry` = 17770;
UPDATE `creature_template` SET `ScriptName` = 'npc_underbog_mushroom', `AIName` = '', `scale` = 1 WHERE `entry` = 17990;
UPDATE `creature_template` SET `scale` = 1 WHERE `entry` = 20189;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17770 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 17990 AND `source_type` = 0;

DELETE FROM `creature_template_addon` WHERE `entry` = 17990;
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES
(17990, '31690');

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 17990;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`) VALUES
(17990, 0, 0, 0, 1, 0, 0);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64 WHERE `ID` = 31692;
