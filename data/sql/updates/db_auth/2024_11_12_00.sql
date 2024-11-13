-- Step 1: Add the new language columns
ALTER TABLE `motd`
ADD COLUMN `enUS` LONGTEXT NULL AFTER `text`,
ADD COLUMN `koKR` LONGTEXT NULL AFTER `enUS`,
ADD COLUMN `frFR` LONGTEXT NULL AFTER `koKR`,
ADD COLUMN `deDE` LONGTEXT NULL AFTER `frFR`,
ADD COLUMN `zhCN` LONGTEXT NULL AFTER `deDE`,
ADD COLUMN `zhTW` LONGTEXT NULL AFTER `zhCN`,
ADD COLUMN `esES` LONGTEXT NULL AFTER `zhTW`,
ADD COLUMN `esMX` LONGTEXT NULL AFTER `esES`,
ADD COLUMN `ruRU` LONGTEXT NULL AFTER `esMX`;

-- Step 2: Move the data from `text` to `enUS`
UPDATE `motd` SET `enUS` = `text` WHERE `text` IS NOT NULL;

-- Step 3: Drop the `text` column now that the data has been moved
ALTER TABLE `motd` DROP COLUMN `text`;