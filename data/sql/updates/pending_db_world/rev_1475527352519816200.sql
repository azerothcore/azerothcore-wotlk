INSERT INTO version_db_world(`sql_rev`) VALUES ('1475527352519816200');

--Fix #116
UPDATE `gameobject_template` SET Data1 = "5000" WHERE entry = 176248

INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
 (5000, 13172, -100, 1, 0, 1, 1);
