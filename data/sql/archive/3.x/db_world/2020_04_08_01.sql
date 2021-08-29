-- DB update 2020_04_08_00 -> 2020_04_08_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_04_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_04_08_00 2020_04_08_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1583079134916792500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583079134916792500');

-- One space too much: 'Greetings. ' instead of 'Greetings.  ' - No locales texts available!
UPDATE `quest_request_items` SET `CompletionText`='Greetings. And welcome to the Harborage.' WHERE `ID`=1392;

-- Text error grammar: 'hölzernen' instead of 'hölzernes' & wrong location: 'Badlands' instead of 'Searing Gorge'- Text in quest_template is already correct! 
UPDATE `quest_template_locale` SET `CompletedText`='Kehrt zum hölzernen Plumpsklo in der sengenden Schlucht zurück.' WHERE `ID`=4449 AND `locale`='deDE';

-- Quest obejctives lead to Hellscream's Vigil which was added in Cataclysm. - Text in quest_template is already correct, cannot proof the correctness of other locales!
-- https://wow.gamepedia.com/Mitsuwa
UPDATE `quest_template_locale` SET `Objectives`='Bringt Mitsuwa beim Außenposten von Zoram''gar 8 Trollglücksbringer.' WHERE `ID`=6462 AND `locale`='deDE';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
