-- Obsidian Sanctum

UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 28860; -- sartharion
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 30449; -- vesperon
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 30451; -- shadron
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 30452; -- tenebron
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 30453; -- guardians
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 30680; -- generals
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 30681; -- mistresses
UPDATE `creature_template` SET `speed_walk` = 1.6, `speed_run` = 1.428571428571429, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 30682; -- captains
UPDATE `creature_template` SET `speed_walk` = 1,   `speed_run` = 1.14285714286,     `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 31103; -- egg
UPDATE `creature_model_info` SET `BoundingRadius` = 3.75,                 `CombatReach` = 4.375, `VerifiedBuild` = 46248 WHERE `DisplayID` = 12891; -- captains
UPDATE `creature_model_info` SET `BoundingRadius` = 1.799999952316284179, `CombatReach` = 18,    `VerifiedBuild` = 46248 WHERE `DisplayID` = 27035; -- sartharion
UPDATE `creature_model_info` SET `BoundingRadius` = 2.25,                 `CombatReach` = 4.5,   `VerifiedBuild` = 46248 WHERE `DisplayID` = 27039; -- vesperon
UPDATE `creature_model_info` SET `BoundingRadius` = 2.25,                 `CombatReach` = 4.5,   `VerifiedBuild` = 46248 WHERE `DisplayID` = 27082; -- tenebron
UPDATE `creature_model_info` SET `BoundingRadius` = 3,                    `CombatReach` = 10,    `VerifiedBuild` = 46248 WHERE `DisplayID` = 27225; -- guardians
UPDATE `creature_model_info` SET `BoundingRadius` = 1.25,                 `CombatReach` = 8.75,  `VerifiedBuild` = 46248 WHERE `DisplayID` = 27226; -- generals
UPDATE `creature_model_info` SET `BoundingRadius` = 3.75,                 `CombatReach` = 3.75,  `VerifiedBuild` = 46248 WHERE `DisplayID` = 27227; -- mistresses
UPDATE `creature_model_info` SET `BoundingRadius` = 0.75,                 `CombatReach` = 2.5,   `VerifiedBuild` = 46248 WHERE `DisplayID` = 27396; -- egg
UPDATE `creature_model_info` SET `BoundingRadius` = 2.25,                 `CombatReach` = 4.5,   `VerifiedBuild` = 46248 WHERE `DisplayID` = 27421; -- shadron

-- The Eye of Eternity
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 0.9920628411429269, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 22517; -- world trigger
UPDATE `creature_template` SET `speed_walk` = 4, `speed_run` = 2.857142857142857,  `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 28859; -- malygos
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 1.142857142857143,  `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 31253; -- alexstrasza
UPDATE `creature_model_info` SET `BoundingRadius` = 0.5, `CombatReach` = 1,  `VerifiedBuild` = 46248 WHERE `DisplayID` = 16925; -- world trigger
UPDATE `creature_model_info` SET `BoundingRadius` = 2,   `CombatReach` = 20, `VerifiedBuild` = 46248 WHERE `DisplayID` = 26752; -- malygos
UPDATE `creature_model_info` SET `BoundingRadius` = 0.5, `CombatReach` = 1,  `VerifiedBuild` = 46248 WHERE `DisplayID` = 27401; -- alexstrasza

-- Vault of Archavon
UPDATE `creature_template` SET `speed_walk` = 2,                  `speed_run` = 2,                 `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 31125; -- archavon
UPDATE `creature_template` SET `speed_walk` = 1,                  `speed_run` = 1.285714285714286, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 32353; -- archavon warder
UPDATE `creature_template` SET `speed_walk` = 1,                  `speed_run` = 1.142857142857143, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 32780; -- stalker
UPDATE `creature_template` SET `speed_walk` = 0.8888879776000976, `speed_run` = 1.587300028119767, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 33993; -- emalon
UPDATE `creature_template` SET `speed_walk` = 1,                  `speed_run` = 1.714285714285714, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 34015; -- tempest warder
UPDATE `creature_template` SET `speed_walk` = 0.8888879776000976, `speed_run` = 1.587300028119767, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 35013; -- koralon
UPDATE `creature_template` SET `speed_walk` = 1,                  `speed_run` = 1.714285714285714, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 35143; -- flame warder
UPDATE `creature_template` SET `speed_walk` = 1,                  `speed_run` = 1.142857142857143, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 36093; -- stalker
UPDATE `creature_template` SET `speed_walk` = 0.8888879776000976, `speed_run` = 1.714285714285714, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 38433; -- toravon
UPDATE `creature_template` SET `speed_walk` = 1,                  `speed_run` = 1.714285714285714, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 38482; -- frost warder
UPDATE `creature_model_info` SET `BoundingRadius` = 0.465000003576278686, `CombatReach` = 7.5, `VerifiedBuild` = 53788 WHERE `DisplayID` = 26967; -- archavon
UPDATE `creature_model_info` SET `BoundingRadius` = 0.620000004768371582, `CombatReach` = 2,   `VerifiedBuild` = 53788 WHERE `DisplayID` = 26693; -- archavon warder
UPDATE `creature_model_info` SET `BoundingRadius` = 0.5,                  `CombatReach` = 1,   `VerifiedBuild` = 53788 WHERE `DisplayID` = 11686; -- stalker
UPDATE `creature_model_info` SET `BoundingRadius` = 0.465000003576278686, `CombatReach` = 7.5, `VerifiedBuild` = 53788 WHERE `DisplayID` = 27108; -- emalon
UPDATE `creature_model_info` SET `BoundingRadius` = 0.620000004768371582, `CombatReach` = 2,   `VerifiedBuild` = 53788 WHERE `DisplayID` = 26383; -- tempest warder
UPDATE `creature_model_info` SET `BoundingRadius` = 0.387499988079071044, `CombatReach` = 7.5, `VerifiedBuild` = 53788 WHERE `DisplayID` = 29524; -- koralon
UPDATE `creature_model_info` SET `BoundingRadius` = 0.620000004768371582, `CombatReach` = 2,   `VerifiedBuild` = 53788 WHERE `DisplayID` = 25680; -- flame warder
UPDATE `creature_model_info` SET `BoundingRadius` = 0.465000003576278686, `CombatReach` = 9,   `VerifiedBuild` = 53788 WHERE `DisplayID` = 31089; -- toravon
UPDATE `creature_model_info` SET `BoundingRadius` = 0.620000004768371582, `CombatReach` = 2,   `VerifiedBuild` = 53788 WHERE `DisplayID` = 27392; -- frost warder

-- Onyxia's Lair
UPDATE `creature_template` SET `speed_walk` = 1,                  `speed_run` = 1.285714285714286, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 10184; -- onyxia
UPDATE `creature_template` SET `speed_walk` = 1.111112022399902,  `speed_run` = 1.142857142857143, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 11262; -- whelp
UPDATE `creature_template` SET `speed_walk` = 0.8888879776000976, `speed_run` = 1.142857142857143, `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` = 12129; -- warder
UPDATE `creature_model_info` SET `BoundingRadius` = 0.416999995708465576, `CombatReach` = 1.875, `VerifiedBuild` = 53788 WHERE `DisplayID` = 397; -- whelp
UPDATE `creature_model_info` SET `BoundingRadius` = 1.799999952316284179, `CombatReach` = 18,    `VerifiedBuild` = 53788 WHERE `DisplayID` = 8570; -- onyxia
UPDATE `creature_model_info` SET `BoundingRadius` = 3,                    `CombatReach` = 3.5,   `VerifiedBuild` = 53788 WHERE `DisplayID` = 8711; -- warder
