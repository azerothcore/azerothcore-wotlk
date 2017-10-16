INSERT INTO version_db_world (`sql_rev`) VALUES ('1508172729879058700');

-- Fix Startup Errors
UPDATE `creature_addon` SET `auras`='' WHERE `guid`=6432;
UPDATE `creature_template` SET `skinloot`=80102 WHERE `entry` IN (18343, 20268);
DELETE FROM `creature_addon` WHERE `guid`=3574;
