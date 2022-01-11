INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641843150724825400');

SET @FLAMEWAKER_PROTECTOR = 12119;
UPDATE `creature_template` SET `mechanic_immune_mask`= `mechanic_immune_mask`&~ 16384 WHERE (`entry` IN (@FLAMEWAKER_PROTECTOR));
