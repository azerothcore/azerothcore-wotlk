-- DB update 2020_11_24_00 -> 2020_11_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_24_00 2020_11_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1605979091794346800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605979091794346800');

/* Add extra mobs to The Antechamber in 25-man version of Ulduar */

DELETE FROM `creature` WHERE `guid` IN (136770,136771,136772,136773,136774,136775);
INSERT INTO `creature` VALUES 

/* Near Teleporter */

    /* Iron Golem */
    (136770, 34190, 603, 0, 0, 2, 1, 26155, 0, 1548.84, -10.5333, 420.967, 5.04629, 604800, 0, 0, 404430, 0, 0, 0, 0, 0, '', 0),
    /* Lightning Charged Iron Dwarf */
    (136771, 34199, 603, 0, 0, 2, 1, 26239, 1, 1549.15, -19.0012, 420.967, 5.12484, 604800, 5, 0, 471835, 0, 1, 0, 0, 0, '', 0),
    /* Iron Mender */
    (136772, 34198, 603, 0, 0, 2, 1, 26218, 1, 1552.57, -14.2679, 420.967, 3.94674, 604800, 0, 0, 337025, 62535, 0, 0, 0, 0, '', 0),

/* Near Stairs */

    /* Iron Golem */
    (136773, 34190, 603, 0, 0, 2, 1, 26155, 0, 1682.97, -11.0873, 427.312, 3.93888, 604800, 0, 0, 404430, 0, 0, 0, 0, 0, '', 0),
    /* Lightning Charged Iron Dwarf */
    (136774, 34199, 603, 0, 0, 2, 1, 26239, 1, 1679.91, -19.6422, 427.31, 3.19275, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', 0),
    /* Iron Mender */
    (136775, 34198, 603, 0, 0, 2, 1, 26218, 1, 1676.98, -11.2869, 427.31, 5.76657, 604800, 0, 0, 337025, 62535, 0, 0, 0, 0, '', 0);
    
/* Lightning Charged Iron Dwarf unsheath weapons and emote ready */
DELETE FROM `creature_addon` WHERE `guid` IN (136609,136610,136771,136774);
INSERT INTO `creature_addon` (`guid`, `bytes2`, `emote`) VALUES 
(136609, 1, 333),
(136610, 1, 0),
(136771, 1, 0),
(136774, 1, 333);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
