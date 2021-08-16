INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628777209086733059');

-- Make Aku'mai Servant cast Frostbolt Volley on victims and not itself
UPDATE `smart_scripts` SET `target_type` = 2 WHERE `source_type` = 0 AND `id` = 0 AND `entryorguid` = 4978;

