-- Update Domesticated Felboar - they should not provide XP, Loot, or be Skinnable as of an exploit fix in 2.4
UPDATE `creature_template` SET `lootid` = 0, `skinloot` = 0, `ExperienceModifier` = 0 WHERE `entry` = 21195;
