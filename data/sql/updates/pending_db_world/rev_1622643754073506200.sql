INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622643754073506200');

SET @THORIUM_ORE = 10620;
SET @BC_GEMS = 13001;
UPDATE `prospecting_loot_template`
SET `GroupId` = 0
WHERE `ENTRY` = @THORIUM_ORE AND `Reference` = @BC_GEMS;
