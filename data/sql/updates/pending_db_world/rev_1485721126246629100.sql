INSERT INTO version_db_world (`sql_rev`) VALUES ('1485721126246629100');
-- [NPC][WOTLK] Argent Cannon
UPDATE `creature` SET `curmana`=0 WHERE `id`=30236;
UPDATE `creature_template` SET `VehicleId`=244 WHERE `entry`=30236;