-- Bjorn Halgurdsson - Set position, spawntimesecs
DELETE FROM `creature` WHERE (`guid` = 112513 AND `id1` = 24238);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
VALUES
(112513, 24238, 0, 0, 571, 0, 0, 1, 1, 1, 1510.538, -5271.508, 206.169, 5.3840, 60, 0, 0, 35928, 0, 0, 0, 0, 0, '', 0, 0, NULL);

-- Bjorn Halgurdsson - Set speed_run
UPDATE `creature_template` SET `speed_run` = 1.7435 WHERE (`entry` = 24238);

-- Bjorn Halgurdsson - Set mount
DELETE FROM `creature_template_addon` WHERE (`entry` = 24238);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24238, 0, 22657, 0, 0, 0, 0, '');

-- Bjorn Halgurdsson - Set movement
UPDATE `creature_template_movement` SET `Swim` = 0, `Flight` = 0 WHERE (`CreatureId` = 24238);

-- Bjorn Halgurdsson - SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 24238);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24238 AND `source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24238, 0, 0, 0, 1, 0, 100, 0, 10000, 15000, 45000, 60000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On update OOC - Say text 2'),
(24238, 0, 1, 2, 8, 0, 100, 0, 43315, 0, 0, 0, 0, 0, 84, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Invoker say text 0'),
(24238, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Say text 1'),
(24238, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Unmount'),
(24238, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Set Aggressive'),
(24238, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Remove Unit Flags'),
(24238, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On spellhit Vrykul Insult - Attack Start'),
(24238, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 43371, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On death - Spellcast Bjorn Kill Credit'),
(24238, 0, 8, 0, 0, 0, 100, 0, 5000, 10000, 10000, 15000, 0, 0, 11, 32736, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On update IC - Spellcast Mortal Strike'),
(24238, 0, 9, 0, 0, 0, 100, 0, 0, 5000, 10000, 15000, 0, 0, 11, 33661, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On update IC - Spellcast Crush Armor'),
(24238, 0, 11, 12, 7, 0, 100, 512, 0, 0, 0, 0, 0, 0, 43, 0, 22657, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On evade - Mount'),
(24238, 0, 12, 13, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On evade - Set Passive'),
(24238, 0, 13, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bjorn Halgurdsson - On evade - Set Unit Flags');
