-- DB update 2020_05_17_00 -> 2020_05_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_17_00 2020_05_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1586994404926935400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586994404926935400');

UPDATE `quest_template_locale` SET `Objectives`='Sammelt 12 Bäumlingssprosse.' WHERE `ID`=919 AND `locale`='deDE';
UPDATE `quest_template_locale` SET `Objectives`='Reúne 12 brotes de Brezomadera.' WHERE `ID`=919 AND `locale`='esES';
UPDATE `quest_template_locale` SET `Objectives`='Reúne 12 brotes de Brezomadera.' WHERE `ID`=919 AND `locale`='esMX';
UPDATE `quest_template_locale` SET `Objectives`='Collectez 12 Pousses de sylvain.' WHERE `ID`=919 AND `locale`='frFR';
UPDATE `quest_template_locale` SET `Objectives`='Принесите 12 ростков древесника.' WHERE `ID`=919 AND `locale`='ruRU';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
