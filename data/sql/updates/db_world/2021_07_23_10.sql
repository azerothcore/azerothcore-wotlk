-- DB update 2021_07_23_09 -> 2021_07_23_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_09 2021_07_23_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626825033504612600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626825033504612600');

-- Remove the nodes from any existing nodes then add them to their distinct pool

-- ME = Murloc Encampment
-- BP = Blackwell Pumpin
-- JL = Jarod's Landing
-- FM = Fargodeep Mine
-- FE = Forest's Edge

SET
@POOL_ENTRY_ME = 11665,
@POOL_ENTRY_BP = 11666,
@POOL_ENTRY_JL = 11667,
@POOL_ENTRY_FM = 11668,
@POOL_ENTRY_FE = 11669,
@POOL_SIZE = 1,
@CHANCE = 0,
@RESPAWN = 3600,
@POOL_DESCRIPTION_ME = 'Battered Chests - Murloc Encampment near Goldshire',
@POOL_DESCRIPTION_BP = 'Battered Chests - Brackwell Pumpin Patch',
@POOL_DESCRIPTION_JL = 'Battered Chests - Jerods Landing',
@POOL_DESCRIPTION_FM = 'Battered Chests - Fargodepp Mine Entrance',
@POOL_DESCRIPTION_FE = 'Battered Chests - Forests Edge';

-- Create temp table with pool entries
CREATE TABLE TEMP_POOL_ENTRIES (guid int, pool_entry int, description char(64));
INSERT INTO TEMP_POOL_ENTRIES VALUES 
(33616, @POOL_ENTRY_ME, 'Battered Chest, Murloc Encampment near Goldshire, Node 1'),
(26234, @POOL_ENTRY_ME, 'Battered Chest, Murloc Encampment near Goldshire, Node 2'),
(26978, @POOL_ENTRY_ME, 'Battered Chest, Murloc Encampment near Goldshire, Node 3'),
(85756, @POOL_ENTRY_BP, 'Battered Chest, Brackwell Pumpin Patch, Node 1'),
(85879, @POOL_ENTRY_BP, 'Battered Chest, Brackwell Pumpin Patch, Node 2'),
(85745, @POOL_ENTRY_BP, 'Battered Chest, Brackwell Pumpin Patch, Node 3'),
(26916, @POOL_ENTRY_BP, 'Battered Chest, Brackwell Pumpin Patch, Node 4'),
(26895, @POOL_ENTRY_JL, 'Battered Chest, Jerods Landing, Node 1'),
(87390, @POOL_ENTRY_JL, 'Battered Chest, Jerods Landing, Node 2'),
(85746, @POOL_ENTRY_JL, 'Battered Chest, Jerods Landing, Node 3'),
(30950, @POOL_ENTRY_FM, 'Battered Chest, Fargodepp Mine Entrance, Node 1'),
(85770, @POOL_ENTRY_FM, 'Battered Chest, Fargodepp Mine Entrance, Node 2'),
(26865, @POOL_ENTRY_FE, 'Battered Chest, Forests Edge, Node 1'),
(85747, @POOL_ENTRY_FE, 'Battered Chest, Forests Edge, Node 2'),
(34032, @POOL_ENTRY_FE, 'Battered Chest, Forests Edge, Node 3');

-- General Winterspring Zone
DELETE FROM `pool_template` WHERE `entry` IN (SELECT DISTINCT `pool_entry` FROM TEMP_POOL_ENTRIES);


INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(@POOL_ENTRY_ME, @POOL_SIZE, @POOL_DESCRIPTION_ME),
(@POOL_ENTRY_BP, @POOL_SIZE, @POOL_DESCRIPTION_BP),
(@POOL_ENTRY_JL, @POOL_SIZE, @POOL_DESCRIPTION_JL),
(@POOL_ENTRY_FM, @POOL_SIZE, @POOL_DESCRIPTION_FM),
(@POOL_ENTRY_FE, @POOL_SIZE, @POOL_DESCRIPTION_FE);


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
UPDATE version_db_world SET date = '2021_07_23_10' WHERE sql_rev = '1626825033504612600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
