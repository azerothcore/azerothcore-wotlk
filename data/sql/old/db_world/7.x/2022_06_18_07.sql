-- DB update 2022_06_18_06 -> 2022_06_18_07
-- Update Domesticated Felboar - they should not provide XP, Loot, or be Skinnable as of an exploit fix in 2.4
UPDATE `creature_template` SET `lootid` = 0, `skinloot` = 0, `ExperienceModifier` = 0 WHERE `entry` = 21195;
DELETE FROM `creature_loot_template` WHERE `entry` = 21195;
