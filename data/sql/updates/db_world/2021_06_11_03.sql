-- DB update 2021_06_11_02 -> 2021_06_11_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_11_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_11_02 2021_06_11_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622719475133710519'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622719475133710519');

-- unused GUIDs
SET @GOB1 := 64811;
SET @GOB2 := 64827;
SET @GOB3 := 64837;
SET @GOB4 := 64839;
SET @GOB5 := 64843;
SET @GOB6 := 64859;
SET @POOL1:= 364;

DELETE FROM `gameobject` WHERE `id` = 180753 AND `guid` IN (@GOB1, @GOB2, @GOB3, @GOB4, @GOB5, @GOB6);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `position_x`, `position_y`, `spawntimesecs`, `animprogress`) VALUES
(64811, 180753, 1, 3636.9329, -6091.6519, 3600, 100),
(64827, 180753, 1, 4020.0103, -6045.5298, 3600, 100),
(64837, 180753, 1, 3990.0527, -6295.1006, 3600, 100),
(64839, 180753, 1, 3517.3694, -7286.9570, 3600, 100),
(64843, 180753, 1, 2907.5141, -7090.7153, 3600, 100),
(64859, 180753, 1, 3031.2488, -6676.1084, 3600, 100);

DELETE FROM `pool_template` WHERE `entry` = @POOL1;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL1, 4, 'Azshara - Patch of Elemental Water');

DELETE FROM `pool_gameobject` WHERE `guid` IN (@GOB1, @GOB2, @GOB3, @GOB4, @GOB5, @GOB6);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(64811, @POOL1, 0, '1 - Patch of Elemental Water'),
(64827, @POOL1, 0, '2 - Patch of Elemental Water'),
(64837, @POOL1, 0, '3 - Patch of Elemental Water'),
(64839, @POOL1, 0, '4 - Patch of Elemental Water'),
(64843, @POOL1, 0, '5 - Patch of Elemental Water'),
(64859, @POOL1, 0, '6 - Patch of Elemental Water');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_11_03' WHERE sql_rev = '1622719475133710519';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
