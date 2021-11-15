-- DB update 2021_07_23_10 -> 2021_07_23_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_10 2021_07_23_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626826866431944500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626826866431944500');

-- Remove the nodes from any existing nodes then add them to their distinct pool

-- JM = Jangolode Mine

SET
@POOL_ENTRY_JM = 11670,
@POOL_SIZE = 1,
@CHANCE = 0,
@RESPAWN = 3600,
@POOL_DESCRIPTION_JM = 'Battered Chests - Jangolode Mine';

-- Create temp table with pool entries
CREATE TABLE TEMP_POOL_ENTRIES (guid int, pool_entry int, description char(64));
INSERT INTO TEMP_POOL_ENTRIES VALUES 
(42718, @POOL_ENTRY_JM, 'Battered Chest, Jangolode Mine, Node 1'),
(85887, @POOL_ENTRY_JM, 'Battered Chest, Jangolode Mine, Node 2'),
(42739, @POOL_ENTRY_JM, 'Battered Chest, Jangolode Mine, Node 3');

-- General Winterspring Zone
DELETE FROM `pool_template` WHERE `entry` IN (SELECT DISTINCT `pool_entry` FROM TEMP_POOL_ENTRIES);


INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(@POOL_ENTRY_JM, @POOL_SIZE, @POOL_DESCRIPTION_JM);


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
UPDATE version_db_world SET date = '2021_07_23_11' WHERE sql_rev = '1626826866431944500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
