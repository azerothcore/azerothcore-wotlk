DROP TABLE IF EXISTS `hearthstone_criteria_credits`;
CREATE TABLE `hearthstone_criteria_credits`(  
  `type` INT(10) NOT NULL DEFAULT 0 COMMENT 'criteria type (column 3)',
  `data0` INT(10) DEFAULT 0 COMMENT 'column 4',
  `data1` INT(10) DEFAULT 0 COMMENT 'column 5',
  `creature` BIGINT(10) DEFAULT 0 COMMENT 'linked creature',
  `comment` TEXT
);

-- honorable kill at area 31, areatable.db, count

INSERT INTO `hearthstone_criteria_credits` (`type`,  `data0`, `data1`, `creature`,`comment`) VALUES
-- Bg wins
(1, 30, 1, 110001, "Alterac Valley Victory"),
(1, 489, 1, 110002, "Warsong Gulch Victory"),
(1, 529, 1, 110003, "Arathi Basin Victory"),
(1, 566, 1, 110004, "Eye of the Storm Victory"),
(1, 607, 1, 110005, "Strand of the Ancients Victory"),
(1, 628, 1, 110006, "Isle of Conquest Victory"),
-- Bg Objectives
(30, 122, 1, 110007, "Arathi Basin Flag Capture "),
(30, 42, 1, 110008, "Warsong Gulch Flag Capture"),
(30, 44, 1, 110009, "Warsong Gulch Flag Recover"),
(30, 183, 1, 110010, "Eye of the Storm Flag Capture"),
(30, 63, 1, 110011, "Alterac Valley Graveyard Capture"),
(30, 64, 1, 110012, "Alterac Valley Tower Defense"),
(30, 61, 1, 110013, "Alterac Valley Tower Capture"),
(30, 123, 1, 110014, "Arathi Basin Base Defense"),
(30, 65, 1, 110015, "Alterac Valley Graveyard Capture"), -- need test!! not sure
(30, 245, 1, 110016, "Isle of Conquest Base Capture"), -- not sure, maybe this is defend
(30, 246, 1, 110017, "Isle of Conquest Base Defend"), -- not sure, maybe this is capture
-- Kill Class
(52, 1, 1, 110018, "Kill a Warrior"),
(52, 2, 1, 110019, "Kill a Paladin"),
(52, 3, 1, 110020, "Kill a Hunter"),
(52, 4, 1, 110021, "Kill a Rogue"),
(52, 5, 1, 110022, "Kill a Priest"),
(52, 6, 1, 110023, "Kill a Death Knight"),
(52, 7, 1, 110024, "Kill a Shaman"),
(52, 8, 1, 110025, "Kill a Mage"),
(52, 9, 1, 110026, "Kill a Warlock"),
(52, 11, 1, 110027, "Kill a Druid"),
-- Kill Race
(53, 1, 1, 110028, "Kill a Human"),
(53, 2, 1, 110029, "Kill an Orc"),
(53, 3, 1, 110030, "Kill a Dwarf"),
(53, 4, 1, 110031, "Kill a Night Elf"),
(53, 5, 1, 110032, "Kill an Undead"),
(53, 6, 1, 110033, "Kill a Tauren"),
(53, 7, 1, 110034, "Kill a Gnome"),
(53, 8, 1, 110035, "Kill a Troll"),
(53, 10, 1, 110036, "Kill a Blood Elf"),
(53, 11, 1, 110037, "Kill a Draenei"),
-- Get Kills
(56, 0, 1, 110038, "Get a Killing Blow"),
(113, 0, 1, 110039, "Earn Honorable Kill"),
-- Win Duel
(76, 0, 1, 110040, "Win Duel")
;