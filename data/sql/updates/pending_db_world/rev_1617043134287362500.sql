INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617043134287362500');

-- Useless object
DELETE FROM `gameobject` WHERE `guid`=65857;
-- PhaseMask to 1 for all Naxx end wing eyes
UPDATE `gameobject` SET `phaseMask`=1 WHERE `guid` IN (268045, 268044, 268047, 268046);
-- Add gobject flag "GO_FLAG_NOT_SELECTABLE" for all Naxx end wing eyes
UPDATE `gameobject_template_addon` SET `flags`=`flags`|16 WHERE `entry` IN (181577, 181575, 181578, 181576);

