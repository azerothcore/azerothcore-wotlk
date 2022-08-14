--
DELETE FROM `spell_target_position` WHERE `ID` IN (25708, 25709, 25825, 25826, 25827, 25828);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(25708, 0, 509, -9846, 1353, 106.083336, 0, 0),
(25709, 0, 509, -9757.87, 1416.71, 76.7664, 0, 0),
(25825, 0, 509, -9805.95, 1422.85, 77.5852, 0, 0),
(25826, 0, 509, -9827.58, 1506.28, 82.3052, 0, 0),
(25827, 0, 509, -9778.91, 1419.98, 61.0743, 0, 0),
(25828, 0, 509, -9829.42, 1456.37, 90.7015, 0, 0);

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ayamiss_swarmer_teleport_trigger';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25830, 'spell_ayamiss_swarmer_teleport_trigger');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_ayamiss_swarmer_swarm';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(25844, 'spell_ayamiss_swarmer_swarm');

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 1, `EffectDieSides_1` = 0 WHERE `ID` = 25708;