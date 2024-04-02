--
-- trigger AI
UPDATE `creature_template` SET `ScriptName` = 'npc_gothik_trigger' WHERE `entry` = 16137;

-- re-do spawn locations for triggers
DELETE FROM `creature` WHERE `id1`=16137;
SET @CGUID = 127618; -- PR NOTE: This needs to match the value set in boss_gothik.cpp for the CGUID_TRIGGER const
SET @AREAID = 3456; -- Naxxramas AreaId
SET @ZONEID = 3456; -- Naxxramas ZoneId
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+00,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2643.731,-3399.681,284.1829,0,0,0,1710,0,0,0,0,0,0,'',0,0,'living side soul trigger (south)'),
(@CGUID+01,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2739.995,-3399.779,284.2946,0,0,0,1710,0,0,0,0,0,0,'',0,0,'living side soul trigger (north)'),
(@CGUID+02,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2643.731,-3321.727,284.2327,0,0,0,1710,0,0,0,0,0,0,'',0,0,'spectral side soul trigger (south)'),
(@CGUID+03,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2739.995,-3321.727,284.2316,0,0,0,1710,0,0,0,0,0,0,'',0,0,'spectral side soul trigger (north)'),
(@CGUID+04,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2692.161,-3430.746,268.6462,0,0,0,1710,0,0,0,0,0,0,'',0,0,'living side spawn trigger (center back)'),
(@CGUID+05,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2714.562,-3430.610,268.6462,0,0,0,1710,0,0,0,0,0,0,'',0,0,'living side spawn trigger (north)'),
(@CGUID+06,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2692.213,-3428.783,268.6462,0,0,0,1710,0,0,0,0,0,0,'',0,0,'living side spawn trigger (center front)'),
(@CGUID+07,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2669.581,-3428.859,268.6462,0,0,0,1710,0,0,0,0,0,0,'',0,0,'living side spawn trigger (south)'),
(@CGUID+08,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2733.457,-3349.388,267.7677,0,0,0,1710,0,0,0,0,0,0,'',0,0,'spectral side spawn trigger (northeast)'),
(@CGUID+09,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2725.818,-3309.567,267.7686,0,0,0,1710,0,0,0,0,0,0,'',0,0,'spectral side spawn trigger (northwest)'),
(@CGUID+10,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2700.269,-3322.354,267.7678,0,0,0,1710,0,0,0,0,0,0,'',0,0,'spectral side spawn trigger (center)'),
(@CGUID+11,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2664.872,-3340.749,267.7674,0,0,0,1710,0,0,0,0,0,0,'',0,0,'spectral side spawn trigger (southeast)'),
(@CGUID+12,16137,0,0,533,@ZONEID,@AREAID,3,1,0,2683.886,-3304.213,267.768 ,0,0,0,1710,0,0,0,0,0,0,'',0,0,'spectral side spawn trigger (southwest)');

-- make visuals target proper triggers
-- to anchor 1: 27892 (Trainee), 27928 (DK), 27935 (Rider)
-- to anchor 2: 27893 (Trainee), 27929 (DK), 27936 (Rider)
-- anchor -> skull: 27915 (Trainee), 27931 (DK), 27937 (Rider)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (27892,27928,27935,27893,27929,27936,27915,27931,27937);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,27892,0,0,31,0,3,16137,@CGUID+0,0,0,0,'','To Anchor 1 - Target Anchor Living South'),
(13,1,27892,0,1,31,0,3,16137,@CGUID+1,0,0,0,'','To Anchor 1 - Target Anchor Living North'),
(13,1,27928,0,0,31,0,3,16137,@CGUID+0,0,0,0,'','To Anchor 1 - Target Anchor Living South'),
(13,1,27928,0,1,31,0,3,16137,@CGUID+1,0,0,0,'','To Anchor 1 - Target Anchor Living North'),
(13,1,27935,0,0,31,0,3,16137,@CGUID+0,0,0,0,'','To Anchor 1 - Target Anchor Living South'),
(13,1,27935,0,1,31,0,3,16137,@CGUID+1,0,0,0,'','To Anchor 1 - Target Anchor Living North'),
(13,1,27893,0,0,31,0,3,16137,@CGUID+2,0,0,0,'','To Anchor 2 - Target Anchor Spectral South'),
(13,1,27893,0,1,31,0,3,16137,@CGUID+3,0,0,0,'','To Anchor 2 - Target Anchor Spectral North'),
(13,1,27929,0,0,31,0,3,16137,@CGUID+2,0,0,0,'','To Anchor 2 - Target Anchor Spectral South'),
(13,1,27929,0,1,31,0,3,16137,@CGUID+3,0,0,0,'','To Anchor 2 - Target Anchor Spectral North'),
(13,1,27936,0,0,31,0,3,16137,@CGUID+2,0,0,0,'','To Anchor 2 - Target Anchor Spectral South'),
(13,1,27936,0,1,31,0,3,16137,@CGUID+3,0,0,0,'','To Anchor 2 - Target Anchor Spectral North');
