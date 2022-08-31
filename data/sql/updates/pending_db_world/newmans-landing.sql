DELETE FROM `npc_vendor` WHERE `entry` = 26081;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `VerifiedBuild`) VALUES
(26081, 2, 2880, 0, 0, 0, 0),
(26081, 0, 2901, 0, 0, 0, 0),
(26081, 3, 3466, 0, 0, 0, 0),
(26081, 5, 3857, 0, 0, 0, 0),
(26081, 1, 5956, 0, 0, 0, 0),
(26081, 4, 18567, 0, 0, 0, 0);

UPDATE `creature_equip_template` SET `ItemID1` = '26081' WHERE  `CreatureID` = 26081; -- ItemID needs to be reparsed once WPP is fixed
UPDATE `creature_equip_template` SET `VerifiedBuild` = '0' WHERE  `CreatureID` = 26081;

-- The coordinates below need to be reparsed once WPP is fixed
UPDATE `creature` SET `position_x` = -6378.96, `position_y` = 1263.02, `position_z` = 7.1876, `orientation` = 2.274 WHERE `guid` = 1975958;
UPDATE `creature` SET `position_x` = -6373.69, `position_y` = 1267.84, `position_z` = 7.1876, `orientation` = 2.18761 WHERE `guid` = 1975959;
UPDATE `creature` SET `position_x` = -6378.09, `position_y` = 1268.65, `position_z` = 7.1876, `orientation` = 2.26222 WHERE `guid` = 1975960;

