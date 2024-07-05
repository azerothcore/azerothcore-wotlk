-- DB update 2019_10_11_00 -> 2019_10_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_10_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_10_11_00 2019_10_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1569001965174107468'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1569001965174107468');

UPDATE `creature_template` SET `modelid1` = 29189 WHERE `entry` = 33810;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 33810;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(33810,0,0,1,54,0,100,0,0,0,0,0,0,3,0,28880,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sen''Jin Fetish - Just Summoned - Morph Model'),
(33810,0,1,2,61,0,100,0,0,0,0,0,0,11,52619,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sen''Jin Fetish - Linked - Cast Spell ''Enchanted Tiki Warrior: Enchanted Tiki Warrior Glow Visual'' (52619) on self'),
(33810,0,2,0,61,0,100,0,0,0,0,0,0,87,3381000,3381001,3381002,0,0,0,1,0,0,0,0,0,0,0,0,'Sen''Jin Fetish - Linked - Call Random Script');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
