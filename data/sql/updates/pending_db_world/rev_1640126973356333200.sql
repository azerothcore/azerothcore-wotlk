INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640126973356333200');

-- Baron Geddon root immunity (MECHANIC_ROOT).
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 64  WHERE `entry`= 12056;
