-- Kraz = 24024/24444
-- Tanzar = 23790/24442
-- Harkor = 23999/24443
-- Ashli = 24001/24441

DELETE FROM `creature` WHERE `id1` IN (24024, 24444, 23790, 24442, 23999, 24443, 24001, 24441);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@GUID, 24024, 0, 0, 568, 0, 0, 1, 1, 0, -73.82075,  1164.7422, 5.2878876, 4.590215682983398437, 7200, 0, 0, 5624, 0, 0, 0, 0, 0, '', 53788, 1, NULL), -- Kraz
(@GUID, 23790, 0, 0, 568, 0, 0, 1, 1, 0, -147.69608, 1333.2717, 48.25721,  0.820304751396179199, 7200, 0, 0, 4890, 0, 0, 0, 0, 0, '', 53788, 1, NULL), -- Tanzar
(@GUID, 23999, 0, 0, 568, 0, 0, 1, 1, 0, 296.2255,   1468.3542, 81.589294, 5.375614166259765625, 7200, 0, 0, 4890, 0, 0, 0, 0, 0, '', 53788, 1, NULL), -- Harkor
(@GUID, 24001, 0, 0, 568, 0, 0, 1, 1, 0, 383.77628,  1082.9733, 6.0476613, 1.588249564170837402, 7200, 0, 0, 3260, 0, 0, 0, 0, 0, '', 53788, 1, NULL); -- Ashli
