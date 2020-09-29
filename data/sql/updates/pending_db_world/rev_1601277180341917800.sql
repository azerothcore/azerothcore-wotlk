INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601277180341917800');

-- Immune to Spell IDs: 9484 / 3355 / 20066 / 10326 / 60192 / 339 / 33786
UPDATE `creature_template` SET `mechanic_immune_mask`=550187859 WHERE `entry`=34607; -- ToC 10-man Normal Raid
UPDATE `creature_template` SET `mechanic_immune_mask`=550187859 WHERE `entry`=34648; -- ToC 25-man Normal Raid 
UPDATE `creature_template` SET `mechanic_immune_mask`=550187859 WHERE `entry`=35655; -- ToC 10-man Heroic Raid
UPDATE `creature_template` SET `mechanic_immune_mask`=550187859 WHERE `entry`=35656; -- ToC 25-man Heroic Raid

