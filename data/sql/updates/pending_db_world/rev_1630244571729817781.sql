INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630244571729817781');

--  Anubisath Defender, Anubisath Sentinel, Obsidian Eradicator, Qiraji Lasher, Vekniss Hive Crawler, Vekniss Soldier, Vekniss Stinger, Vekniss Warrior, Vekniss Wasp kill rep to 100
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 100 WHERE `creature_id` IN (15277, 15264, 15262, 15249, 15240, 15229, 15235, 15230, 15236);
