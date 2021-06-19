INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624093373812039200');

-- Set spell school immunity to FIRE
UPDATE `creature_template` SET `spell_school_immune_mask` = 4 WHERE (`entry` = 4339);
