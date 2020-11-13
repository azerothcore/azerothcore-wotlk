-- DB update 2020_10_22_00 -> 2020_10_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_10_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_10_22_00 2020_10_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601240498542654700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601240498542654700');

/*
 * Update by Silker | <www.azerothcore.org> | Copyright (C)
*/

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18693;

-- Passive
DELETE FROM `creature_text` WHERE  `CreatureID`=18693 AND `GroupID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `id`, `text`, `type`, `language`, `Probability`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18693, 0, 0, 'Mog\'dorg is a fool to think that one of the smaller races will be our savior.', 12, 0, 16, 21025, 0, 'Speaker Mar\'grom - Say Speech 1'),
(18693, 0, 1, 'Do not listen to Mog\'dorg\'s lies! Ogri\'la is a myth! We make our own heaven here with the blood of any that would divide and subjugate us!', 12, 0, 16, 21029, 0, 'Speaker Mar\'grom - Say Speech 2'),
(18693, 0, 2, 'The time has come. Strike down every creature that stands in the way of the clans!', 12, 0, 16, 21028, 0, 'Speaker Mar\'grom - Say Speech 3'),
(18693, 0, 3, 'Will we never learn to work together? Or will we simply kill each other off and be forgotten in time.', 12, 0, 16, 19882, 0, 'Speaker Mar\'grom - Say Speech 4'),
(18693, 0, 4, 'Do not bow to Mog\'dorg\'s puppet! He would replace our gronn overlords with a liege of lesser stock. Why should we replace one master with another?', 12, 0, 16, 21027, 0, 'Speaker Mar\'grom - Say Speech 5'),
(18693, 0, 5, 'If only the leaders of the clans would listen. Unity is the only answer. All other paths lead to our destruction.', 12, 0, 16, 19883, 0, 'Speaker Mar\'grom - Say Speech 6');

-- Combat
DELETE FROM `creature_text` WHERE  `CreatureID`=18693 AND `GroupID`=1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `id`, `text`, `type`, `language`, `Probability`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18693, 1, 0, 'My message of unity is meant for the Ogre clans, not for you, $R!', 12, 0, 25, 19884, 0, 'Speaker Mar\'grom - Say aggro 1'),
(18693, 1, 1, 'I will not allow you to kill any more of my kind! Prepare to die!', 12, 0, 25, 19885, 0, 'Speaker Mar\'grom - Say aggro 2'),
(18693, 1, 2, 'I decree that you are an enemy of the Ogre clans. Punishment is death!', 12, 0, 25, 19886, 0, 'Speaker Mar\'grom - Say aggro 3'),
(18693, 1, 3, 'The Ogre clans will not be subjugated. Not by the gronn, and not by a puny $R like you!', 12, 0, 25, 21024, 0, 'Speaker Mar\'grom - Say aggro 4');

DELETE FROM `smart_scripts` WHERE  `entryorguid`=18693 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES	
-- Speech (Passive)
(18693, 0, 0, 0, 1, 0, 100, 0, 15000, 30000, 40000, 60000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - In Combat - Say Speech'),
-- Quotes (Combat)
(18693, 0, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - In Combat - Say Quote'),
-- Spells at combat per HP
(18693, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 11, 37844, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - On Aggro - Cast 37844'),
(18693, 0, 3, 0, 2, 0, 100, 0, 60, 99, 60, 99, 0, 11, 12466, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Between 60-99% Health - Cast 12466'),
(18693, 0, 4, 0, 2, 0, 100, 0, 19, 69, 19, 69, 0, 11, 15497, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Between 19-69% Health - Cast 15497'),
(18693, 0, 5, 0, 2, 0, 100, 0, 0, 19, 0, 19, 0, 11, 15241, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Between 0-19% Health - Cast 15241');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
