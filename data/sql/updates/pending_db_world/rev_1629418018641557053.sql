INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629418018641557053');

# Update Scarlet Friar preventing evade / floor falling
UPDATE `creature` SET `position_z` = 81 WHERE (`id` = 1538) AND (`guid` IN (44770));
