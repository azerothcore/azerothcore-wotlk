INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1574370477422185700');

/* 
NPC Riggle Bassbait			 ID 15077 GUID 203521
NPC Fischbot 5000			 ID 15079 GUID 54688
NPC Jang					 ID 15078 GUID 54687
Gameobject					 ID 180403 GUID 164445
*/

/*Creating Gameobject*/
/*-------------------*/
DELETE FROM `gameobject` WHERE `guid` = '164445' AND `id`= '180403'; 
INSERT INTO `gameobject` VALUES 
('164445', '180403', '0', '0', '0', '1', '1', '-14438.509766', '474.10745', '15.301989', '3.695229','0', '0', '0', '0', '180', '100', '1', 'NULL', '0');

/*Insert Gobject*/
/*--------------*/
DELETE FROM `game_event_gameobject` WHERE eventEntry = '15' AND guid = '164445';
INSERT INTO `game_event_gameobject` VALUES ('15', '164445');

/*Updating Event NPC's Position*/
/*-----------------------------*/
UPDATE `creature` SET `position_x` = -14438.509766, `position_y` = 474.107452, `position_z` = 15.937873, `orientation` = 3.983454 WHERE `guid` = 203521;
UPDATE `creature` SET `position_x` = -14436.471680, `position_y` = 472.914825, `position_z` = 15.335059, `orientation` = 3.385898 WHERE `guid` = 54687;
UPDATE `creature` SET `position_x` = -14438.791992, `position_y` = 476.681549, `position_z` = 15.270824, `orientation` = 3.696133 WHERE `guid` = 54688;

/*Delete records if already exists*/
/*--------------------------------*/
DELETE FROM `game_event_creature` WHERE eventEntry = '15' AND guid = '203521';
DELETE FROM `game_event_creature` WHERE eventEntry = '15' AND guid = '54687';
DELETE FROM `game_event_creature` WHERE eventEntry = '15' AND guid = '54688';

/*Insert NPC's entrys*/
/*-------------------*/
INSERT INTO `game_event_creature` VALUES ('15', '203521');
INSERT INTO `game_event_creature` VALUES ('15', '54687');
INSERT INTO `game_event_creature` VALUES ('15', '54688');

