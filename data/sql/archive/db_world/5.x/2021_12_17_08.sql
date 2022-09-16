-- DB update 2021_12_17_07 -> 2021_12_17_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_17_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_17_07 2021_12_17_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639409951725872400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639409951725872400');

/* Assign Alchemist Arbington as Queststarter & Questender of 'The Key to Scholomance' ID 5505
*/

DELETE FROM `creature_queststarter` WHERE (`quest` = 5505) AND (`id` IN (10838, 11056));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(11056, 5505);

DELETE FROM `creature_questender` WHERE (`quest` = 5505) AND (`id` IN (10838, 11056));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(11056, 5505);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_17_08' WHERE sql_rev = '1639409951725872400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
