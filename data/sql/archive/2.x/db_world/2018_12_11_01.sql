-- DB update 2018_12_11_00 -> 2018_12_11_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_12_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_12_11_00 2018_12_11_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1544312897285686000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1544312897285686000');
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18399 AND `source_type` = 0 AND `id` > 3;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 18471 AND `source_type` = 0 AND `id` > 27;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Murkblood Twin - Store Variable Decimal
(18399, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 19, 18471, 200, 0, 0, 0, 0, 0, "Murkblood Twin - On Just Died - Set Counter"),
-- Gurgthock - Counter 2 = Quest Complete, Reset Counter, Self Data 11 11
(18471, 0, 28, 29, 77, 0, 100, 0, 1, 2, 0, 0, 26, 9967, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, "Gurgthock - On Counter Set 1 2 - Quest Credit 'The Ring of Blood: The Blue Brothers'"),
(18471, 0, 29, 30, 61, 0, 100, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Gurgthock - On Counter Set 1 2 (Link) - Reset Counter"),
(18471, 0, 30, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 11, 11, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Gurgthock - On Counter Set 1 2 (Link) - Set Data 11 11 (Self)");
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
