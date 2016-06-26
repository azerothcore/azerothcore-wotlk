DROP TABLE IF EXISTS group_instance;
ALTER TABLE character_instance ADD COLUMN extended tinyint(3) unsigned NOT NULL DEFAULT 0;
