-- DELETE old spawns 
DELETE FROM `pool_template` WHERE `entry` IN (2032,11701,11702,11703,11704,11705);
DELETE FROM `pool_pool` WHERE `mother_pool`=2032;
DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (11701,11702,11703,11704,11705);
-- DELETE FROM `gameobject` WHERE `id` IN (181555, 181556, 181557, 181569, 181570) AND `guid` IN ();

/*---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------HERBS--------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------*/

-- Delete Duplicates
DELETE FROM `gameobject` WHERE `guid` IN (40184, 40158, 40191, 40160, 40176);
-- Delete old pools
DELETE FROM `pool_template` WHERE `entry` IN (973);
DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (973);

UPDATE `gameobject` SET `position_z`=64.519707 WHERE `guid`=40157;
UPDATE `gameobject` SET `position_z`=38.092190 WHERE `guid`=40194;
UPDATE `gameobject` SET `position_z`=21.815708 WHERE `guid`=40155;
UPDATE `gameobject` SET `position_z`=33.026737 WHERE `guid`=40178;
UPDATE `gameobject` SET `position_z`=-10.123981 WHERE `guid`=40185;