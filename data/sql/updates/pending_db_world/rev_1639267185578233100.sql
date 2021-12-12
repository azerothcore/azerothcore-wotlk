INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639267185578233100');

/* Disable LOS on Unworthy Initiate Chains
*/

DELETE FROM `disables` WHERE `sourceType`=0 AND `entry` IN (54613);
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 54613, 64, '', '', 'Disable LOS on Unworthy Initiate Chains');

