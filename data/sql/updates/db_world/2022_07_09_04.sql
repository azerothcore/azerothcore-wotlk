-- DB update 2022_07_09_03 -> 2022_07_09_04
--
DELETE FROM `creature_text` WHERE `CreatureID`=14834 AND `groupid`=7;
INSERT INTO `creature_text` VALUES
(14834,7,0,'Fleeing will do you no good, mortals!',14,0,100,0,0,0,10635,0,'Hakkar Evade Yell');
