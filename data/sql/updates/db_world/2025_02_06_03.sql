-- DB update 2025_02_06_02 -> 2025_02_06_03

SET @LOOTTHISTLEBOAR := 1985; -- Skinning loot template for Thistle Boar
SET @LOOTSCORPIDWORKER := 3124; -- Skinning loot template for Scorpid Worker
SET @LIGHTLEATHER := 2318; -- Light Leather
SET @RUINEDSCRAPS := 2934; -- Ruined Leather Scraps

-- Setting skinloot as 0 for creature that should not be skinnable
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (1984, 1985, 2032, 3124);

-- Removing now unused skinning loot template to keep the DB cleaned up
DELETE FROM `skinning_loot_template` WHERE `entry` = @LOOTTHISTLEBOAR AND `item` = @LIGHTLEATHER;
DELETE FROM `skinning_loot_template` WHERE `entry` = @LOOTTHISTLEBOAR AND `item` = @RUINEDSCRAPS;
DELETE FROM `skinning_loot_template` WHERE `entry` = @LOOTSCORPIDWORKER AND `item` = @LIGHTLEATHER;
DELETE FROM `skinning_loot_template` WHERE `entry` = @LOOTSCORPIDWORKER AND `item` = @RUINEDSCRAPS;
