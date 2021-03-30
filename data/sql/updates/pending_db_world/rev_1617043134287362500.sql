INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617043134287362500');

-- Useless object in world
DELETE FROM `gameobject` WHERE `guid`=65857;
-- PhaseMask to 1 for all Naxx end wing eyes
UPDATE `gameobject` SET `phaseMask`=1 WHERE `guid` IN (268045, 268044, 268047, 268046);
-- Add gobject flag "GO_FLAG_NOT_SELECTABLE" for all Naxx end wing eyes
UPDATE `gameobject_template_addon` SET `flags`=`flags`|16 WHERE `entry` IN (181577, 181575, 181578, 181576);
-- Fix Horsemen end wing eye location
UPDATE `gameobject` SET `position_x`=2493.02, `position_y`=-2921.78, `position_z`=241.193, `orientation`=3.14159 WHERE `guid`=268046;

