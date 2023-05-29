-- DB update 2022_10_26_00 -> 2022_10_26_01
--
DELETE FROM `spell_proc_event` WHERE `entry` IN (64349,64350);
INSERT INTO `spell_proc_event` VALUES
(64349,0,0,0,0,0,0,0,0,0,0,60000),
(64350,0,0,0,0,0,0,0,0,0,0,60000);
