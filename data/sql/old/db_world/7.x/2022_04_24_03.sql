-- DB update 2022_04_24_02 -> 2022_04_24_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_24_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_24_02 2022_04_24_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1649654147658907782'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649654147658907782');

UPDATE `item_template_locale` SET `Name`='Fórmula: encantar capa: tejido de titán',`Description`='Te enseña a encantar de forma permanente una capa para aumentar el índice de defensa 16 p. Requiere un objeto de nivel 60 o superior.' WHERE `ID`=37347 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description`='Te enseña a encantar de forma permanente una capa para que aumente el sigilo ligeramente y la agilidad 10 p. Requiere un objeto de nivel 60 o superior.' WHERE `ID`=37349 AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description`="Vous apprend à enchanter de manière permanente une cape pour augmenter légèrement le camouflage et ajoute 10 à l'Agilité. Nécessite un objet de niveau 60 ou supérieur." WHERE `ID`=37349 AND `locale`='frFR';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_24_03' WHERE sql_rev = '1649654147658907782';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
