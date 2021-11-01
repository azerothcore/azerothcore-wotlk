-- DB update 2019_11_05_00 -> 2019_11_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_05_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_05_00 2019_11_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1567002995154862031'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567002995154862031');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (56698, 59102, 56702, 59103);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(56698, 'spell_gen_default_count_pct_from_max_hp'),
(59102, 'spell_gen_default_count_pct_from_max_hp'),
(56702, 'spell_shadow_sickle_periodic_damage'),
(59103, 'spell_shadow_sickle_periodic_damage');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
