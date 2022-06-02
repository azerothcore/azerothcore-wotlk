-- DB update 2019_12_30_00 -> 2019_12_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_12_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_12_30_00 2019_12_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1576973316431604917'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1576973316431604917');

-- Kanati Greycloud: Correct orientation; delete waypoints (not necessary anymore)
UPDATE `creature` SET `orientation` = 5.448936 WHERE `id` = 10638;
DELETE FROM `script_waypoint` WHERE `entry` = 10638;

-- Kanati Greycloud / Galak Assassin SAI
UPDATE `creature_template` SET `AIName` = 'SmartAI', ScriptName = '' WHERE `entry` IN (10638,10720);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (10638,10720) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1063800) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(10638,0,0,0,19,0,100,0,4966,0,0,0,0,80,1063800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Quest Accepted - Call Action List'),
(10638,0,1,2,77,0,100,0,1,3,5000,5000,0,15,4966,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kanati Greycloud - On Counter - Quest Completed ''Protect Kanati Greycloud'''),
(10638,0,2,0,61,0,100,0,0,0,0,0,0,78,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - Linked - Reset'),
(10638,0,3,4,25,0,100,0,0,0,0,0,0,18,512,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Reset - Set Unit Flag ''UNIT_FLAG_IMMUNE_TO_NPC'''),
(10638,0,4,5,61,0,100,0,0,0,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - Linked - Set NPC Flag ''Quest Giver'''),
(10638,0,5,6,61,0,100,0,0,0,0,0,0,63,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - Linked - Reset Counter'),
(10638,0,6,0,61,0,100,0,0,0,0,0,0,2,104,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - Linked - Set Faction ''Thunder Bluff'''),
(10638,0,7,0,6,0,100,0,0,0,0,0,0,6,4966,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Kanati Greycloud - On Death - Fail Quest ''Protect Kanati Greycloud'''),

(1063800,9,0,0,0,0,100,0,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Script - Remove NPC Flag ''Quest Giver'''),
(1063800,9,1,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Script - Set Run Off'),
(1063800,9,2,0,0,0,100,0,0,0,0,0,0,19,512,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Script - Remove Unit Flag ''UNIT_FLAG_IMMUNE_TO_NPC'''),
(1063800,9,3,0,0,0,100,0,0,0,0,0,0,2,250,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Script - Set Faction ''Escortee'''),
(1063800,9,4,0,0,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,16,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Script - Store target'),
(1063800,9,5,0,0,0,100,0,2000,2000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,-4901.48,-1372.65,-52.6119,5.46307,'Kanati Greycloud - On Script - Move To Position'),
(1063800,9,6,0,0,0,100,0,3000,3000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kanati Greycloud - On Script - Say Line 0'),
(1063800,9,7,0,0,0,100,0,3000,3000,0,0,0,12,10720,8,0,0,0,0,8,0,0,0,0,-4878.45,-1396.49,-53.3029,2.37567,'Kanati Greycloud - On Script - Summon ''Galak Assassin'''),
(1063800,9,8,0,0,0,100,0,0,0,0,0,0,12,10720,8,0,0,0,0,8,0,0,0,0,-4873.76,-1397.93,-53.4669,2.37567,'Kanati Greycloud - On Script - Summon ''Galak Assassin'''),
(1063800,9,9,0,0,0,100,0,0,0,0,0,0,12,10720,8,0,0,0,0,8,0,0,0,0,-4876.83,-1401.12,-53.2158,2.37567,'Kanati Greycloud - On Script - Summon ''Galak Assassin'''),
(1063800,9,10,0,0,0,100,0,2000,2000,0,0,0,49,0,0,0,0,0,0,19,10720,100,0,0,0,0,0,0,'Kanati Greycloud - On Script - Start Attack ''Galak Assassin'''),

(10720,0,0,0,54,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,19,10638,100,0,0,0,0,0,0,'Galak Assassin - Just Summoned - Start Attack ''Kanati Greycloud'''),
(10720,0,1,0,0,0,100,0,2000,7000,8000,12000,0,11,6533,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Galak Assassin - IC - Cast Net'),
(10720,0,2,0,7,0,100,0,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Galak Assassin - On Evade - Despawn'),
(10720,0,3,0,6,0,100,0,0,0,0,0,0,63,1,1,0,0,0,0,19,10638,100,0,0,0,0,0,0,'Galak Assassin - On Death - Set Counter');

-- Galak Assassin: Add aura "Poison Proc"
DELETE FROM `creature_template_addon` WHERE `entry` = 10720;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`)
VALUES
(10720,0,0,0,1,0,0,'3616');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
