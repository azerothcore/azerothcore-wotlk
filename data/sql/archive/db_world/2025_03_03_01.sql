-- DB update 2025_03_03_00 -> 2025_03_03_01
SET @CGUID := 452;
SET @OGUID := 517;

DELETE FROM `creature` WHERE `guid` = @CGUID AND `id1` = 28194;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`, `CreateObject`) VALUES
(@CGUID, 28194, 532, 0, 0, 1, 1, 0, -11099.45703125, -1967.8096923828125, 76.2422027587890625, 2.49582076072692871, 7200, 0, 0, 398370, 0, 0, 0, 0, 0, 49345, 2);

DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+6 AND `id` IN (190604, 190609, 190610);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@OGUID+0, 190604, 532, 0, 0, 1, 1, -11084.806640625,  -1981.458984375,     76.17449951171875,    4.049167633056640625, 0, 0, -0.89879322052001953, 0.438372820615768432, 7200, 255, 1, 49345),
(@OGUID+1, 190604, 532, 0, 0, 1, 1, -11097.796875,     -1982.6768798828125, 76.17401885986328125, 1.570795774459838867, 0, 0, 0.707106590270996093, 0.707106947898864746, 7200, 255, 1, 49345),
(@OGUID+2, 190604, 532, 0, 0, 1, 1, -11091.640625,     -1962.049072265625,  76.17254638671875,    0.122172988951206207, 0, 0, 0.061048507690429687, 0.998134791851043701, 7200, 255, 1, 49345),
(@OGUID+3, 190604, 532, 0, 0, 1, 1, -11104.51171875,   -1973.4371337890625, 76.17641448974609375, 1.48352813720703125,  0, 0, 0.675589561462402343, 0.737277925014495849, 7200, 255, 1, 49345),
(@OGUID+4, 190609, 532, 0, 0, 1, 1, -11082.6298828125, -1973.4215087890625, 77.53208160400390625, 1.448621988296508789, 0, 0, 0.662619590759277343, 0.748956084251403808, 7200, 255, 1, 49345),
(@OGUID+5, 190610, 532, 0, 0, 1, 1, -11083.3388671875, -1972.9371337890625, 77.55469512939453125, 1.832594871520996093, 0, 0, 0.793353080749511718, 0.608761727809906005, 7200, 255, 1, 49345),
(@OGUID+6, 190604, 532, 0, 0, 1, 1, -11087.6552734375, -1996.1715087890625, 76.1771392822265625,  2.792518377304077148, 0, 0, 0.984807014465332031, 0.173652306199073791, 7200, 255, 1, 49345);

DELETE FROM `gameobject_template` WHERE `entry` = 190610;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(190610, 1, 220, 'Orders from the Lich King', '', 'Reading orders', '', 1, 0, 1690, 1000, 190611, 0, 0, 33041, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 49345);

SET @SCOURGEINVASION := 17;
DELETE FROM `game_event_creature` WHERE `eventEntry` = @SCOURGEINVASION AND `guid` = @CGUID;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@SCOURGEINVASION, @CGUID);

DELETE FROM `game_event_gameobject` WHERE `eventEntry` = @SCOURGEINVASION AND `guid` BETWEEN @OGUID+0 AND @OGUID+6;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(@SCOURGEINVASION, @OGUID+0),
(@SCOURGEINVASION, @OGUID+1),
(@SCOURGEINVASION, @OGUID+2),
(@SCOURGEINVASION, @OGUID+3),
(@SCOURGEINVASION, @OGUID+4),
(@SCOURGEINVASION, @OGUID+5),
(@SCOURGEINVASION, @OGUID+6);
