-- DB update 2019_04_16_00 -> 2019_04_18_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_04_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_04_16_00 2019_04_18_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1555051312474328059'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555051312474328059');

-- reduce the spawn time of the Horde / Alliance defenders
UPDATE `creature` SET `spawntimesecs` = 1 WHERE `id` IN (18972,18970,18950,18986,18948,18965,18949,18971);

-- increase the random time interval when the defenders leave their portal, so they won't run all at once when spawning the first time
UPDATE `smart_scripts` SET `action_param3` = 6500 WHERE `source_type` = 0 AND `id` = 0 AND `entryorguid` IN (18972,18970,18950,18986,18948,18965);

-- stop combat right before starting wapoint movement in order to prevent error messages in the log
DELETE FROM `smart_scripts` WHERE `id` IN (2,12) AND `source_type` = 0 AND `entryorguid` IN (18972,18970,18950,18986,18948,18965);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(18972,0,2,12,59,0,100,0,1,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Timed Event - Stop Combat'),
(18970,0,2,12,59,0,100,0,1,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Timed Event - Stop Combat'),
(18950,0,2,12,59,0,100,0,1,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Timed Event - Stop Combat'),
(18986,0,2,12,59,0,100,0,1,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Timed Event - Stop Combat'),
(18948,0,2,12,59,0,100,0,1,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Timed Event - Stop Combat'),
(18965,0,2,12,59,0,100,0,1,0,0,0,0,27,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Timed Event - Stop Combat'),
(18972,0,12,0,61,0,100,0,0,0,0,0,0,53,1,18970,0,0,0,2,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - Linked - Start WP'),
(18970,0,12,0,61,0,100,0,0,0,0,0,0,53,1,18970,0,0,0,2,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - Linked - Start WP'),
(18950,0,12,0,61,0,100,0,0,0,0,0,0,53,1,18970,0,0,0,2,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - Linked - Start WP'),
(18986,0,12,0,61,0,100,0,0,0,0,0,0,53,1,18965,0,0,0,2,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - Linked - Start WP'),
(18948,0,12,0,61,0,100,0,0,0,0,0,0,53,1,18965,0,0,0,2,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - Linked - Start WP'),
(18965,0,12,0,61,0,100,0,0,0,0,0,0,53,1,18965,0,0,0,2,1,0,0,0,0,0,0,0,0,'Darnassian Archer - Linked - Start WP');

-- use one of the hidden creatures "Infernal Relay (Hellfire)" to spawn an initial wave of daemons, so the battle can begin at once when the player enters the area
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19215;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = -68744;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
VALUES
(-68744,0,0,1,63,0,100,1,0,0,0,0,0,12,19005,3,600000,0,0,0,8,0,0,0,0,-263.628,1102.61,41.6675,4.93514,'Infernal Relay (Hellfire) - On Just Created - Summon Wrath Master (19005)'),
(-68744,0,1,2,61,0,100,0,0,0,0,0,0,12,19005,3,600000,0,0,0,8,0,0,0,0,-239.837,1103.57,41.6671,4.47176,'Infernal Relay (Hellfire) - Linked - Summon Wrath Master (19005)'),
(-68744,0,2,3,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-246.118,1104.64,41.6671,4.72309,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,3,4,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-254.605,1105.03,41.6671,4.74272,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,4,5,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-270.904,1101.37,41.7302,5.25715,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,5,6,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-230.616,1102.52,41.6672,4.24008,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,6,7,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-256.508,1108.92,41.6667,4.7019,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,7,8,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-242.871,1108.85,41.6667,4.69012,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,8,9,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-271.232,1105.23,41.6668,5.0713,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)'),
(-68744,0,9,0,61,0,100,0,0,0,0,0,0,12,18944,3,600000,0,0,0,8,0,0,0,0,-231.023,1106.31,41.6668,4.43121,'Infernal Relay (Hellfire) - Linked - Summon Fel Soldier (18944)');


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
