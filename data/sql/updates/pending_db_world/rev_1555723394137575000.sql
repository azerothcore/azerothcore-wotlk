INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555723394137575000');

-- Update razorgore movement
UPDATE `creature_template` SET `MovementType`='0' WHERE  `entry`=12435;

-- Remove Grethok script from SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=12557;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='boss_grethok' WHERE  `entry`=12557;

-- Change Razorgore's faction
UPDATE `creature_template` SET `faction`='103' WHERE  `entry`=12435;

-- Rotate the Orb of Domination to the right position
UPDATE `gameobject` SET `orientation`='5.343413' WHERE  `guid`=67867;
