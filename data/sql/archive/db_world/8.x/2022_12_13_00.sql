-- DB update 2022_12_12_01 -> 2022_12_13_00
SET @guid := 92053;
DELETE FROM `gameobject` WHERE `guid` = @guid;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES (@guid, 195218, 1, 493, 2361, 8008.7421875, -2668.053955078125, 512.06414794921875, 2.757613182067871093, 0.981626510620117187, 0.190812408924102783, 120, 255, 1, 46902);
