-- DB update 2020_12_13_04 -> 2020_12_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_13_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_13_04 2020_12_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606594157029530500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606594157029530500');

-- (Algalon the Observer): 'Phase Punch' applied as debuff
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 64412;

-- (High King Maulgar): 'Death Coil' applied as debuff
DELETE FROM `spell_custom_attr` WHERE  `spell_id`=33130;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES 
(33130,12288);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
