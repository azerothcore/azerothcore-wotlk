INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617596593417183200');

-- harvest watcher 36 -> 43
UPDATE `creature_loot_template` SET `Chance`=43 WHERE `Entry`=114 AND `Item`=732;
-- harvest reaper 40 -> 43
UPDATE `creature_loot_template` SET `Chance`=43 WHERE `Entry`=115 AND `Item`=732;
-- rusty harvest golem 28.0247 -> 37
UPDATE `creature_loot_template` SET `Chance`=37 WHERE `Entry`=480 AND `Item`=732;
-- harvest golem 33-> 40
UPDATE `creature_loot_template` SET `Chance`=40 WHERE `Entry`=36 AND `Item`=732;
-- foe reaper 4000 30 -> 43
UPDATE `creature_loot_template` SET `Chance`=43 WHERE `Entry`=573 AND `Item`=732;

