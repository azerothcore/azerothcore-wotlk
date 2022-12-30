-- DB update 2022_12_06_22 -> 2022_12_06_23
--
DELETE FROM `dungeon_access_requirements` WHERE `dungeon_access_id` IN (62,63) AND `requirement_type`=1 AND `requirement_id`=10277;
INSERT INTO `dungeon_access_requirements` VALUES
(62,1,10277,'You must complete the quest "The Caverns of Time" before entering the Old Hillsbrad.',2,0,0,''),
(63,1,10277,'You must complete the quest "The Caverns of Time" before entering the Old Hillsbrad (Heroic).',2,0,0,'');
