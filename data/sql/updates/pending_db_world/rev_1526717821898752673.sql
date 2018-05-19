INSERT INTO version_db_world (`sql_rev`) VALUES ('1526717821898752673');

UPDATE `quest_template_addon` SET `RewardMailTemplateID` = 236 WHERE `id` = 12711;

DELETE FROM `mail_loot_template` WHERE `entry` = 236;
INSERT INTO `mail_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES (236,39317,100,1,0,1,1);
