-- Zombie Infestation spell scripts
DELETE FROM `spell_script_names` WHERE `spell_id` IN (48953, 43958, 43869);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48953, 'spell_zombie_infestation_infect'),
(43958, 'spell_zombie_infestation_infected'),
(43869, 'spell_zombie_infestation_zombie');

-- Plagued Roach / Vermin: SmartAI to cast Infect! on killer
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (27845, 27855);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27845, 27855) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27845, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48953, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Plagued Roach - On Death - Cast Infect! on Killer'),
(27855, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 48953, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Plagued Vermin - On Death - Cast Infect! on Killer');

-- Argent Healer
UPDATE `creature_template` SET `ScriptName` = 'npc_argent_healer_zombie' WHERE `entry` = 27305;

-- Zombie Infestation game_event
DELETE FROM `game_event` WHERE `eventEntry` = 200;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `world_event`, `description`) VALUES
(200, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 5, 'Zombie Infestation');

-- Event creature spawns: Booty Bay
SET @CGUID := 290000;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID AND @CGUID+4;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`) VALUES
(@CGUID+0, 27845, 0, 1, 1, -14310.0, 510.0, 8.7, 0, 30, 5, 1, 0),
(@CGUID+1, 27845, 0, 1, 1, -14325.0, 475.0, 8.6, 0, 30, 5, 1, 0),
(@CGUID+2, 27855, 0, 1, 1, -14295.0, 505.0, 9.1, 0, 30, 5, 1, 0),
(@CGUID+3, 27855, 0, 1, 1, -14305.0, 520.0, 8.9, 0, 30, 5, 1, 0),
(@CGUID+4, 27305, 0, 1, 1, -14300.0, 500.0, 9.2, 0, 120, 0, 0, 0);

DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @CGUID AND @CGUID+4;
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(200, @CGUID+0),
(200, @CGUID+1),
(200, @CGUID+2),
(200, @CGUID+3),
(200, @CGUID+4);

-- Event gameobject spawns: Conspicuous Crates in Booty Bay
SET @GGUID := 270000;
DELETE FROM `gameobject` WHERE `guid` BETWEEN @GGUID AND @GGUID+1;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(@GGUID+0, 186799, 0, 1, 1, -14315.0, 508.0, 8.7, 0, 0, 0, 0, 1, 120, 100, 1, 0),
(@GGUID+1, 186799, 0, 1, 1, -14298.0, 515.0, 9.0, 0, 0, 0, 0, 1, 120, 100, 1, 0);

DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @GGUID AND @GGUID+1;
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(200, @GGUID+0),
(200, @GGUID+1);
