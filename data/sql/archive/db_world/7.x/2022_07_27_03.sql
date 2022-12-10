-- DB update 2022_07_27_02 -> 2022_07_27_03
--
DELETE FROM `spell_bonus_data` WHERE `entry`=22009;
INSERT INTO `spell_bonus_data` VALUES
(22009,0,0.2,0,0,'Priest - Greater Heal - 8P T2');
