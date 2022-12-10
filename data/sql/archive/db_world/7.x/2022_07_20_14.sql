-- DB update 2022_07_20_13 -> 2022_07_20_14
--
DELETE FROM `creature_addon` WHERE `guid`=144632;
INSERT INTO `creature_addon` (`guid`, `auras`) VALUES 
(144632, '8876'); -- Triggers SPELL_THRASH = 3391

