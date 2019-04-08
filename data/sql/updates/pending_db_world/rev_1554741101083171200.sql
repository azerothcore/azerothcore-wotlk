INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554741101083171200');

UPDATE `creature_template` SET `unit_flags` =4 WHERE `entry` =22443;

DELETE FROM `creature` WHERE `id` =22443;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(78793, 22443, 530, 0, 0, 1, 1, 0, 0, 2227.4599609375, 5484.31982421875, 153.772994995117, 3.3173999786377, 60, 0, 0, 7850, 0, 0, 0, 0, 0, '', 0),
(78794, 22443, 530, 0, 0, 1, 1, 0, 0, 1931.43994140625, 5330.759765625, 154.175994873047, 5.86600017547607, 60, 0, 0, 7850, 0, 0, 0, 0, 0, '', 0);
