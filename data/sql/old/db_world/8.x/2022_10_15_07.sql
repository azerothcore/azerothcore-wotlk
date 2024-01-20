-- DB update 2022_10_15_06 -> 2022_10_15_07
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |256|512 WHERE `entry` IN (15910, 15904, 15896);
UPDATE `creature_model_info` SET `CombatReach` = 15 WHERE `displayID` IN (15556, 15790, 15793);
UPDATE `creature_summon_groups` SET `summonType` = 6, `summonTime` = 500 WHERE `summonerId` = 15589 AND `summonerType` = 0;
