INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630405831769074100');

-- Corrected faction for Southshore Guard
UPDATE `creature_template` SET `faction` = 11 WHERE (`entry` = 2386);
