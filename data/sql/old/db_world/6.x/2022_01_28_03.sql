-- DB update 2022_01_28_02 -> 2022_01_28_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_28_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_28_02 2022_01_28_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642703572062384100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642703572062384100');

DELETE FROM `spell_group` WHERE `spell_id` IN (22730, 18191, 18192, 18193, 18194, 18222, 15852);
INSERT INTO `spell_group` (`id`, `spell_id`, `special_flag`) VALUES
(1001, 22730, 0), -- Runn Tum Tuber Surprise
(1001, 18191, 0), -- Ravager Egg Omelet, Cooked Glossy Mightfish, Mightfish Steak
(1001, 18192, 0), -- Grilled Squid
(1001, 18193, 0), -- Hot Smoked Bass
(1001, 18194, 0), -- Nightfin Soup
(1001, 18222, 0), -- Poached Sunscale Salmon
(1001, 15852, 0); -- Dragonbreath Chili

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_28_03' WHERE sql_rev = '1642703572062384100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
