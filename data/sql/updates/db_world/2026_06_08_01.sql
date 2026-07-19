-- DB update 2026_06_08_00 -> 2026_06_08_01
-- Reverts changes from https://github.com/azerothcore/azerothcore-wotlk/pull/26112
-- Adds back the ExperienceModifier and Adds the correct flag "CREATURE_FLAG_EXTRA_NO_XP" for "Risen Alliance Soldier" and "Icy Ghoul"
UPDATE `creature_template` SET `ExperienceModifier` = 1, `flags_extra` = `flags_extra` | 64 WHERE `entry` IN (31205, 31142);
