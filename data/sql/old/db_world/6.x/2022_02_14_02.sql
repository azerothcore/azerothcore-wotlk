-- DB update 2022_02_14_01 -> 2022_02_14_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_14_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_14_01 2022_02_14_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1644517852933459100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644517852933459100');

/* Add missing gossip menu to two instances of Kwee Q. Peddlefeet */
UPDATE `creature_template` SET `gossip_menu_id` = 10948, `npcflag` = `npcflag`|1 WHERE `entry` IN (38044, 38045);


/* Assign SmartAI to all instances of Kwee Q. Peddlefeet */
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (37887, 38039, 38040, 38041, 38042, 38043, 38044, 38045);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (37887, 38039, 38040, 38041, 38042, 38043, 38044, 38045) AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(38045, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(38045, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip'),
(38044, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(38044, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip'),
(38043, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(38043, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip'),
(38042, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(38042, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip'),
(38041, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(38041, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip'),
(38040, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(38040, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip'),
(38039, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(38039, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip'),
(37887, 0, 0, 1, 62, 0, 100, 0, 10948, 0, 0, 0, 11, 70648, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Cast Create Lovely Charm Collectors Kit'),
(37887, 0, 1, 0, 61, 0, 100, 0, 10948, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Kwee Q. Peddlefeet - On Gossip Option Select - Close Gossip');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_14_02' WHERE sql_rev = '1644517852933459100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
