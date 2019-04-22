INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1555926066020418100');

-- Remove UNIT_FLAG_IMMUNE_TO_PC from NPC 'Ethereum guardian'
UPDATE `creature_template` SET `unit_flags`='0' WHERE `entry`=20854;
