-- DB update 2020_12_10_05 -> 2020_12_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_10_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_10_05 2020_12_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606625488742709700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606625488742709700');

/* Add missing messages when attempting to enter an instance without completing the required quest. */

    /* Magister's Terrace */
    UPDATE `access_requirement` SET `quest_failed_text`='You must complete the quest "Hard to Kill" and be level 70 before entering the Heroic difficulty of the Magisters\' Terrace.' WHERE  `mapId`=585 AND `difficulty`=1;
    /* Pit of Saron */
    UPDATE `access_requirement` SET `quest_failed_text`='You must complete the quest "Echoes of Tortured Souls" before entering the Pit of Saron.' WHERE  `mapId`=658 AND `difficulty`=0;
    UPDATE `access_requirement` SET `quest_failed_text`='You must complete the quest "Echoes of Tortured Souls" and be level 80 before entering the Heroic difficulty of the Pit of Saron.' WHERE  `mapId`=658 AND `difficulty`=1;
    /* Halls of Reflection */
    UPDATE `access_requirement` SET `quest_failed_text`='You must complete the quest "Deliverance from the Pit" before entering the Halls of Reflection.' WHERE  `mapId`=668 AND `difficulty`=0;
    UPDATE `access_requirement` SET `quest_failed_text`='You must complete the quest "Deliverance from the Pit" and be level 80 before entering the Heroic difficulty of the Halls of Reflection.' WHERE  `mapId`=668 AND `difficulty`=1;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
