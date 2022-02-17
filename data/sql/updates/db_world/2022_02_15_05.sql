-- DB update 2022_02_15_04 -> 2022_02_15_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_15_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_15_04 2022_02_15_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644959483034654993'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644959483034654993');

-- back up of original line
-- DELETE FROM `smart_scripts` WHERE `entryorguid`=17664 AND `source_type`=0 AND `id`=23 AND `link`=13;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (17664, 0, 23, 13, 61, 1, 100, 1, 22, 51, 0, 0, 0, 11, 31336, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Matis the Cruel - Between 22-51% Health - Cast \'Matis Captured DND\' (Phase 1) (No Repeat)');

UPDATE `smart_scripts` SET `event_param1`=0, `event_param2`=0 WHERE  `entryorguid`=17664 AND `source_type`=0 AND `id`=23 AND `link`=13;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=18985 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (18985, 0, 1, 0, 61, 0, 100, 0, 7859, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Seer Skaltesh - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=18985 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=37887 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (37887, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=37887 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=38039 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (38039, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=38039 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=38040 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (38040, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=38040 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=38041 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (38041, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=38041 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=18985 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (18985, 0, 1, 0, 61, 0, 100, 0, 7859, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Seer Skaltesh - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=18985 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=38042 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (38042, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=38042 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=38043 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (38043, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=38043 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=38044 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (38044, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=38044 AND `source_type`=0 AND `id`=1 AND `link`=0;

-- DELETE FROM `smart_scripts` WHERE `entryorguid`=38045 AND `source_type`=0 AND `id`=1 AND `link`=0;
-- INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (38045, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

UPDATE `smart_scripts` SET `event_param1`=0 WHERE  `entryorguid`=38045 AND `source_type`=0 AND `id`=1 AND `link`=0;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_15_05' WHERE sql_rev = '1644959483034654993';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
