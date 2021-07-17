INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626532264671526700');

-- We had 2 gossips with the id, and it was choosing the wrong one. So we insert into a new one id.
DELETE FROM `gossip_menu` WHERE `menuid` = 61025 and `textid` = 10041;

-- The line 10041 is the one needed for this character.
INSERT INTO `gossip_menu` (`menuid` , `textid` ) VALUES (61025 ,10041);

-- We update the character to use the new gossip id.
UPDATE `creature_template` SET `gossip_menu_id` = 61025, `faction` = 1604 WHERE (`entry` = 20406);