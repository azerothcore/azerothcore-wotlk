-- DB update 2019_08_02_00 -> 2019_08_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_08_02_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_08_02_00 2019_08_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1563489887082454533'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1563489887082454533');

-- Equip a throwing knife for Instructor Razuvious to use with his ability "Jagged Knife"
UPDATE `creature_equip_template` SET `ItemID3` = 29010 WHERE `CreatureID` = 16061;

-- Ensure that the Drakkari Battle Riders can use their ability "Poisoned Spear" (otherwise they would constantly use "Throw")
UPDATE `smart_scripts` SET `action_param2` = 1 WHERE `entryorguid` = 29836 AND `source_type` = 0 AND `id` IN (2,3);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
