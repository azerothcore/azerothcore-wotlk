INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621414710329639831');

SET @SHIVER_BLADE := 5182;
SET @GESHARAHAN := 3398;

DELETE FROM `reference_loot_template` where `Item` = @SHIVER_BLADE;

DELETE FROM `creature_loot_template` WHERE `Entry` = @GESHARAHAN AND `Item` = @SHIVER_BLADE;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(@GESHARAHAN, @SHIVER_BLADE, 0, 72.12, 0, 1, 0, 1, 1, "Gesharahan - Shiver Blade");
