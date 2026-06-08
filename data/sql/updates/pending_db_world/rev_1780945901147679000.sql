-- Remove the XP gains from "Risen Alliance Soldier" and "Icy Ghoul"
UPDATE `creature_template` SET `ExperienceModifier` = 0 WHERE `entry` IN (31205, 31142);
