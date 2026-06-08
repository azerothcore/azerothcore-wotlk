-- DB update 2026_06_05_00 -> 2026_06_08_00
-- Remove the XP gains from "Risen Alliance Soldier" and "Icy Ghoul"
UPDATE `creature_template` SET `ExperienceModifier` = 0 WHERE `entry` IN (31205, 31142);
