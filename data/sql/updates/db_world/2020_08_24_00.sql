-- DB update 2020_08_23_00 -> 2020_08_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_23_00 2020_08_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1595477734897952400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595477734897952400');

DELETE FROM `quest_offer_reward_locale` WHERE `locale` IN ('esES', 'esMX') AND `ID` IN (24499, 24511, 24506, 24510);

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24499, 'esES', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24499, 'esMX', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24511, 'esES', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24511, 'esMX', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24506, 'esES', 'Bien. $n, he oído hablar de ti. Eres perfecto para estas tareas.$B$BNos han brindado una rara oportunidad para entrar en la Ciudadela de la Corona de Hielo, pero debemos apresurarnos para evitar la atención de Arthas.', 18019),
(24506, 'esMX', 'Bien. $n, he oído hablar de ti. Eres perfecto para estas tareas.$B$BNos han brindado una rara oportunidad para entrar en la Ciudadela de la Corona de Hielo, pero debemos apresurarnos para evitar la atención de Arthas.', 18019),
(24510, 'esES', '¡%n! Cuánto me alegro de que hayas venido.$B$BSe nos ha concedido la insólita oportunidad de adentrarnos en la Ciudadela de la Corona de Hielo, pero debemos darnos prisa si queremos evitar la atención de Arthas.', 18019),
(24510, 'esMX', '¡%n! Cuánto me alegro de que hayas venido.$B$BSe nos ha concedido la insólita oportunidad de adentrarnos en la Ciudadela de la Corona de Hielo, pero debemos darnos prisa si queremos evitar la atención de Arthas.', 18019);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
