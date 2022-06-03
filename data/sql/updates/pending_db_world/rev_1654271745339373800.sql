-- Skinning loot: 100008
SET @LOOT               = 100008;
SET @RED_WHELP          = 1042;
SET @LOST_WHELP         = 1043;
SET @CRIMSON_WHELP      = 1069;
SET @LIGHT_LEATHER      = 2318;
SET @LIGHT_HIDE         = 783;
SET @MEDIUM_LEATHER     = 2319;
SET @MEDIUM_HIDE        = 4232;
SET @RED_WHELP_SCALE    = 7287;

UPDATE `creature_template` SET `skinloot`= 0 WHERE `skinloot`= @LOOT AND `entry` NOT IN (@RED_WHELP, @LOST_WHELP, @CRIMSON_WHELP);

UPDATE `skinning_loot_template` SET `Comment` = 'Light Leather' WHERE `Item` = @LIGHT_LEATHER AND `Entry` = @LOOT;
UPDATE `skinning_loot_template` SET `Comment` = 'Light Hide' WHERE `Item` = @LIGHT_HIDE AND `Entry` = @LOOT;
UPDATE `skinning_loot_template` SET `Comment` = 'Medium Leather' WHERE `Item` = @MEDIUM_LEATHER AND `Entry` = @LOOT;
UPDATE `skinning_loot_template` SET `Comment` = 'Medium Hide' WHERE `Item` = @MEDIUM_HIDE AND `Entry` = @LOOT;
UPDATE `skinning_loot_template` SET `Comment` = 'Red Whelp Scale' WHERE `Item` = @RED_WHELP_SCALE AND `Entry` = @LOOT;
