-- DB update 2025_01_14_01 -> 2025_01_14_02

-- Delete Double Nerub'ar Victims
DELETE FROM `creature` WHERE (`id1` = 25284) AND (`guid` IN (143230, 143231, 143232, 143263, 143264, 143268, 143269, 143271, 143272, 143273));

-- Set MT to 0 for a Crystalline Tender inside The Nexus (dungeon).
UPDATE `creature` SET `MovementType` = 0 WHERE (`id1` = 28231) AND (`guid` IN (126441));
