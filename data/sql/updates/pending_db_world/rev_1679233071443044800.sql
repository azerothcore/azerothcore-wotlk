--
ALTER TABLE `spell_enchant_proc_data` ADD COLUMN `attributeMask` INT UNSIGNED DEFAULT 0 NOT NULL AFTER `procEx`;
UPDATE `spell_enchant_proc_data` SET `attributeMask`=1 WHERE `entry`=3225;
