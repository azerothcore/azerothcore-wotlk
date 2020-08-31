INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598881542523907700');
/*
 * General: Dalaran Fountain
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.5 */

DELETE FROM `gameobject` WHERE `guid`=268968;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(268968, 191446, 571, 0, 0, 1, 1, 5804.72, 640.837, 647.627, -0.680677, 0, 0, -0.333807, 0.942641, 180, 255, 1, '', 0);
