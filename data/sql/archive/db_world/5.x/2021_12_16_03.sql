-- DB update 2021_12_16_02 -> 2021_12_16_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_16_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_16_02 2021_12_16_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632675335691344600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632675335691344600');

-- add yells emperor
DELETE FROM `creature_text` WHERE `CreatureID` = 9019;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`COMMENT`) VALUES
(9019,0,0,'Come to aid the Throne!',14,0,100,0,0,0,0,0,'Aggro line council alive'),
(9019,1,0,'I will crush you into little tiny pieces!',14,0,100,0,0,0,5457,0,'Aggro line council dead'),
(9019,2,0,'Hail to the king, baby!',14,0,100,0,0,0,5431,0,'Killing player'),
(9019,3,0,'Your efforts are utterly pointless, fools!  You will never be able to defeat me!',14,0,100,0,0,0,5312,0,'Killing council 1'),
(9019,4,0,'They were just getting in the way anyways.',14,0,100,0,0,0,5313,0,'Killing council 2'),
(9019,5,0,'Ha! You can''t even begin to imagine the futility of your efforts.',14,0,100,0,0,0,5314,0,'Killing council 3'),
(9019,6,0,'Is that the best you can do?  Do you really expect that you could defeat someone as awe inspiring as me?',14,0,100,0,0,0,5315,0,'Killing council 4'),
(9019,7,0,'Thank you for clearing out those foolish senators.  Now prepare to meet your doom at the hands of Ragnaros'' most powerful servant.',14,0,100,0,0,0,5311,0,'Killing all council');

-- priestess yell 
UPDATE `creature_template` SET  `ScriptName` = 'boss_high_priestess_thaurissan' WHERE (`entry` = 10076);
DELETE FROM `creature_text` where `CreatureID` = 10076;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `BroadcastTextId`)
VALUES (10076, 0, 0, 'You will not harm Emperor Thaurissan!', 14, 0);

-- ironhand guardians, add cpp script, remove smartAI and smartscripts
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'brd_ironhand_guardian' WHERE (`entry` = 8982);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8982) AND (`source_type` = 0) AND (`id` IN (0, 1));

-- flamekeepers 
DELETE FROM `pool_template` WHERE `entry` = 1550;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) 
VALUES (1550, 2, 'BRD Lyceum shadowforge flame keepers');

DELETE FROM `pool_creature` WHERE `guid` IN (47302, 47303, 91119, 91120);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(47302, 1550, 0, 'BRD Lyceum shadowforge flame keepers'),
(47303, 1550, 0, 'BRD Lyceum shadowforge flame keepers'),
(91119, 1550, 0, 'BRD Lyceum shadowforge flame keepers'),
(91120, 1550, 0, 'BRD Lyceum shadowforge flame keepers');

-- moira and priestess are mages, not paladins.
UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` IN (8929, 10076);

-- scripts for bosses in arena
UPDATE `creature_template` SET `ScriptName` = 'boss_eviscerator' WHERE (`entry` = 9029);
UPDATE `creature_template` SET `ScriptName` = 'boss_okthor' WHERE (`entry` = 9030);
UPDATE `creature_template` SET `ScriptName` = 'boss_hedrum' WHERE (`entry` = 9032);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_16_03' WHERE sql_rev = '1632675335691344600';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
