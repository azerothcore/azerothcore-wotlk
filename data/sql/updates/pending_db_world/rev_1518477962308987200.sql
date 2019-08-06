INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1518477962308987200');

DELETE FROM `item_loot_template` WHERE (`entry` = 54537 AND `item` = 49426);
INSERT INTO `item_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
('54537','49426','100','1','0','2','2');
