INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622192313812244100');

-- Set Gatekeeper Rageroar to 'Timbermaw Hold' faction
UPDATE `creature_template` SET `faction` = 414 WHERE (`entry` = 6651);
