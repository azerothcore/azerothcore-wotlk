-- DB update 2021_07_23_11 -> 2021_07_23_12
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_11';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_11 2021_07_23_12 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626827552415834800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626827552415834800');

-- Remove the nodes from any existing nodes then add them to their distinct pool

-- RH = Raven Hill Cementary
-- RW = Random chests in the woods
-- GM = Ghost mary
-- ND = Woods north of Darkshire
-- OM = Ogre Mound

SET
@POOL_ENTRY_RH = 11671,
@POOL_ENTRY_RW = 11672,
@POOL_ENTRY_GM = 11673,
@POOL_ENTRY_ND = 11674,
@POOL_ENTRY_OM = 11675,
@POOL_SIZE = 1,
@CHANCE = 0,
@RESPAWN = 7200,
@POOL_DESCRIPTION_RH = 'Solid Chests - Raven Hill Cementary',
@POOL_DESCRIPTION_RW = 'Solid Chests - Woods of Duskwood',
@POOL_DESCRIPTION_GM = 'Solid Chests - Ghost Mary',
@POOL_DESCRIPTION_ND = 'Solid Chests - Woods north of Darkshire',
@POOL_DESCRIPTION_OM = 'Solid Chests - VulGol Ogre Mound';

-- Create temp table with pool entries
CREATE TABLE TEMP_POOL_ENTRIES (guid int, pool_entry int, description char(64));
INSERT INTO TEMP_POOL_ENTRIES VALUES 
(85666, @POOL_ENTRY_RH, 'Solid Chest, Raven Hill Cementary, Node 1'),
(18572, @POOL_ENTRY_RH, 'Solid Chest, Raven Hill Cementary, Node 2'),
(85665, @POOL_ENTRY_RH, 'Solid Chest, Raven Hill Cementary, Node 3'),
(85667, @POOL_ENTRY_RH, 'Solid Chest, Raven Hill Cementary, Node 4'),
(85808, @POOL_ENTRY_RH, 'Solid Chest, Raven Hill Cementary, Node 5'),
(33475, @POOL_ENTRY_RW, 'Solid Chest, Woods of Duskwood, Node 1'),
(85807, @POOL_ENTRY_RW, 'Solid Chest, Woods of Duskwood, Node 2'),
(17033, @POOL_ENTRY_GM, 'Solid Chest, Ghost Mary, Node 1'),
(85809, @POOL_ENTRY_GM, 'Solid Chest, Ghost Mary, Node 2'),
(85810, @POOL_ENTRY_GM, 'Solid Chest, Ghost Mary, Node 3'),
(85663, @POOL_ENTRY_ND, 'Solid Chest, Woods north of Darkshire, Node 1'),
(85839, @POOL_ENTRY_ND, 'Solid Chest, Woods north of Darkshire, Node 2'),
(18577, @POOL_ENTRY_ND, 'Solid Chest, Woods north of Darkshire, Node 3'),
(18562, @POOL_ENTRY_OM, 'Solid Chest, VulGol Ogre Mound, Node 1'),
(18547, @POOL_ENTRY_OM, 'Solid Chest, VulGol Ogre Mound, Node 2'),
(85844, @POOL_ENTRY_OM, 'Solid Chest, VulGol Ogre Mound, Node 3'),
(85675, @POOL_ENTRY_OM, 'Solid Chest, VulGol Ogre Mound, Node 4');

-- General Winterspring Zone
DELETE FROM `pool_template` WHERE `entry` IN (SELECT DISTINCT `pool_entry` FROM TEMP_POOL_ENTRIES);


INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(@POOL_ENTRY_RH, @POOL_SIZE, @POOL_DESCRIPTION_RH),
(@POOL_ENTRY_RW, @POOL_SIZE, @POOL_DESCRIPTION_RW),
(@POOL_ENTRY_GM, @POOL_SIZE, @POOL_DESCRIPTION_GM),
(@POOL_ENTRY_ND, @POOL_SIZE, @POOL_DESCRIPTION_ND),
(@POOL_ENTRY_OM, @POOL_SIZE, @POOL_DESCRIPTION_OM);


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
UPDATE version_db_world SET date = '2021_07_23_12' WHERE sql_rev = '1626827552415834800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
