-- DB update 2022_12_02_05 -> 2022_12_06_00
--
SET @GUID := 24967;

DELETE FROM `gameobject` WHERE `id`=184031 AND `zoneId`=3523 AND `areaId`=3734 AND `guid` IN (@GUID+0, @GUID+1, @GUID+2);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(@GUID+0, 184031, 530, 3523, 3734, 1, 3096.23, 2195.02, 149.16, 0.314158, 0, 0, 0, 0, 181, 255, 1),
(@GUID+1, 184031, 530, 3523, 3734, 1, 3097.86, 2184.51, 149.162, 2.40855, 0, 0, 0, 0, 181, 255, 1),
(@GUID+2, 184031, 530, 3523, 3734, 1, 3098.44, 2164.58, 149.168, 0.628317, 0, 0, 0, 0, 181, 255, 1);
