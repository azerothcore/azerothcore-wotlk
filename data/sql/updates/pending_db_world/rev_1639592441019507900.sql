INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639592441019507900');

ALTER TABLE `spell_proc_event` ADD COLUMN `procPhase` INT UNSIGNED DEFAULT 0 NOT NULL AFTER `procEx`; 
