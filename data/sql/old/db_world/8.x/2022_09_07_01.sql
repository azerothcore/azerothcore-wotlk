-- DB update 2022_09_07_00 -> 2022_09_07_01
DELETE FROM `npc_vendor` WHERE `entry` = 26081;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(26081, 2, 2880, 0, 0, 0, 0),
(26081, 0, 2901, 0, 0, 0, 0),
(26081, 3, 3466, 0, 0, 0, 0),
(26081, 5, 3857, 0, 0, 0, 0),
(26081, 1, 5956, 0, 0, 0, 0),
(26081, 4, 18567, 0, 0, 0, 0);

UPDATE `creature_equip_template` SET `ItemID1` = 19022 WHERE  `CreatureID` = 26081;

UPDATE `creature` SET `position_x` = -6378.61, `position_y` = 1263.21, `position_z` = 7.2709, `orientation` = 3.03687 WHERE `guid` = 1975958;
UPDATE `creature` SET `position_x` = -6373.53, `position_y` = 1267.88, `position_z` = 7.2709, `orientation` = 2.39110 WHERE `guid` = 1975959;
UPDATE `creature` SET `position_x` = -6378.08, `position_y` = 1268.47, `position_z` = 7.2709, `orientation` = 2.44346 WHERE `guid` = 1975960;
