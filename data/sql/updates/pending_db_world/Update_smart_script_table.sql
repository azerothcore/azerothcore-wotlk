-- Update Smart scropt TABLE
ALTER TABLE `smart_scripts`
ADD COLUMN `guid` INT(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `entryorguid`;

ALTER TABLE `smart_scripts` DROP PRIMARY KEY;

ALTER TABLE `smart_scripts`
CHANGE `entryorguid` `entry` INT(11) NOT NULL;

ALTER TABLE `smart_scripts` ADD PRIMARY KEY (`entry`, `source_type`, `id`, `link`) USING BTREE;
