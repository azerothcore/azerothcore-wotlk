INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632394526847584580');

-- Set 300 rep until end of exalted for Moam, General Rajaxx, Kurinnaxx, Ayamiss the Hunter, Buru The Gorger
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue2` = 300 WHERE `creature_id` IN (15340, 15341, 15348, 15369, 15370);

-- Set 600 rep until end of exalted for Ossirian the Unscarred
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue2` = 600 WHERE `creature_id` = 15339;

-- Set 10 rep until end of exalted for Vekniss (Soldier, Warrior, Stinger, Wasp, Hive Crawler), Qiraji Lasher, Obsidian Eradicator, Anubisath (Sentinel, Defender).
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue2` = 10 WHERE `creature_id` IN (15229, 15230, 15235, 15236, 15240, 15249, 15262, 15264, 15277);
