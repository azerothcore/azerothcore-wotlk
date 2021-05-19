INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621426406097836315');

SET @REF_TIGERSTRIKE_MANTLE := 24053;

DELETE FROM `creature_loot_template` 
WHERE `Reference` = @REF_TIGERSTRIKE_MANTLE AND `entry` IN (4287, 4291, 4296, 4299, 4306, 4540);

-- 4287 - Scarlet Gallant
-- 4291 - Scarlet Diviner
-- 4296 - Scarlet Adept
-- 4299 - Scarlet Chaplain
-- 4306 - Scarlet Torturer
-- 4540 - Scarlet Monk

