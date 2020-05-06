-- DB update 2019_01_06_00 -> 2019_01_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_06_00 2019_01_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1546694249586814731'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1546694249586814731');

-- Moths:
DELETE FROM `creature_template_addon` WHERE `entry` IN (21008,21009,21010,21018);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(21008,0,0,33554432,0,0,''),
(21009,0,0,33554432,0,0,''),
(21010,0,0,33554432,0,0,''),
(21018,0,0,33554432,0,0,'');
UPDATE `creature_template` SET `ScriptName` = 'npc_pet_gen_moth' WHERE `entry` IN (21008,21009,21010,21018);

-- Gryphon Hatchling / Wind Rider Cub:
DELETE FROM `creature_template_addon` WHERE `entry` IN (36908,36909);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(36908,0,0,50331648,0,0,''),
(36909,0,0,50331648,0,0,'');

-- The smart script for the Wind Rider Cub can also be used for the Gryphon Hatchling:
UPDATE `creature_template` SET `ScriptName` = 'npc_pet_gen_wind_rider_cub' WHERE `entry` = 36908;

-- Dragonhawk Hatchlings:
DELETE FROM `creature_template_addon` WHERE `entry` IN (21055,21056,21063,21064);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(21055,0,0,33554432,0,0,''),
(21056,0,0,33554432,0,0,''),
(21063,0,0,33554432,0,0,''),
(21064,0,0,33554432,0,0,'');

-- Dragon Whelplings (including Frosty and Netherwhelp):
DELETE FROM `creature_template_addon` WHERE `entry` IN (7543,7544,7545,7547,36607,28883,18381);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(7543,0,0,33554432,0,0,''),
(7544,0,0,33554432,0,0,''),
(7545,0,0,33554432,0,0,''),
(7547,0,0,33554432,0,0,''),
(36607,0,0,33554432,0,0,''),
(28883,0,0,33554432,0,0,''),
(18381,0,0,33554432,0,0,'');

-- Parrots:
DELETE FROM `creature_template_addon` WHERE `entry` IN (7390,7387,7391,22445,7389);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(7390,0,0,33554432,0,0,''),
(7387,0,0,33554432,0,0,''),
(7391,0,0,33554432,0,0,''),
(22445,0,0,33554432,0,0,''),
(7389,0,0,33554432,0,0,'');

-- Tickbird Hatchlings:
DELETE FROM `creature_template_addon` WHERE `entry` IN (32589,32590);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(32589,0,0,33554432,0,0,''),
(32590,0,0,33554432,0,0,'');

-- Owls:
DELETE FROM `creature_template_addon` WHERE `entry` IN (7553,7555);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(7553,0,0,33554432,0,0,''),
(7555,0,0,33554432,0,0,'');

-- Batlings:
DELETE FROM `creature_template_addon` WHERE `entry` IN (28513,33197);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(28513,0,0,33554432,0,0,''),
(33197,0,0,33554432,0,0,'');

-- Sprite Darter Hatchling:
DELETE FROM `creature_template_addon` WHERE `entry` IN (9662);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(9662,0,0,33554432,0,0,'');

-- Willy:
UPDATE `creature_template_addon` SET `bytes1` = 33554432 WHERE `entry` = 23231;

-- Firefly:
DELETE FROM `creature_template_addon` WHERE `entry` IN (21076);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(21076,0,0,33554432,0,0,'');

-- Mana Wyrmling:
DELETE FROM `creature_template_addon` WHERE `entry` IN (20408);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(20408,0,0,33554432,0,0,'');

-- Nether Ray Fry:
DELETE FROM `creature_template_addon` WHERE `entry` IN (28470);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(28470,0,0,33554432,0,0,'');

-- Phoenix Hatchling:
DELETE FROM `creature_template_addon` WHERE `entry` IN (26119);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(26119,0,0,33554432,0,0,'');

-- Tiny Sporebat:
DELETE FROM `creature_template_addon` WHERE `entry` IN (25062);
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`)
VALUES
(25062,0,0,33554432,0,0,'');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
