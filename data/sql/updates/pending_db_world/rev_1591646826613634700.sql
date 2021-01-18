INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1591646826613634700');

UPDATE `command` SET `help` = "Syntax: .reload page_text\r\nReload page_text table.\nYou need to delete your client cache or change the cache number in the config in order for your players see the changes." WHERE `name` = "reload page_text";
UPDATE `command` SET `help` = "Syntax: .reload page_text_locale\r\nReload page_text_locale table.\nYou need to delete your client cache or change the cache number in config in order for your players see the changes." WHERE `name` = "reload page_text_locale";
