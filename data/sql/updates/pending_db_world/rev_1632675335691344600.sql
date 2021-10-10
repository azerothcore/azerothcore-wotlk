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
VALUES (10076, 0, 0, "You will not harm Emperor Thaurissan!", 14, 0);


-- ironhand guardians, add cpp script, remove smartAI and smartscripts
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'brd_ironhand_guardian' WHERE (`entry` = 8982);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8982) AND (`source_type` = 0) AND (`id` IN (0, 1));

-- magmus
DELETE FROM `creature_text` WHERE `CreatureID` = 9938;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `BroadcastTextId`)
VALUES (9938, 0, 0, "Emperor Thaurissan does not wish to be disturbed! Turn back now or face your doom, weak mortals!", 14, 5430);

-- flamekeepers 
DELETE FROM `pool_template` WHERE `entry` = 1550;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) 
VALUES (1550, 2, "BRD Lyceum shadowforge flame keepers");

DELETE FROM `pool_creature` WHERE `guid` IN (47302, 47303, 91119, 91120);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(47302, 1550, 0, "BRD Lyceum shadowforge flame keepers"),
(47303, 1550, 0, "BRD Lyceum shadowforge flame keepers"),
(91119, 1550, 0, "BRD Lyceum shadowforge flame keepers"),
(91120, 1550, 0, "BRD Lyceum shadowforge flame keepers");

-- moira and priestess are mages, not paladins.
UPDATE `creature_template` SET `unit_class` = 8 WHERE `entry` IN (8929, 10076);
