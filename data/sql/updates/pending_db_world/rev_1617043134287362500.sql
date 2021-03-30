INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617043134287362500');

-- Useless object in the instance
DELETE FROM `gameobject` WHERE `guid`=65857;
-- PhaseMask to 1 for all Naxx end wing eyes
UPDATE `gameobject` SET `phaseMask`=1 WHERE `guid` IN (268045, 268044, 268047, 268046);
-- Set gobject flag "GO_FLAG_NOT_SELECTABLE" for all Naxx end wing eyes
UPDATE `gameobject_template_addon` SET `flags`=16 WHERE `entry` IN (181577, 181575, 181578, 181576);
-- Fix Horsemen end wing eye location
UPDATE `gameobject` SET `position_x`=2493.02, `position_y`=-2921.78, `position_z`=241.193, `orientation`=3.14159 WHERE `guid`=268046;
-- Adjust normal portal & phased glow portal on the same location
DELETE FROM `gameobject` WHERE `id` IN (181230, 181231, 181232, 181233);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES 
(65855, 181231, 533, 0, 0, 3, 1, 2909, -4025.02, 273.475, 3.14159, 0, 0, 1, 0, 180, 0, 1, 0), -- Plague Wing Eye Portal Boss
(65856, 181232, 533, 0, 0, 3, 1, 3507.95, -2900.4, 302.459, 0.369949, 0, 0, 0.183921, 0.982941, 180, 0, 1, 0), -- Abom Wing Eye Portal Boss
(65857, 181233, 533, 0, 0, 3, 1, 3465.16, -3940.45, 308.788, 0.441179, -0.305481, 0.637715, 0.305481, 0.637716, 180, 0, 1, 0), -- Spider Wing Eye Portal Boss
(65854, 181230, 533, 0, 0, 3, 1, 2493.02, -2921.78, 241.193, 3.14159, 0, 0, 0.411143, -0.911571, 180, 0, 1, 0); -- Deathknight Wing Eye Portal Boss
-- Update flags & faction for glow eyes at boss-side
UPDATE `gameobject_template_addon` SET `faction`=0, `flags`=6553648 WHERE `entry` IN (181230, 181231, 181232, 181233);

