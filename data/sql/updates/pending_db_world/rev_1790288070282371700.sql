-- --------------------------------------------------------------------------------------------
-- Trial of the Crusader (Trial of the Crusader, map 649)
-- Frost Sphere (Entry 3460603)
-- Correct 25-man heroic health from 3,000 to 9,000
-- -------------------------------------------
-- The custom 25-man heroic entry copied the 10-man health modifier (0.238095). Use the 25-man
-- normal entry's modifier (34649, 0.714286) so the sphere has 9,000 health at level 80.
UPDATE `creature_template` SET `HealthModifier` = 0.714286 WHERE `entry` = 3460603;
