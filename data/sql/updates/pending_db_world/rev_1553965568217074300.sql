INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553965568217074300');

DELETE FROM `creature_text` WHERE `CreatureID` = 15931 AND `GroupID` = 0;
DELETE FROM `creature_text` WHERE `CreatureID` = 16061 AND `GroupID` IN (1,2);
DELETE FROM `creature_text` WHERE `CreatureID` = 15954 AND `GroupID` = 8;
INSERT INTO `creature_text` VALUES 
(15931, 0, 0, '%s sprays slime across the room!', 16, 0, 100, 0, 0, 0, 32318, 1, 'Grobbulus - slime'),
(15954, 8, 0, '%s blinks away!', 41, 0, 100, 0, 0, 0, 32978, 3, 'Noth EMOTE_BLINK'),
(16061,1,0,'You should have stayed home.',14,0,50,0,0,8861,13081,3,'Razuvious SAY_SLAY #1'),
(16061,1,1,'You disappoint me, students!',14,0,50,0,0,8858,13077,3,'Razuvious SAY_SLAY #2'),
(16061,2,0,'I\'m just getting warmed up!',14,0,50,0,0,8852,13072,3,'Razuvious SAY_TAUNTED #1'),
(16061,2,1,'Stand and fight!',14,0,50,0,0,8853,13073,3,'Razuvious SAY_TAUNTED #2'),
(16061,2,2,'Sweep the leg... Do you have a problem with that?',14,0,50,0,0,8861,13080,3,'Razuvious SAY_TAUNTED #3'),
(16061,4,0,'%s lets loose a triumphant shout.',41,0,30,0,0,0,13082,3,'Razuvious SAY_SHOUT');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_tesla', `dynamicflags` = 0 WHERE `entry` = 16218;

-- trigger when entering thaddius' room
DELETE FROM `areatrigger_scripts` WHERE `entry`=4113;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(4113,"at_thaddius_entrance");
