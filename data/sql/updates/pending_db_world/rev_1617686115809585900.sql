INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617686115809585900');

-- They did not have stealth in classic https://youtu.be/4Hlaez09riY?t=90
-- No changes during TBC or WOLTK, until WoD https://youtu.be/JVQzZmGWjF8?t=16
DELETE FROM `smart_scripts` WHERE `entryorguid`=3566 AND `source_type`=0 AND `id`=0 AND `link`=0;
UPDATE `creature_template` SET `AIName`='' WHERE `entry`=3566;

