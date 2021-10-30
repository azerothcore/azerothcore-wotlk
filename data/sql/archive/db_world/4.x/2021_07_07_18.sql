-- DB update 2021_07_07_17 -> 2021_07_07_18
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_17';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_17 2021_07_07_18 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625515191527869300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625515191527869300');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 178908;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 178908);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(178908, 1, 0, 0, 8, 0, 100, 0, 21885, 0, 0, 0, 0, 12, 13696, 4, 30000, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 'Vylestem Vine - On Spellhit \'Heal Vylestem Vine\' - Summon Creature \'Noxxious Scion\''),
(178908, 1, 1, 0, 8, 0, 100, 0, 21885, 0, 0, 0, 0, 12, 13696, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vylestem Vine - On Spellhit \'Heal Vylestem Vine\' - Summon Creature \'Noxxious Scion\''),
(178908, 1, 2, 0, 8, 0, 100, 0, 21885, 0, 0, 0, 0, 12, 13696, 4, 30000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vylestem Vine - On Spellhit \'Heal Vylestem Vine\' - Summon Creature \'Noxxious Scion\''),
(178908, 1, 3, 0, 8, 0, 100, 0, 21885, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Vylestem Vine - On Spellhit \'Heal Vylestem Vine\' - Set Lootstate Deactivated');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_18' WHERE sql_rev = '1625515191527869300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
