-- DB update 2018_08_26_00 -> 2018_09_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_08_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_08_26_00 2018_09_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1537701976962508800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1537701976962508800');
SET @ENTRY := 7726;
DELETE FROM smart_scripts WHERE entryOrGuid = 7726 AND source_type = 0;
UPDATE creature_template SET AIName="SmartAI" WHERE entry= @ENTRY;
INSERT INTO smart_scripts (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(@ENTRY, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Set event phase to 1"),
(@ENTRY, 0, 1, 0, 0, 1, 100, 0, 0, 0, 3400, 4700, 11, 9739, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Every 3.4 - 4.7 seconds (0 - 0s initially) [IC] - Self: Cast spell 9739 on Victim"),
(@ENTRY, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When health between 0 and 50 (check every 0 - 0 ms) - Self: Set event phase to 2"),
(@ENTRY, 0, 3, 0, 0, 2, 100, 1, 0, 0, 0, 0, 11, 19030, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Once [IC] - Self: Cast spell 19030 on Self"),
(@ENTRY, 0, 4, 0, 0, 2, 100, 0, 5000, 7000, 11000, 13000, 11, 12161, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Every 11 - 13 seconds (5 - 7s initially) [IC] - Self: Cast spell 12161 on Victim"),
(@ENTRY, 0, 5, 0, 0, 2, 100, 0, 8000, 10000, 24000, 28000, 11, 15727, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Every 24 - 28 seconds (8 - 10s initially) [IC] - Self: Cast spell 15727 on Self"),
(@ENTRY, 0, 6, 0, 0, 2, 100, 1, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Once [IC] - Self: Enable combat based movement"),
(@ENTRY, 0, 7, 0, 2, 0, 100, 1, 0, 15, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When health between 0 and 15 (check every 0 - 0 ms) - Self: Flee for assist"),
(@ENTRY, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 28, 19030, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On reset (e.g. after reaching home) - Self: Remove aura due to spell 19030"),
(@ENTRY, 0, 9, 0, 25, 0, 100, 0, 0, 0, 0, 0, 3, 7726, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On reset (e.g. after reaching home) - Self: Morph to model from creature Grimtotem Naturalist");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
