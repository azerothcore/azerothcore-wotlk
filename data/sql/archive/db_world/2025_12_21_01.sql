-- DB update 2025_12_21_00 -> 2025_12_21_01
--
UPDATE `creature_template` SET `ScriptName` = 'npc_pet_proto_drake_whelp' WHERE (`entry` = 32592);
UPDATE `creature_template_addon` SET `bytes1` = 0 WHERE (`entry` = 32592);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 32592);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(32592, 2, 0, 1, 0, 0, 0, 0);
