-- DB update 2022_06_27_00 -> 2022_06_27_01
--
DELETE FROM `areatrigger_scripts` WHERE `entry`=3956;
INSERT INTO `areatrigger_scripts` VALUES
(3956,'at_zulgurub_bridge_speech');

DELETE FROM `creature_text` WHERE `CreatureID`=14834 AND `GroupId`=4;
INSERT INTO `creature_text` VALUES
(14834,4,0,'Your callous disregard for the sovereign might of the Gurubashi Empire has been noted. The inhabitants of Zul\'Gurub have been alerted to your presence.',16,0,100,0,0,0,10550,3,'Hakkar SAY_PROTECT_GURUBASHI_EMPIRE');
