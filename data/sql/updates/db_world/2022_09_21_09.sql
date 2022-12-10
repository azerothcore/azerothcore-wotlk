-- DB update 2022_09_21_08 -> 2022_09_21_09
--
DELETE FROM `spell_target_position` WHERE `ID` IN (25865, 25866, 25867, 25868, 25869, 25870, 25871, 25872, 25873, 25874, 25875, 25876, 25877, 25878, 25879, 25880, 25881, 25882, 25883, 25884);
INSERT INTO `spell_target_position` (`ID`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`) VALUES
(25865, 531, -8023.59, 964.772, -41.229, 5.376),
(25866, 531, -8042.13, 911.263, -42.841, 6.200),
(25867, 531, -7999.36, 860.525, -47.206, 1.417),
(25868, 531, -7971.30, 862.581, -48.099, 2.148),
(25869, 531, -7943.21, 903.804, -48.473, 3.078),
(25870, 531, -7954.38, 958.562, -41.609, 3.962),
(25871, 531, -7997.19, 979.192, -41.653, 4.896),
(25872, 531, -8037.89, 929.679, -43.416, 6.024),
(25873, 531, -8015.41, 867.734, -45.607, 1.103),
(25874, 531, -7982.80, 857.172, -48.212, 1.500),
(25875, 531, -7952.12, 883.183, -48.194, 2.430),
(25876, 531, -7947.22, 939.122, -44.014, 3.718),
(25877, 531, -7975.77, 974.820, -41.584, 4.417),
(25878, 531, -8032.75, 948.274, -41.919, 5.595),
(25879, 531, -8037.08, 887.268, -43.581, 0.675),
(25880, 531, -7992.21, 857.500, -47.762, 1.664),
(25881, 531, -7960.71, 872.483, -48.759, 2.360),
(25882, 531, -7942.98, 918.616, -46.401, 3.306),
(25883, 531, -7964.32, 967.879, -42.112, 4.087),
(25884, 531, -8015.24, 976.553, -41.647, 4.947);

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_explode_trigger' AND `spell_id` = 25938;
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_summon_toxin_slime' AND `spell_id` = 26584;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25938, 'spell_explode_trigger'),
(26584, 'spell_summon_toxin_slime');

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|1073741824 WHERE `entry` = 15667;

UPDATE `creature_template_addon` SET `auras` = '25994' WHERE `entry` = 15299;

UPDATE `creature_template` SET `modelid1` = 19595, `unit_flags` = `unit_flags`|33554432, `flags_extra` = `flags_extra`|64, `AIName` = '', `ScriptName` = 'npc_toxic_slime' WHERE `entry` = 15925;

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 15925;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(15925, 0, 0, 0, 1, 0, 0, 0);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectBasePoints_1` = 1, `EffectDieSides_1` = 0, `EffectMiscValueB_1` = 64 WHERE `ID` = 26577;
