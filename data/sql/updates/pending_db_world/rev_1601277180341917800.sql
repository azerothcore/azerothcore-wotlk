INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601277180341917800');

UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|2|64|4096|8192|131072|524288 WHERE `entry` IN 
(34607, 34648, 35655, 35656);

