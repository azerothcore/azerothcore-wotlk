-- DB update 2026_07_12_00 -> 2026_07_12_01
DELETE FROM `areatrigger_teleport` WHERE `ID` = 5206;
INSERT INTO `areatrigger_teleport` (`ID`, `Name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(5206, 'Gundrak (North Entrance)', 604, 1882.32, 631.027, 176.696, 3.1415927);

-- For below, Wrath Classic (51943) has the player arrive at 1880.74, 853.76, 176.696, 3.14159.
-- However, retail Wrath seems to put the player on the opposing side.
-- The above areatrigger_teleport position was also sniffed from Wrath Classic, so that is being used for the LFG teleport,
-- as it is on the correct side of the instance.

DELETE FROM `lfg_dungeon_template` WHERE `dungeonId` IN (216, 217);
INSERT INTO `lfg_dungeon_template` (`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`, `VerifiedBuild`) VALUES
(216, 'Gundrak', 1882.32, 631.027, 176.696, 3.1415927, 0), -- Normal
(217, 'Gundrak', 1882.32, 631.027, 176.696, 3.1415927, 0); -- Heroic
