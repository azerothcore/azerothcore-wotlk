-- DB update 2022_03_12_01 -> 2022_03_12_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_12_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_12_01 2022_03_12_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646846735975559298'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646846735975559298');

-- Fixed ruRU translation of the objectives field for quest 5624
UPDATE `quest_template_locale` SET `VerifiedBuild`=0, `Objectives`='Разыщите стражника Робертса и исцелите его раны, пользуясь "Малым исцелением" (уровень 2), а затем одарите его заклинанием "Слово силы: Стойкость", после чего вернитесь в Златоземье к жрице Жозетте.' WHERE `ID`=5624 AND `locale`='ruRU';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_12_02' WHERE sql_rev = '1646846735975559298';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
