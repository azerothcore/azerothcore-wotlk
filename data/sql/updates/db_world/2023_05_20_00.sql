-- DB update 2023_05_17_00 -> 2023_05_20_00
--
SET @CGUID := 138519;

DELETE FROM `creature` WHERE `id1` IN (17653, 17377) AND `map` = 542;
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 17653, 542, 3713, 3713, 3, 1, 0, 316.273651123046875, -108.876602172851562, -24.6027107238769531, 1.256637096405029296, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 46366),
(@CGUID+1, 17653, 542, 3713, 3713, 3, 1, 0, 345.848419189453125, -74.4559097290039062, -24.6402416229248046, 3.59537816047668457, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 46366),
(@CGUID+2, 17653, 542, 3713, 3713, 3, 1, 0, 343.5838623046875, -103.630592346191406, -24.5688228607177734, 2.356194496154785156, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 46366),
(@CGUID+3, 17653, 542, 3713, 3713, 3, 1, 0, 301.987579345703125, -86.74652099609375, -24.4516544342041015, 0.157079637050628662, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 46366),
(@CGUID+4, 17653, 542, 3713, 3713, 3, 1, 0, 320.75, -63.6120796203613281, -24.6360912322998046, 4.886921882629394531, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 46366),
(@CGUID+5, 17377, 542, 3713, 3713, 3, 1, 1, 326.502899169921875, -86.0027542114257812, -24.5770149230957031, 3.59537816047668457, 86400, 0, 0, 0, 0, 0, 0, 0, 0, 46366);
 
 UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 17653);
 UPDATE `creature_template` SET `flags_extra` = `flags_extra`|67108864 WHERE (`entry` IN (17653, 18620));
 
 DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 17653);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17653, 0, 0, 0, 0, 0, 100, 0, 1200, 2400, 6000, 7200, 0, 11, 12739, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - In Combat - Cast \'Shadow Bolt\''),
(17653, 0, 1, 0, 0, 0, 100, 0, 5000, 6500, 16000, 17500, 0, 11, 30937, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - In Combat - Cast \'Mark of Shadow\''),
(17653, 0, 2, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 10, @CGUID+5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - On Just Died - Do Action 1 on Keli\'dan the Breaker'),
(17653, 0, 3, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 9, 17653, 0, 100, 1, 0, 0, 0, 0, 'Shadowmoon Channeler - On Aggro - Set In Combat With Zone');

DELETE FROM `creature_formations` WHERE `memberGUID` IN (@CGUID+0,@CGUID+1,@CGUID+2,@CGUID+3,@CGUID+4,@CGUID+5);
INSERT INTO `creature_formations` (`memberGUID`, `leaderGUID`, `groupAI`) VALUES
(@CGUID+0, @CGUID+5, 24),
(@CGUID+1, @CGUID+5, 24),
(@CGUID+2, @CGUID+5, 24),
(@CGUID+3, @CGUID+5, 24),
(@CGUID+4, @CGUID+5, 24),
(@CGUID+5, @CGUID+5, 24);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-138519,-138519,-138520,-138521,-138522,-138523));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-(@CGUID+0), 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 15000, 15000, 0, 11, 30888, 0, 0, 0, 0, 0, 10, @CGUID+4, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - Out of Combat - Cast \'Star Beam\''),
(-(@CGUID+0), 0, 1001, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 223, 2, 0, 0, 0, 0, 0, 10, @CGUID+5, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - On Aggro - Do Action 2 on Keli\'dan the Breaker'),
(-(@CGUID+1), 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 15000, 15000, 0, 11, 30888, 0, 0, 0, 0, 0, 10, @CGUID+0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - Out of Combat - Cast \'Star Beam\''),
(-(@CGUID+2), 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 15000, 15000, 0, 11, 30888, 0, 0, 0, 0, 0, 10, @CGUID+3, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - Out of Combat - Cast \'Star Beam\''),
(-(@CGUID+3), 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 15000, 15000, 0, 11, 30888, 0, 0, 0, 0, 0, 10, @CGUID+1, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - Out of Combat - Cast \'Star Beam\''),
(-(@CGUID+4), 0, 1000, 0, 1, 0, 100, 0, 3600, 3600, 15000, 15000, 0, 11, 30888, 0, 0, 0, 0, 0, 10, @CGUID+2, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Channeler - Out of Combat - Cast \'Star Beam\'');
