-- DB update 2021_12_21_00 -> 2021_12_21_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_21_00 2021_12_21_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639551676154983666'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639551676154983666');

DELETE FROM `spell_script_names` WHERE `ScriptName` IN
('spell_four_horsemen_consumption',
 'spell_rajaxx_thundercrash',
 'spell_gen_arcane_charge',
 'spell_pet_dk_gargoyle_strike');

INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(28865, 'spell_four_horsemen_consumption'),
(25599, 'spell_rajaxx_thundercrash'),
(45072, 'spell_gen_arcane_charge'),
(51963, 'spell_pet_dk_gargoyle_strike');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_21_01' WHERE sql_rev = '1639551676154983666';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
