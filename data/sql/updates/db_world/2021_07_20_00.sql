-- DB update 2021_07_19_00 -> 2021_07_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_19_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_19_00 2021_07_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626206610803393000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626206610803393000');

-- Remove the nodes from any existing nodes then add them to their distinct pool

-- GW = General Winterspring
-- WV = Winterfall Village
-- LK = Lake Kel'Theril
-- TP = Timbermaw Post
-- FH = Frostfire Hot Springs

SET
@POOL_ENTRY_GW = 11660,
@POOL_ENTRY_WV = 11661,
@POOL_ENTRY_LK = 11662,
@POOL_ENTRY_TP = 11663,
@POOL_ENTRY_FH = 11664,
@POOL_SIZE = 1,
@CHANCE = 0,
@RESPAWN = 7200,
@POOL_DESCRIPTION_GW = 'Solid Chests - Winterspring',
@POOL_DESCRIPTION_WV = 'Solid Chests - Winterfall Village',
@POOL_DESCRIPTION_LK = 'Solid Chests - Lake KelTheril',
@POOL_DESCRIPTION_TP = 'Solid Chests - Timbermaw Post',
@POOL_DESCRIPTION_FH = 'Solid Chests - Frostfire Hot Springs';

-- Create temp table with pool entries
CREATE TABLE TEMP_POOL_ENTRIES (guid int, pool_entry int, description char(64));
INSERT INTO TEMP_POOL_ENTRIES VALUES 
(85800, @POOL_ENTRY_GW, 'Solid Chest, Winterspring, Node 1'),
(87393, @POOL_ENTRY_GW, 'Solid Chest, Winterspring, Node 2'),
(49091, @POOL_ENTRY_WV, 'Solid Chest, Winterfall Village, Node 1'),
(85798, @POOL_ENTRY_WV, 'Solid Chest, Winterfall Village, Node 2'),
(85799, @POOL_ENTRY_WV, 'Solid Chest, Winterfall Village, Node 3'),
(85803, @POOL_ENTRY_WV, 'Solid Chest, Winterfall Village, Node 4'),
(49088, @POOL_ENTRY_LK, 'Solid Chest, Lake KelTheril, Node 1'),
(85802, @POOL_ENTRY_LK, 'Solid Chest, Lake KelTheril, Node 2'),
(49089, @POOL_ENTRY_TP, 'Solid Chest, Timbermaw Post, Node 1'),
(85796, @POOL_ENTRY_TP, 'Solid Chest, Timbermaw Post, Node 2'),
(49090, @POOL_ENTRY_FH, 'Solid Chest, Frostfire Hot Springs, Node 1'),
(85801, @POOL_ENTRY_FH, 'Solid Chest, Frostfire Hot Springs, Node 2');

-- General Winterspring Zone
DELETE FROM `pool_template` WHERE `entry` IN (SELECT DISTINCT `pool_entry` FROM TEMP_POOL_ENTRIES);


INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(@POOL_ENTRY_GW, @POOL_SIZE, @POOL_DESCRIPTION_GW),
(@POOL_ENTRY_WV, @POOL_SIZE, @POOL_DESCRIPTION_WV),
(@POOL_ENTRY_LK, @POOL_SIZE, @POOL_DESCRIPTION_LK),
(@POOL_ENTRY_TP, @POOL_SIZE, @POOL_DESCRIPTION_TP),
(@POOL_ENTRY_FH, @POOL_SIZE, @POOL_DESCRIPTION_FH);


-- Delete from any existing pools
DELETE FROM `pool_gameobject` WHERE `guid` IN (SELECT `guid` FROM TEMP_POOL_ENTRIES);

-- Add to new pool
INSERT INTO `pool_gameobject`
(`guid`, `pool_entry`, `chance`, `description`) 
SELECT `guid`, `pool_entry`, @CHANCE, `description` FROM TEMP_POOL_ENTRIES;

-- Set spawn time
UPDATE `gameobject` SET `spawntimesecs` = @RESPAWN WHERE `guid` IN (SELECT `guid` FROM TEMP_POOL_ENTRIES);

-- Drop temp table
DROP TABLE TEMP_POOL_ENTRIES;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_20_00' WHERE sql_rev = '1626206610803393000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
