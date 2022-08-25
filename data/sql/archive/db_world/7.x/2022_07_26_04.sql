-- DB update 2022_07_26_03 -> 2022_07_26_04
--

UPDATE `creature_template` SET `mingold`=0, `maxgold`=0 WHERE `entry`=15546;
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry`=15369;
DELETE FROM `creature_addon` WHERE `guid`=144641;
INSERT INTO `creature_addon` (`guid`, `auras`) VALUES 
(144641, '8876'); -- Triggers SPELL_THRASH = 3391

