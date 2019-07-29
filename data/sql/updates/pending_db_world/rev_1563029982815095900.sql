INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1563029982815095900');

-- Enslaved Netherwing Drake (Correctly fly animation)
UPDATE `creature_template` SET `InhabitType`=5 WHERE `entry`=21722;
