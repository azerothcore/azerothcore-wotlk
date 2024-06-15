-- DB update 2022_12_06_13 -> 2022_12_06_14
--
DELETE FROM `creature_text` WHERE `CreatureID`=15264 AND `groupid`=1;
INSERT INTO `creature_text` VALUES
(15264,1,0,'%s shares his powers with his brethren.',16,0,100,0,0,0,11692,0,'Anubisath Sentinel Emote');
