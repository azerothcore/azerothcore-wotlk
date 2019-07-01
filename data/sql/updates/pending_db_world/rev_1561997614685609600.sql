INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1561997614685609600');

-- Razorscale Harpoon Fire State creature is trigger-NPC (invisible to players only)
UPDATE `creature_template` SET `flags_extra`='130' WHERE `entry`=33282;
