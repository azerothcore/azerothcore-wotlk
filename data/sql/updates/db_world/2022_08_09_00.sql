-- DB update 2022_08_08_00 -> 2022_08_09_00
--
SET @NPC := 15369;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-9689.981,1548.2961,33.27733,0,0,0,0,100,0),
(@PATH,2,-9682.716,1554.252,31.416214,0,0,0,0,100,0),
(@PATH,3,-9677.917,1558.839,27.249535,0,0,0,0,100,0);

-- Summon HiveZara larvae
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 1, `EffectDieSides_1` = 0 WHERE `ID` IN (26538, 26539);

DELETE FROM `spell_target_position` WHERE `ID` IN (26538, 26539);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(26538, 0, 509, -9678.29, 1526.39, 24.403833,0,0),
(26539, 0, 509, -9709, 1551.2, 23.988834, 0, 0);

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 15546;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(15546, 1, 0, 1, 0, 0, NULL);
