INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649663437340205577');
-- Broodlord Lashlayer should not be disarmable
UPDATE `creature_template` SET `mechanic_immune_mask` = 617299807 WHERE (`entry` = 12017);
