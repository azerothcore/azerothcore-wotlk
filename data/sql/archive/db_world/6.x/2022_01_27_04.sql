-- DB update 2022_01_27_03 -> 2022_01_27_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_27_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_27_03 2022_01_27_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642724246151292535'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642724246151292535');

-- adds missing quest item objective marker for CC ticket 2838
DELETE FROM `creature_questitem` WHERE `CreatureEntry` IN (17200, 17201);
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES 
(17200, 0, 23676, 0),
(17201, 0, 23676, 0),
(17201, 1, 23677, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_27_04' WHERE sql_rev = '1642724246151292535';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
