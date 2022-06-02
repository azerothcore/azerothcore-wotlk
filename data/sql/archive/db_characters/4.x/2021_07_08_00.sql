-- DB update 2021_07_06_00 -> 2021_07_08_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2021_07_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2021_07_06_00 2021_07_08_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1625571576605726121'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1625571576605726121');

-- Set Riding Skill (762) to 75/75 where Apprentice Riding (33388) is max
UPDATE `character_skills` SET `value`=75, `max`=75 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=33388);

-- Set Riding Skill (762) to 150/150 where Journeyman Riding (33391) is max
UPDATE `character_skills` SET `value`=150, `max`=150 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=33391);

-- Set Riding Skill (762) to 225/225 where Expert Riding (34090) is max
UPDATE `character_skills` SET `value`=225, `max`=225 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=34090);

-- Set Riding Skill (762) to 300/300 where Artisan Riding (34091) is max
UPDATE `character_skills` SET `value`=300, `max`=300 WHERE `skill`=762 AND `guid` IN
  (SELECT `guid` FROM `character_spell` WHERE `spell` IN (33388, 33391, 34090, 34091)
    GROUP BY `guid` HAVING MAX(`spell`)=34091);

--
-- END UPDATING QUERIES
--
UPDATE version_db_characters SET date = '2021_07_08_00' WHERE sql_rev = '1625571576605726121';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
