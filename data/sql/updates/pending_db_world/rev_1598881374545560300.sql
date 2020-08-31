INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598881374545560300');
/*
 * General: NPC Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.5 */

-- NPC entry 40405 Kieupid, Pet Trainer in Silvermoon City (map: 530, zone ID 0, area ID 0)
SET @CGUID = 248600;

DELETE FROM `creature` WHERE `id` = 40405 AND `guid` = @CGUID;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(@CGUID,40405,530,1,1,0,0, 9924.067, -7400.503, 13.71723, 6.073746, 120,0,0,0,0,0,0,0,0);
