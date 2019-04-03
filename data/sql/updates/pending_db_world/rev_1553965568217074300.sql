INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1553965568217074300');

DELETE FROM `creature_text` WHERE `CreatureID` = 15931 AND `GroupID` = 0;
DELETE FROM `creature_text` WHERE `CreatureID` = 15954 AND `GroupID` = 8;
INSERT INTO `creature_text` VALUES 
(15931, 0, 0, '%s sprays slime across the room!', 16, 0, 100, 0, 0, 0, 32318, 1, 'Grobbulus - slime'),
(15954, 8, 0, '%s blinks away!', 41, 0, 100, 0, 0, 0, 32978, 3, 'Noth EMOTE_BLINK');

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_tesla', `dynamicflags` = 0 WHERE `entry` = 16218;

-- trigger when entering thaddius' room
DELETE FROM `areatrigger_scripts` WHERE `entry`=4113;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(4113,"at_thaddius_entrance");
