-- DB update 2022_07_09_06 -> 2022_07_09_07
--
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (3961,3962);
INSERT INTO `areatrigger_scripts` VALUES
(3961,'at_zulgurub_bloodfire_pit_speech'),
(3962,'at_zulgurub_edge_of_madness_speech');

DELETE FROM `creature_text` WHERE `CreatureID`=14834 AND `groupid` IN (5,6);
INSERT INTO `creature_text` VALUES
(14834,5,0,'Pledge your allegiance to Hakkar and the pain you suffer shall be minimal.',15,0,100,0,0,0,10593,0,'Hakkar Bloodfire Pit Whisper'),
(14834,6,0,'The world will suffer immeasurable cruelties under my reign.',15,0,100,0,0,0,10590,0,'Hakkar Edge Of Madness Whisper');
