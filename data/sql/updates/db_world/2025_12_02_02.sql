-- DB update 2025_12_02_01 -> 2025_12_02_02
-- Makes all Everfrost Chips spawns 45 minutes (before 30 and 1 hour).
UPDATE `gameobject` SET `spawntimesecs` = 2700 WHERE `id` = 193997;

DELETE FROM `pool_template` WHERE `entry` IN (150, 151, 152);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(150, 8, "Everfrost Chip - Valley of Ancient Winters"), -- Total 30 / 4 = 7.5 rounded to 8
(151, 4, "Everfrost Chip - Frostfield Lake"), -- Total 16 / 4 = 4
(152, 2, "Everfrost Chip - Dun Niffelem"); -- Total 08 / 4 = 2

DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (150, 151, 152) AND `guid` IN (221000, 221002, 1161, 1162, 1163, 1164, 1165, 1166, 1167, 1168, 1169, 1170, 3721, 3722, 3723, 3724, 3725, 3726, 3727, 3728, 3729, 3730, 3731, 3732, 3733, 3734, 3735, 3736, 3737, 3738, 3739, 3740, 3741, 3742, 3743, 3744, 3745, 3746, 3747, 3748, 3749, 3750, 3751, 3752, 3753, 3754, 3755, 3756, 3757, 3758, 3759, 3760, 3761, 221001);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(3728, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3751, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3761, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3721, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3734, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3755, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3724, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(1170, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3732, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3723, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3729, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3746, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3752, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(1161, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3722, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3756, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3731, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(1162, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(1163, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3737, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3730, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3726, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3727, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(1169, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3736, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(221002, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3749, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(221000, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3743, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3725, 150, 0, "Everfrost Chip - Valley of Ancient Winters"),
(3759, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3733, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3753, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3758, 151, 0, "Everfrost Chip - Frostfield Lake"),
(221001, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3735, 151, 0, "Everfrost Chip - Frostfield Lake"),
(1168, 151, 0, "Everfrost Chip - Frostfield Lake"),
(1167, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3760, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3745, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3741, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3744, 151, 0, "Everfrost Chip - Frostfield Lake"),
(1166, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3739, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3757, 151, 0, "Everfrost Chip - Frostfield Lake"),
(3748, 152, 0, "Everfrost Chip - Dun Niffelem"),
(3740, 152, 0, "Everfrost Chip - Dun Niffelem"),
(3738, 152, 0, "Everfrost Chip - Dun Niffelem"),
(3750, 152, 0, "Everfrost Chip - Dun Niffelem"),
(1164, 152, 0, "Everfrost Chip - Dun Niffelem"),
(3747, 152, 0, "Everfrost Chip - Dun Niffelem"),
(1165, 152, 0, "Everfrost Chip - Dun Niffelem"),
(3742, 152, 0, "Everfrost Chip - Dun Niffelem"),
(3754, 152, 0, "Everfrost Chip - Dun Niffelem");
