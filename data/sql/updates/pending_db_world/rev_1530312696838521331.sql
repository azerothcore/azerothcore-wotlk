INSERT INTO version_db_world (`sql_rev`) VALUES ('1530312696838521331');

UPDATE `creature` SET `modelid` = 16444, `orientation` = 1.2727 WHERE `guid` = 202761;
UPDATE `creature` SET `modelid` = 16432, `orientation` = 4.35146 WHERE `guid` = 202762;
UPDATE `creature` SET `modelid` = 16438 WHERE `guid` = 202759;
UPDATE `creature` SET `modelid` = 16445 WHERE `guid` = 202760;

DELETE FROM `creature` WHERE `guid` = 86895;
INSERT INTO `creature`
(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES
(86895,26520,0,1,1,8409,0,2281.25,428.862,33.9647,3.54294,300,0,0,42,0,0,0,0,0);
