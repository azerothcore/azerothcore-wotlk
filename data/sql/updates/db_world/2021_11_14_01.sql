-- DB update 2021_11_14_00 -> 2021_11_14_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_14_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_14_00 2021_11_14_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636718487600176900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636718487600176900');

UPDATE `gameobject_template` SET `ScriptName`='go_bells' WHERE `entry` IN (175885, 176573, 182064);

DELETE FROM `game_event` WHERE `eventEntry`=73;
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`,`holidayStage`, `description`, `world_event`, `announce`) VALUES
(73, '2010-01-01 01:00:00', '2030-01-01 01:00:00', 60, 1, 0, 0, 'Hourly Bells', 0, 2);

DELETE FROM `game_event_gameobject` WHERE `eventEntry`=73;

-- Horde bells
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(73, 12435), -- Orgrimmar 
(73, 12436), -- Orgrimmar 
(73, 12437), -- Orgrimmar 
(73, 12438), -- Orgrimmar 
(73, 12439), -- Orgrimmar 
(73, 15508), -- Darkshire
(73, 18097), -- Thunder Bluff
(73, 18098), -- Thunder Bluff
(73, 18099), -- Thunder Bluff
(73, 18100), -- Thunder Bluff
(73, 18101), -- Thunder Bluff
(73, 18102), -- Thunder Bluff
(73, 18103), -- Thunder Bluff
(73, 18683), -- Stonebreaker Hold
(73, 20802), -- Tarren Mill 
(73, 45022); -- Brill

-- Alliance bells
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(73, 94),    -- Ironforge
(73, 619),   -- Ironforge
(73, 870),   -- Ironforge
(73, 1140),  -- Kharanos
(73, 4841),  -- Ironforge
(73, 6867),  -- Ironforge
(73, 9104),  -- Alcaz Island
(73, 9114),  -- Theramore
(73, 14562), -- Menethil
(73, 18894), -- Allerian Stronghold
(73, 18901), -- Stormwind
(73, 18896), -- Shattrath
(73, 20801), -- Hillsbrad
(73, 26283), -- Stormwind
(73, 26414), -- Stormwind
(73, 26435), -- Stormwind
(73, 26469), -- Stormwind
(73, 26743), -- Northshire Abbey
(73, 42666), -- Westfall Lighthouse
(73, 42905), -- Stormwind
(73, 42906), -- Stormwind
(73, 42924), -- Stormwind
(73, 48107), -- Astranaar
(73, 49811); -- Darnassus

-- karazhan bell
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) VALUES
(73, 24539);
--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_14_01' WHERE sql_rev = '1636718487600176900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
