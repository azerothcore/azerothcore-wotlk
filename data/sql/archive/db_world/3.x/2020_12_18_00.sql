-- DB update 2020_12_16_00 -> 2020_12_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_16_00 2020_12_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1607086882277070500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607086882277070500');

UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man ein Fischmahl zubereitet.' WHERE `ID`=43017 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man ein Megamammutmahl zubereitet.' WHERE `ID`=43018 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man ein zartes Schaufelhauersteak zubereitet.' WHERE `ID`=43019 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man sehr verbrannten Worg zubereitet.' WHERE `ID`=43021 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man eine große Rhinowurst zubereitet.' WHERE `ID`=43022 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man eine pochierte nordische Groppe zubereitet.' WHERE `ID`=43023 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man einen Feuerkracherlachs zubereitet.' WHERE `ID`=43024 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Lehrt Euch, wie man einen würzigen blauen Nesselfisch zubereitet.' WHERE `ID`=43025 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Tun wir mal so, als hättet Ihr ein komplettes Ulduar-10er-Set' WHERE `ID`=46103 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Tun wir mal so, als hättet Ihr ein komplettes Ulduar-25er-Set' WHERE `ID`=46104 AND `locale`='deDE';
UPDATE `item_template_locale` SET `Description`='Tun wir mal so, als hättet Ihr ein komplettes Ulduar-Hardmode-Set' WHERE `ID`=46105 AND `locale`='deDE';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
