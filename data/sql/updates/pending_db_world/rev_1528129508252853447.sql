INSERT INTO version_db_world (`sql_rev`) VALUES ('1528129508252853447');

DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (1969,1971);
UPDATE `creature_template` SET `gossip_menu_id` = 2441 WHERE `entry` = 3149;
UPDATE `creature_template` SET `gossip_menu_id` = 3842 WHERE `entry` = 12137;
