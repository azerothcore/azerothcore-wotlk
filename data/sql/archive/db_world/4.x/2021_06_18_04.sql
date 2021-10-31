-- DB update 2021_06_18_03 -> 2021_06_18_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_18_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_18_03 2021_06_18_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1617975941808751069'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617975941808751069');

SET @ENTRY := 10901;
DELETE FROM `creature_template_spell` WHERE (`CreatureID` = @ENTRY);
INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(@ENTRY, 0, 8245, 12340),
(@ENTRY, 1, 18149, 12340),
(@ENTRY, 2, 18116, 12340);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ENTRY);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 7000, 15000, 40000, 40000, 0, 11, 18149, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - In Combat - Cast \'Volatile Infection\''),
(@ENTRY, 0, 1, 0, 0, 0, 100, 0, 3000, 12000, 17000, 28000, 0, 11, 8245, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - In Combat - Cast \'Corrosive Acid\''),
(@ENTRY, 0, 2, 0, 0, 0, 100, 0, 11000, 22000, 30000, 30000, 0, 11, 18151, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - In Combat - Cast \'Noxious Catalyst\''),
(@ENTRY, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 34, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lorekeeper Polkelt - On Just Died - Set Instance Data 1 to 1');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_18_04' WHERE sql_rev = '1617975941808751069';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
