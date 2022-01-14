-- DB update 2022_01_10_01 -> 2022_01_10_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_10_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_10_01 2022_01_10_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641531429690119500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641531429690119500');
/* This is a amalgamation of work from a collection of parses.

Specific packets used are mentioned here for reference purposes, and were uploaded to the AC submission page

# TrinityCore - WowPacketParser
# File name: 2.5.2.41510 Night Elf Hunter 025 Twisted Hatred (3 Spawns) also Sentinel Shayla Nightbreeze Patrol and Threggil Patrol Battered Chest.pkt
# Detected build: V2_5_2_41510
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 01/06/2022 00:34:31

# TrinityCore - WowPacketParser
# File name: 2.5.2.41510 Night Elf Rogue 08 Fel Rock Lower Half Spawnpoints.pkt
# Detected build: V2_5_2_41510
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 01/06/2022 00:34:24

# TrinityCore - WowPacketParser
# File name: 2.5.2.41510 Night Elf Rogue 010 Area Spawnpoints Disconnect.pkt
# Detected build: V2_5_2_41510
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 01/06/2022 00:34:27

# TrinityCore - WowPacketParser
# File name: 2.5.2.41510 Night Elf Rogue 09 Area Spawnpoints Disconnect.pkt
# Detected build: V2_5_2_41510
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 01/06/2022 00:34:25

# TrinityCore - WowPacketParser
# File name: 2.5.2.41510 Night Elf Rogue 08 Area Spawnpoints Disconnect.pkt
# Detected build: V2_5_2_41510
# Detected locale: enUS
# Targeted database: WrathOfTheLichKing
# Parsing date: 01/06/2022 00:34:20

*/
/* New Guids Sourced from GUID Searcher */
/* Fel Rock has 4 Battered Chest Spawns Pooled */
DELETE FROM `gameobject` WHERE `guid` IN (49628, 49512, 49513, 49514);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(49512, 106318, 1, 141, 258, 1, 1, 10128.7626953125, 1114.3878173828125, 1323.858154296875, 5.270895957946777343, 0, 0, -0.48480892181396484, 0.87462007999420166, 450, 255, 1, 0), -- 106318 (Area: 258 - Difficulty: 0) .go xyz 10128.7626953125 1114.3878173828125 1323.858154296875 5.270895957946777343
(49513, 106318, 1, 141, 258, 1, 1, 10182.3330078125, 1174.6905517578125, 1326.032958984375, 5.829400539398193359, 0, 0, -0.22495079040527343, 0.974370121955871582, 420, 255, 1, 0), -- 106318 (Area: 258 - Difficulty: 0) .go xyz 10182.3330078125 1174.6905517578125 1326.032958984375 5.829400539398193359
(49514, 106318, 1, 141, 258, 1, 1, 10134.7548828125, 1183.4837646484375, 1323.5435791015625, 5.375615119934082031, 0, 0, -0.4383707046508789, 0.898794233798980712, 450, 255, 1, 0), -- 106318 (Area: 258 - Difficulty: 0) .go xyz 10134.7548828125 1183.4837646484375 1323.5435791015625 5.375615119934082031
(49628, 106318, 1, 141, 0, 1, 1, 10087.7861328125, 1164.7264404296875, 1300.3565673828125, 1.466075778007507324, 0, 0, 0.669130325317382812, 0.74314504861831665, 420, 255, 1, 0); -- 106318 (Area: 0 - Difficulty: 0) .go xyz 10087.7861328125 1164.7264404296875 1300.3565673828125 1.466075778007507324
/* Remove bad pooling (49628) */
DELETE FROM `pool_gameobject` WHERE  `guid` IN (49628, 49512, 49513, 49514);
DELETE FROM `pool_template` WHERE `entry` IN (379);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(379, 1, 'Fel Rock, Teldrassil, Gameobject Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(49628, 379, 0, 'Fel Rock, Teldrassil Battered Chest 1 of 4'),
(49512, 379, 0, 'Fel Rock, Teldrassil Battered Chest 2 of 4'),
(49513, 379, 0, 'Fel Rock, Teldrassil Battered Chest 3 of 4'),
(49514, 379, 0, 'Fel Rock, Teldrassil Battered Chest 4 of 4');
/* Lord Melenas Spawns */
DELETE FROM `creature` WHERE `guid` IN (49850, 49818, 49819);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(49818, 2038, 1, 0, 0, 1, 1, 0, 0, 10131.353, 1190.7599, 1323.6772, 0.05235987901687622, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0), -- .go xyz 10131.353 1190.7599 1323.6772
(49850, 2038, 1, 0, 0, 1, 1, 0, 0, 10107.082, 1206.2411, 1311.5499, 4.468042850494384765, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0), -- .go xyz 10107.082 1206.2411 1311.5499
(49819, 2038, 1, 0, 0, 1, 1, 0, 0, 10126.479, 1124.7946, 1338.0225, 3.682644605636596679, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0); -- .go xyz 10126.479 1124.7946 1338.0225
/* Lord Melenas 3 Spawn Locations Pooled */
DELETE FROM `pool_creature` WHERE  `guid` IN (49818, 49850, 49819);
DELETE FROM `pool_template` WHERE `entry` IN (387);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(387, 1, 'Fel Rock, Teldrassil, Creature Lord Melenas 2038');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(49818, 387, 0, 'Fel Rock, Lord Melenas Spawn 1 of 3'),
(49819, 387, 0, 'Fel Rock, Lord Melenas Spawn 2 of 3'),
(49850, 387, 0, 'Fel Rock, Lord Melenas Spawn 3 of 3');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_10_02' WHERE sql_rev = '1641531429690119500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
