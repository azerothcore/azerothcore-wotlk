--
SET @GEVENT := 46;

DELETE FROM `game_event` WHERE `eventEntry` = @GEVENT;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(@GEVENT, '2008-09-08 12:00:00', '2008-09-24 12:00:00', 525600, 1, 0, 0, 'Spirit of Competition', 0, 2);

SET @CGUID := 152340;

DELETE FROM `creature` WHERE `id1` IN (27346, 27398, 27399);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@CGUID, 27398, 0, 0, 0, 1537, 1537, 0, 1, 0, -5040.92, -1250.81, 507.76, 0.70, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0), -- Grandhammer
(@CGUID+1, 27346, 0, 0, 0, 1537, 1537, 0, 1, 0, -5041.91, -1250.2, 507.76, 1.37, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0), -- IF Dragon
(@CGUID+2, 27399, 0, 0, 1, 1637, 1637, 0, 1, 0, 1964.39, -4798.77, 56.99, 0.08, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0), -- Muja
(@CGUID+3, 27346, 0, 0, 1, 1637, 1637, 0, 1, 0, 1963.26, -4797.62, 56.99, 0.72, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0); -- Org Dragon
-- Positions based on screenshots.
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@GEVENT, @CGUID),
(@GEVENT, @CGUID+1),
(@GEVENT, @CGUID+2),
(@GEVENT, @CGUID+3);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (48163,48164);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(48163,'spell_gen_spirit_of_competition_participant'),
(48164,'spell_gen_spirit_of_competition_winner');
