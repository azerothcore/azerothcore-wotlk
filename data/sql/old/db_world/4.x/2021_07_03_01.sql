-- DB update 2021_07_03_00 -> 2021_07_03_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_03_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_03_00 2021_07_03_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624664527197257200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624664527197257200');

/* Wrong Names */
UPDATE `item_template_locale` SET `Name` = 'Lágrima de granate de sangre' WHERE `ID` = 23094 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Lágrima de espinela carmesí' WHERE `ID` = 32195 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Espinela carmesí rúnica' WHERE `ID` = 32196 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Espinela carmesí brillante' WHERE `ID` = 32197 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Espinela carmesí sutil' WHERE `ID` = 32198 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Lágrima de rubí vivo' WHERE `ID` = 24029 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Cristal de sol grueso perfecto' WHERE `ID` = 41449 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Jade oscuro hendido perfecto' WHERE `ID` = 41477 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Cristal de Sombras enjundioso' WHERE `ID` = 39933 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Cristal de Sombras enjundioso perfecto' WHERE `ID` = 41456 AND `locale` IN ('esES','esMX');

/* Wrong descriptions */
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o amarillo.' WHERE `ID` IN 
(23098,23101,30553,30556,30559,30564,30565,30573,30575,30601) AND `locale` IN ('esES','esMX');

UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo.' WHERE `ID` IN 
(28466,28468,33139,33141) AND `locale` IN ('esES','esMX');

UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o azul.' WHERE `ID` IN 
(30583,30586,30589,32735,32639,41479,41473,41463) AND `locale` IN ('esES','esMX');

UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o azul.' WHERE `ID` IN 
(30563) AND `locale` IN ('esES','esMX');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_03_01' WHERE sql_rev = '1624664527197257200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
