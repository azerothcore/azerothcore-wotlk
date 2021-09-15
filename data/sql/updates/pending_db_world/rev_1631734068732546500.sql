INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631734068732546500');

SET @Entry = 35009;

UPDATE `reference_loot_template` SET `Chance` = 13.3 WHERE `Entry` = @Entry AND `Item` IN (17707, 17710, 17711, 17715, 17766); 
UPDATE `reference_loot_template` SET `Chance` = 16.6 WHERE `Entry` = @Entry AND `Item` IN (17713, 17714); 
UPDATE `reference_loot_template` SET `Chance` = 0.3 WHERE `Entry` = @Entry AND `Item` IN (17780); 
