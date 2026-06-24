-- Dark Portal battle tuning and demon wave fixes.

-- Creature tuning for the Dark Portal battle.
UPDATE `creature_template`
SET `HealthModifier` = CASE `entry`
    WHEN 18946 THEN 27
    WHEN 18966 THEN 40
    WHEN 18969 THEN 40
END
WHERE `entry` IN (18946, 18966, 18969);

UPDATE `creature_template`
SET `DamageModifier` = CASE `entry`
    WHEN 18944 THEN 4.8
    WHEN 18946 THEN 13.4
    WHEN 19005 THEN 22
END
WHERE `entry` IN (18944, 18946, 19005);

UPDATE `creature_template`
SET `unit_flags` = `unit_flags` & ~0x4
WHERE `entry` IN (18949, 18971);

UPDATE `creature_template_addon`
SET `emote` = 0
WHERE `entry` = 18966;

-- Justinius and Melgromm ability sets.
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18966, 18969)
  AND `id` IN (74, 75, 76, 77, 78);

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18966,0,74,0,0,0,100,0,7000,11000,12000,18000,0,0,11,20922,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Justinius the Harbinger - In Combat - Cast Consecration (Rank 3)'),
(18966,0,75,0,2,0,100,0,1,45,8000,14000,0,0,11,37254,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - At 45% HP - Cast Flash of Light'),
(18966,0,76,0,4,0,100,1,0,0,0,0,0,0,11,29381,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Aggro - Cast Greater Blessing of Might'),
(18966,0,77,0,2,0,100,0,1,15,60000,60000,0,0,11,13874,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - At 15% HP - Cast Divine Shield'),
(18966,0,78,0,1,0,100,0,2000,2000,30000,30000,0,0,11,29381,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - Out of Combat - Buff allies (Greater Blessing of Might)'),
(18969,0,74,0,2,0,100,0,1,50,7000,12000,0,0,11,33642,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - At 50% HP - Cast Chain Heal'),
(18969,0,75,0,0,0,100,0,9000,14000,25000,31000,0,0,11,33560,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - In Combat - Cast Magma Flow Totem');

DELETE FROM `creature_template_spell`
WHERE `CreatureID` IN (19222, 19225) AND `Index` = 0;

INSERT INTO `creature_template_spell` (`CreatureID`, `Index`, `Spell`, `VerifiedBuild`) VALUES
(19225, 0, 33571, NULL),
(19222, 0, 33561, NULL);

-- Keep Justinius' buffs off players and his Consecration limited to demon victims.
DELETE FROM `conditions`
WHERE (`SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 29381)
   OR (`SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 18966 AND `SourceGroup` = 75)
   OR (`SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 33559 AND `SourceGroup` IN (1, 2, 3));

INSERT INTO `conditions`
(`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
 `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
 `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(13,1,29381,0,0,32,0,16,0,0,1,0,0,'','Justinius Greater Blessing of Might cannot target players'),
(22,75,18966,0,0,24,2,3,0,0,0,0,0,'','Justinius Consecration only runs when his victim is a demon');

-- Let the defending army die normally, leave a corpse briefly, then respawn.
UPDATE `creature`
SET `spawntimesecs` = 0
WHERE `map` = 530
  AND `id1` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986);

DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` IN (18948, 18949, 18950, 18965, 18966, 18969, 18970, 18971, 18972, 18986)
  AND ((`event_type` = 6 AND `action_type` = 70) OR `id` = 103);

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
 `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(18948,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Soldier - On Respawn - Set corpse delay to 10s'),
(18949,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormwind Mage - On Respawn - Set corpse delay to 10s'),
(18950,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Grunt - On Respawn - Set corpse delay to 10s'),
(18965,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darnassian Archer - On Respawn - Set corpse delay to 10s'),
(18966,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justinius the Harbinger - On Respawn - Set corpse delay to 10s'),
(18969,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Melgromm Highmountain - On Respawn - Set corpse delay to 10s'),
(18970,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Darkspear Axe Thrower - On Respawn - Set corpse delay to 10s'),
(18971,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Undercity Mage - On Respawn - Set corpse delay to 10s'),
(18972,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Orgrimmar Shaman - On Respawn - Set corpse delay to 10s'),
(18986,0,103,0,11,0,100,512,0,0,0,0,0,0,116,10,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Ironforge Paladin - On Respawn - Set corpse delay to 10s');

-- Restore the four gate Wrath Master spawns to floor-safe coordinates.
UPDATE `creature`
SET `map` = 530, `zoneId` = 3483, `areaId` = 3483, `spawnMask` = 1, `phaseMask` = 4294967295,
    `position_x` = -302.05676, `position_y` = 1524.8987, `position_z` = 37.92391, `orientation` = 0.18216586,
    `spawntimesecs` = 10, `wander_distance` = 0, `MovementType` = 0, `curhealth` = 143620, `Comment` = 'GUID SAI'
WHERE `guid` = 68311 AND `id1` = 19005;

UPDATE `creature`
SET `map` = 530, `zoneId` = 3483, `areaId` = 3483, `spawnMask` = 1, `phaseMask` = 4294967295,
    `position_x` = -146.42024, `position_y` = 1510.6957, `position_z` = 33.62471, `orientation` = 3.0842154,
    `spawntimesecs` = 10, `wander_distance` = 0, `MovementType` = 0, `curhealth` = 143620, `Comment` = 'GUID SAI'
WHERE `guid` = 68312 AND `id1` = 19005;

UPDATE `creature`
SET `map` = 530, `zoneId` = 3483, `areaId` = 3804, `spawnMask` = 1, `phaseMask` = 4294967295,
    `position_x` = -84.32881, `position_y` = 1881.8777, `position_z` = 74.695015, `orientation` = 2.5140123,
    `spawntimesecs` = 10, `wander_distance` = 0, `MovementType` = 0, `curhealth` = 143620, `Comment` = 'GUID SAI'
WHERE `guid` = 68313 AND `id1` = 19005;

UPDATE `creature`
SET `map` = 530, `zoneId` = 3483, `areaId` = 3804, `spawnMask` = 1, `phaseMask` = 4294967295,
    `position_x` = -419.23682, `position_y` = 1846.775, `position_z` = 81.09361, `orientation` = 1.7246842,
    `spawntimesecs` = 10, `wander_distance` = 0, `MovementType` = 0, `curhealth` = 143620, `Comment` = 'GUID SAI'
WHERE `guid` = 68314 AND `id1` = 19005;

UPDATE `smart_scripts`
SET `link` = 0,
    `action_param2` = 5000,
    `action_param3` = 5000
WHERE `source_type` = 0
  AND `entryorguid` IN (-68311, -68312, -68313, -68314)
  AND `id` = 3
  AND `action_type` = 67;

UPDATE `smart_scripts`
SET `event_type` = 59,
    `event_param1` = 1,
    `event_param2` = 0,
    `event_param3` = 0,
    `event_param4` = 0,
    `event_param5` = 0,
    `event_param6` = 0
WHERE `source_type` = 0
  AND `entryorguid` IN (-68311, -68312, -68313, -68314)
  AND `id` = 4
  AND `action_type` = 80;

UPDATE `smart_scripts` SET `action_param2` = 68311
WHERE `entryorguid` = -68311 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900500
WHERE `entryorguid` = -68311 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;
UPDATE `smart_scripts` SET `action_param2` = 68312
WHERE `entryorguid` = -68312 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900501
WHERE `entryorguid` = -68312 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;
UPDATE `smart_scripts` SET `action_param2` = 68313
WHERE `entryorguid` = -68313 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900502
WHERE `entryorguid` = -68313 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;
UPDATE `smart_scripts` SET `action_param2` = 68314
WHERE `entryorguid` = -68314 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 53;
UPDATE `smart_scripts` SET `action_param1` = 1900503
WHERE `entryorguid` = -68314 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;

-- Non-overlapping Fel Soldier summon points around each restored gate.
UPDATE `smart_scripts` SET `target_x` = -298.00, `target_y` = 1529.00, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -307.00, `target_y` = 1530.00, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -297.80, `target_y` = 1520.70, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -307.40, `target_y` = 1519.90, `target_z` = 37.92391, `target_o` = 0.18216586
WHERE `entryorguid` = 1900500 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -142.00, `target_y` = 1514.90, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -151.10, `target_y` = 1515.40, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -141.80, `target_y` = 1506.00, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -151.40, `target_y` = 1505.20, `target_z` = 33.62471, `target_o` = 3.0842154
WHERE `entryorguid` = 1900501 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -80.00, `target_y` = 1886.00, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -89.20, `target_y` = 1886.50, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -79.80, `target_y` = 1877.70, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -89.60, `target_y` = 1876.90, `target_z` = 74.695015, `target_o` = 2.5140123
WHERE `entryorguid` = 1900502 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -414.70, `target_y` = 1851.20, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -424.30, `target_y` = 1851.80, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 2 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -414.40, `target_y` = 1842.50, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 4 AND `action_type` = 12;
UPDATE `smart_scripts` SET `target_x` = -425.00, `target_y` = 1841.70, `target_z` = 81.09361, `target_o` = 1.7246842
WHERE `entryorguid` = 1900503 AND `source_type` = 9 AND `id` = 6 AND `action_type` = 12;

DELETE FROM `waypoint_data` WHERE `id` IN (68311, 68312, 68313, 68314);

INSERT INTO `waypoint_data`
(`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `velocity`, `delay`, `smoothTransition`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(68311, 1, -302.05676, 1524.8987, 37.92391, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 2, -288.00, 1490.00, 54.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 3, -279.00, 1448.00, 45.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 4, -267.00, 1378.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 5, -257.00, 1285.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 6, -249.00, 1165.00, 48.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68311, 7, -247.00, 1088.00, 54.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 1, -146.42024, 1510.6957, 33.62471, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 2, -171.00, 1470.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 3, -190.00, 1400.00, 35.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 4, -215.00, 1300.00, 36.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 5, -235.00, 1200.00, 44.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68312, 6, -245.00, 1095.00, 54.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 1, -84.32881, 1881.8777, 74.695015, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 2, -120.00, 1820.00, 78.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 3, -155.00, 1760.00, 68.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 4, -190.00, 1680.00, 58.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 5, -220.00, 1580.00, 48.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 6, -245.00, 1450.00, 40.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 7, -250.00, 1300.00, 39.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68313, 8, -247.00, 1125.00, 52.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 1, -419.23682, 1846.775, 81.09361, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 2, -390.00, 1785.00, 75.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 3, -350.00, 1700.00, 62.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 4, -315.00, 1600.00, 52.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 5, -285.00, 1500.00, 45.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 6, -260.00, 1320.00, 40.00, NULL, 0, 0, 0, 0, 0, 100, 0),
(68314, 7, -247.00, 1090.00, 54.00, NULL, 0, 0, 0, 0, 0, 100, 0);

-- Remove duplicate relay spawns that stack extra unmoving demons at startup.
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` = -68744
  AND `id` IN (0, 1, 2, 3, 4, 44, 45);
