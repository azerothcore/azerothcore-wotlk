INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617043134287362500');

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
UPDATE `gameobject_template_addon` SET `faction`=0, `flags`=16 WHERE `entry` IN (181230, 181231, 181232, 181233);
-- Fix Thaddius end wing eye location and its glow ramp
UPDATE `gameobject` SET `position_x`=3539.016, `position_y`=-2936.821, `position_z`=302.4756, `orientation`=3.141593 WHERE `guid` IN (268047, 65856);
-- Kelthuzad's throne should not be selectable otherwise player can see the name file of the gobject
UPDATE `gameobject_template_addon` SET `flags`=16 WHERE `entry`=181640;
-- Remove first and third Naxxramas trigger
DELETE FROM `creature` WHERE `guid` IN (1971312, 1971314);


/* Fix SAI */

-- Fix Blood Presence on Death Knight
UPDATE `smart_scripts` SET `event_type`=4, `event_phase_mask`=0, `event_param2`=0, `comment`='On Aggro - Cast Self - Blood Presence' WHERE `entryorguid`=16146 AND `source_type`=0 AND `id`=2 AND `link`=0;

