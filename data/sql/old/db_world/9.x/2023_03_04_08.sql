-- DB update 2023_03_04_07 -> 2023_03_04_08
--
DELETE FROM `spell_proc_event` WHERE `entry`=-31641;
INSERT INTO `spell_proc_event` VALUES
(-31641,0,0,0,0,0,0x000002A8,0x0000403,2,0,0,0);
