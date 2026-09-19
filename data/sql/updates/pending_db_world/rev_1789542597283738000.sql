-- Deathbringer Saurfang intro and outro: the emotes played with each line, and the Orcish line spoken in Orcish.
UPDATE `creature_text` SET `Emote` = 22 WHERE `CreatureID` = 37200 AND `GroupID` = 0;
UPDATE `creature_text` SET `Emote` = 6 WHERE `CreatureID` = 37200 AND `GroupID` = 1;
UPDATE `creature_text` SET `Emote` = 15 WHERE `CreatureID` = 37200 AND `GroupID` = 2;
UPDATE `creature_text` SET `Emote` = 397 WHERE `CreatureID` = 37813 AND `GroupID` = 0;
UPDATE `creature_text` SET `Emote` = 153 WHERE `CreatureID` = 37813 AND `GroupID` = 2;
UPDATE `creature_text` SET `Emote` = 274 WHERE `CreatureID` = 37200 AND `GroupID` = 4;
UPDATE `creature_text` SET `Emote` = 25 WHERE `CreatureID` = 37200 AND `GroupID` = 5;
UPDATE `creature_text` SET `Emote` = 5 WHERE `CreatureID` = 37200 AND `GroupID` = 7;
UPDATE `creature_text` SET `Emote` = 397 WHERE `CreatureID` = 37187 AND `GroupID` = 6;
UPDATE `creature_text` SET `Text` = 'No\'ku kil zil\'nok ha tar.', `Language` = 1 WHERE `CreatureID` = 37187 AND `GroupID` = 8;
UPDATE `creature_text` SET `Emote` = 1 WHERE `CreatureID` = 37187 AND `GroupID` = 10;
UPDATE `creature_text` SET `Emote` = 25 WHERE `CreatureID` = 37879 AND `GroupID` = 0;
UPDATE `creature_text` SET `Emote` = 1 WHERE `CreatureID` = 37879 AND `GroupID` = 1;
UPDATE `creature_text` SET `Emote` = 6 WHERE `CreatureID` = 37879 AND `GroupID` = 2;

-- The Stormwind portal is scenery, Varian and Jaina are not attackable.
UPDATE `creature_template` SET `unit_flags` = 33555200, `VerifiedBuild` = 69814 WHERE `entry` = 37880;
UPDATE `creature_template` SET `unit_flags` = 768, `VerifiedBuild` = 69814 WHERE `entry` = 37879;
UPDATE `creature_template` SET `unit_flags` = 33600, `VerifiedBuild` = 69814 WHERE `entry` = 37188;

-- Victory camp vendors walking from their teleporter pads to their pitches, entry * 10.
-- Shely Steelbowels
DELETE FROM `waypoint_data` WHERE `id` = 379030;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(379030, 1, -548.3507, 2202.4739, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379030, 2, -544.9071, 2207.38, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379030, 3, -543.533, 2209.3838, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379030, 4, -530.8691, 2222.263, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379030, 5, -528.9062, 2224.5051, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379030, 6, -526.80206, 2231.3682, 539.28, 5.5152402, 0, 1, 0, 0, 0, 100, 0);

-- Brazie Getz
DELETE FROM `waypoint_data` WHERE `id` = 379040;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(379040, 1, -546.2265, 2223.0754, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379040, 2, -540.0955, 2224.25, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379040, 3, -533.3658, 2223.3423, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379040, 4, -530.3941, 2222.8645, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379040, 5, -528.3299, 2225.2656, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379040, 6, -530.6007, 2227.6736, 539.28, 5.497787, 0, 1, 0, 0, 0, 100, 0);

-- Apothecary Candith Tomas, who lingers on the pad before setting off
DELETE FROM `waypoint_data` WHERE `id` = 379350;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(379350, 1, -560.29517, 2220.2153, 539.2854, NULL, 0, 2400, 0, 0, 0, 100, 0),
(379350, 2, -548.1919, 2219.9202, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379350, 3, -544.9419, 2219.9202, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379350, 4, -535.7101, 2219.7864, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379350, 5, -533.0685, 2223.0264, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379350, 6, -530.17017, 2226.231, 539.28, 5.4628806, 0, 1, 0, 0, 0, 100, 0);

-- Morgan Dayblaze
DELETE FROM `waypoint_data` WHERE `id` = 379360;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(379360, 1, -544.9707, 2206.6287, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379360, 2, -533.3457, 2209.617, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379360, 3, -527.9583, 2211.0017, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379360, 4, -524.5902, 2216.5625, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379360, 5, -521.3402, 2221.0625, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379360, 6, -518.1354, 2225.9167, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379360, 7, -520.3289, 2232.0615, 539.28, NULL, 0, 0, 0, 0, 0, 100, 0),
(379360, 8, -520.941, 2233.1077, 539.28, 5.3756142, 0, 1, 0, 0, 0, 100, 0);
