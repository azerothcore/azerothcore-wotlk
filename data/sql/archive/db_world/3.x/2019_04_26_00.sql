-- DB update 2019_04_22_00 -> 2019_04_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_22_00 2019_04_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555795494372087220'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555795494372087220');

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 26379;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(26379,0,0,1,19,0,100,0,12140,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Set Active on'),
(26379,0,1,2,61,0,100,0,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Set Npc Flags'),
(26379,0,2,3,61,0,100,0,0,0,0,0,0,91,255,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Remove Bytes 1'),
(26379,0,3,4,61,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Say Line 1'),
(26379,0,4,0,61,0,100,0,0,0,0,0,0,53,0,26379,0,0,0,0,7,0,0,0,0,0,0,0,0,'Overlord Agmar - On Quest Accept (All Hail Roanauk!) - Start WP'),
(26379,0,5,0,40,0,100,0,10,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On reached WP10 - Create Timed Event ID 1'),
(26379,0,6,7,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Overlord Agmar - On Timed Event ID 1 - Set Orientation'),
(26379,0,7,0,61,0,100,0,0,0,0,0,0,67,2,180000,180000,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - Linked - Create Timed Event ID 2'),
(26379,0,8,9,38,0,100,0,1,1,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Data Set - Set Home Pos (Respawn)'),
(26379,0,9,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Data Set - Evade'),
(26379,0,10,11,59,0,100,0,2,0,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Timed Event ID 2 - Set Home Pos (Respawn)'),
(26379,0,11,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - Linked - Evade'),
(26379,0,12,13,21,0,100,0,0,0,0,0,0,81,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Reached Home - Set Unit Flags'),
(26379,0,13,0,61,0,100,0,0,0,0,0,0,48,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Overlord Agmar - On Reached Home - Set Active off');

DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 2681000;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2681000,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 1'),
(2681000,9,1,0,0,0,100,0,10000,10000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 2'),
(2681000,9,2,0,0,0,100,0,2000,2000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 3'),
(2681000,9,3,0,0,0,100,0,8000,8000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 4'),
(2681000,9,4,0,0,0,100,0,8000,8000,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 5'),
(2681000,9,5,0,0,0,100,0,1000,1000,0,0,0,1,1,0,0,0,0,0,19,26379,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 1 on Overlord Agmar'),
(2681000,9,6,0,0,0,100,0,4000,4000,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Play emote OneShotRoar'),
(2681000,9,7,0,0,0,100,0,4000,4000,0,0,0,33,26810,0,0,0,0,0,12,1,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Give Kill Credit'),
(2681000,9,8,0,0,0,100,0,0,0,0,0,0,5,388,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Play emote OneShotStomp'),
(2681000,9,9,0,0,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,9,26437,0,200,0,0,0,0,0,'Roanauk Icemist - Script - Set Data Taunka Soldier'),
(2681000,9,10,0,0,0,100,0,0,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 6'),
(2681000,9,11,0,0,0,100,0,7000,7000,0,0,0,1,2,0,0,0,0,0,19,26379,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 2 on Overlord Agmar'),
(2681000,9,12,0,0,0,100,0,5000,5000,0,0,0,1,0,0,0,0,0,0,19,26437,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Say Line 0 on Taunka Soldier'),
(2681000,9,13,0,0,0,100,0,5000,5000,0,0,0,45,3,3,0,0,0,0,9,26437,0,200,0,0,0,0,0,'Roanauk Icemist - Script - Set Data Taunka Soldier'),
(2681000,9,14,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,19,26379,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Set Data Overlord Agmar'),
(2681000,9,15,0,0,0,100,0,0,0,0,0,0,81,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roanauk Icemist - Script - Set NPC Flags');

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (-102326,-102327,-102328,-102329,-102330,-102333,-102341);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(-102326,0,0,1,38,0,100,0,1,1,0,0,0,91,65537,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Bytes 1'),
(-102326,0,1,0,61,0,100,0,0,0,0,0,0,53,0,2643704,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Start WP'),
(-102326,0,2,3,38,0,100,0,2,2,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Remove ''UNIT_STAND_STATE_KNEEL'''),
(-102326,0,3,0,61,0,100,0,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Play emote Cheer'),
(-102326,0,4,5,38,0,100,0,3,3,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Home Pos (Respawn)'),
(-102326,0,5,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Evade'),
(-102326,0,6,0,40,0,100,0,1,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On reached WP1 - Create Timed Event ID 1'),
(-102326,0,7,8,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Taunka Soldier - On Timed Event ID 1 - Set Orientation'),
(-102326,0,8,0,61,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Set ''UNIT_STAND_STATE_KNEEL'''),

(-102327,0,0,1,38,0,100,0,1,1,0,0,0,91,65536,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Bytes 1'),
(-102327,0,1,2,61,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Emote State 0'),
(-102327,0,2,0,61,0,100,0,0,0,0,0,0,53,0,2643706,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Start WP'),
(-102327,0,3,4,38,0,100,0,2,2,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Remove ''UNIT_STAND_STATE_KNEEL'''),
(-102327,0,4,0,61,0,100,0,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Play emote Cheer'),
(-102327,0,5,6,38,0,100,0,3,3,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Home Pos (Respawn)'),
(-102327,0,6,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Evade'),
(-102327,0,7,0,40,0,100,0,1,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On reached WP1 - Create Timed Event ID 1'),
(-102327,0,8,9,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Taunka Soldier - On Timed Event ID 1 - Set Orientation'),
(-102327,0,9,0,61,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Set ''UNIT_STAND_STATE_KNEEL'''),

(-102328,0,0,1,38,0,100,0,1,1,0,0,0,91,65536,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Bytes 1'),
(-102328,0,1,0,61,0,100,0,0,0,0,0,0,53,0,2643703,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Start WP'),
(-102328,0,2,3,38,0,100,0,2,2,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Remove ''UNIT_STAND_STATE_KNEEL'''),
(-102328,0,3,0,61,0,100,0,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Play emote Cheer'),
(-102328,0,4,5,38,0,100,0,3,3,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Home Pos (Respawn)'),
(-102328,0,5,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Evade'),
(-102328,0,6,0,40,0,100,0,1,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On reached WP1 - Create Timed Event ID 1'),
(-102328,0,7,8,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Taunka Soldier - On Timed Event ID 1 - Set Orientation'),
(-102328,0,8,0,61,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Set ''UNIT_STAND_STATE_KNEEL'''),

(-102329,0,0,1,38,0,100,0,1,1,0,0,0,91,65539,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Bytes 1'),
(-102329,0,1,0,61,0,100,0,0,0,0,0,0,53,0,2643700,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Start WP'),
(-102329,0,2,3,38,0,100,0,2,2,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Remove ''UNIT_STAND_STATE_KNEEL'''),
(-102329,0,3,0,61,0,100,0,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Play emote Cheer'),
(-102329,0,4,5,38,0,100,0,3,3,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Home Pos (Respawn)'),
(-102329,0,5,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Evade'),
(-102329,0,6,0,40,0,100,0,1,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On reached WP1 - Create Timed Event ID 1'),
(-102329,0,7,8,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Taunka Soldier - On Timed Event ID 1 - Set Orientation'),
(-102329,0,8,0,61,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Set ''UNIT_STAND_STATE_KNEEL'''),

(-102330,0,0,1,38,0,100,0,1,1,0,0,0,91,65536,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Bytes 1'),
(-102330,0,1,0,61,0,100,0,0,0,0,0,0,53,0,2643702,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Start WP'),
(-102330,0,2,3,38,0,100,0,2,2,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Remove ''UNIT_STAND_STATE_KNEEL'''),
(-102330,0,3,0,61,0,100,0,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Play emote Cheer'),
(-102330,0,4,5,38,0,100,0,3,3,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Home Pos (Respawn)'),
(-102330,0,5,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Evade'),
(-102330,0,6,0,40,0,100,0,1,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On reached WP1 - Create Timed Event ID 1'),
(-102330,0,7,8,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Taunka Soldier - On Timed Event ID 1 - Set Orientation'),
(-102330,0,8,0,61,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Set ''UNIT_STAND_STATE_KNEEL'''),

(-102333,0,0,1,38,0,100,0,1,1,0,0,0,91,65537,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Bytes 1'),
(-102333,0,1,0,61,0,100,0,0,0,0,0,0,53,0,2643705,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Start WP'),
(-102333,0,2,3,38,0,100,0,2,2,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Remove ''UNIT_STAND_STATE_KNEEL'''),
(-102333,0,3,0,61,0,100,0,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Play emote Cheer'),
(-102333,0,4,5,38,0,100,0,3,3,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Home Pos (Respawn)'),
(-102333,0,5,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Evade'),
(-102333,0,6,0,40,0,100,0,1,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On reached WP1 - Create Timed Event ID 1'),
(-102333,0,7,8,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Taunka Soldier - On Timed Event ID 1 - Set Orientation'),
(-102333,0,8,0,61,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Set ''UNIT_STAND_STATE_KNEEL'''),

(-102341,0,0,1,38,0,100,0,1,1,0,0,0,91,65539,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Bytes 1'),
(-102341,0,1,0,61,0,100,0,0,0,0,0,0,53,0,2643701,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Start WP'),
(-102341,0,2,3,38,0,100,0,2,2,0,0,0,91,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Remove ''UNIT_STAND_STATE_KNEEL'''),
(-102341,0,3,0,61,0,100,0,0,0,0,0,0,5,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Play emote Cheer'),
(-102341,0,4,5,38,0,100,0,3,3,0,0,0,101,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On Data Set - Set Home Pos (Respawn)'),
(-102341,0,5,0,61,0,100,0,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Evade'),
(-102341,0,6,0,40,0,100,0,1,0,0,0,0,67,1,2000,2000,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - On reached WP1 - Create Timed Event ID 1'),
(-102341,0,7,8,59,0,100,0,1,0,0,0,0,66,0,0,0,0,0,0,19,26810,0,0,0,0,0,0,0,'Taunka Soldier - On Timed Event ID 1 - Set Orientation'),
(-102341,0,8,0,61,0,100,0,0,0,0,0,0,90,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Taunka Soldier - Linked - Set ''UNIT_STAND_STATE_KNEEL''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
