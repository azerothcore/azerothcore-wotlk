-- DB update 2019_11_28_00 -> 2019_11_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_28_00 2019_11_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1572680805604667000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1572680805604667000');

-- Prevent triggering the event while another event is running
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 51210;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(17,0,51210,0,0,29,0,28256,20,0,1,0,0,'','Use Soo-rahms Incense if no Voice of Nozronn is spawned');

-- Enable talk to summoner (player) instead of invoker
UPDATE `smart_scripts` SET `target_type` = 23, `target_param1` = 0  WHERE `entryorguid` = 2825600 AND `source_type` = 9;

-- Summon "Voice of Nozronn", "Spiritsbreath Incense", various "Nozronn's Eye", various "Sholazar Witch Light" and cast "Internal Shake Camera"
DELETE FROM `event_scripts` WHERE `id` = 18481;
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`)
VALUES
(18481,0,10,28256,30000,0,5211.89,5788.68,-71.0877,2.1648),
(18481,1,10,28230,30000,0,5219.11,5779.45,-71.0571,4.5204),
(18481,1,10,28230,30000,0,5225.28,5777.67,-67.5094,5.06145),
(18481,1,10,28230,30000,0,5215.02,5777.66,-71.1333,3.75245),
(18481,1,10,28230,30000,0,5220.02,5771.54,-68.3226,5.16617),
(18481,1,10,28230,30000,0,5214.41,5784.44,-62.0158,0.59341),
(18481,1,10,28230,30000,0,5208.64,5778.08,-63.0435,2.56563),
(18481,0,9,9263,30,0,0,0,0,0),
(18481,1,15,39983,1,0,0,0,0,0),
(18481,1,10,28279,30000,0,5240.07,5784.48,-63.6731,3.76355),
(18481,1,10,28279,30000,0,5243.02,5777.95,-65.7595,2.06222),
(18481,1,10,28279,30000,0,5259.32,5768,-63.7346,2.75762),
(18481,1,10,28279,30000,0,5242.08,5740.67,-59.9892,4.18879),
(18481,1,10,28279,30000,0,5249.26,5765.97,-59.9069,6.17846),
(18481,1,10,28279,30000,0,5197.42,5776.38,-70.2504,2.09439),
(18481,1,10,28279,30000,0,5207.38,5800.15,-67.0273,3.82227),
(18481,1,10,28279,30000,0,5206.19,5754.94,-71.6155,2.87979),
(18481,1,10,28279,30000,0,5204.7,5791.86,-68.1195,1.62315),
(18481,1,10,28279,30000,0,5214.36,5743.66,-73.3691,4.29351),
(18481,1,10,28279,30000,0,5232.82,5750.23,-63.9341,3.96189),
(18481,1,10,28279,30000,0,5242.87,5777.24,-65.6762,2.426),
(18481,1,10,28279,30000,0,5232.51,5731.53,-68.7676,4.76474),
(18481,1,10,28279,30000,0,5206.44,5767.63,-68.1974,3.82227),
(18481,1,10,28279,30000,0,5254.31,5781.61,-67.9666,3.42084),
(18481,1,10,28279,30000,0,5223.68,5794.55,-64.1046,5.95157),
(18481,1,10,28279,30000,0,5232,5790.67,-68.2579,1.51843),
(18481,1,10,28279,30000,0,5240.94,5786.49,-63.5898,1.22173),
(18481,1,10,28279,30000,0,5198.98,5768.56,-70.7088,0.43633),
(18481,1,10,28279,30000,0,5230.02,5771.1,-56.9605,1.71042),
(18481,1,10,28279,30000,0,5199.84,5789.27,-62.4512,2.77507),
(18481,1,10,28279,30000,0,5215.57,5799.32,-68.9914,3.19395),
(18481,1,10,28279,30000,0,5221.6,5749.74,-63.7595,3.54301);

-- Add aura "Cosmetic - Low Poly Blue Fire" to "Nozronn's Eye"
UPDATE `creature_template_addon` SET `auras` = '46679' WHERE `entry` = 28230;

-- Add game object "Spiritsbreath Incense", which is initially not spawned (spawntimesecs -1)
DELETE FROM `gameobject` WHERE `guid` = 9263 AND `id` = 188443;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`)
VALUES
(9263,188443,571,0,0,1,1,5210.02,5790.89,-71.3845,-3.08918,0,0,-0.999657,0.0262017,-1,255,1,'',0);

-- Sholazar Witch Light: Enable flying
UPDATE `creature_template` SET `InhabitType` = `InhabitType` | 4 WHERE `entry` = 28279;

-- Sholazar Witch Light SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28279;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 28279 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 2827900 AND 2827903 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(28279,0,0,0,54,0,100,0,0,0,0,0,0,88,2827900,2827903,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sholazar Witch Light - On Just Summoned - Call Random Range Action List'),
(28279,0,1,0,1,0,100,0,0,0,5000,5000,0,89,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sholazar Witch Light - OOC - Random Movement'),
(28279,0,2,0,1,0,100,1,5000,25000,0,0,0,29,0,0,0,0,0,0,23,0,0,0,0,0,0,0,0,'Sholazar Witch Light - OOC - Follow Summoner'),
(28279,0,3,0,34,0,100,0,14,0,0,0,0,41,500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sholazar Witch Light - On Movement Inform ''FOLLOW_MOTION_TYPE'' - Despawn'),

(2827900,9,0,0,0,0,100,0,0,0,0,0,0,11,33343,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sholazar Witch Light - On Just Summoned - Cast Spell ''Red Banish State'''),
(2827901,9,1,0,0,0,100,0,0,0,0,0,0,11,33344,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sholazar Witch Light - On Just Summoned - Cast Spell ''Blue Banish State'''),
(2827902,9,2,0,0,0,100,0,0,0,0,0,0,11,32566,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sholazar Witch Light - On Just Summoned - Cast Spell ''Purple Banish State'''),
(2827903,9,3,0,0,0,100,0,0,0,0,0,0,11,35709,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sholazar Witch Light - On Just Summoned - Cast Spell ''White Banish State''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
