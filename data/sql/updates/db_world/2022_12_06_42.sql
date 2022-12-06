-- DB update 2022_12_06_41 -> 2022_12_06_42
--
UPDATE `dungeon_access_requirements` SET `priority`=(NULL), `requirement_note`='You must complete the quest "The Caverns of Time" before entering Old Hillsbrad Foothills', `comment`='Caverns Of Time: Escape from Durnholde (Normal)' WHERE `dungeon_access_id`=62 AND `requirement_type`=1 AND `requirement_id`=10277;
UPDATE `dungeon_access_requirements` SET `priority`=(NULL), `requirement_note`='You must complete the quest "The Caverns of Time" and be level 70 before entering the Heroic difficulty of Old Hillsbrad Foothills', `comment`='Caverns Of Time: Escape from Durnholde (Heroic)' WHERE `dungeon_access_id`=63 AND `requirement_type`=1 AND `requirement_id`=10277;
