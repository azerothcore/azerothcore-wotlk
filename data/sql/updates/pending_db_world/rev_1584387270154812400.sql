INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1584387270154812400');

UPDATE `item_template` SET `flags`=`flags`|16 WHERE `entry` = 16665;

DELETE FROM `creature_loot_template` WHERE `Item`=16665;
