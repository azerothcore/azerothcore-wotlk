-- DB update 2019_06_26_00 -> 2019_06_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_06_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_06_26_00 2019_06_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1553965568217074300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553965568217074300');

DELETE FROM `creature_text` WHERE `CreatureID` = 15931 AND `GroupID` = 0;
DELETE FROM `creature_text` WHERE `CreatureID` = 16061 AND `GroupID` IN (0,1,2,4);
DELETE FROM `creature_text` WHERE `CreatureID` = 15953 AND `GroupID` IN (1,6);
DELETE FROM `creature_text` WHERE `CreatureID` = 15936 AND `GroupID` IN (2,6);
DELETE FROM `creature_text` WHERE `CreatureID` = 15954 AND `GroupID` = 8;
INSERT INTO `creature_text` VALUES 
-- Grobbulus
(15931, 0, 0, '%s sprays slime across the room!', 16, 0, 100, 0, 0, 0, 32318, 1, 'Grobbulus - slime'),
-- Noth
(15954, 8, 0, '%s blinks away!', 41, 0, 100, 0, 0, 0, 32978, 3, 'Noth EMOTE_BLINK'),
-- Razuvious
(16061,0,0,'Do as I taught you!',14,0,100,0,0,8855,13075,3,'Razuvious SAY_AGGRO #1'),
(16061,0,1,'The time for practice is over! Show me what you have learned!',14,0,100,0,0,8859,13078,3,'Razuvious SAY_AGGRO #2'),
(16061,0,2,'Show them no mercy!',14,0,100,0,0,8856,13076,3,'Razuvious SAY_AGGRO #3'),
(16061,0,3,'Sweep the leg... Do you have a problem with that?',14,0,50,0,0,8861,13080,3,'Razuvious SAY_AGGRO #3'),
(16061,1,0,'You should have stayed home.',14,0,50,0,0,8861,13081,3,'Razuvious SAY_SLAY #1'),
(16061,1,1,'You disappoint me, students!',14,0,50,0,0,8858,13077,3,'Razuvious SAY_SLAY #2'),
(16061,2,0,'Hah hah, I\'m just getting warmed up!',14,0,50,0,0,8852,13072,3,'Razuvious SAY_TAUNTED #1'),
(16061,2,1,'Stand and fight!',14,0,50,0,0,8853,13073,3,'Razuvious SAY_TAUNTED #2'),
(16061,2,2,'Show me what you\'ve got!',14,0,50,0,0,8854,13074,3,'Razuvious SAY_TAUNTED #3'),
(16061,4,0,'%s lets loose a triumphant shout.',41,0,30,0,0,0,13082,3,'Razuvious SAY_SHOUT'),
-- Faerlina
(15953,1,0,'Slay them in the master\'s name!',14,0,100,0,0,8794,12856,0,'faerlina SAY_AGGRO'),
(15953,6,0,'You cannot hide from me!',14,0,100,0,0,8795,12857,0,'faerlina SAY_ENRAGE1'),
(15953,6,1,'Kneel before me, worm!',14,0,100,0,0,8796,12858,0,'faerlina SAY_ENRAGE2'),
(15953,6,2,'Run while you still can!',14,0,100,0,0,8797,61582,0,'faerlina SAY_ENRAGE3'),
-- Heigan
(15936,2,0,'The races of the world will perish. It is only a matter of time.',14,0,100,0,0,8830,13046,0,'heigan SAY_TAUNT1'),
(15936,2,1,'I see endless suffering. I see torment. I see rage. I see everything...',14,0,100,0,0,8831,13047,0,'heigan SAY_TAUNT2'),
(15936,2,2,'Soon the world will tremble.',14,0,100,0,0,8832,13048,0,'heigan SAY_TAUNT3'),
(15936,2,3,'Hungry worms will feast on your rotting flesh.',14,0,100,0,0,8834,13050,0,'heigan SAY_TAUNT4'),
(15936,6,0,'The end is upon you.',14,0,100,0,0,8833,13049,0,'heigan SAY_DANCE');

UPDATE `creature_text` SET `BroadcastTextId` = 12984 WHERE `CreatureID` = 15990 AND `GroupID` = 16;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_tesla', `dynamicflags` = 0 WHERE `entry` = 16218;

-- trigger when entering thaddius' room
DELETE FROM `areatrigger_scripts` WHERE `entry`=4113;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(4113,"at_thaddius_entrance");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
